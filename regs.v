module regfile(
    input clk,
    input rstb,
                output reg [3:0] out_cnt,
                output reg [0:0] rx_dac_gain,
                output reg [0:0] is_10_bit,
                output reg [5:0] adc_clk_dly,
                output reg [3:0] ld_dac_en,
                output reg [11:0] ld_dac_val,
                input [11:0] adc_chb_result,
                input [11:0] adc_cha_result,
                input [11:0] adc_fco_result,
                input [11:0] adc_dco_result,
                output reg [0:0] adc_spi_wr_en,
                output reg [0:0] adc_spi_rd_en,
                input [0:0] adc_spi_busy,
                output reg [23:0] adc_spi_wdata,
                output reg [4:0] adc_spi_wr_len,
                input [7:0] adc_spi_rdata,
                output reg [0:0] rx_dac_spi_wr_en,
                input [0:0] rx_dac_spi_busy,
                output reg [23:0] rx_dac_spi_wdata,
                output reg [0:0] l_adc_spi_rd_en,
                input [0:0] l_adc_spi_busy,
                input [13:0] l_adc_spi_rdata1,
                input [13:0] l_adc_spi_rdata,
                input [31:0] timer_l,
                output reg [0:0] timer_rst,
                output reg [0:0] timer_stop,
                input [29:0] timer_h,
    input wr_en,
    input [3:0] be,
    input [15:0] wr_addr,
    input [31:0] wdata,

    input rd_en,
    input [15:0] rd_addr,
    output reg [31:0] rdata,
    output reg rd_rdy
);

//rw registers write
always @(posedge clk or negedge rstb) begin
    if(~rstb) begin
                    out_cnt <= 0;
                    rx_dac_gain <= 0;
                    is_10_bit <= 0;
                    adc_clk_dly <= 0;
                    ld_dac_en <= 0;
                    ld_dac_val <= 0;
                    adc_spi_wdata <= 0;
                    adc_spi_wr_len <= 0;
                    rx_dac_spi_wdata <= 0;
                    timer_stop <= 0;
    end else if(wr_en) begin
        case(wr_addr)
                0: begin
                        if(be[0]) begin
                                    adc_clk_dly[5:0] <= wdata[5:0];
                        end
                        if(be[1]) begin
                                    out_cnt[3:0] <= wdata[15:12];
                                    rx_dac_gain[0:0] <= wdata[9:9];
                                    is_10_bit[0:0] <= wdata[8:8];
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                'hc: begin
                        if(be[0]) begin
                                    ld_dac_val[7:0] <= wdata[7:0];
                        end
                        if(be[1]) begin
                                    ld_dac_val[11:8] <= wdata[11:8];
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                                    ld_dac_en[3:0] <= wdata[31:28];
                        end
                end
                'h10: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                'h14: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                'h20: begin
                        if(be[0]) begin
                                    adc_spi_wdata[7:0] <= wdata[7:0];
                        end
                        if(be[1]) begin
                                    adc_spi_wdata[15:8] <= wdata[15:8];
                        end
                        if(be[2]) begin
                                    adc_spi_wdata[23:16] <= wdata[23:16];
                        end
                        if(be[3]) begin
                        end
                end
                'h24: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                                    adc_spi_wr_len[4:0] <= wdata[12:8];
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                'h28: begin
                        if(be[0]) begin
                                    rx_dac_spi_wdata[7:0] <= wdata[7:0];
                        end
                        if(be[1]) begin
                                    rx_dac_spi_wdata[15:8] <= wdata[15:8];
                        end
                        if(be[2]) begin
                                    rx_dac_spi_wdata[23:16] <= wdata[23:16];
                        end
                        if(be[3]) begin
                        end
                end
                'h2c: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                'h40: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                'h44: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                                    timer_stop[0:0] <= wdata[30:30];
                        end
                end
        endcase
    end
end

//wo registers write
always @(posedge clk or negedge rstb) begin
    if(~rstb) begin
                    adc_spi_wr_en <= 0;
                    adc_spi_rd_en <= 0;
                    rx_dac_spi_wr_en <= 0;
                    l_adc_spi_rd_en <= 0;
                    timer_rst <= 0;
    end else if(wr_en) begin
        case(wr_addr)
                0: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                'hc: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                'h10: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                'h14: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                'h20: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                                    adc_spi_wr_en[0:0] <= wdata[31:31];
                                    adc_spi_rd_en[0:0] <= wdata[30:30];
                        end
                end
                'h24: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                'h28: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                                    rx_dac_spi_wr_en[0:0] <= wdata[31:31];
                        end
                end
                'h2c: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                                    l_adc_spi_rd_en[0:0] <= wdata[30:30];
                        end
                end
                'h40: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                'h44: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                                    timer_rst[0:0] <= wdata[31:31];
                        end
                end
        endcase
    end else begin
                    adc_spi_wr_en <= 0;
                    adc_spi_rd_en <= 0;
                    rx_dac_spi_wr_en <= 0;
                    l_adc_spi_rd_en <= 0;
                    timer_rst <= 0;
    end
end

//register read
always @(posedge clk or negedge rstb) begin
    if(~rstb) begin
        rdata <= 0;
    end else if(rd_en)begin
        case(rd_addr)
            0: begin
                    rdata[15:12] <= out_cnt;
                    rdata[9] <= rx_dac_gain;
                    rdata[8] <= is_10_bit;
                    rdata[5:0] <= adc_clk_dly;
            end
            'hc: begin
                    rdata[31:28] <= ld_dac_en;
                    rdata[11:0] <= ld_dac_val;
            end
            'h10: begin
                    rdata[27:16] <= adc_chb_result;
                    rdata[11:0] <= adc_cha_result;
            end
            'h14: begin
                    rdata[27:16] <= adc_fco_result;
                    rdata[11:0] <= adc_dco_result;
            end
            'h20: begin
                    rdata[31] <= adc_spi_wr_en;
                    rdata[30] <= adc_spi_rd_en;
                    rdata[29] <= adc_spi_busy;
                    rdata[23:0] <= adc_spi_wdata;
            end
            'h24: begin
                    rdata[12:8] <= adc_spi_wr_len;
                    rdata[7:0] <= adc_spi_rdata;
            end
            'h28: begin
                    rdata[31] <= rx_dac_spi_wr_en;
                    rdata[29] <= rx_dac_spi_busy;
                    rdata[23:0] <= rx_dac_spi_wdata;
            end
            'h2c: begin
                    rdata[30] <= l_adc_spi_rd_en;
                    rdata[29] <= l_adc_spi_busy;
                    rdata[27:14] <= l_adc_spi_rdata1;
                    rdata[13:0] <= l_adc_spi_rdata;
            end
            'h40: begin
                    rdata[31:0] <= timer_l;
            end
            'h44: begin
                    rdata[31] <= timer_rst;
                    rdata[30] <= timer_stop;
                    rdata[29:0] <= timer_h;
            end
        endcase
    end else if(~rd_rdy)begin
        rdata <= 0;
    end
end

always @(posedge clk or negedge rstb) begin
    if(~rstb) begin
        rd_rdy <= 0;
    end else if(rd_en) begin
        rd_rdy <= 1;
    end else begin
        rd_rdy <= 0;
    end
end
endmodule