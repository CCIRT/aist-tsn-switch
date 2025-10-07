// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module set_timestamp #(
<<<<<<< HEAD
  parameter DATA_WIDTH = 8,
  parameter TIMESTAMP_WIDTH = 72  // Must be aligned to DATA_WIDTH
=======
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter TIMESTAMP_WIDTH = 72  // Must be aligned to C_AXIS_TDATA_WIDTH
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // ATS Scheduler Timer input
  input  wire [TIMESTAMP_WIDTH-1:0] ats_scheduler_timer,

  // AXI4-Stream Data In
  // [Ethernet Frame]
<<<<<<< HEAD
  input  wire [DATA_WIDTH-1:0] s_axis_tdata,
  input  wire                  s_axis_tvalid,
  output wire                  s_axis_tready,
  input  wire                  s_axis_tlast,

  // AXI4-Stream Data Out
  // [Ethernet Frame]/[Timestamp]
  output wire [DATA_WIDTH-1:0] m_axis_tdata,
  output wire                  m_axis_tvalid,
  input  wire                  m_axis_tready,
  output wire                  m_axis_tlast
);

  // Parameter for timestamp
  localparam TIMESTAMP_BEAT_NUM = TIMESTAMP_WIDTH / DATA_WIDTH;
  localparam TIMESTAMP_COUNTER_WIDTH = $clog2(TIMESTAMP_BEAT_NUM);

  // AXI4-Stream connection
  assign m_axis_tdata  = (is_timestamp_beat)? timestamp >> (DATA_WIDTH * timestamp_counter): s_axis_tdata;
  assign m_axis_tvalid = (is_timestamp_beat)? 1'b1                                         : s_axis_tvalid;
  assign s_axis_tready = (is_timestamp_beat)? 1'b0                                         : m_axis_tready;
  assign m_axis_tlast  = (is_timestamp_beat & (timestamp_counter == TIMESTAMP_BEAT_NUM - 1));


  // Important registers
  reg [TIMESTAMP_WIDTH-1:0] timestamp = 'd0;
  reg [TIMESTAMP_COUNTER_WIDTH-1:0] timestamp_counter = 'd0;
  reg is_timestamp_beat = 1'b0;

  always @ (posedge clk) begin
    if (!rstn) begin
      timestamp <= 'd0;
      timestamp_counter <= 'd0;
      is_timestamp_beat <= 1'b0;
    end else begin
      if (is_timestamp_beat) begin
        if (m_axis_tvalid & m_axis_tready) begin
          if (timestamp_counter == TIMESTAMP_BEAT_NUM - 1) begin
            timestamp_counter <= 'd0;
            is_timestamp_beat <= 1'b0;
          end else begin
            timestamp_counter <= timestamp_counter + 'd1;
          end
        end else begin
          // Do nothing
        end
      end else begin
        if (s_axis_tvalid & s_axis_tready & s_axis_tlast) begin
          timestamp <= ats_scheduler_timer;
          is_timestamp_beat <= 1'b1;
        end else begin
          // Do nothing
        end
      end
    end
  end

