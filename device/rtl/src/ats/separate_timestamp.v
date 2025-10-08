// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module separate_timestamp #(
  parameter DATA_WIDTH = 8,
  parameter FRAME_LENGTH_WIDTH = 16,                  // Must be aligned to DATA_WIDTH
  parameter ETHERNET_FRAME_WIDTH = 1600 * DATA_WIDTH, // Must be aligned to DATA_WIDTH
  parameter TIMESTAMP_WIDTH = 72                      // Must be aligned to DATA_WIDTH
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // AXI4-Stream In with timestamp
  // [Ethernet Frame]/[Timestamp]
  input  wire [DATA_WIDTH-1:0] s_axis_tdata,
  input  wire                  s_axis_tvalid,
  output wire                  s_axis_tready,
  input  wire                  s_axis_tlast,

  // AXI4-Stream Frame length In
  input  wire [FRAME_LENGTH_WIDTH-1:0] s_axis_frame_length_tdata,
  input  wire                          s_axis_frame_length_tvalid,
  output wire                          s_axis_frame_length_tready,

  // AXI4-Stream Out without timestamp
  // [Ethernet Frame]
  output wire [DATA_WIDTH-1:0] m_axis_tdata,
  output wire                  m_axis_tvalid,
  input  wire                  m_axis_tready,
  output wire                  m_axis_tlast,

  // AXI4-Stream Timestamp Out
  output wire [TIMESTAMP_WIDTH-1:0] m_axis_timestamp_tdata,
  output wire                       m_axis_timestamp_tvalid,
  input  wire                       m_axis_timestamp_tready
);

  // Parameter for ethernet_frame
  localparam ETHERNET_FRAME_BEAT_NUM = ETHERNET_FRAME_WIDTH / DATA_WIDTH;
  localparam ETHERNET_FRAME_COUNTER_WIDTH = $clog2(ETHERNET_FRAME_BEAT_NUM);
  // Parameter for timestamp
  localparam TIMESTAMP_BEAT_NUM = TIMESTAMP_WIDTH / DATA_WIDTH;
  localparam TIMESTAMP_COUNTER_WIDTH = $clog2(TIMESTAMP_BEAT_NUM);

  // AXI4-Stream connection
  //// Common
  assign s_axis_tready = (state == STATE_READ_ETHERNET_FRAME)? m_axis_tready: (state == STATE_READ_TIMESTAMP);
  //// Length
  assign s_axis_frame_length_tready = (state == STATE_READ_FRAME_LENGTH);
  //// Data
  assign m_axis_tdata  = s_axis_tdata;
  assign m_axis_tvalid = (state == STATE_READ_ETHERNET_FRAME)? s_axis_tvalid: 1'b0;
  assign m_axis_tlast  = (state == STATE_READ_ETHERNET_FRAME && ethernet_frame_counter == frame_length - 1);
  //// Timestamp
  assign m_axis_timestamp_tdata  = timestamp;
  assign m_axis_timestamp_tvalid = (state == STATE_WRITE_TIMESTAMP);

  // Utility wires
  wire stream_incoming = s_axis_tvalid & s_axis_tready;

  // Main state
  reg [STATE_WIDTH-1:0] state = 'd0;
  localparam STATE_WIDTH = 2;
  localparam STATE_READ_FRAME_LENGTH = 0;
  localparam STATE_READ_ETHERNET_FRAME = 1;
  localparam STATE_READ_TIMESTAMP = 2;
  localparam STATE_WRITE_TIMESTAMP = 3;
  // Important registers
  reg [FRAME_LENGTH_WIDTH-1:0] frame_length = 'd0;
  reg [ETHERNET_FRAME_COUNTER_WIDTH-1:0] ethernet_frame_counter = 'd0;
  reg [TIMESTAMP_WIDTH-1:0] timestamp = 'd0;
  reg [TIMESTAMP_COUNTER_WIDTH-1:0] timestamp_counter = 'd0;
  // State machine
  always @ (posedge clk) begin
    if (!rstn) begin
      frame_length <= 'd0;
      ethernet_frame_counter <='d0;
      timestamp <= 'd0;
      timestamp_counter <= 'd0;
      state <= STATE_READ_FRAME_LENGTH;
    end else begin
      case (state)
        STATE_READ_FRAME_LENGTH: begin
          if (s_axis_frame_length_tvalid & s_axis_frame_length_tready) begin
            frame_length <= s_axis_frame_length_tdata;
            state <= STATE_READ_ETHERNET_FRAME;
          end else begin
            // Do nothing
          end
        end
        STATE_READ_ETHERNET_FRAME: begin
          if (stream_incoming) begin
            if (ethernet_frame_counter == frame_length - 1) begin
              ethernet_frame_counter <= 'd0;
              state <= STATE_READ_TIMESTAMP;
            end else begin
              ethernet_frame_counter <= ethernet_frame_counter + 'd1;
            end
          end
        end
        STATE_READ_TIMESTAMP: begin
          if (stream_incoming) begin
            timestamp <= s_axis_tdata << (DATA_WIDTH * timestamp_counter) | timestamp;
            if (timestamp_counter == TIMESTAMP_BEAT_NUM - 1) begin
              timestamp_counter <= 'd0;
              state <= STATE_WRITE_TIMESTAMP;
            end else begin
              timestamp_counter <= timestamp_counter + 'd1;
            end
          end
        end
        STATE_WRITE_TIMESTAMP: begin
          if (m_axis_timestamp_tvalid & m_axis_timestamp_tready) begin
            timestamp <= 'd0;
            state <= STATE_READ_FRAME_LENGTH;
          end else begin
            // Do nothing
          end
        end
        default: begin
          frame_length <= 'd0;
          ethernet_frame_counter <='d0;
          timestamp <= 'd0;
          timestamp_counter <= 'd0;
          state <= STATE_READ_FRAME_LENGTH;
        end
      endcase
    end
  end
