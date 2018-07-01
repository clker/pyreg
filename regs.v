module regfile(
    input clk,
    input rstb,
                output reg [4:0] spi_rw_len,
                output reg [0:0] spi_d_rise_align,
                output reg [3:0] out_cnt,
                output reg [0:0] rx_dac_gain,
                output reg [0:0] is_10_bit,
                output reg [4:0] adc_clk_dly,
                output reg [31:0] spi_wdata,
                output reg [0:0] spi_wr_en,
                output reg [0:0] spi_rd_en,
                input [11:0] adc_chb_result,
                input [11:0] adc_cha_result,
                input [11:0] adc_fco_result,
                input [11:0] adc_dco_result,
                input [31:0] spi_rdata,
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
                    spi_rw_len <= 0;
                    spi_d_rise_align <= 0;
                    out_cnt <= 0;
                    rx_dac_gain <= 0;
                    is_10_bit <= 0;
                    adc_clk_dly <= 0;
                    spi_wdata <= 0;
    end else if(wr_en) begin
        case(wr_addr)
                0: begin
                        if(be[0]) begin
                                    adc_clk_dly[4:0] <= wdata[4:0];
                        end
                        if(be[1]) begin
                                    out_cnt[3:0] <= wdata[15:12];
                                    rx_dac_gain[0:0] <= wdata[9:9];
                                    is_10_bit[0:0] <= wdata[8:8];
                        end
                        if(be[2]) begin
                                    spi_d_rise_align[0:0] <= wdata[16:16];
                        end
                        if(be[3]) begin
                                    spi_rw_len[4:0] <= wdata[28:24];
                        end
                end
                4: begin
                        if(be[0]) begin
                                    spi_wdata[7:0] <= wdata[7:0];
                        end
                        if(be[1]) begin
                                    spi_wdata[15:8] <= wdata[15:8];
                        end
                        if(be[2]) begin
                                    spi_wdata[23:16] <= wdata[23:16];
                        end
                        if(be[3]) begin
                                    spi_wdata[31:24] <= wdata[31:24];
                        end
                end
                8: begin
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
                        end
                end
        endcase
    end
end

//wo registers write
always @(posedge clk or negedge rstb) begin
    if(~rstb) begin
                    spi_wr_en <= 0;
                    spi_rd_en <= 0;
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
                4: begin
                        if(be[0]) begin
                        end
                        if(be[1]) begin
                        end
                        if(be[2]) begin
                        end
                        if(be[3]) begin
                        end
                end
                8: begin
                        if(be[0]) begin
                                    spi_wr_en[0:0] <= wdata[0:0];
                                    spi_rd_en[0:0] <= wdata[1:1];
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
                        end
                end
        endcase
    end else begin
                    spi_wr_en <= 0;
                    spi_rd_en <= 0;
    end
end

//register read
always @(posedge clk or negedge rstb) begin
    if(~rstb) begin
        rdata <= 0;
    end else if(rd_en)begin
        case(rd_addr)
            0: begin
                    rdata[28:24] <= spi_rw_len;
                    rdata[16] <= spi_d_rise_align;
                    rdata[15:12] <= out_cnt;
                    rdata[9] <= rx_dac_gain;
                    rdata[8] <= is_10_bit;
                    rdata[4:0] <= adc_clk_dly;
            end
            4: begin
                    rdata[31:0] <= spi_wdata;
            end
            8: begin
                    rdata[0] <= spi_wr_en;
                    rdata[1] <= spi_rd_en;
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
                    rdata[31:0] <= spi_rdata;
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