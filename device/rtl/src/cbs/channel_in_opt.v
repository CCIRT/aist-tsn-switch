// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module channel_in_opt #(
  parameter PORT_ADDR = 0,
  parameter PORT_HIGH = 3,
  parameter PORT_WIDTH = $clog2(PORT_HIGH+1),
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8
) (
  input wire                            aclk,
  input wire                            aresetn,
  // Income frames
  input wire [C_AXIS_TDATA_WIDTH-1:0]   s_axis_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0]   s_axis_tkeep,
  input wire                            s_axis_tvalid,
  output wire                           s_axis_tready,
  input wire                            s_axis_tlast,
  // Outcome frames
  output wire [C_AXIS_TDATA_WIDTH-1:0]  m_axis_tdata,
  output wire [C_AXIS_TKEEP_WIDTH-1:0]  m_axis_tkeep,
  output wire [PORT_WIDTH-1:0]          m_axis_tdest,
  output wire                           m_axis_tvalid,
  input wire                            m_axis_tready,
  output wire                           m_axis_tlast,
  // Table read request
  output wire [95:0]                    m_axis_table_request_tdata,
  output wire [PORT_WIDTH-1:0]          m_axis_table_request_tuser,
  output wire                           m_axis_table_request_tvalid,
  input wire                            m_axis_table_request_tready,
  // Table read response
  input wire [7:0]                      s_axis_table_response_tdata,
  input wire [PORT_WIDTH*2-1:0]         s_axis_table_response_tuser,
  input wire                            s_axis_table_response_tvalid,
  // Status: {frames, dropped, error_crc, error_len}
  output wire [127:0]                   m_axis_status_tdata,
  output wire                           m_axis_status_tvalid
);

  assign m_axis_status_tdata = 0;
  assign m_axis_status_tvalid = 0;

  /*
   *  receiver --+-> fifo  --> regular --+-> mux
   *             `-> broadcast         --'
   */

  // regular
  // receiver <-> fifo <-> regular <-> mux
  wire [C_AXIS_TDATA_WIDTH-1:0]         tmp_r0_axis_tdata;
  wire [C_AXIS_TKEEP_WIDTH-1:0]         tmp_r0_axis_tkeep;
  wire                                  tmp_r0_axis_tvalid;
  wire                                  tmp_r0_axis_tready;
  wire                                  tmp_r0_axis_tlast;
  wire [C_AXIS_TDATA_WIDTH-1:0]         tmp_r1_axis_tdata;
  wire [C_AXIS_TKEEP_WIDTH-1:0]         tmp_r1_axis_tkeep;
  wire                                  tmp_r1_axis_tvalid;
  wire                                  tmp_r1_axis_tready;
  wire                                  tmp_r1_axis_tlast;
  wire [C_AXIS_TDATA_WIDTH-1:0]         tmp_r2_axis_tdata;
  wire [C_AXIS_TKEEP_WIDTH-1:0]         tmp_r2_axis_tkeep;
  wire [PORT_WIDTH-1:0]                 tmp_r2_axis_tdest;
  wire                                  tmp_r2_axis_tvalid;
  wire                                  tmp_r2_axis_tready;
  wire                                  tmp_r2_axis_tlast;

  // broadcast
  // receiver <-> broadcast <-> mux
  wire [C_AXIS_TDATA_WIDTH-1:0]         tmp_b0_axis_tdata;
  wire [C_AXIS_TKEEP_WIDTH-1:0]         tmp_b0_axis_tkeep;
  wire                                  tmp_b0_axis_tvalid;
  wire                                  tmp_b0_axis_tready;
  wire                                  tmp_b0_axis_tlast;
  wire [C_AXIS_TDATA_WIDTH-1:0]         tmp_b1_axis_tdata;
  wire [C_AXIS_TKEEP_WIDTH-1:0]         tmp_b1_axis_tkeep;
  wire [PORT_WIDTH-1:0]                 tmp_b1_axis_tdest;
  wire                                  tmp_b1_axis_tvalid;
  wire                                  tmp_b1_axis_tready;
  wire                                  tmp_b1_axis_tlast;


  channel_in_receiver #(
                        // Parameters
                        .PORT_ADDR                        (PORT_ADDR),
                        .PORT_HIGH                        (PORT_HIGH),
                        .PORT_WIDTH                       (PORT_WIDTH),
                        .C_AXIS_TDATA_WIDTH               (C_AXIS_TDATA_WIDTH),
                        .C_AXIS_TKEEP_WIDTH               (C_AXIS_TKEEP_WIDTH))
  channel_in_receiver_inst (
                            // Outputs
                            .s_axis_tready                (s_axis_tready),
                            .m_axis_regular_tdata         (tmp_r0_axis_tdata),
                            .m_axis_regular_tkeep         (tmp_r0_axis_tkeep),
                            .m_axis_regular_tvalid        (tmp_r0_axis_tvalid),
                            .m_axis_regular_tlast         (tmp_r0_axis_tlast),
                            .m_axis_broadcast_tdata       (tmp_b0_axis_tdata),
                            .m_axis_broadcast_tkeep       (tmp_b0_axis_tkeep),
                            .m_axis_broadcast_tvalid      (tmp_b0_axis_tvalid),
                            .m_axis_broadcast_tlast       (tmp_b0_axis_tlast),
                            .m_axis_table_request_tdata   (m_axis_table_request_tdata),
                            .m_axis_table_request_tuser   (m_axis_table_request_tuser),
                            .m_axis_table_request_tvalid  (m_axis_table_request_tvalid),
                            // Inputs
                            .aclk                         (aclk),
                            .aresetn                      (aresetn),
                            .s_axis_tdata                 (s_axis_tdata),
                            .s_axis_tkeep                 (s_axis_tkeep),
                            .s_axis_tvalid                (s_axis_tvalid),
                            .s_axis_tlast                 (s_axis_tlast),
                            .m_axis_regular_tready        (tmp_r0_axis_tready),
                            .m_axis_broadcast_tready      (tmp_b0_axis_tready),
                            .m_axis_table_request_tready  (m_axis_table_request_tready));


  // fixed to 2048 depth
  generate
    if (C_AXIS_TKEEP_WIDTH == 1) begin
      channel_in_fifo #(
                        // Parameters
                        .DWIDTH             (C_AXIS_TDATA_WIDTH + 1),
                        .AWIDTH             (11))
      channel_in_fifo_inst (
                            // Outputs
                            .s_axis_tready  (tmp_r0_axis_tready),
                            .m_axis_tdata   ({tmp_r1_axis_tdata, tmp_r1_axis_tlast}),
                            .m_axis_tvalid  (tmp_r1_axis_tvalid),
                            // Inputs
                            .aclk           (aclk),
                            .aresetn        (aresetn),
                            .s_axis_tdata   ({tmp_r0_axis_tdata, tmp_r0_axis_tlast}),
                            .s_axis_tvalid  (tmp_r0_axis_tvalid),
                            .m_axis_tready  (tmp_r1_axis_tready));

      assign tmp_r1_axis_tkeep = 1;
    end else begin // if (C_AXIS_TKEEP_WIDTH == 1)
      channel_in_fifo #(
                        // Parameters
                        .DWIDTH             (C_AXIS_TDATA_WIDTH + C_AXIS_TKEEP_WIDTH + 1),
                        .AWIDTH             (11))
      channel_in_fifo_inst (
                            // Outputs
                            .s_axis_tready  (tmp_r0_axis_tready),
                            .m_axis_tdata   ({tmp_r1_axis_tdata, tmp_r1_axis_tkeep, tmp_r1_axis_tlast}),
                            .m_axis_tvalid  (tmp_r1_axis_tvalid),
                            // Inputs
                            .aclk           (aclk),
                            .aresetn        (aresetn),
                            .s_axis_tdata   ({tmp_r0_axis_tdata, tmp_r0_axis_tkeep, tmp_r0_axis_tlast}),
                            .s_axis_tvalid  (tmp_r0_axis_tvalid),
                            .m_axis_tready  (tmp_r1_axis_tready));
    end
  endgenerate


  channel_in_regular #(
                       // Parameters
                       .PORT_ADDR                         (PORT_ADDR),
                       .PORT_HIGH                         (PORT_HIGH),
                       .PORT_WIDTH                        (PORT_WIDTH),
                       .C_AXIS_TDATA_WIDTH                (C_AXIS_TDATA_WIDTH),
                       .C_AXIS_TKEEP_WIDTH                (C_AXIS_TKEEP_WIDTH))
  channel_in_regular_inst (
                           // Outputs
                           .s_axis_tready                 (tmp_r1_axis_tready),
                           .m_axis_tdata                  (tmp_r2_axis_tdata),
                           .m_axis_tkeep                  (tmp_r2_axis_tkeep),
                           .m_axis_tdest                  (tmp_r2_axis_tdest),
                           .m_axis_tvalid                 (tmp_r2_axis_tvalid),
                           .m_axis_tlast                  (tmp_r2_axis_tlast),
                           // Inputs
                           .aclk                          (aclk),
                           .aresetn                       (aresetn),
                           .s_axis_tdata                  (tmp_r1_axis_tdata),
                           .s_axis_tkeep                  (tmp_r1_axis_tkeep),
                           .s_axis_tvalid                 (tmp_r1_axis_tvalid),
                           .s_axis_tlast                  (tmp_r1_axis_tlast),
                           .s_axis_table_response_tdata   (s_axis_table_response_tdata),
                           .s_axis_table_response_tuser   (s_axis_table_response_tuser),
                           .s_axis_table_response_tvalid  (s_axis_table_response_tvalid),
                           .m_axis_tready                 (tmp_r2_axis_tready));

  channel_in_broadcast #(
                         // Parameters
                         .PORT_ADDR          (PORT_ADDR),
                         .PORT_HIGH          (PORT_HIGH),
                         .PORT_WIDTH         (PORT_WIDTH),
                         .C_AXIS_TDATA_WIDTH (C_AXIS_TDATA_WIDTH),
                         .C_AXIS_TKEEP_WIDTH (C_AXIS_TKEEP_WIDTH))
  channel_in_broadcast_inst (
                             // Outputs
                             .s_axis_tready  (tmp_b0_axis_tready),
                             .m_axis_tdata   (tmp_b1_axis_tdata),
                             .m_axis_tkeep   (tmp_b1_axis_tkeep),
                             .m_axis_tdest   (tmp_b1_axis_tdest),
                             .m_axis_tvalid  (tmp_b1_axis_tvalid),
                             .m_axis_tlast   (tmp_b1_axis_tlast),
                             // Inputs
                             .aclk           (aclk),
                             .aresetn        (aresetn),
                             .s_axis_tdata   (tmp_b0_axis_tdata),
                             .s_axis_tkeep   (tmp_b0_axis_tkeep),
                             .s_axis_tvalid  (tmp_b0_axis_tvalid),
                             .s_axis_tlast   (tmp_b0_axis_tlast),
                             .m_axis_tready  (tmp_b1_axis_tready));

  channel_in_mux #(
                   // Parameters
                   .PORT_HIGH                    (PORT_HIGH),
                   .PORT_WIDTH                   (PORT_WIDTH),
                   .C_AXIS_TDATA_WIDTH           (C_AXIS_TDATA_WIDTH),
                   .C_AXIS_TKEEP_WIDTH           (C_AXIS_TKEEP_WIDTH))
  channel_in_mux_inst (
                       // Outputs
                       .s_axis_regular_tready    (tmp_r2_axis_tready),
                       .s_axis_broadcast_tready  (tmp_b1_axis_tready),
                       .m_axis_tdata             (m_axis_tdata),
                       .m_axis_tkeep             (m_axis_tkeep),
                       .m_axis_tdest             (m_axis_tdest),
                       .m_axis_tvalid            (m_axis_tvalid),
                       .m_axis_tlast             (m_axis_tlast),
                       // Inputs
                       .aclk                     (aclk),
                       .aresetn                  (aresetn),
                       .s_axis_regular_tdata     (tmp_r2_axis_tdata),
                       .s_axis_regular_tkeep     (tmp_r2_axis_tkeep),
                       .s_axis_regular_tdest     (tmp_r2_axis_tdest),
                       .s_axis_regular_tvalid    (tmp_r2_axis_tvalid),
                       .s_axis_regular_tlast     (tmp_r2_axis_tlast),
                       .s_axis_broadcast_tdata   (tmp_b1_axis_tdata),
                       .s_axis_broadcast_tkeep   (tmp_b1_axis_tkeep),
                       .s_axis_broadcast_tdest   (tmp_b1_axis_tdest),
                       .s_axis_broadcast_tvalid  (tmp_b1_axis_tvalid),
                       .s_axis_broadcast_tlast   (tmp_b1_axis_tlast),
                       .m_axis_tready            (m_axis_tready));