=======
  input  wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input  wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_tkeep,
  input  wire                          s_axis_tvalid,
  output wire                          s_axis_tready,
  input  wire                          s_axis_tlast,

  // AXI4-Stream Data Out
  // [Ethernet Frame]/[Timestamp]
  output wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
  output wire                          m_axis_tvalid,
  input  wire                          m_axis_tready,
  output wire                          m_axis_tlast
);

  generate
    if (C_AXIS_TDATA_WIDTH == 8) begin
      // Parameter for timestamp
      localparam TIMESTAMP_BEAT_NUM = TIMESTAMP_WIDTH / C_AXIS_TDATA_WIDTH;
      localparam TIMESTAMP_COUNTER_WIDTH = $clog2(TIMESTAMP_BEAT_NUM);

      // AXI4-Stream connection
      assign m_axis_tdata  = (is_timestamp_beat)? timestamp >> (C_AXIS_TDATA_WIDTH * timestamp_counter): s_axis_tdata;
      assign m_axis_tkeep  = 1'b1;
      assign m_axis_tvalid = (is_timestamp_beat)? 1'b1                                         : s_axis_tvalid;
      assign s_axis_tready = (is_timestamp_beat)? 1'b0                                         : m_axis_tready;
      assign m_axis_tlast  = (is_timestamp_beat & (timestamp_counter == TIMESTAMP_BEAT_NUM - 1));

      // Important registers
      reg [TIMESTAMP_WIDTH-1:0] timestamp = 'd0;
      reg [TIMESTAMP_COUNTER_WIDTH-1:0] timestamp_counter = 'd0;
      reg                               is_timestamp_beat = 1'b0;
      reg                               is_first_beat = 1'b1;

      // Control is_first_beat
      always @ (posedge clk) begin
        if (!rstn) begin
          is_first_beat <= 1'b1;
        end else begin
          if (s_axis_tvalid & s_axis_tready) begin
            if (s_axis_tlast) begin
              is_first_beat <= 1'b1;
            end else begin
              is_first_beat <= 0;
            end
          end else begin
            // Do nothing
          end
        end
      end

      always @ (posedge clk) begin
        if (!rstn) begin
          timestamp <= 'd0;
          timestamp_counter <= 'd0;
          is_timestamp_beat <= 1'b0;
        end else begin
          if (is_timestamp_beat) begin
            if (m_axis_tvalid & m_axis_tready) begin
              if (timestamp_counter == TIMESTAMP_BEAT_NUM - 1) begin
                timestamp_counter <= 'd0;
                is_timestamp_beat <= 1'b0;
              end else begin
                timestamp_counter <= timestamp_counter + 'd1;
              end
            end else begin
              // Do nothing
            end
          end else begin
            if (s_axis_tvalid & s_axis_tready & is_first_beat) begin
              timestamp <= ats_scheduler_timer;
            end else begin
              // Do nothing
            end
            if (s_axis_tvalid & s_axis_tready & s_axis_tlast) begin
              is_timestamp_beat <= 1'b1;
            end else begin
              // Do nothing
            end
          end
        end
      end // always @ (posedge clk)
    end else begin // if (C_AXIS_TDATA_WIDTH == 8)
      localparam SHIFTREG_WIDTH = TIMESTAMP_WIDTH + C_AXIS_TDATA_WIDTH;
      reg [1:0]                  state;
      wire                       send_done = (m_axis_tvalid && m_axis_tready && m_axis_tlast);

      localparam [1:0] ST_IDLE = 2'b00;
      localparam [1:0] ST_READING = 2'b01;
      localparam [1:0] ST_TIMESTAMP = 2'b10;

      always @ (posedge clk) begin
        if (!rstn) begin
          state <= ST_IDLE;
        end else begin
          case (state)
            ST_IDLE: begin
              if (s_axis_tvalid && s_axis_tready) begin
                if (s_axis_tlast) begin
                  state <= ST_TIMESTAMP;
                end else begin
                  state <= ST_READING;
                end
              end
            end
            ST_READING: begin
              if (s_axis_tvalid && s_axis_tready) begin
                if (s_axis_tlast) begin
                  state <= ST_TIMESTAMP;
                end
              end
            end
            ST_TIMESTAMP: begin
              if (send_done) begin
                state <= ST_IDLE;
              end
            end
            default: begin
              state <= ST_IDLE;
            end
          endcase
        end
      end // always @ (posedge clk)

      wire cke = !m_axis_tvalid || m_axis_tready;
      assign s_axis_tready = cke && (state != ST_TIMESTAMP);

      reg [C_AXIS_TDATA_WIDTH-1:0] keep_mask;
      reg [$clog2(C_AXIS_TKEEP_WIDTH):0] num_bytes;
      integer              i;
      always @ (*) begin
        num_bytes = 0;
        for (i = 0; i < C_AXIS_TKEEP_WIDTH; i = i + 1) begin
          keep_mask[i * 8 +: 8] = {8{s_axis_tkeep[i]}};

          if (s_axis_tkeep[i]) begin
            num_bytes = i + 1;
          end
        end
      end

      reg [SHIFTREG_WIDTH-1:0] out_words;
      reg [SHIFTREG_WIDTH/8-1:0] out_keeps;
      reg                        out_valid;
      always @(posedge clk) begin
        if (!rstn) begin
          out_words <= 0;
          out_keeps <= 0;
          out_valid <= 0;
        end else begin
          if (cke) begin
            if (s_axis_tvalid && s_axis_tready) begin
              if (state == ST_IDLE) begin
                if (s_axis_tlast) begin
                  out_words <= (s_axis_tdata & keep_mask) | ({{1'b0{C_AXIS_TDATA_WIDTH}}, ats_scheduler_timer} << (num_bytes * 8));
                  out_keeps <= {SHIFTREG_WIDTH/8{1'b1}} >> (C_AXIS_TKEEP_WIDTH - num_bytes);
                  out_valid <= 1'b1;
                end else begin
                  out_words <= {ats_scheduler_timer, s_axis_tdata};
                  out_keeps <= {SHIFTREG_WIDTH/8{1'b1}};
                  out_valid <= 1'b1;
                end
              end else begin
                if (s_axis_tlast) begin
                  out_words <= (s_axis_tdata & keep_mask) | ({{1'b0{C_AXIS_TDATA_WIDTH}}, out_words[C_AXIS_TDATA_WIDTH +: TIMESTAMP_WIDTH]} << (num_bytes * 8));
                  out_keeps <= {SHIFTREG_WIDTH/8{1'b1}} >> (C_AXIS_TKEEP_WIDTH - num_bytes);
                  out_valid <= 1'b1;
                end else begin
                  out_words <= {out_words[C_AXIS_TDATA_WIDTH +: TIMESTAMP_WIDTH], s_axis_tdata};
                  out_keeps <= {SHIFTREG_WIDTH/8{1'b1}};
                  out_valid <= 1'b1;
                end
              end
            end else if (state == ST_TIMESTAMP) begin // if (s_axis_tvalid && s_axis_tready)
              out_words <= (out_words >> C_AXIS_TDATA_WIDTH);
              out_keeps <= (out_keeps >> C_AXIS_TKEEP_WIDTH);
              out_valid <= 1'b1;
            end else begin
              out_words <= out_words;
              out_keeps <= out_keeps;
              out_valid <= 1'b0;
            end
          end // if (cke)
        end
      end

      assign m_axis_tdata = out_words[0 +: C_AXIS_TDATA_WIDTH];
      assign m_axis_tkeep = out_keeps[0 +: C_AXIS_TKEEP_WIDTH];
      assign m_axis_tvalid = out_valid && (out_keeps[0 +: C_AXIS_TKEEP_WIDTH] != 0);
      assign m_axis_tlast = !(|out_keeps[SHIFTREG_WIDTH/8-1:C_AXIS_TKEEP_WIDTH]);
    end
  endgenerate
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
endmodule

`default_nettype wire
