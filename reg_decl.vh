
            logic [3:0] out_cnt;
            logic [0:0] rx_dac_gain;
            logic [0:0] is_10_bit;
            logic [5:0] adc_clk_dly;
            logic [3:0] ld_dac_en;
            logic [11:0] ld_dac_val;
            logic [11:0] adc_chb_result;
            logic [11:0] adc_cha_result;
            logic [11:0] adc_fco_result;
            logic [11:0] adc_dco_result;
            logic [0:0] adc_spi_wr_en;
            logic [0:0] adc_spi_rd_en;
            logic [0:0] adc_spi_busy;
            logic [23:0] adc_spi_wdata;
            logic [4:0] adc_spi_wr_len;
            logic [7:0] adc_spi_rdata;
            logic [0:0] rx_dac_spi_wr_en;
            logic [0:0] rx_dac_spi_busy;
            logic [23:0] rx_dac_spi_wdata;
            logic [0:0] l_adc_spi_rd_en;
            logic [0:0] l_adc_spi_busy;
            logic [13:0] l_adc_spi_rdata1;
            logic [13:0] l_adc_spi_rdata;
            logic [31:0] timer_l;
            logic [0:0] timer_rst;
            logic [0:0] timer_stop;
            logic [29:0] timer_h;