endmodule

module channel_in_fifo #(
  parameter DWIDTH = 8,
  parameter AWIDTH = 10
) (
  input wire              aclk,
  input wire              aresetn,

  input wire [DWIDTH-1:0] s_axis_tdata,
  input wire              s_axis_tvalid,
  output wire             s_axis_tready,

  output reg [DWIDTH-1:0] m_axis_tdata,
  output reg              m_axis_tvalid,
  input wire              m_axis_tready
);

  reg [AWIDTH:0]           waddr;
  reg [AWIDTH:0]           raddr;
  reg [AWIDTH:0]           raddr_pre;
  reg [DWIDTH-1:0]         mem[2**AWIDTH-1:0];

  wire                     empty = (raddr == waddr);
  wire                     full = raddr[AWIDTH-1:0] == waddr[AWIDTH-1:0] && raddr[AWIDTH] != waddr[AWIDTH];

  assign s_axis_tready = !full;
  wire                     write_ok = s_axis_tvalid && s_axis_tready;
  wire                     read_ok = m_axis_tvalid && m_axis_tready;

  // counter logic
  always @(posedge aclk) begin
    if (!aresetn) begin
      waddr <= 0;
      raddr <= 0;
    end else begin
      if (write_ok) begin
        waddr <= waddr + 1;
      end
      if (read_ok) begin
        raddr <= raddr + 1;
      end
    end
  end

  // output logic
  wire read_en = !empty && raddr_pre != waddr;

  always @(posedge aclk) begin
    if (!aresetn) begin
      m_axis_tdata <= 0;
      m_axis_tvalid <= 0;
      raddr_pre <= 0;
    end else begin
      if (!m_axis_tvalid || m_axis_tready) begin
        if (read_en) begin
          m_axis_tdata <= mem[raddr_pre[AWIDTH-1:0]];
          m_axis_tvalid <= 1;
          raddr_pre <= raddr_pre + 1;
        end else begin
          m_axis_tvalid <= 0;
        end
      end
    end
  end

  // memory logic
  always @(posedge aclk) begin
    if (write_ok) begin
      mem[waddr[AWIDTH-1:0]] <= s_axis_tdata;
    end
  end

