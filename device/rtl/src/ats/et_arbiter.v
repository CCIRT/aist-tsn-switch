// Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module et_selector #(
  parameter TIMESTAMP_WIDTH = 72,      // Must be aligned to DATA_WIDTH
  parameter NUM_INPUT_PORTS = 3
) (
  // clock, negative-reset
  input wire                       clk,
  input wire                       rstn,

  input wire [TIMESTAMP_WIDTH-1:0] et_p0_tdata,
  input wire                       et_p0_tvalid,
  input wire [TIMESTAMP_WIDTH-1:0] et_p1_tdata,
  input wire                       et_p1_tvalid,
  input wire [TIMESTAMP_WIDTH-1:0] et_p2_tdata,
  input wire                       et_p2_tvalid,
  input wire [TIMESTAMP_WIDTH-1:0] et_p3_tdata,
  input wire                       et_p3_tvalid,
  input wire [TIMESTAMP_WIDTH-1:0] et_p4_tdata,
  input wire                       et_p4_tvalid,
  input wire [TIMESTAMP_WIDTH-1:0] et_p5_tdata,
  input wire                       et_p5_tvalid,
  input wire [TIMESTAMP_WIDTH-1:0] et_p6_tdata,
  input wire                       et_p6_tvalid,
  input wire [TIMESTAMP_WIDTH-1:0] et_p7_tdata,
  input wire                       et_p7_tvalid,

  input wire                       select_req,
  output reg [NUM_INPUT_PORTS-1:0] select_resp,
  output reg                       select_resp_valid);

  reg [TIMESTAMP_WIDTH-1:0]        p0_et;
  reg [TIMESTAMP_WIDTH-1:0]        p1_et;
  reg [TIMESTAMP_WIDTH-1:0]        p2_et;
  reg [TIMESTAMP_WIDTH-1:0]        p3_et;
  reg [TIMESTAMP_WIDTH-1:0]        p4_et;
  reg [TIMESTAMP_WIDTH-1:0]        p5_et;
  reg [TIMESTAMP_WIDTH-1:0]        p6_et;
  reg [TIMESTAMP_WIDTH-1:0]        p7_et;

  reg                              s0_valid;
  reg                              s1_valid;
  reg                              s2_valid;

  // Stage 0: latch input
  always @(posedge clk) begin
    if (select_req) begin
      p0_et <= (NUM_INPUT_PORTS >= 1) ? (et_p0_tdata | {TIMESTAMP_WIDTH{~et_p0_tvalid}}) : {TIMESTAMP_WIDTH{1'b1}};
      p1_et <= (NUM_INPUT_PORTS >= 2) ? (et_p1_tdata | {TIMESTAMP_WIDTH{~et_p1_tvalid}}) : {TIMESTAMP_WIDTH{1'b1}};
      p2_et <= (NUM_INPUT_PORTS >= 3) ? (et_p2_tdata | {TIMESTAMP_WIDTH{~et_p2_tvalid}}) : {TIMESTAMP_WIDTH{1'b1}};
      p3_et <= (NUM_INPUT_PORTS >= 4) ? (et_p3_tdata | {TIMESTAMP_WIDTH{~et_p3_tvalid}}) : {TIMESTAMP_WIDTH{1'b1}};
      p4_et <= (NUM_INPUT_PORTS >= 5) ? (et_p4_tdata | {TIMESTAMP_WIDTH{~et_p4_tvalid}}) : {TIMESTAMP_WIDTH{1'b1}};
      p5_et <= (NUM_INPUT_PORTS >= 6) ? (et_p5_tdata | {TIMESTAMP_WIDTH{~et_p5_tvalid}}) : {TIMESTAMP_WIDTH{1'b1}};
      p6_et <= (NUM_INPUT_PORTS >= 7) ? (et_p6_tdata | {TIMESTAMP_WIDTH{~et_p6_tvalid}}) : {TIMESTAMP_WIDTH{1'b1}};
      p7_et <= (NUM_INPUT_PORTS >= 8) ? (et_p7_tdata | {TIMESTAMP_WIDTH{~et_p7_tvalid}}) : {TIMESTAMP_WIDTH{1'b1}};
    end
    s0_valid <= select_req;
  end

  // Stage 1: x4 compare
  reg [TIMESTAMP_WIDTH-1:0]        p01_et;
  reg [TIMESTAMP_WIDTH-1:0]        p23_et;
  reg [TIMESTAMP_WIDTH-1:0]        p45_et;
  reg [TIMESTAMP_WIDTH-1:0]        p67_et;
  reg [1:0]                        p01_win;
  reg [1:0]                        p23_win;
  reg [1:0]                        p45_win;
  reg [1:0]                        p67_win;
  always @(posedge clk) begin
    // 0 vs 1
    if (p0_et <= p1_et) begin
      p01_et <= p0_et;
      p01_win <= 2'b01;
    end else begin
      p01_et <= p1_et;
      p01_win <= 2'b10;
    end

    // 2 vs 3
    if (p2_et <= p3_et) begin
      p23_et <= p2_et;
      p23_win <= 2'b01;
    end else begin
      p23_et <= p3_et;
      p23_win <= 2'b10;
    end

    // 4 vs 5
    if (p4_et <= p5_et) begin
      p45_et <= p4_et;
      p45_win <= 2'b01;
    end else begin
      p45_et <= p5_et;
      p45_win <= 2'b10;
    end

    // 6 vs 7
    if (p6_et <= p7_et) begin
      p67_et <= p6_et;
      p67_win <= 2'b01;
    end else begin
      p67_et <= p7_et;
      p67_win <= 2'b10;
    end

    s1_valid <= s0_valid;
  end

  // Stage 2: x2 compare
  reg [TIMESTAMP_WIDTH-1:0]        p0123_et;
  reg [TIMESTAMP_WIDTH-1:0]        p4567_et;
  reg [3:0]                        p0123_win;
  reg [3:0]                        p4567_win;
  always @(posedge clk) begin
    // 01 vs 23
    if (p01_et <= p23_et) begin
      p0123_et <= p01_et;
      p0123_win <= {2'b00, p01_win};
    end else begin
      p0123_et <= p23_et;
      p0123_win <= {p23_win, 2'b00};
    end

    // 45 vs 67
    if (p45_et <= p67_et) begin
      p4567_et <= p45_et;
      p4567_win <= {2'b00, p45_win};
    end else begin
      p4567_et <= p67_et;
      p4567_win <= {p67_win, 2'b00};
    end

    s2_valid <= s1_valid;
  end

  // Stage 2: x1 compare
  always @(posedge clk) begin
    // 0123 vs 4567
    if (p0123_et <= p4567_et) begin
      select_resp <= {4'b0000, p0123_win};
    end else begin
      select_resp <= {p4567_win, 4'b0000};
    end
    select_resp_valid <= s2_valid;
  end
endmodule

module et_reader #(
  parameter DATA_WIDTH = 8,
  parameter TIMESTAMP_WIDTH = 72,      // Must be aligned to DATA_WIDTH
  parameter NUM_INPUT_PORTS = 3
) (
   // clock, negative-reset
   input wire                       clk,
   input wire                       rstn,

   // ET-passed AXI4-Stream Timestamp In
   input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p0_tdata,
   input wire                       s_axis_eligibility_timestamp_p0_tvalid,
   output wire                      s_axis_eligibility_timestamp_p0_tready,
   input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p1_tdata,
   input wire                       s_axis_eligibility_timestamp_p1_tvalid,
   output wire                      s_axis_eligibility_timestamp_p1_tready,
   input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p2_tdata,
   input wire                       s_axis_eligibility_timestamp_p2_tvalid,
   output wire                      s_axis_eligibility_timestamp_p2_tready,
   input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p3_tdata,
   input wire                       s_axis_eligibility_timestamp_p3_tvalid,
   output wire                      s_axis_eligibility_timestamp_p3_tready,
   input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p4_tdata,
   input wire                       s_axis_eligibility_timestamp_p4_tvalid,
   output wire                      s_axis_eligibility_timestamp_p4_tready,
   input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p5_tdata,
   input wire                       s_axis_eligibility_timestamp_p5_tvalid,
   output wire                      s_axis_eligibility_timestamp_p5_tready,
   input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p6_tdata,
   input wire                       s_axis_eligibility_timestamp_p6_tvalid,
   output wire                      s_axis_eligibility_timestamp_p6_tready,
   input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p7_tdata,
   input wire                       s_axis_eligibility_timestamp_p7_tvalid,
   output wire                      s_axis_eligibility_timestamp_p7_tready,

   // output
   output reg [7:0]                 m_axis_port_tdata,
   output reg                       m_axis_port_tvalid,
   input wire                       m_axis_port_tready);

  // Main state
  reg [STATE_WIDTH-1:0]             state = 'd0;
  localparam STATE_WIDTH = 2;
  localparam STATE_WAIT_FOR_TIMESTAMP = 0;
  localparam STATE_WAIT_SELECTION = 1;
  localparam STATE_SEND_OUTPUT = 2;

  reg                               select_req;
  wire [NUM_INPUT_PORTS-1:0]        select_resp;
  wire                              select_resp_valid;

  wire [7:0]                        s_axis_et_all_tvalid =
                                    { s_axis_eligibility_timestamp_p0_tvalid,
                                      s_axis_eligibility_timestamp_p1_tvalid,
                                      s_axis_eligibility_timestamp_p2_tvalid,
                                      s_axis_eligibility_timestamp_p3_tvalid,
                                      s_axis_eligibility_timestamp_p4_tvalid,
                                      s_axis_eligibility_timestamp_p5_tvalid,
                                      s_axis_eligibility_timestamp_p6_tvalid,
                                      s_axis_eligibility_timestamp_p7_tvalid };

  reg [7:0]                         s_axis_tready;
  assign s_axis_eligibility_timestamp_p0_tready = s_axis_tready[0];
  assign s_axis_eligibility_timestamp_p1_tready = s_axis_tready[1];
  assign s_axis_eligibility_timestamp_p2_tready = s_axis_tready[2];
  assign s_axis_eligibility_timestamp_p3_tready = s_axis_tready[3];
  assign s_axis_eligibility_timestamp_p4_tready = s_axis_tready[4];
  assign s_axis_eligibility_timestamp_p5_tready = s_axis_tready[5];
  assign s_axis_eligibility_timestamp_p6_tready = s_axis_tready[6];
  assign s_axis_eligibility_timestamp_p7_tready = s_axis_tready[7];

  // State machine
  always @ (posedge clk) begin
    if (!rstn) begin
      state <= STATE_WAIT_FOR_TIMESTAMP;
      select_req <= 0;
      s_axis_tready <= 0;
    end else begin
      case (state)
        STATE_WAIT_FOR_TIMESTAMP: begin
          if (|s_axis_et_all_tvalid) begin
            // send request to selctor
            state <= STATE_WAIT_SELECTION;
            select_req <= 1;
          end else begin
            // Do nothing
          end
        end
        STATE_WAIT_SELECTION: begin
          select_req <= 0;
          if (select_resp_valid) begin
            state <= STATE_SEND_OUTPUT;

            // これを行う必要がある
            s_axis_tready <= select_resp;
          end else begin
            // Do nothing
          end
        end
        STATE_SEND_OUTPUT: begin
          s_axis_tready <= 0;
          // 前回分の送信が終わっていない場合はここで待機
          if (!m_axis_port_tvalid || m_axis_port_tready) begin
            state <= STATE_WAIT_FOR_TIMESTAMP;
          end else begin
            // Do nothing
          end
        end
        default: begin
          state <= STATE_WAIT_FOR_TIMESTAMP;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (!rstn) begin
      m_axis_port_tdata <= 0;
      m_axis_port_tvalid <= 0;
    end else begin
      if (state == STATE_WAIT_SELECTION && select_resp_valid) begin
        m_axis_port_tdata <= select_resp;
        m_axis_port_tvalid <= 1'b1;
      end else begin
        m_axis_port_tdata <= m_axis_port_tdata;
        m_axis_port_tvalid <= m_axis_port_tvalid & !m_axis_port_tready;
      end
    end
  end

  et_selector #(
                // Parameters
                .TIMESTAMP_WIDTH        (TIMESTAMP_WIDTH),
                .NUM_INPUT_PORTS        (NUM_INPUT_PORTS))
  et_selector_i (
                 // Outputs
                 .select_resp           (select_resp[NUM_INPUT_PORTS-1:0]),
                 .select_resp_valid     (select_resp_valid),
                 // Inputs
                 .clk                   (clk),
                 .rstn                  (rstn),
                 .et_p0_tdata           (s_axis_eligibility_timestamp_p0_tdata[TIMESTAMP_WIDTH-1:0]),
                 .et_p0_tvalid          (s_axis_eligibility_timestamp_p0_tvalid),
                 .et_p1_tdata           (s_axis_eligibility_timestamp_p1_tdata[TIMESTAMP_WIDTH-1:0]),
                 .et_p1_tvalid          (s_axis_eligibility_timestamp_p1_tvalid),
                 .et_p2_tdata           (s_axis_eligibility_timestamp_p2_tdata[TIMESTAMP_WIDTH-1:0]),
                 .et_p2_tvalid          (s_axis_eligibility_timestamp_p2_tvalid),
                 .et_p3_tdata           (s_axis_eligibility_timestamp_p3_tdata[TIMESTAMP_WIDTH-1:0]),
                 .et_p3_tvalid          (s_axis_eligibility_timestamp_p3_tvalid),
                 .et_p4_tdata           (s_axis_eligibility_timestamp_p4_tdata[TIMESTAMP_WIDTH-1:0]),
                 .et_p4_tvalid          (s_axis_eligibility_timestamp_p4_tvalid),
                 .et_p5_tdata           (s_axis_eligibility_timestamp_p5_tdata[TIMESTAMP_WIDTH-1:0]),
                 .et_p5_tvalid          (s_axis_eligibility_timestamp_p5_tvalid),
                 .et_p6_tdata           (s_axis_eligibility_timestamp_p6_tdata[TIMESTAMP_WIDTH-1:0]),
                 .et_p6_tvalid          (s_axis_eligibility_timestamp_p6_tvalid),
                 .et_p7_tdata           (s_axis_eligibility_timestamp_p7_tdata[TIMESTAMP_WIDTH-1:0]),
                 .et_p7_tvalid          (s_axis_eligibility_timestamp_p7_tvalid),
                 .select_req            (select_req));


endmodule

module et_arbiter #(
  parameter DATA_WIDTH = 8,
  parameter KEEP_WIDTH = DATA_WIDTH / 8,
  parameter TIMESTAMP_WIDTH = 72,      // Must be aligned to DATA_WIDTH
  parameter NUM_INPUT_PORTS = 3
) (
  // clock, negative-reset
  input wire                       clk,
  input wire                       rstn,

  // ET-passed AXI4-Stream Timestamp In
  input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p0_tdata,
  input wire                       s_axis_eligibility_timestamp_p0_tvalid,
  output wire                      s_axis_eligibility_timestamp_p0_tready,
  input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p1_tdata,
  input wire                       s_axis_eligibility_timestamp_p1_tvalid,
  output wire                      s_axis_eligibility_timestamp_p1_tready,
  input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p2_tdata,
  input wire                       s_axis_eligibility_timestamp_p2_tvalid,
  output wire                      s_axis_eligibility_timestamp_p2_tready,
  input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p3_tdata,
  input wire                       s_axis_eligibility_timestamp_p3_tvalid,
  output wire                      s_axis_eligibility_timestamp_p3_tready,
  input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p4_tdata,
  input wire                       s_axis_eligibility_timestamp_p4_tvalid,
  output wire                      s_axis_eligibility_timestamp_p4_tready,
  input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p5_tdata,
  input wire                       s_axis_eligibility_timestamp_p5_tvalid,
  output wire                      s_axis_eligibility_timestamp_p5_tready,
  input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p6_tdata,
  input wire                       s_axis_eligibility_timestamp_p6_tvalid,
  output wire                      s_axis_eligibility_timestamp_p6_tready,
  input wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p7_tdata,
  input wire                       s_axis_eligibility_timestamp_p7_tvalid,
  output wire                      s_axis_eligibility_timestamp_p7_tready,

  // AXI4-Stream Data In
  input wire [DATA_WIDTH-1:0]      s_axis_p0_tdata,
  input wire [KEEP_WIDTH-1:0]      s_axis_p0_tkeep,
  input wire                       s_axis_p0_tvalid,
  output wire                      s_axis_p0_tready,
  input wire                       s_axis_p0_tlast,
  input wire [DATA_WIDTH-1:0]      s_axis_p1_tdata,
  input wire [KEEP_WIDTH-1:0]      s_axis_p1_tkeep,
  input wire                       s_axis_p1_tvalid,
  output wire                      s_axis_p1_tready,
  input wire                       s_axis_p1_tlast,
  input wire [DATA_WIDTH-1:0]      s_axis_p2_tdata,
  input wire [KEEP_WIDTH-1:0]      s_axis_p2_tkeep,
  input wire                       s_axis_p2_tvalid,
  output wire                      s_axis_p2_tready,
  input wire                       s_axis_p2_tlast,
  input wire [DATA_WIDTH-1:0]      s_axis_p3_tdata,
  input wire [KEEP_WIDTH-1:0]      s_axis_p3_tkeep,
  input wire                       s_axis_p3_tvalid,
  output wire                      s_axis_p3_tready,
  input wire                       s_axis_p3_tlast,
  input wire [DATA_WIDTH-1:0]      s_axis_p4_tdata,
  input wire [KEEP_WIDTH-1:0]      s_axis_p4_tkeep,
  input wire                       s_axis_p4_tvalid,
  output wire                      s_axis_p4_tready,
  input wire                       s_axis_p4_tlast,
  input wire [DATA_WIDTH-1:0]      s_axis_p5_tdata,
  input wire [KEEP_WIDTH-1:0]      s_axis_p5_tkeep,
  input wire                       s_axis_p5_tvalid,
  output wire                      s_axis_p5_tready,
  input wire                       s_axis_p5_tlast,
  input wire [DATA_WIDTH-1:0]      s_axis_p6_tdata,
  input wire [KEEP_WIDTH-1:0]      s_axis_p6_tkeep,
  input wire                       s_axis_p6_tvalid,
  output wire                      s_axis_p6_tready,
  input wire                       s_axis_p6_tlast,
  input wire [DATA_WIDTH-1:0]      s_axis_p7_tdata,
  input wire [KEEP_WIDTH-1:0]      s_axis_p7_tkeep,
  input wire                       s_axis_p7_tvalid,
  output wire                      s_axis_p7_tready,
  input wire                       s_axis_p7_tlast,

   // AXI4-Stream Data Out
  output reg [DATA_WIDTH-1:0]      m_axis_tdata,
  output reg [KEEP_WIDTH-1:0]      m_axis_tkeep,
  output reg                       m_axis_tvalid,
  input wire                       m_axis_tready,
  output reg                       m_axis_tlast
);

  wire [7:0]                       s_axis_port_tdata;
  wire                             s_axis_port_tvalid;
  wire                             s_axis_port_tready;


  // Main state
  reg [0:0] state = 'd0;
  localparam STATE_WAIT_PORT = 0;
  localparam STATE_OUTPUT = 1;

  reg [7:0] output_port;

  // State machine
  always @ (posedge clk) begin
    if (!rstn) begin
      state <= STATE_WAIT_PORT;
      output_port <= 0;
    end else begin
      case (state)
        STATE_WAIT_PORT: begin
          if (s_axis_port_tvalid && s_axis_port_tready) begin
            output_port <= s_axis_port_tdata;
            state <= STATE_OUTPUT;
          end else begin
            // Do nothing
          end
        end
        STATE_OUTPUT: begin
          if (m_axis_tvalid && m_axis_tlast && m_axis_tready) begin
            state <= STATE_WAIT_PORT;
          end
        end
      endcase // case (state)
    end // else: !if(!rstn)
  end // always @ (posedge clk)

  reg out_done;
  always @(posedge clk) begin
    if (!rstn) begin
      m_axis_tdata <= 0;
      m_axis_tkeep <= 0;
      m_axis_tvalid <= 0;
      m_axis_tlast <= 0;
      out_done <= 0;
    end else begin
      if (state == STATE_OUTPUT && !out_done && (!m_axis_tvalid || m_axis_tready)) begin
        case (1'b1) // output_port is one-hot
          output_port[0]: begin
            m_axis_tdata <= s_axis_p0_tdata;
            m_axis_tkeep <= s_axis_p0_tkeep;
            m_axis_tvalid <= s_axis_p0_tvalid;
            m_axis_tlast <= s_axis_p0_tlast;
            if (s_axis_p0_tvalid && s_axis_p0_tlast) begin
              out_done <= 1;
            end
          end
          output_port[1]: begin
            m_axis_tdata <= s_axis_p1_tdata;
            m_axis_tkeep <= s_axis_p1_tkeep;
            m_axis_tvalid <= s_axis_p1_tvalid;
            m_axis_tlast <= s_axis_p1_tlast;
            if (s_axis_p1_tvalid && s_axis_p1_tlast) begin
              out_done <= 1;
            end
          end
          output_port[2]: begin
            m_axis_tdata <= s_axis_p2_tdata;
            m_axis_tkeep <= s_axis_p2_tkeep;
            m_axis_tvalid <= s_axis_p2_tvalid;
            m_axis_tlast <= s_axis_p2_tlast;
            if (s_axis_p2_tvalid && s_axis_p2_tlast) begin
              out_done <= 1;
            end
          end
          output_port[3]: begin
            m_axis_tdata <= s_axis_p3_tdata;
            m_axis_tkeep <= s_axis_p3_tkeep;
            m_axis_tvalid <= s_axis_p3_tvalid;
            m_axis_tlast <= s_axis_p3_tlast;
            if (s_axis_p3_tvalid && s_axis_p3_tlast) begin
              out_done <= 1;
            end
          end
          output_port[4]: begin
            m_axis_tdata <= s_axis_p4_tdata;
            m_axis_tkeep <= s_axis_p4_tkeep;
            m_axis_tvalid <= s_axis_p4_tvalid;
            m_axis_tlast <= s_axis_p4_tlast;
            if (s_axis_p4_tvalid && s_axis_p4_tlast) begin
              out_done <= 1;
            end
          end
          output_port[5]: begin
            m_axis_tdata <= s_axis_p5_tdata;
            m_axis_tkeep <= s_axis_p5_tkeep;
            m_axis_tvalid <= s_axis_p5_tvalid;
            m_axis_tlast <= s_axis_p5_tlast;
            if (s_axis_p5_tvalid && s_axis_p5_tlast) begin
              out_done <= 1;
            end
          end
          output_port[6]: begin
            m_axis_tdata <= s_axis_p6_tdata;
            m_axis_tkeep <= s_axis_p6_tkeep;
            m_axis_tvalid <= s_axis_p6_tvalid;
            m_axis_tlast <= s_axis_p6_tlast;
            if (s_axis_p6_tvalid && s_axis_p6_tlast) begin
              out_done <= 1;
            end
          end
          output_port[7]: begin
            m_axis_tdata <= s_axis_p7_tdata;
            m_axis_tkeep <= s_axis_p7_tkeep;
            m_axis_tvalid <= s_axis_p7_tvalid;
            m_axis_tlast <= s_axis_p7_tlast;
            if (s_axis_p7_tvalid && s_axis_p7_tlast) begin
              out_done <= 1;
            end
          end
        endcase // case (output_port)
      end else begin
        m_axis_tdata <= m_axis_tdata;
        m_axis_tkeep <= m_axis_tkeep;
        m_axis_tvalid <= m_axis_tvalid & !m_axis_tready;
        m_axis_tlast <= m_axis_tlast;
        out_done <= (state == STATE_WAIT_PORT) ? 0 : out_done;
      end
    end // else: !if(!rstn)
  end // always @ (posedge clk)

  assign s_axis_port_tready = (state == STATE_WAIT_PORT);
  assign s_axis_p0_tready = (!m_axis_tvalid || m_axis_tready) && (state == STATE_OUTPUT) && !out_done && output_port[0];
  assign s_axis_p1_tready = (!m_axis_tvalid || m_axis_tready) && (state == STATE_OUTPUT) && !out_done && output_port[1];
  assign s_axis_p2_tready = (!m_axis_tvalid || m_axis_tready) && (state == STATE_OUTPUT) && !out_done && output_port[2];
  assign s_axis_p3_tready = (!m_axis_tvalid || m_axis_tready) && (state == STATE_OUTPUT) && !out_done && output_port[3];
  assign s_axis_p4_tready = (!m_axis_tvalid || m_axis_tready) && (state == STATE_OUTPUT) && !out_done && output_port[4];
  assign s_axis_p5_tready = (!m_axis_tvalid || m_axis_tready) && (state == STATE_OUTPUT) && !out_done && output_port[5];
  assign s_axis_p6_tready = (!m_axis_tvalid || m_axis_tready) && (state == STATE_OUTPUT) && !out_done && output_port[6];
  assign s_axis_p7_tready = (!m_axis_tvalid || m_axis_tready) && (state == STATE_OUTPUT) && !out_done && output_port[7];

  et_reader #(
              // Parameters
              .DATA_WIDTH               (DATA_WIDTH),
              .TIMESTAMP_WIDTH          (TIMESTAMP_WIDTH),
              .NUM_INPUT_PORTS          (NUM_INPUT_PORTS))
  et_reader_i (
               // Outputs
               .s_axis_eligibility_timestamp_p0_tready(s_axis_eligibility_timestamp_p0_tready),
               .s_axis_eligibility_timestamp_p1_tready(s_axis_eligibility_timestamp_p1_tready),
               .s_axis_eligibility_timestamp_p2_tready(s_axis_eligibility_timestamp_p2_tready),
               .s_axis_eligibility_timestamp_p3_tready(s_axis_eligibility_timestamp_p3_tready),
               .s_axis_eligibility_timestamp_p4_tready(s_axis_eligibility_timestamp_p4_tready),
               .s_axis_eligibility_timestamp_p5_tready(s_axis_eligibility_timestamp_p5_tready),
               .s_axis_eligibility_timestamp_p6_tready(s_axis_eligibility_timestamp_p6_tready),
               .s_axis_eligibility_timestamp_p7_tready(s_axis_eligibility_timestamp_p7_tready),
               .m_axis_port_tdata       (s_axis_port_tdata[7:0]),
               .m_axis_port_tvalid      (s_axis_port_tvalid),
               // Inputs
               .clk                     (clk),
               .rstn                    (rstn),
               .s_axis_eligibility_timestamp_p0_tdata(s_axis_eligibility_timestamp_p0_tdata[TIMESTAMP_WIDTH-1:0]),
               .s_axis_eligibility_timestamp_p0_tvalid(s_axis_eligibility_timestamp_p0_tvalid),
               .s_axis_eligibility_timestamp_p1_tdata(s_axis_eligibility_timestamp_p1_tdata[TIMESTAMP_WIDTH-1:0]),
               .s_axis_eligibility_timestamp_p1_tvalid(s_axis_eligibility_timestamp_p1_tvalid),
               .s_axis_eligibility_timestamp_p2_tdata(s_axis_eligibility_timestamp_p2_tdata[TIMESTAMP_WIDTH-1:0]),
               .s_axis_eligibility_timestamp_p2_tvalid(s_axis_eligibility_timestamp_p2_tvalid),
               .s_axis_eligibility_timestamp_p3_tdata(s_axis_eligibility_timestamp_p3_tdata[TIMESTAMP_WIDTH-1:0]),
               .s_axis_eligibility_timestamp_p3_tvalid(s_axis_eligibility_timestamp_p3_tvalid),
               .s_axis_eligibility_timestamp_p4_tdata(s_axis_eligibility_timestamp_p4_tdata[TIMESTAMP_WIDTH-1:0]),
               .s_axis_eligibility_timestamp_p4_tvalid(s_axis_eligibility_timestamp_p4_tvalid),
               .s_axis_eligibility_timestamp_p5_tdata(s_axis_eligibility_timestamp_p5_tdata[TIMESTAMP_WIDTH-1:0]),
               .s_axis_eligibility_timestamp_p5_tvalid(s_axis_eligibility_timestamp_p5_tvalid),
               .s_axis_eligibility_timestamp_p6_tdata(s_axis_eligibility_timestamp_p6_tdata[TIMESTAMP_WIDTH-1:0]),
               .s_axis_eligibility_timestamp_p6_tvalid(s_axis_eligibility_timestamp_p6_tvalid),
               .s_axis_eligibility_timestamp_p7_tdata(s_axis_eligibility_timestamp_p7_tdata[TIMESTAMP_WIDTH-1:0]),
               .s_axis_eligibility_timestamp_p7_tvalid(s_axis_eligibility_timestamp_p7_tvalid),
               .m_axis_port_tready      (s_axis_port_tready));

endmodule // et_arbiter

`default_nettype wire
