// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module process_frame_core #(
  parameter DATA_WIDTH = 8,
  parameter FLOW_NUM = 16,
  parameter FLOW_WIDTH = 8,
  parameter FRAME_LENGTH_WIDTH = 16,  // Must be aligned to DATA_WIDTH
  parameter TIMESTAMP_WIDTH = 72,     // Must be aligned to DATA_WIDTH
  parameter COMMIT_VALUE_WIDTH = 32
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // Settings
  //// committed_information_rate_inv [ps/Byte] = [sec/TByte]: 1Gbps -> 8,000, 10Gbps -> 800 ...
  //// independent per flow
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_0,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_1,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_2,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_3,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_4,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_5,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_6,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_7,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_8,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_9,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_10,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_11,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_12,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_13,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_14,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_15,
  //// committed_burst_size [Byte]
  //// independent per flow
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_0,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_1,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_2,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_3,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_4,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_5,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_6,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_7,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_8,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_9,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_10,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_11,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_12,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_13,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_14,
  input  wire [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_15,
  //// max_residence_time [ps]
  //// shared between each flow
  input  wire [TIMESTAMP_WIDTH-1:0] max_residence_time,

  // AXI4-Stream Timestamp In
  input  wire [TIMESTAMP_WIDTH-1:0] s_axis_arrival_timestamp_tdata,
  input  wire                       s_axis_arrival_timestamp_tvalid,
  output wire                       s_axis_arrival_timestamp_tready,

  // AXI4-Stream Flow In
  input  wire [FLOW_WIDTH-1:0] s_axis_flow_tdata,
  input  wire                  s_axis_flow_tvalid,
  output wire                  s_axis_flow_tready,

  // AXI4-Stream Frame length In
  input  wire [FRAME_LENGTH_WIDTH-1:0] s_axis_frame_length_tdata,
  input  wire                          s_axis_frame_length_tvalid,
  output wire                          s_axis_frame_length_tready,

  // AXI4-Stream Timestamp Out
  output wire [TIMESTAMP_WIDTH-1:0] m_axis_eligibility_timestamp_tdata,
  output wire                       m_axis_eligibility_timestamp_tvalid,
  input  wire                       m_axis_eligibility_timestamp_tready
  input wire                          clk,
  input wire                          rstn,

  // Settings
  //// committed_information_rate_inv [ps/Byte] = [sec/TByte]
  //// committed_burst_size [Byte]
  //// max_residence_time [ps]
  output wire [FLOW_WIDTH-1:0]        flow_id,
  output wire                         flow_ren,
  output wire                         flow_sel, // sel=0 -> committed_information_rate_inv, sel=1 -> committed_burst_size
  input wire [COMMIT_VALUE_WIDTH-1:0] committed_value,
  input wire [TIMESTAMP_WIDTH-1:0]    max_residence_time,

  // AXI4-Stream Timestamp In
  input wire [TIMESTAMP_WIDTH-1:0]    s_axis_arrival_timestamp_tdata,
  input wire                          s_axis_arrival_timestamp_tvalid,
  output wire                         s_axis_arrival_timestamp_tready,

  // AXI4-Stream Flow In
  input wire [FLOW_WIDTH-1:0]         s_axis_flow_tdata,
  input wire                          s_axis_flow_tvalid,
  output wire                         s_axis_flow_tready,

  // AXI4-Stream Frame length In
  input wire [FRAME_LENGTH_WIDTH-1:0] s_axis_frame_length_tdata,
  input wire                          s_axis_frame_length_tvalid,
  output wire                         s_axis_frame_length_tready,

  // AXI4-Stream Timestamp Out
  output wire [TIMESTAMP_WIDTH-1:0]   m_axis_eligibility_timestamp_tdata,
  output wire                         m_axis_eligibility_timestamp_tvalid,
  input wire                          m_axis_eligibility_timestamp_tready
);

  // AXI4-Stream connection
  assign s_axis_flow_tready = (state == STATE_WAIT_FOR_FLOW);
  assign s_axis_arrival_timestamp_tready = (state == STATE_WAIT_FOR_ARRIVAL_TIMESTAMP);
  assign m_axis_eligibility_timestamp_tdata = eligibility_timestamp;
  assign m_axis_eligibility_timestamp_tvalid = (state == STATE_OUTPUT_ELIGIBILITY_TIMESTAMP);
  assign s_axis_frame_length_tready = (state == STATE_WAIT_FOR_FRAME_LENGTH);

  // Main state
  reg [STATE_WIDTH-1:0] state = 'd0;
  localparam STATE_WIDTH = 4;
  localparam STATE_IDLE = 0;
  localparam STATE_WAIT_FOR_FLOW = 1;
  localparam STATE_WAIT_FOR_ARRIVAL_TIMESTAMP = 2;
  localparam STATE_WAIT_FOR_FRAME_LENGTH = 3;
  localparam STATE_CALCULATE_STEP_1 = 4;
  localparam STATE_CALCULATE_STEP_2 = 5;
  localparam STATE_CALCULATE_STEP_3 = 6;
  localparam STATE_CALCULATE_STEP_4 = 7;
  localparam STATE_OUTPUT_ELIGIBILITY_TIMESTAMP = 8;
  localparam STATE_RESET = 0;
  localparam STATE_IDLE = 1;
  localparam STATE_WAIT_FOR_FLOW = 2;
  localparam STATE_WAIT_FOR_ARRIVAL_TIMESTAMP = 3;
  localparam STATE_WAIT_FOR_FRAME_LENGTH = 4;
  localparam STATE_BUBBLE = 5;
  localparam STATE_CALCULATE_STEP_1 = 6;
  localparam STATE_CALCULATE_STEP_2 = 7;
  localparam STATE_CALCULATE_STEP_3 = 8;
  localparam STATE_CALCULATE_STEP_4 = 9;
  localparam STATE_CALCULATE_STEP_5 = 10;
  localparam STATE_CALCULATE_STEP_6 = 11;
  localparam STATE_OUTPUT_ELIGIBILITY_TIMESTAMP = 12;
  // Important registers
  reg [FLOW_WIDTH-1:0] flow = 'd0;
  reg [FRAME_LENGTH_WIDTH-1:0] frame_length_reg = 'd0;
  reg [TIMESTAMP_WIDTH-1:0] arrival_timestamp = 'd0;
  reg [TIMESTAMP_WIDTH-1:0] eligibility_timestamp = 'd0;
  // Independent register per flow
  reg [TIMESTAMP_WIDTH-1:0] bucket_empty_time = 'd0;           // [ps]
  reg [TIMESTAMP_WIDTH-1:0] bucket_empty_time_per_flow[FLOW_NUM-1:0];
  (* RAM_STYLE="DISTRIBUTED" *) reg [TIMESTAMP_WIDTH-1:0] bucket_empty_time_per_flow[FLOW_NUM-1:0];
  // Shared register between each flow
  reg [TIMESTAMP_WIDTH-1:0] group_eligibility_time      = 'd0; // [ps]
  // Calculated temporary registers
  reg [TIMESTAMP_WIDTH-1:0] length_recovery_duration    = 'd0; // [ps]
  reg [TIMESTAMP_WIDTH-1:0] empty_to_full_duration      = 'd0; // [ps]
  reg [TIMESTAMP_WIDTH-1:0] scheduler_eligibility_time  = 'd0; // [ps]
  reg [TIMESTAMP_WIDTH-1:0] bucket_full_time            = 'd0; // [ps]
  // Avoid overflow
  wire [TIMESTAMP_WIDTH:0]   scheduler_eligibility_time_tmp = bucket_empty_time + length_recovery_duration;
  wire [TIMESTAMP_WIDTH-1:0] scheduler_eligibility_time_val = (scheduler_eligibility_time_tmp[TIMESTAMP_WIDTH])? {TIMESTAMP_WIDTH{1'b1}}: scheduler_eligibility_time_tmp;
  wire [TIMESTAMP_WIDTH:0]   bucket_full_time_tmp           = bucket_empty_time + empty_to_full_duration;
  reg [TIMESTAMP_WIDTH-1:0] length_recovery_duration_d  = 'd0; // [ps]
  reg [TIMESTAMP_WIDTH-1:0] empty_to_full_duration_d    = 'd0; // [ps]
  reg [TIMESTAMP_WIDTH-1:0] bucket_empty_time_tmp       = 'd0; // [ps]
  reg [TIMESTAMP_WIDTH-1:0] arrival_plus_max_residence  = 'd0; // [ps]
  reg [TIMESTAMP_WIDTH-1:0] scheduler_eligibility_time  = 'd0; // [ps]
  reg [TIMESTAMP_WIDTH-1:0] bucket_full_time            = 'd0; // [ps]
  // Avoid overflow
  wire [TIMESTAMP_WIDTH:0]   scheduler_eligibility_time_tmp = bucket_empty_time + length_recovery_duration_d;
  wire [TIMESTAMP_WIDTH-1:0] scheduler_eligibility_time_val = (scheduler_eligibility_time_tmp[TIMESTAMP_WIDTH])? {TIMESTAMP_WIDTH{1'b1}}: scheduler_eligibility_time_tmp;
  wire [TIMESTAMP_WIDTH:0]   bucket_full_time_tmp           = bucket_empty_time + empty_to_full_duration_d;
  wire [TIMESTAMP_WIDTH-1:0] bucket_full_time_val           = (bucket_full_time_tmp[TIMESTAMP_WIDTH])?           {TIMESTAMP_WIDTH{1'b1}}: bucket_full_time_tmp;
  wire [TIMESTAMP_WIDTH:0]   arrival_plus_max_residence_tmp = arrival_timestamp + max_residence_time;
  wire [TIMESTAMP_WIDTH-1:0] arrival_plus_max_residence_val = (arrival_plus_max_residence_tmp[TIMESTAMP_WIDTH])? {TIMESTAMP_WIDTH{1'b1}}: arrival_plus_max_residence_tmp;
  wire [TIMESTAMP_WIDTH:0]   bucket_empty_time_tmp_0        = scheduler_eligibility_time + eligibility_timestamp;
  wire [TIMESTAMP_WIDTH-1:0] bucket_empty_time_val_0        = (bucket_empty_time_tmp_0[TIMESTAMP_WIDTH])?        {TIMESTAMP_WIDTH{1'b1}}: bucket_empty_time_tmp_0;
  wire [TIMESTAMP_WIDTH:0]   bucket_empty_time_tmp_1        = bucket_empty_time_val_0 - bucket_full_time;
  wire [TIMESTAMP_WIDTH:0]   bucket_empty_time_tmp_1        = bucket_empty_time_tmp - bucket_full_time;
  wire [TIMESTAMP_WIDTH-1:0] bucket_empty_time_val_1        = (bucket_empty_time_tmp_1[TIMESTAMP_WIDTH])?        {TIMESTAMP_WIDTH{1'b0}}: bucket_empty_time_tmp_1;
  // For for-loop
  integer i;
  always @ (posedge clk) begin
    if (!rstn) begin
      bucket_empty_time <= 'd0;
      for (i = 0; i < FLOW_NUM; i = i + 1) bucket_empty_time_per_flow[i] <= 'd0;
      group_eligibility_time <= 'd0;
      length_recovery_duration <= 'd0;
      empty_to_full_duration <= 'd0;
      scheduler_eligibility_time <= 'd0;
      bucket_full_time <= 'd0;
      flow <= 'd0;
      frame_length_reg <= 'd0;
      arrival_timestamp <= 'd0;
      eligibility_timestamp <= 'd0;
      state <= STATE_IDLE;
    end else begin
      case (state)
        STATE_IDLE: begin
          length_recovery_duration <= 'd0;
          empty_to_full_duration <= 'd0;
          scheduler_eligibility_time <= 'd0;
          bucket_full_time <= 'd0;
          flow <= 'd0;
          frame_length_reg <= 'd0;
          arrival_timestamp <= 'd0;
          eligibility_timestamp <= 'd0;
      flow <= 'd0;
      state <= STATE_RESET;
    end else begin
      case (state)
        STATE_RESET: begin
          bucket_empty_time_per_flow[flow] <= 'd0;
          flow <= flow + 1;
          group_eligibility_time <= 'd0;

          if (flow == FLOW_NUM - 1) begin
            state <= STATE_IDLE;
          end
        end
        STATE_IDLE: begin
          flow <= 'd0;
          state <= STATE_WAIT_FOR_FLOW;
        end
        STATE_WAIT_FOR_FLOW: begin
          // Wait for flow
          if (s_axis_flow_tvalid & s_axis_flow_tready) begin
            flow <= s_axis_flow_tdata;
            state <= STATE_WAIT_FOR_ARRIVAL_TIMESTAMP;
          end else begin
            // Do nothing
          end
        end
        STATE_WAIT_FOR_ARRIVAL_TIMESTAMP: begin
          // Wait for arrival_timestamp
          if (s_axis_arrival_timestamp_tvalid & s_axis_arrival_timestamp_tready) begin
            arrival_timestamp <= s_axis_arrival_timestamp_tdata;
            state <= STATE_WAIT_FOR_FRAME_LENGTH;
          end else begin
            // Do nothing
          end
        end
        STATE_WAIT_FOR_FRAME_LENGTH: begin
          // Wait for frame_length
          if (s_axis_frame_length_tvalid & s_axis_frame_length_tready) begin
            frame_length_reg <= s_axis_frame_length_tdata;
            state <= STATE_CALCULATE_STEP_1;
            state <= STATE_BUBBLE;
          end else begin
            // Do nothing
          end
        end
        STATE_BUBBLE: begin
          state <= STATE_CALCULATE_STEP_1;
        end
        STATE_CALCULATE_STEP_1: begin
          // Calculate step 1
          bucket_empty_time <= bucket_empty_time_per_flow[flow];
          length_recovery_duration <= frame_length_reg * committed_information_rate_inv;
          empty_to_full_duration <= committed_burst_size * committed_information_rate_inv;
          state <= STATE_CALCULATE_STEP_2;
        end
        STATE_CALCULATE_STEP_2: begin
          // Calculate step 2
          scheduler_eligibility_time <= scheduler_eligibility_time_val; // bucket_empty_time + length_recovery_duration;
          bucket_full_time <= bucket_full_time_val; // bucket_empty_time + empty_to_full_duration;
          // Delay register2 to ease routing.
          length_recovery_duration_d <= length_recovery_duration;
          empty_to_full_duration_d <= empty_to_full_duration;
          state <= STATE_CALCULATE_STEP_3;
        end
        STATE_CALCULATE_STEP_3: begin
          // Calculate step 3
          scheduler_eligibility_time <= scheduler_eligibility_time_val; // bucket_empty_time + length_recovery_duration;
          bucket_full_time <= bucket_full_time_val; // bucket_empty_time + empty_to_full_duration;
          state <= STATE_CALCULATE_STEP_4;
        end
        STATE_CALCULATE_STEP_4: begin
          // Calculate step 4
          // Adopt the max value of arrival_timestamp, group_eligibility_time and bucket_empty_time
          if (arrival_timestamp > group_eligibility_time && arrival_timestamp > scheduler_eligibility_time) begin
            eligibility_timestamp <= arrival_timestamp;
          end else if (group_eligibility_time > scheduler_eligibility_time) begin
            eligibility_timestamp <= group_eligibility_time;
          end else begin
            eligibility_timestamp <= scheduler_eligibility_time;
          end
          state <= STATE_CALCULATE_STEP_4;
        end
        STATE_CALCULATE_STEP_4: begin
          // Calculate step 4
          if (eligibility_timestamp <= arrival_plus_max_residence_val) begin  // arrival_timestamp + max_residence_time
          state <= STATE_CALCULATE_STEP_5;
        end
        STATE_CALCULATE_STEP_5: begin
          // Calculate step 5
          bucket_empty_time_tmp <= bucket_empty_time_val_0; // scheduler_eligibility_time + eligibility_timestamp
          arrival_plus_max_residence <= arrival_plus_max_residence_val; // arrival_timestamp + max_residence_time
          state <= STATE_CALCULATE_STEP_6;
        end
        STATE_CALCULATE_STEP_6: begin
          // Calculate step 6
          if (eligibility_timestamp <= arrival_plus_max_residence) begin  // arrival_timestamp + max_residence_time
            group_eligibility_time <= eligibility_timestamp;
            if (eligibility_timestamp < bucket_full_time) begin
              bucket_empty_time_per_flow[flow] <= scheduler_eligibility_time;
            end else begin
              bucket_empty_time_per_flow[flow] <= bucket_empty_time_val_1; // scheduler_eligibility_time + eligibility_timestamp - bucket_full_time;
            end
          end else begin
            // Discard frame
            eligibility_timestamp <= 'd0; // Zero means discard frame
          end
          state <= STATE_OUTPUT_ELIGIBILITY_TIMESTAMP;
        end
        STATE_OUTPUT_ELIGIBILITY_TIMESTAMP: begin
          // Output eligibility_timestamp
          if (m_axis_eligibility_timestamp_tvalid & m_axis_eligibility_timestamp_tready) begin
            state <= STATE_IDLE;
          end else begin
            // Do nothing
          end
        end
        default: begin
          bucket_empty_time <= 'd0;
          for (i = 0; i < FLOW_NUM; i = i + 1) bucket_empty_time_per_flow[i] <= 'd0;
          group_eligibility_time <= 'd0;
          length_recovery_duration <= 'd0;
          empty_to_full_duration <= 'd0;
          scheduler_eligibility_time <= 'd0;
          bucket_full_time <= 'd0;
          flow <= 'd0;
          frame_length_reg <= 'd0;
          arrival_timestamp <= 'd0;
          eligibility_timestamp <= 'd0;
          state <= STATE_IDLE;
          state <= STATE_RESET;
        end
      endcase
    end
  end

  // Set value based on flow value
  assign flow_id = flow;
  assign flow_ren = (state == STATE_WAIT_FOR_ARRIVAL_TIMESTAMP || state == STATE_WAIT_FOR_FRAME_LENGTH);
  assign flow_sel = (state == STATE_WAIT_FOR_ARRIVAL_TIMESTAMP) ? 0 : 1;

  reg flow_sel_reg;
  reg flow_ren_reg;
  reg [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv = 'd0;
  reg [COMMIT_VALUE_WIDTH-1:0] committed_burst_size = 'd0;
  always @ (posedge clk) begin
    if (!rstn) begin
      committed_information_rate_inv <= 'd0;
      committed_burst_size <= 'd0;
    end else begin
      case(flow)
        0: begin
          committed_information_rate_inv <= committed_information_rate_inv_0;
          committed_burst_size <= committed_burst_size_0;
        end
        1: begin
          committed_information_rate_inv <= committed_information_rate_inv_1;
          committed_burst_size <= committed_burst_size_1;
        end
        2: begin
          committed_information_rate_inv <= committed_information_rate_inv_2;
          committed_burst_size <= committed_burst_size_2;
        end
        3: begin
          committed_information_rate_inv <= committed_information_rate_inv_3;
          committed_burst_size <= committed_burst_size_3;
        end
        4: begin
          committed_information_rate_inv <= committed_information_rate_inv_4;
          committed_burst_size <= committed_burst_size_4;
        end
        5: begin
          committed_information_rate_inv <= committed_information_rate_inv_5;
          committed_burst_size <= committed_burst_size_5;
        end
        6: begin
          committed_information_rate_inv <= committed_information_rate_inv_6;
          committed_burst_size <= committed_burst_size_6;
        end
        7: begin
          committed_information_rate_inv <= committed_information_rate_inv_7;
          committed_burst_size <= committed_burst_size_7;
        end
        8: begin
          committed_information_rate_inv <= committed_information_rate_inv_8;
          committed_burst_size <= committed_burst_size_8;
        end
        9: begin
          committed_information_rate_inv <= committed_information_rate_inv_9;
          committed_burst_size <= committed_burst_size_9;
        end
        10: begin
          committed_information_rate_inv <= committed_information_rate_inv_10;
          committed_burst_size <= committed_burst_size_10;
        end
        11: begin
          committed_information_rate_inv <= committed_information_rate_inv_11;
          committed_burst_size <= committed_burst_size_11;
        end
        12: begin
          committed_information_rate_inv <= committed_information_rate_inv_12;
          committed_burst_size <= committed_burst_size_12;
        end
        13: begin
          committed_information_rate_inv <= committed_information_rate_inv_13;
          committed_burst_size <= committed_burst_size_13;
        end
        14: begin
          committed_information_rate_inv <= committed_information_rate_inv_14;
          committed_burst_size <= committed_burst_size_14;
        end
        15: begin
          committed_information_rate_inv <= committed_information_rate_inv_15;
          committed_burst_size <= committed_burst_size_15;
        end
        default: begin
          committed_information_rate_inv <= 'd0;
          committed_burst_size <= 'd0;
        end
      endcase
      flow_ren_reg <= 1'b0;
      flow_sel_reg <= 1'b0;
      committed_information_rate_inv <= 'd0;
      committed_burst_size <= 'd0;
    end else begin
      flow_ren_reg <= flow_ren;
      flow_sel_reg <= flow_sel;

      if (flow_ren_reg) begin
        if (flow_sel_reg == 0) begin
          committed_information_rate_inv <= committed_value;
        end else begin
          committed_burst_size <= committed_value;
        end
      end
    end
  end

endmodule

module process_frame_register #(
  parameter FLOW_NUM = 16,
  parameter FLOW_WIDTH = 8,
  parameter TIMESTAMP_WIDTH = 72,     // Must be aligned to DATA_WIDTH
  parameter COMMIT_VALUE_WIDTH = 32,
  parameter C_S_AXI_DATA_WIDTH = 32,
  parameter NUM_OF_REGISTERS = 36,
  parameter C_S_AXI_ADDR_WIDTH = $clog2(NUM_OF_REGISTERS * (C_S_AXI_DATA_WIDTH / 8))
) (
  // clock, negative-reset
  input wire                              clk,
  input wire                              rstn,

  // AXI4-Lite
  input wire [C_S_AXI_ADDR_WIDTH-1:0]     S_AXI_AWADDR,
  input wire [2:0]                        S_AXI_AWPROT,
  input wire                              S_AXI_AWVALID,
  output wire                             S_AXI_AWREADY,
  input wire [C_S_AXI_DATA_WIDTH-1:0]     S_AXI_WDATA,
  input wire [(C_S_AXI_DATA_WIDTH/8)-1:0] S_AXI_WSTRB,
  input wire                              S_AXI_WVALID,
  output wire                             S_AXI_WREADY,
  output wire [1:0]                       S_AXI_BRESP,
  output wire                             S_AXI_BVALID,
  input wire                              S_AXI_BREADY,
  input wire [C_S_AXI_ADDR_WIDTH-1:0]     S_AXI_ARADDR,
  input wire [2:0]                        S_AXI_ARPROT,
  input wire                              S_AXI_ARVALID,
  output wire                             S_AXI_ARREADY,
  output wire [C_S_AXI_DATA_WIDTH-1:0]    S_AXI_RDATA,
  output wire [1:0]                       S_AXI_RRESP,
  output wire                             S_AXI_RVALID,
  input wire                              S_AXI_RREADY,

  // To user interface
  input wire [FLOW_WIDTH-1:0]             flow_id,
  input wire                              flow_ren,
  input wire                              flow_sel, // sel=0 -> committed_information_rate_inv, sel=1 -> committed_burst_size
  output reg [COMMIT_VALUE_WIDTH-1:0]     committed_value,
  output wire [TIMESTAMP_WIDTH-1:0]       max_residence_time
);

  localparam REG_ADDR_BIT = $clog2(NUM_OF_REGISTERS);

  wire [REG_ADDR_BIT-1:0]                 local_waddr;
  wire [REG_ADDR_BIT-1:0]                 local_raddr;
  wire                                    local_wen;
  wire                                    local_ren;
  wire [C_S_AXI_DATA_WIDTH-1:0]           local_wdata;
  reg [C_S_AXI_DATA_WIDTH-1:0]            local_rdata;
  reg                                     local_rdatavalid;

  axi4_lite_slave_if #(
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .REG_ADDR_BIT(REG_ADDR_BIT),
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
  ) axi4_lite_slave_if_i (
    clk,
    rstn,
    S_AXI_AWADDR,
    S_AXI_AWPROT,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARPROT,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY,
    local_waddr,
    local_raddr,
    local_wen,
    local_ren,
    local_wdata,
    local_rdata,
    local_rdatavalid
  );

  // Triple Port RAM
  // - commited_values: Write (axi4lite), Read (axi4lite), Read (core logic)
  reg [COMMIT_VALUE_WIDTH-1:0]            committed_values[FLOW_NUM * 2 - 1 : 0];

  // initialize commited_values
  integer                                 i;
  initial begin
    for (i = 0; i < FLOW_NUM * 2; i = i + 1) begin
      committed_values[i] = 0;
    end
  end

  // commited values read/write
  wire [FLOW_WIDTH:0] flow_raddr = {flow_id, flow_sel};
  reg [C_S_AXI_DATA_WIDTH-1:0] local_0_rdata;
  reg                          local_0_rdatavalid;
  always @(posedge clk) begin
    if (!rstn) begin
      local_0_rdata <= 0;
      local_0_rdatavalid <= 1'b0;
      committed_value <= 0;
    end else begin
      // write port
      if (local_wen && local_waddr < FLOW_NUM * 2) begin
        committed_values[local_waddr[4:0]] <= local_wdata;
      end

      // read port
      local_0_rdatavalid <= 1'b0;
      if (flow_ren) begin
        if (flow_raddr < FLOW_NUM * 2) begin
          committed_value <= committed_values[flow_raddr];
        end else begin
          committed_value <= 0;
        end
      end

      if (local_ren) begin
        if (local_raddr < FLOW_NUM * 2) begin
          local_0_rdata <= committed_values[local_raddr];
          local_0_rdatavalid <= 1'b1;
        end
      end
    end
  end

  // max_residence_time read/write
  reg [127:0] max_residence_time_i128;
  assign max_residence_time = max_residence_time_i128[TIMESTAMP_WIDTH-1:0];

  reg [C_S_AXI_DATA_WIDTH-1:0] local_1_rdata;
  reg                          local_1_rdatavalid;
  always @(posedge clk) begin
    if (!rstn) begin
      max_residence_time_i128 <= {128{1'b1}};
      local_1_rdata <= 0;
      local_1_rdatavalid <= 1'b0;
    end else begin
      if (local_wen) begin
        case (local_waddr)
          FLOW_NUM * 2 + 0: max_residence_time_i128[0 +: 32] <= local_wdata;
          FLOW_NUM * 2 + 1: max_residence_time_i128[32 +: 32] <= local_wdata;
          FLOW_NUM * 2 + 2: max_residence_time_i128[64 +: 32] <= local_wdata;
          FLOW_NUM * 2 + 3: max_residence_time_i128[96 +: 32] <= local_wdata;
        endcase
      end

      local_1_rdatavalid <= 1'b0;
      if (local_ren) begin
        case (local_raddr)
          FLOW_NUM * 2 + 0: local_1_rdata <= max_residence_time_i128[0 +: 32];
          FLOW_NUM * 2 + 1: local_1_rdata <= max_residence_time_i128[32 +: 32];
          FLOW_NUM * 2 + 2: local_1_rdata <= max_residence_time_i128[64 +: 32];
          FLOW_NUM * 2 + 3: local_1_rdata <= max_residence_time_i128[96 +: 32];
        endcase
        local_1_rdatavalid <= (local_raddr >= FLOW_NUM * 2);
      end
    end
  end

  always @(posedge clk) begin
    if (!rstn) begin
      local_rdata <= 0;
      local_rdatavalid <= 0;
    end else begin
      if (local_0_rdatavalid) begin
        local_rdata <= local_0_rdata;
        local_rdatavalid <= 1'b1;
      end else if (local_1_rdatavalid) begin
        local_rdata <= local_1_rdata;
        local_rdatavalid <= 1'b1;
      end else begin
        local_rdata <= local_rdata;
        local_rdatavalid <= 1'b0;
      end
    end
  end

endmodule

module process_frame #(
  parameter DATA_WIDTH = 8,
  parameter FLOW_NUM = 16,
  parameter FLOW_WIDTH = 8,
  parameter FRAME_LENGTH_WIDTH = 16,  // Must be aligned to DATA_WIDTH
  parameter TIMESTAMP_WIDTH = 72,     // Must be aligned to DATA_WIDTH
  parameter COMMIT_VALUE_WIDTH = 32,
  parameter C_S_AXI_DATA_WIDTH = 32,
  parameter NUM_OF_REGISTERS = 36,
  parameter C_S_AXI_ADDR_WIDTH = $clog2(NUM_OF_REGISTERS * (C_S_AXI_DATA_WIDTH / 8))
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // AXI4-Lite
  input  wire [C_S_AXI_ADDR_WIDTH-1:0]     S_AXI_AWADDR,
  input  wire [2:0]                        S_AXI_AWPROT,
  input  wire                              S_AXI_AWVALID,
  output wire                              S_AXI_AWREADY,
  input  wire [C_S_AXI_DATA_WIDTH-1:0]     S_AXI_WDATA,
  input  wire [(C_S_AXI_DATA_WIDTH/8)-1:0] S_AXI_WSTRB,
  input  wire                              S_AXI_WVALID,
  output wire                              S_AXI_WREADY,
  output wire [1:0]                        S_AXI_BRESP,
  output wire                              S_AXI_BVALID,
  input  wire                              S_AXI_BREADY,
  input  wire [C_S_AXI_ADDR_WIDTH-1:0]     S_AXI_ARADDR,
  input  wire [2:0]                        S_AXI_ARPROT,
  input  wire                              S_AXI_ARVALID,
  output wire                              S_AXI_ARREADY,
  output wire [C_S_AXI_DATA_WIDTH-1:0]     S_AXI_RDATA,
  output wire [1:0]                        S_AXI_RRESP,
  output wire                              S_AXI_RVALID,
  input  wire                              S_AXI_RREADY,

  // AXI4-Stream Timestamp In
  input  wire [TIMESTAMP_WIDTH-1:0] s_axis_arrival_timestamp_tdata,
  input  wire                       s_axis_arrival_timestamp_tvalid,
  output wire                       s_axis_arrival_timestamp_tready,

  // AXI4-Stream Flow In
  input  wire [FLOW_WIDTH-1:0] s_axis_flow_tdata,
  input  wire                  s_axis_flow_tvalid,
  output wire                  s_axis_flow_tready,

  // AXI4-Stream Frame length In
  input  wire [FRAME_LENGTH_WIDTH-1:0] s_axis_frame_length_tdata,
  input  wire                          s_axis_frame_length_tvalid,
  output wire                          s_axis_frame_length_tready,

  // AXI4-Stream Timestamp Out
  output wire [TIMESTAMP_WIDTH-1:0] m_axis_eligibility_timestamp_tdata,
  output wire                       m_axis_eligibility_timestamp_tvalid,
  input  wire                       m_axis_eligibility_timestamp_tready
);

  wire [(C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS)-1:0] init_val;
  wire [(C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS)-1:0] val;
  reg  [COMMIT_VALUE_WIDTH-1:0] committed_information_rate_inv_0_15[15:0];
  reg  [COMMIT_VALUE_WIDTH-1:0] committed_burst_size_0_15[15:0];
  wire [TIMESTAMP_WIDTH-1:0] max_residence_time;

  assign init_val[C_S_AXI_DATA_WIDTH*32-1:C_S_AXI_DATA_WIDTH*0]  = 'd0;                             // committed_information_rate_inv, committed_burst_size x16
  assign init_val[C_S_AXI_DATA_WIDTH*36-1:C_S_AXI_DATA_WIDTH*32] = {(C_S_AXI_DATA_WIDTH*4){1'b1}};  // max_residence_time

  //--------------------------------------------------
  // Connection of AXI4-Lite Slave and Main module
  //--------------------------------------------------
  genvar i;
  generate
    for (i = 0; i < 16; i = i + 1) begin
      always @ (*) begin
        committed_information_rate_inv_0_15[i] <= val[64*i+31:64*i+0];
        committed_burst_size_0_15[i]           <= val[64*i+63:64*i+32];
      end
    end
  endgenerate
  assign max_residence_time = val[64*16+71:64*16+0];
  wire [FLOW_WIDTH-1:0]             flow_id;
  wire                              flow_ren;
  wire                              flow_sel;
  wire [COMMIT_VALUE_WIDTH-1:0]     committed_value;
  wire [TIMESTAMP_WIDTH-1:0]        max_residence_time;

  //-------------------------
  // Main module
  //-------------------------
  process_frame_core #(
    .DATA_WIDTH(DATA_WIDTH),
    .FLOW_NUM(FLOW_NUM),
    .FLOW_WIDTH(FLOW_WIDTH),
    .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH),
    .FRAME_LENGTH_WIDTH(FRAME_LENGTH_WIDTH),
    .COMMIT_VALUE_WIDTH(COMMIT_VALUE_WIDTH)
  ) process_frame_core_i (
    clk,
    rstn,
    committed_information_rate_inv_0_15[0],
    committed_information_rate_inv_0_15[1],
    committed_information_rate_inv_0_15[2],
    committed_information_rate_inv_0_15[3],
    committed_information_rate_inv_0_15[4],
    committed_information_rate_inv_0_15[5],
    committed_information_rate_inv_0_15[6],
    committed_information_rate_inv_0_15[7],
    committed_information_rate_inv_0_15[8],
    committed_information_rate_inv_0_15[9],
    committed_information_rate_inv_0_15[10],
    committed_information_rate_inv_0_15[11],
    committed_information_rate_inv_0_15[12],
    committed_information_rate_inv_0_15[13],
    committed_information_rate_inv_0_15[14],
    committed_information_rate_inv_0_15[15],
    committed_burst_size_0_15[0],
    committed_burst_size_0_15[1],
    committed_burst_size_0_15[2],
    committed_burst_size_0_15[3],
    committed_burst_size_0_15[4],
    committed_burst_size_0_15[5],
    committed_burst_size_0_15[6],
    committed_burst_size_0_15[7],
    committed_burst_size_0_15[8],
    committed_burst_size_0_15[9],
    committed_burst_size_0_15[10],
    committed_burst_size_0_15[11],
    committed_burst_size_0_15[12],
    committed_burst_size_0_15[13],
    committed_burst_size_0_15[14],
    committed_burst_size_0_15[15],
    flow_id,
    flow_ren,
    flow_sel,
    committed_value,
    max_residence_time,
    s_axis_arrival_timestamp_tdata,
    s_axis_arrival_timestamp_tvalid,
    s_axis_arrival_timestamp_tready,
    s_axis_flow_tdata,
    s_axis_flow_tvalid,
    s_axis_flow_tready,
    s_axis_frame_length_tdata,
    s_axis_frame_length_tvalid,
    s_axis_frame_length_tready,
    m_axis_eligibility_timestamp_tdata,
    m_axis_eligibility_timestamp_tvalid,
    m_axis_eligibility_timestamp_tready
  );

  //-------------------------
  // AXI4-Lite Slave module
  //-------------------------
  axi4_lite_slave #(
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .NUM_OF_REGISTERS(NUM_OF_REGISTERS),
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
  ) axi4_lite_slave_i (
  process_frame_register #(
    .FLOW_NUM(FLOW_NUM),
    .FLOW_WIDTH(FLOW_WIDTH),
    .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH),
    .COMMIT_VALUE_WIDTH(COMMIT_VALUE_WIDTH),
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .NUM_OF_REGISTERS(NUM_OF_REGISTERS),
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
  ) process_frame_register_i (
    clk,
    rstn,
    S_AXI_AWADDR,
    S_AXI_AWPROT,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARPROT,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY,
    init_val,
    val
    flow_id,
    flow_ren,
    flow_sel,
    committed_value,
    max_residence_time
  );

endmodule

`default_nettype wire