endmodule

module channel_in_receiver #(
  parameter PORT_ADDR = 0,
  parameter PORT_HIGH = 3,
  parameter PORT_WIDTH = $clog2(PORT_HIGH+1),
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8
) (
  input wire                          aclk,
  input wire                          aresetn,
  // Income frames
  input wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_tkeep,
  input wire                          s_axis_tvalid,
  output wire                         s_axis_tready,
  input wire                          s_axis_tlast,
  // Regular outcome frames
  output reg [C_AXIS_TDATA_WIDTH-1:0] m_axis_regular_tdata,
  output reg [C_AXIS_TKEEP_WIDTH-1:0] m_axis_regular_tkeep,
  output reg                          m_axis_regular_tvalid,
  input wire                          m_axis_regular_tready,
  output reg                          m_axis_regular_tlast,
  // Broadcast outcome frames
  output reg [C_AXIS_TDATA_WIDTH-1:0] m_axis_broadcast_tdata,
  output reg [C_AXIS_TKEEP_WIDTH-1:0] m_axis_broadcast_tkeep,
  output reg                          m_axis_broadcast_tvalid,
  input wire                          m_axis_broadcast_tready,
  output reg                          m_axis_broadcast_tlast,
  // Table read request
  output reg [95:0]                   m_axis_table_request_tdata,
  output reg [PORT_WIDTH-1:0]         m_axis_table_request_tuser,
  output reg                          m_axis_table_request_tvalid,
  input wire                          m_axis_table_request_tready
);

  localparam MAC_WIDTH = 48;
  localparam [47:0] MAC_BROADCAST = 48'hffff_ffff_ffff;

  // align(MAC_WIDTH * 2, C_AXIS_TDATA_WIDTH) + C_AXIS_TDATA_WIDTH
  localparam SHIFT_REG_WIDTH = (((MAC_WIDTH * 2 + C_AXIS_TDATA_WIDTH - 1) / C_AXIS_TDATA_WIDTH) + 1) * C_AXIS_TDATA_WIDTH;
  localparam SHIFT_REG_KEEP_WIDTH = SHIFT_REG_WIDTH/8;
  localparam SHIFT_REG_VALID_WIDTH = SHIFT_REG_WIDTH/C_AXIS_TDATA_WIDTH;

  reg [SHIFT_REG_WIDTH-1:0]            words;
  reg [SHIFT_REG_KEEP_WIDTH-1: 0]      keeps;
  reg [SHIFT_REG_VALID_WIDTH-1: 0]     valids;
  reg [SHIFT_REG_VALID_WIDTH-1: 0]     lasts;

  localparam [1:0] STATE_SELECTING = 0;
  localparam [1:0] STATE_REGULAR = 1;
  localparam [1:0] STATE_BROADCAST = 2;
  reg [1:0]                             state;

  wire                                  stall_by_req = m_axis_table_request_tvalid && !m_axis_table_request_tready;
  wire                                  stall_by_regular = m_axis_regular_tvalid && !m_axis_regular_tready;
  wire                                  stall_by_broadcast = m_axis_broadcast_tvalid && !m_axis_broadcast_tready;
  wire                                  stall = stall_by_req || stall_by_regular || stall_by_broadcast;

  always @(posedge aclk) begin
    if (!aresetn) begin
      state <= STATE_SELECTING;
    end else begin
      if (!stall) begin
        case (state)
          STATE_SELECTING: begin
            if (s_axis_tvalid && s_axis_tready) begin
              if ((&valids[1 +: SHIFT_REG_VALID_WIDTH - 1]) & !valids[0]) begin
                // check state
                if (words[C_AXIS_TDATA_WIDTH +: MAC_WIDTH] == MAC_BROADCAST) begin
                  state <= STATE_BROADCAST;
                end else begin
                  state <= STATE_REGULAR;
                end
              end
            end
          end
          STATE_REGULAR: begin
            if (lasts[0]) begin
              state <= STATE_SELECTING;
            end
          end
          STATE_BROADCAST: begin
            if (lasts[0]) begin
              state <= STATE_SELECTING;
            end
          end
          default: begin
            state <= STATE_SELECTING;
          end
        endcase // case (state)
      end
    end
  end

  //----------------------
  // receive logic
  //----------------------
  always @(posedge aclk) begin
    if (!aresetn) begin
      // disable reset to synthesize shift register
      // words <= 0;
      // keeps <= 0;
      valids <= 0;
      lasts <= 0;
    end else begin
      if (!stall) begin
        if (s_axis_tvalid && s_axis_tready) begin
          words <= {s_axis_tdata, words[SHIFT_REG_WIDTH-1:C_AXIS_TDATA_WIDTH]};
          keeps <= {s_axis_tkeep, keeps[SHIFT_REG_WIDTH/8-1:C_AXIS_TKEEP_WIDTH]};
          valids <= {1'b1, valids[SHIFT_REG_WIDTH/C_AXIS_TDATA_WIDTH-1:1]};
          lasts <= {s_axis_tlast, lasts[SHIFT_REG_WIDTH/C_AXIS_TDATA_WIDTH-1:1]};
        end else if (|lasts) begin
          words <= {s_axis_tdata, words[SHIFT_REG_WIDTH-1:C_AXIS_TDATA_WIDTH]};
          keeps <= {s_axis_tkeep, keeps[SHIFT_REG_WIDTH/8-1:C_AXIS_TKEEP_WIDTH]};
          valids <= {1'b0, valids[SHIFT_REG_WIDTH/C_AXIS_TDATA_WIDTH-1:1]};
          lasts <= {1'b0, lasts[SHIFT_REG_WIDTH/C_AXIS_TDATA_WIDTH-1:1]};
        end
      end
    end
  end
  assign s_axis_tready = !stall && !(|lasts);

  //----------------------
  // request logic
  //----------------------
  wire is_selecting = (state == STATE_SELECTING);
  wire is_regular = (state == STATE_REGULAR);
  reg  d_is_selecting;
  always @(posedge aclk) begin
    d_is_selecting <= is_selecting;
  end

  always @(posedge aclk) begin
    if (!aresetn) begin
      m_axis_table_request_tdata <= 0;
      m_axis_table_request_tvalid <= 0;
      m_axis_table_request_tuser <= 0;
    end else begin
      if (is_regular && d_is_selecting) begin
        m_axis_table_request_tdata <= words[0 +: MAC_WIDTH * 2];
        m_axis_table_request_tvalid <= 1'b1;
        m_axis_table_request_tuser <= PORT_ADDR;
      end else if (!stall_by_req) begin
        // request is accepted
        m_axis_table_request_tvalid <= 1'b0;
      end
    end
  end

  //----------------------
  // regular logic
  //----------------------
  always @(posedge aclk) begin
    if (!aresetn) begin
      m_axis_regular_tdata <= 0;
      m_axis_regular_tkeep <= 0;
      m_axis_regular_tvalid <= 0;
      m_axis_regular_tlast <= 0;
    end else begin
      if (!stall && state == STATE_REGULAR) begin
        if (s_axis_tvalid && s_axis_tready) begin
          m_axis_regular_tdata <= words[0 +: C_AXIS_TDATA_WIDTH];
          m_axis_regular_tkeep <= keeps[0 +: C_AXIS_TKEEP_WIDTH];
          m_axis_regular_tvalid <= 1'b1;
          m_axis_regular_tlast <= 0;
        end else if (|lasts) begin
          m_axis_regular_tdata <= words[0 +: C_AXIS_TDATA_WIDTH];
          m_axis_regular_tkeep <= keeps[0 +: C_AXIS_TKEEP_WIDTH];
          m_axis_regular_tvalid <= 1'b1;
          m_axis_regular_tlast <= lasts[0];
        end else if (m_axis_regular_tready) begin
          m_axis_regular_tvalid <= 1'b0;
        end
      end else if (!stall_by_regular) begin
        // request is accepted
        m_axis_regular_tvalid <= 1'b0;
      end
    end
  end

  //----------------------
  // broadcast logic
  //----------------------
  always @(posedge aclk) begin
    if (!aresetn) begin
      m_axis_broadcast_tdata <= 0;
      m_axis_broadcast_tkeep <= 0;
      m_axis_broadcast_tvalid <= 0;
      m_axis_broadcast_tlast <= 0;
    end else begin
      if (!stall && state == STATE_BROADCAST) begin
        if (s_axis_tvalid && s_axis_tready) begin
          m_axis_broadcast_tdata <= words[0 +: C_AXIS_TDATA_WIDTH];
          m_axis_broadcast_tkeep <= keeps[0 +: C_AXIS_TKEEP_WIDTH];
          m_axis_broadcast_tvalid <= 1'b1;
          m_axis_broadcast_tlast <= 0;
        end else if (|lasts) begin
          m_axis_broadcast_tdata <= words[0 +: C_AXIS_TDATA_WIDTH];
          m_axis_broadcast_tkeep <= keeps[0 +: C_AXIS_TKEEP_WIDTH];
          m_axis_broadcast_tvalid <= 1'b1;
          m_axis_broadcast_tlast <= lasts[0];
        end else if (m_axis_broadcast_tready) begin
          m_axis_broadcast_tvalid <= 1'b0;
        end
      end else if (!stall_by_broadcast) begin
        // request is accepted
        m_axis_broadcast_tvalid <= 1'b0;
      end
    end
  end

endmodule

module channel_in_regular #(
  parameter PORT_ADDR = 0,
  parameter PORT_HIGH = 3,
  parameter PORT_WIDTH = $clog2(PORT_HIGH+1),
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8
) (
  input wire                            aclk,
  input wire                            aresetn,

  // Income frames
  input wire [C_AXIS_TDATA_WIDTH-1:0]   s_axis_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0]   s_axis_tkeep,
  input wire                            s_axis_tvalid,
  output wire                           s_axis_tready,
  input wire                            s_axis_tlast,
  // Table read response
  input wire [7:0]                      s_axis_table_response_tdata,
  input wire [PORT_WIDTH*2-1:0]         s_axis_table_response_tuser,
  input wire                            s_axis_table_response_tvalid,
  // Outcome frames
  output reg [C_AXIS_TDATA_WIDTH-1:0]   m_axis_tdata,
  output reg [C_AXIS_TKEEP_WIDTH-1:0]   m_axis_tkeep,
  output reg [PORT_WIDTH-1:0]           m_axis_tdest,
  output reg                            m_axis_tvalid,
  input wire                            m_axis_tready,
  output reg                            m_axis_tlast
);

  // worst case: 1500 bytes -> 64 bytes * N
  // received N responses when sending 1500 bytes
  wire [7:0]                            tmp_table_response_tdata;
  wire [PORT_WIDTH*2-1:0]               tmp_table_response_tuser;
  wire                                  tmp_table_response_tvalid;
  wire                                  tmp_table_response_tready;

  // only accept responses which is sent to this port.
  wire [PORT_WIDTH-1:0]                port_src_in = s_axis_table_response_tuser[PORT_WIDTH +: PORT_WIDTH];
  wire                                 accept_response = s_axis_table_response_tvalid && (port_src_in == PORT_ADDR);
  channel_in_fifo #(.DWIDTH(8 + PORT_WIDTH * 2),
                    .AWIDTH(6 + $clog2(C_AXIS_TKEEP_WIDTH)))
  channel_in_fifo_inst (
                        // Outputs
                        .s_axis_tready  (),
                        .m_axis_tdata   ({tmp_table_response_tdata, tmp_table_response_tuser}),
                        .m_axis_tvalid  (tmp_table_response_tvalid),
                        // Inputs
                        .aclk           (aclk),
                        .aresetn        (aresetn),
                        .s_axis_tdata   ({s_axis_table_response_tdata, s_axis_table_response_tuser}),
                        .s_axis_tvalid  (accept_response),
                        .m_axis_tready  (tmp_table_response_tready));


  reg [1:0]                            state;
  localparam [1:0] ST_WAIT_RESPONSE = 0;
  localparam [1:0] ST_SEND = 1;
  localparam [1:0] ST_DROP = 2;

  wire [1:0]                           status = tmp_table_response_tdata[1:0];
  localparam [1:0] RESP_OK = 2'b00;
  localparam [1:0] RESP_NOT_IN_TABLE = 2'b01;
  localparam [1:0] RESP_ERROR = 2'b10;
  wire [PORT_WIDTH-1:0]                port_dst = tmp_table_response_tuser[0 +: PORT_WIDTH];

  reg [PORT_WIDTH-1:0]                            port_dst_reg;
  always @(posedge aclk) begin
    if (!aresetn) begin
      state <= ST_WAIT_RESPONSE;
      port_dst_reg <= 0;
    end else begin
      case (state)
        ST_WAIT_RESPONSE: begin
          if (tmp_table_response_tvalid && tmp_table_response_tready) begin
            if (status == RESP_OK) begin
              if (port_dst == PORT_ADDR) begin
                state <= ST_DROP;
              end else begin
                state <= ST_SEND;
                port_dst_reg <= port_dst;
              end
            end else begin
              state <= ST_DROP;
            end
          end
        end
        ST_SEND: begin
          if (s_axis_tvalid && s_axis_tready && s_axis_tlast) begin
            state <= ST_WAIT_RESPONSE;
          end
        end
        ST_DROP: begin
          if (s_axis_tvalid && s_axis_tready && s_axis_tlast) begin
            state <= ST_WAIT_RESPONSE;
          end
        end
        default: begin
          state <= ST_WAIT_RESPONSE;
        end
      endcase
    end
  end
  assign tmp_table_response_tready = (state == ST_WAIT_RESPONSE);
  assign s_axis_tready = (state == ST_SEND || state == ST_DROP) && (!m_axis_tvalid || m_axis_tready);

  always @(posedge aclk) begin
    if (!aresetn) begin
      m_axis_tdata <= 0;
      m_axis_tkeep <= 0;
      m_axis_tvalid <= 0;
      m_axis_tdest <= port_dst_reg;
      m_axis_tlast <= 0;
    end else begin
      if (state == ST_SEND) begin
        if (!m_axis_tvalid || m_axis_tready) begin
          m_axis_tdata <= s_axis_tdata;
          m_axis_tkeep <= s_axis_tkeep;
          m_axis_tvalid <= s_axis_tvalid;
          m_axis_tdest <= port_dst_reg;
          m_axis_tlast <= s_axis_tlast;
        end
      end else if (m_axis_tready) begin
        // last word
        m_axis_tvalid <= 1'b0;
      end
    end
  end