module separate_timestamp_core #(
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter TIMESTAMP_WIDTH = 72                              // Must be aligned to C_AXIS_TDATA_WIDTH
) (
  // clock, negative-reset
  input wire                          clk,
  input wire                          rstn,

  // AXI4-Stream In with timestamp
  // [Ethernet Frame]/[Timestamp]
  input wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_tkeep,
  input wire                          s_axis_tvalid,
  output wire                         s_axis_tready,
  input wire                          s_axis_tlast,

  // AXI4-Stream Out without timestamp
  // [Ethernet Frame]
  output reg [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output reg [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
  output reg                          m_axis_tvalid,
  input wire                          m_axis_tready,
  output reg                          m_axis_tlast,

  // AXI4-Stream Timestamp Out
  output reg [TIMESTAMP_WIDTH-1:0]    m_axis_timestamp_tdata,
  output reg                          m_axis_timestamp_tvalid,
  input wire                          m_axis_timestamp_tready
);

  generate
    if (C_AXIS_TDATA_WIDTH == 8) begin
      wire                              stall;

      assign s_axis_tready = !stall;
      assign stall = (m_axis_tvalid && !m_axis_tready) || (m_axis_timestamp_tvalid && !m_axis_timestamp_tready);

      localparam VALID_WIDTH = TIMESTAMP_WIDTH / C_AXIS_TDATA_WIDTH;

      // timestamp logic
      reg [TIMESTAMP_WIDTH-1:0]         timestamp_data;
      reg [VALID_WIDTH-1:0]             timestamp_valids;
      always @(posedge clk) begin
        if (!rstn) begin
          timestamp_data <= 'd0;
          timestamp_valids <= 'd0;
        end else begin
          if (s_axis_tvalid && s_axis_tready) begin
            timestamp_data <= {s_axis_tdata, timestamp_data[TIMESTAMP_WIDTH-1:C_AXIS_TDATA_WIDTH]};
            if (s_axis_tlast) begin
              timestamp_valids <= 'd0;
            end else begin
              timestamp_valids <= {1'b1, timestamp_valids[VALID_WIDTH-1:1]};
            end
          end
        end
      end

      // delay logic
      wire s_axis_accepted = s_axis_tvalid && s_axis_tready;
      wire s_axis_accepted_with_last = s_axis_tvalid && s_axis_tready && s_axis_tlast;
      reg  s_axis_accepted_with_last_d;
      always @(posedge clk) begin
        s_axis_accepted_with_last_d <= s_axis_accepted_with_last;
      end

      // m_axis
      always @(posedge clk) begin
        if (!rstn) begin
          m_axis_tdata <= 'd0;
          m_axis_tkeep <= 'd1;
          m_axis_tvalid <= 'd0;
          m_axis_tlast <= 'd0;
        end else begin
          if (s_axis_accepted_with_last) begin
            m_axis_tdata <= timestamp_data[0 +: C_AXIS_TDATA_WIDTH];
            m_axis_tkeep <= 'd1;
            m_axis_tvalid <= timestamp_valids[0];
            m_axis_tlast <= 1'b1;
          end else if (s_axis_accepted) begin
            m_axis_tdata <= timestamp_data[0 +: C_AXIS_TDATA_WIDTH];
            m_axis_tkeep <= 'd1;
            m_axis_tvalid <= timestamp_valids[0];
            m_axis_tlast <= 1'b0;
          end else begin
            m_axis_tdata <= m_axis_tdata;
            m_axis_tkeep <= 'd1;
            m_axis_tvalid <= m_axis_tvalid && !m_axis_tready;
            m_axis_tlast <= m_axis_tlast;
          end
        end
      end

      // m_axis_timestamp
      always @(posedge clk) begin
        if (!rstn) begin
          m_axis_timestamp_tdata <= 'd0;
          m_axis_timestamp_tvalid <= 'd0;
        end else begin
          if (s_axis_accepted_with_last_d) begin
            m_axis_timestamp_tdata <= timestamp_data;
            m_axis_timestamp_tvalid <= 1'b1;
          end else begin
            m_axis_timestamp_tdata <= m_axis_timestamp_tdata;
            m_axis_timestamp_tvalid <= m_axis_timestamp_tvalid && !m_axis_timestamp_tready;
          end
        end
      end
    end else if (C_AXIS_TDATA_WIDTH < TIMESTAMP_WIDTH) begin // if (C_AXIS_TDATA_WIDTH == 8)
      wire                              stall;

      reg [1:0]                         state;
      localparam [0:0] STATE_READ = 1'b0;
      localparam [0:0] STATE_FLUSH = 1'b1;
      reg                               data_done;
      reg                               ts_done;

      always @(posedge clk) begin
        if (!rstn) begin
          state <= STATE_READ;
          data_done <= 0;
          ts_done <= 0;
        end else begin
          case (state)
            STATE_READ: begin
              if (s_axis_tvalid && s_axis_tready && s_axis_tlast) begin
                state <= STATE_FLUSH;
              end
            end
            STATE_FLUSH: begin
              if (m_axis_tvalid && m_axis_tready && m_axis_tlast) begin
                data_done <= 1'b1;
              end

              if (m_axis_timestamp_tvalid && m_axis_timestamp_tready) begin
                ts_done <= 1'b1;
              end

              if (((m_axis_tvalid && m_axis_tready && m_axis_tlast) || data_done) &&
                  ((m_axis_timestamp_tvalid && m_axis_timestamp_tready) || ts_done)) begin
                data_done <= 0;
                ts_done <= 0;
                state <= STATE_READ;
              end
            end
          endcase
        end
      end

      assign s_axis_tready = !stall && (state == STATE_READ);
      assign stall = (m_axis_tvalid && !m_axis_tready) || (m_axis_timestamp_tvalid && !m_axis_timestamp_tready);

      // aligned by C_AXIS_TDATA_WIDTH
      localparam SHIFTREG_WIDTH = (TIMESTAMP_WIDTH + C_AXIS_TDATA_WIDTH - 1) / C_AXIS_TDATA_WIDTH * C_AXIS_TDATA_WIDTH;
      localparam SHIFTREG_KEEP_WIDTH = SHIFTREG_WIDTH / 8;
      localparam SHIFTREG_VALID_WIDTH = SHIFTREG_WIDTH / C_AXIS_TDATA_WIDTH;

      // timestamp logic
      reg [SHIFTREG_WIDTH-1:0]          timestamp_data;
      reg [SHIFTREG_KEEP_WIDTH-1:0]     timestamp_keep;
      reg [SHIFTREG_VALID_WIDTH-1:0]    timestamp_valids;

      always @(posedge clk) begin
        if (!rstn) begin
          timestamp_data <= 'd0;
          timestamp_keep <= 'd0;
          timestamp_valids <= 'd0;
        end else begin
          if (s_axis_tvalid && s_axis_tready) begin
            timestamp_data <= {s_axis_tdata, timestamp_data[SHIFTREG_WIDTH-1 : C_AXIS_TDATA_WIDTH]};
            timestamp_keep <= {s_axis_tkeep, timestamp_keep[SHIFTREG_KEEP_WIDTH-1 : C_AXIS_TKEEP_WIDTH]};
            if (s_axis_tlast) begin
              timestamp_valids <= 'd0;
            end else begin
              timestamp_valids <= {1'b1, timestamp_valids[SHIFTREG_VALID_WIDTH-1:1]};
            end
          end
        end
      end

      // input bytes
      reg [$clog2(C_AXIS_TKEEP_WIDTH):0] num_bytes;
      integer              i;
      always @ (*) begin
        num_bytes = 0;
        for (i = 0; i < C_AXIS_TKEEP_WIDTH; i = i + 1) begin
          if (s_axis_tkeep[i]) begin
            num_bytes = i + 1;
          end
        end
      end

      // The number of bytes in last word, when the last input has i bytes.
      reg [$clog2(C_AXIS_TKEEP_WIDTH):0] remain_bytes_table[C_AXIS_TKEEP_WIDTH:0];
      integer                    j;
      initial begin
        remain_bytes_table[0] = 0;
        for (j = 0; j < C_AXIS_TKEEP_WIDTH; j = j + 1) begin
          remain_bytes_table[j + 1] = (j + 1 + SHIFTREG_KEEP_WIDTH - TIMESTAMP_WIDTH/8) % C_AXIS_TKEEP_WIDTH;
        end
      end
      reg [$clog2(C_AXIS_TKEEP_WIDTH):0] remain_bytes;
      always @(*) begin
        remain_bytes = remain_bytes_table[num_bytes];
      end
      reg [$clog2(C_AXIS_TKEEP_WIDTH):0] remain_bytes_d;
      always @(posedge clk) begin
        if (s_axis_accepted_with_last) begin
          remain_bytes_d <= remain_bytes;
        end
      end

      reg [C_AXIS_TKEEP_WIDTH-1:0] last_keep;
      reg [C_AXIS_TDATA_WIDTH-1:0] last_keep_mask;
      always @(*) begin
        last_keep = {C_AXIS_TKEEP_WIDTH{1'b1}} >> (C_AXIS_TKEEP_WIDTH - remain_bytes_d);
      end
      integer k;
      always @(*) begin
        for (k = 0; k < C_AXIS_TKEEP_WIDTH; k = k + 1) begin
          last_keep_mask[k * 8 +: 8] = {8{last_keep[k]}};
        end
      end

      // delay logic
      wire s_axis_accepted = s_axis_tvalid && s_axis_tready;
      wire s_axis_accepted_with_last = s_axis_tvalid && s_axis_tready && s_axis_tlast;
      reg  s_axis_accepted_with_last_d;
      always @(posedge clk) begin
        s_axis_accepted_with_last_d <= s_axis_accepted_with_last;
      end

      // m_axis
      reg require_another_cycle;
      always @(posedge clk) begin
        if (!rstn) begin
          m_axis_tdata <= 'd0;
          m_axis_tvalid <= 'd0;
          m_axis_tlast <= 'd0;
          require_another_cycle <= 1'd0;
        end else begin
          if (!m_axis_tvalid || m_axis_tready) begin
            if (require_another_cycle) begin
              m_axis_tdata <= timestamp_data[0 +: C_AXIS_TDATA_WIDTH] & last_keep_mask;
              m_axis_tkeep <= last_keep;
              m_axis_tvalid <= 1'b1;
              m_axis_tlast <= 1'b1;
              require_another_cycle <= 1'b0;
            end else if (s_axis_accepted_with_last) begin
              if (remain_bytes == 0) begin
                m_axis_tdata <= timestamp_data[0 +: C_AXIS_TDATA_WIDTH];
                m_axis_tkeep <= {C_AXIS_TKEEP_WIDTH{1'b1}};
                m_axis_tvalid <= timestamp_valids[0];
                m_axis_tlast <= 1'b1;
                require_another_cycle <= 1'b0;
              end else begin
                // Another cycle is required
                m_axis_tdata <= timestamp_data[0 +: C_AXIS_TDATA_WIDTH];
                m_axis_tkeep <= {C_AXIS_TKEEP_WIDTH{1'b1}};
                m_axis_tvalid <= timestamp_valids[0];
                m_axis_tlast <= 1'b0;
                require_another_cycle <= 1'b1;
              end
            end else if (s_axis_accepted) begin
              m_axis_tdata <= timestamp_data[0 +: C_AXIS_TDATA_WIDTH];
              m_axis_tkeep <= {C_AXIS_TKEEP_WIDTH{1'b1}};
              m_axis_tvalid <= timestamp_valids[0];
              m_axis_tlast <= 1'b0;
              require_another_cycle <= 1'b0;
            end else begin
              m_axis_tdata <= timestamp_data[0 +: C_AXIS_TDATA_WIDTH];
              m_axis_tkeep <= {C_AXIS_TKEEP_WIDTH{1'b1}};
              m_axis_tvalid <= 1'b0;
              m_axis_tlast <= 1'b0;
              require_another_cycle <= 1'b0;
            end
          end
        end
      end

      // m_axis_timestamp
      always @(posedge clk) begin
        if (!rstn) begin
          m_axis_timestamp_tdata <= 'd0;
          m_axis_timestamp_tvalid <= 'd0;
        end else begin
          if (s_axis_accepted_with_last_d) begin
            m_axis_timestamp_tdata <= timestamp_data >> (remain_bytes_d * 8);
            m_axis_timestamp_tvalid <= 1'b1;
          end else begin
            m_axis_timestamp_tdata <= m_axis_timestamp_tdata;
            m_axis_timestamp_tvalid <= m_axis_timestamp_tvalid && !m_axis_timestamp_tready;
          end
        end
      end

    end else begin // if (C_AXIS_TDATA_WIDTH < TIMESTAMP_WIDTH)
      initial begin
        $error("C_AXIS_TDATA_WIDTH must be less than TIMESTAMP_WIDTH");
      end
    end
  endgenerate
endmodule

module separate_timestamp #(
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter TIMESTAMP_WIDTH = 72,                             // Must be aligned to C_AXIS_TDATA_WIDTH
  parameter OPT_LEVEL = 0
) (
  // clock, negative-reset
  input wire                           clk,
  input wire                           rstn,

  // AXI4-Stream In with timestamp
  // [Ethernet Frame]/[Timestamp]
  input wire [C_AXIS_TDATA_WIDTH-1:0]  s_axis_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0]  s_axis_tkeep,
  input wire                           s_axis_tvalid,
  output wire                          s_axis_tready,
  input wire                           s_axis_tlast,

  // AXI4-Stream Out without timestamp
  // [Ethernet Frame]
  output wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
  output wire                          m_axis_tvalid,
  input wire                           m_axis_tready,
  output wire                          m_axis_tlast,

  // AXI4-Stream Timestamp Out
  output wire [TIMESTAMP_WIDTH-1:0]    m_axis_timestamp_tdata,
  output wire                          m_axis_timestamp_tvalid,
  input wire                           m_axis_timestamp_tready
);
  //-------------------------
  // Main module
  //-------------------------
  generate
    if (OPT_LEVEL >= 1) begin
      reg        iturn;
      reg        oturn;
      reg        data_done;
      reg        ts_done;

      always @(posedge clk) begin
        if (!rstn) begin
          iturn <= 0;
          oturn <= 0;
          data_done <= 0;
          ts_done <= 0;
        end else begin
          if (s_axis_tvalid && s_axis_tready && s_axis_tlast) begin
            iturn <= ~iturn;
          end
          if (m_axis_tvalid && m_axis_tready && m_axis_tlast) begin
            data_done <= 1'b1;
          end
          if (m_axis_timestamp_tvalid && m_axis_timestamp_tready) begin
            ts_done <= 1'b1;
          end
          if (((m_axis_tvalid && m_axis_tready && m_axis_tlast) || data_done) &&
              ((m_axis_timestamp_tvalid && m_axis_timestamp_tready) || ts_done)) begin
            oturn <= ~oturn;
            data_done <= 0;
            ts_done <= 0;
          end
        end
      end

      wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_i0_tdata;
      wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_i0_tkeep;
      wire                          s_axis_i0_tvalid;
      wire                          s_axis_i0_tready;
      wire                          s_axis_i0_tlast;
      wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_i0_tdata;
      wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_i0_tkeep;
      wire                          m_axis_i0_tvalid;
      wire                          m_axis_i0_tready;
      wire                          m_axis_i0_tlast;
      wire [TIMESTAMP_WIDTH-1:0]    m_axis_i0_timestamp_tdata;
      wire                          m_axis_i0_timestamp_tvalid;
      wire                          m_axis_i0_timestamp_tready;

      wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_i1_tdata;
      wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_i1_tkeep;
      wire                          s_axis_i1_tvalid;
      wire                          s_axis_i1_tready;
      wire                          s_axis_i1_tlast;
      wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_i1_tdata;
      wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_i1_tkeep;
      wire                          m_axis_i1_tvalid;
      wire                          m_axis_i1_tready;
      wire                          m_axis_i1_tlast;
      wire [TIMESTAMP_WIDTH-1:0]    m_axis_i1_timestamp_tdata;
      wire                          m_axis_i1_timestamp_tvalid;
      wire                          m_axis_i1_timestamp_tready;

      assign s_axis_i0_tdata = s_axis_tdata;
      assign s_axis_i0_tkeep = s_axis_tkeep;
      assign s_axis_i0_tvalid = (iturn == 0) ? s_axis_tvalid : 0;
      assign s_axis_i0_tlast = s_axis_tlast;
      assign m_axis_i0_tready = (oturn == 0) ? m_axis_tready : 0;

      assign s_axis_i1_tdata = s_axis_tdata;
      assign s_axis_i1_tkeep = s_axis_tkeep;
      assign s_axis_i1_tvalid = (iturn == 1) ? s_axis_tvalid : 0;
      assign s_axis_i1_tlast = s_axis_tlast;
      assign m_axis_i1_tready = (oturn == 1) ? m_axis_tready : 0;

      assign s_axis_tready = (iturn == 0) ? s_axis_i0_tready : s_axis_i1_tready;
      assign m_axis_tdata = (oturn == 0) ? m_axis_i0_tdata : m_axis_i1_tdata;
      assign m_axis_tkeep = (oturn == 0) ? m_axis_i0_tkeep : m_axis_i1_tkeep;
      assign m_axis_tvalid = (oturn == 0) ? m_axis_i0_tvalid : m_axis_i1_tvalid;
      assign m_axis_tlast = (oturn == 0) ? m_axis_i0_tlast : m_axis_i1_tlast;

      assign m_axis_i0_timestamp_tready = (oturn == 0) ? m_axis_timestamp_tready : 0;
      assign m_axis_i1_timestamp_tready = (oturn == 1) ? m_axis_timestamp_tready : 0;
      assign m_axis_timestamp_tdata = (oturn == 0) ? m_axis_i0_timestamp_tdata : m_axis_i1_timestamp_tdata;
      assign m_axis_timestamp_tvalid = (oturn == 0) ? m_axis_i0_timestamp_tvalid : m_axis_i1_timestamp_tvalid;

      separate_timestamp_core #(
        .C_AXIS_TDATA_WIDTH(C_AXIS_TDATA_WIDTH),
        .C_AXIS_TKEEP_WIDTH(C_AXIS_TKEEP_WIDTH),
        .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH)
      ) separate_timestamp_core_i0 (
        clk,
        rstn,
        s_axis_i0_tdata,
        s_axis_i0_tkeep,
        s_axis_i0_tvalid,
        s_axis_i0_tready,
        s_axis_i0_tlast,
        m_axis_i0_tdata,
        m_axis_i0_tkeep,
        m_axis_i0_tvalid,
        m_axis_i0_tready,
        m_axis_i0_tlast,
        m_axis_i0_timestamp_tdata,
        m_axis_i0_timestamp_tvalid,
        m_axis_i0_timestamp_tready
      );

      separate_timestamp_core #(
        .C_AXIS_TDATA_WIDTH(C_AXIS_TDATA_WIDTH),
        .C_AXIS_TKEEP_WIDTH(C_AXIS_TKEEP_WIDTH),
        .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH)
      ) separate_timestamp_core_i1 (
        clk,
        rstn,
        s_axis_i1_tdata,
        s_axis_i1_tkeep,
        s_axis_i1_tvalid,
        s_axis_i1_tready,
        s_axis_i1_tlast,
        m_axis_i1_tdata,
        m_axis_i1_tkeep,
        m_axis_i1_tvalid,
        m_axis_i1_tready,
        m_axis_i1_tlast,
        m_axis_i1_timestamp_tdata,
        m_axis_i1_timestamp_tvalid,
        m_axis_i1_timestamp_tready
      );
    end else begin // if (OPT_LEVEL >= 1)
      separate_timestamp_core #(
        .C_AXIS_TDATA_WIDTH(C_AXIS_TDATA_WIDTH),
        .C_AXIS_TKEEP_WIDTH(C_AXIS_TKEEP_WIDTH),
        .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH)
      ) separate_timestamp_core_i (
        clk,
        rstn,
        s_axis_tdata,
        s_axis_tkeep,
        s_axis_tvalid,
        s_axis_tready,
        s_axis_tlast,
        m_axis_tdata,
        m_axis_tkeep,
        m_axis_tvalid,
        m_axis_tready,
        m_axis_tlast,
        m_axis_timestamp_tdata,
        m_axis_timestamp_tvalid,
        m_axis_timestamp_tready
      );
    end // else: !if(OPT_LEVEL >= 1)
  endgenerate

endmodule

`default_nettype wire