endmodule

module channel_in_broadcast #(
  parameter MAX_FRAME_SIZE = 2048,
  parameter PORT_ADDR = 0,
  parameter PORT_HIGH = 3,
  parameter PORT_WIDTH = $clog2(PORT_HIGH+1),
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8
) (
  input wire                          aclk,
  input wire                          aresetn,

  // Income frames
  input wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_tkeep,
  input wire                          s_axis_tvalid,
  output wire                         s_axis_tready,
  input wire                          s_axis_tlast,
  // Outcome frames
  output reg [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output reg [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
  output reg [PORT_WIDTH-1:0]         m_axis_tdest,
  output reg                          m_axis_tvalid,
  input wire                          m_axis_tready,
  output reg                          m_axis_tlast
);

  parameter RAM_DEPTH = MAX_FRAME_SIZE/C_AXIS_TKEEP_WIDTH;
  parameter RAM_WIDTH = $clog2(RAM_DEPTH);
  localparam [0:0] ST_READ = 0;
  localparam [0:0] ST_FLUSH = 1;
  localparam LAST_PORT = (PORT_ADDR != PORT_HIGH) ? PORT_HIGH : PORT_HIGH - 1;
  localparam RAM_DWIDTH = (C_AXIS_TKEEP_WIDTH == 1) ?
                          C_AXIS_TDATA_WIDTH + 1 :
                          C_AXIS_TDATA_WIDTH + C_AXIS_TKEEP_WIDTH + 1;


  (* ram_style = "block" *) reg [RAM_DWIDTH-1:0]                 mem[RAM_DEPTH-1:0];
  reg [0:0]                            state;

  always @(posedge aclk) begin
    if (!aresetn) begin
      state <= ST_READ;
    end else begin
      case (state)
        ST_READ: begin
          if (s_axis_tvalid && s_axis_tready && s_axis_tlast) begin
            state <= ST_FLUSH;
          end
        end
        ST_FLUSH: begin
          if (m_axis_tdest == LAST_PORT && m_axis_tvalid && m_axis_tready && m_axis_tlast) begin
            state <= ST_READ;
          end
        end
      endcase
    end
  end

  // ST_READ logic
  assign s_axis_tready = (state == ST_READ);
  reg [RAM_WIDTH-1:0] wcnt;
  generate
    wire [RAM_DWIDTH-1:0] ram_wdata;
    if (C_AXIS_TKEEP_WIDTH == 1) begin
      assign ram_wdata = {s_axis_tdata, s_axis_tlast};
    end else begin
      assign ram_wdata = {s_axis_tdata, s_axis_tkeep, s_axis_tlast};
    end

    always @(posedge aclk) begin
      if (!aresetn) begin
        wcnt <= 0;
      end else begin
        if (state == ST_FLUSH) begin
          wcnt <= 0;
        end else if (state == ST_READ) begin
          if (s_axis_tvalid && s_axis_tready) begin
            mem[wcnt] <= ram_wdata[RAM_DWIDTH-1:0];
            wcnt <= wcnt + 1;
          end
        end
      end
    end // always @ (posedge aclk)
  endgenerate

  // ST_FLUSH logic
  reg [PORT_WIDTH-1:0] dest;
  reg [RAM_WIDTH-1:0]  rcnt;
  generate
    reg [RAM_DWIDTH-1:0] ram_rdata;
    if (C_AXIS_TKEEP_WIDTH == 1) begin
      always @(*) begin
        {m_axis_tdata, m_axis_tlast} = ram_rdata;
        m_axis_tkeep = 1;
      end
    end else begin
      always @(*) begin
        {m_axis_tdata, m_axis_tkeep, m_axis_tlast} = ram_rdata;
      end
    end

    always @(posedge aclk) begin
      if (!aresetn) begin
        dest <= 0;
        rcnt <= 0;
        ram_rdata <= 0;
        m_axis_tdest <= 0;
        m_axis_tvalid <= 0;
      end else begin
        if (state == ST_READ) begin
          // reset
          dest <= 0;
          rcnt <= 0;
        end else begin
          if (state == ST_FLUSH) begin
            if (dest == PORT_ADDR) begin
              dest <= dest + 1;
            end else begin
              if (!m_axis_tvalid || m_axis_tready) begin
                ram_rdata <= mem[rcnt];

                m_axis_tvalid <= 1;
                m_axis_tdest <= dest;
                rcnt <= rcnt + 1;

                if (m_axis_tlast) begin
                  // When last word is sent current cycle, cancel next write
                  m_axis_tvalid <= 0;

                  rcnt <= 0;
                  dest <= dest + 1;
                end
              end
            end
          end
        end
      end
    end // always @ (posedge aclk)
  endgenerate
endmodule

module channel_in_mux #(
  parameter PORT_HIGH = 3,
  parameter PORT_WIDTH = $clog2(PORT_HIGH+1),
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8
) (
  input wire                          aclk,
  input wire                          aresetn,

   // Regular income frames
  input wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_regular_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_regular_tkeep,
  input wire [PORT_WIDTH-1:0]         s_axis_regular_tdest,
  input wire                          s_axis_regular_tvalid,
  output wire                         s_axis_regular_tready,
  input wire                          s_axis_regular_tlast,

  // Broadcast income frames
  input wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_broadcast_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_broadcast_tkeep,
  input wire [PORT_WIDTH-1:0]         s_axis_broadcast_tdest,
  input wire                          s_axis_broadcast_tvalid,
  output wire                         s_axis_broadcast_tready,
  input wire                          s_axis_broadcast_tlast,

  // Outcome frames
  output reg [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output reg [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
  output reg [PORT_WIDTH-1:0]         m_axis_tdest,
  output reg                          m_axis_tvalid,
  input wire                          m_axis_tready,
  output reg                          m_axis_tlast
);

  localparam [1:0] STATE_IDLE = 0;
  localparam [1:0] STATE_READ_REGULAR = 1;
  localparam [1:0] STATE_READ_BROADCAST = 2;
  wire                                cke = !m_axis_tvalid || m_axis_tready;
  reg [1:0]                           state;

  always @(posedge aclk) begin
    if (!aresetn) begin
      state <= STATE_IDLE;
    end else begin
      case (state)
        STATE_IDLE: begin
          if (s_axis_broadcast_tvalid) begin
            state <= STATE_READ_BROADCAST;
          end else if (s_axis_regular_tvalid) begin
            state <= STATE_READ_REGULAR;
          end
        end
        STATE_READ_BROADCAST: begin
          if (m_axis_tvalid && m_axis_tready && m_axis_tlast) begin
            state <= STATE_IDLE;
          end
        end
        STATE_READ_REGULAR: begin
          if (m_axis_tvalid && m_axis_tready && m_axis_tlast) begin
            state <= STATE_IDLE;
          end
        end
        default: begin
          state <= STATE_IDLE;
        end
      endcase
    end
  end

  always @(posedge aclk) begin
    if (!aresetn) begin
      m_axis_tdata <= 0;
      m_axis_tkeep <= 0;
      m_axis_tvalid <= 0;
      m_axis_tdest <= 0;
      m_axis_tlast <= 0;
    end else begin
      if (state == STATE_READ_BROADCAST) begin
        if (cke) begin
          m_axis_tdata <= s_axis_broadcast_tdata;
          m_axis_tkeep <= s_axis_broadcast_tkeep;
          m_axis_tvalid <= s_axis_broadcast_tvalid;
          m_axis_tdest <= s_axis_broadcast_tdest;
          m_axis_tlast <= s_axis_broadcast_tlast;
        end
      end else if (state == STATE_READ_REGULAR) begin
        if (cke) begin
          m_axis_tdata <= s_axis_regular_tdata;
          m_axis_tkeep <= s_axis_regular_tkeep;
          m_axis_tvalid <= s_axis_regular_tvalid;
          m_axis_tdest <= s_axis_regular_tdest;
          m_axis_tlast <= s_axis_regular_tlast;
        end
      end
    end
  end

  assign s_axis_broadcast_tready = cke && (state == STATE_READ_BROADCAST);
  assign s_axis_regular_tready = cke && (state == STATE_READ_REGULAR);

endmodule


`default_nettype wire
