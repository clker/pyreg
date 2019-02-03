module regfile(
    input clk,
    input rstb,
    {% for reg in regs %}
        {% for field in reg.fields %}
            {% if field['attr'] == 'rw' or field['attr'] == 'wo' %}
    output reg [{{field['len']-1}}:0] {{field.name}},
            {% else %}
    input [{{field['len']-1}}:0] {{field.name}},
            {% endif %}
        {% endfor %}
    {% endfor %}
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
        {% for reg in regs %}
            {% for field in reg['fields'] %}
                {% if field['attr'] == 'rw' %}
        {{field.name}} <= {{field.default}};
                {% endif %}
            {% endfor %}
        {% endfor %}
    end else if(wr_en) begin
        case(wr_addr) 
            {% for reg in regs %}
            {{reg['offset']}}: begin
                    {% for b_fields in reg['seg_fields'] %}
                        {% if b_fields %}
                if(be[{{loop.index0}}]) begin
                            {% for field in b_fields %}
                                {% if field['attr'] == 'rw' %}
                    {{field['name']}}{{field['field_range']}} <= wdata{{field['wdata_range']}};
                                {% endif %}
                            {% endfor %}
                end
                        {% endif %}
                    {% endfor %}
            end
            {% endfor %}
        endcase
    end
end

//wo registers write
always @(posedge clk or negedge rstb) begin
    if(~rstb) begin
        {% for reg in regs %}
            {% for field in reg['fields'] %}
                {% if field['attr'] == 'wo' %}
        {{field.name}} <= {{field.default}};
                {% endif %}
            {% endfor %}
        {% endfor %}
    end else if(wr_en) begin
        case(wr_addr) 
            {% for reg in regs %}
            {{reg['offset']}}: begin
                    {% for b_fields in reg['seg_fields'] %}
                        {% if b_fields %}
                if(be[{{loop.index0}}]) begin
                            {% for field in b_fields %}
                                {% if field['attr'] == 'wo' %}
                    {{field['name']}}{{field['field_range']}} <= wdata{{field['wdata_range']}};
                                {% endif %}
                            {% endfor %}
                end
                        {% endif %}
                    {% endfor %}
            end
            {% endfor %}
        endcase
    end else begin
        {% for reg in regs %}
            {% for field in reg['fields'] %}
                {% if field['attr'] == 'wo' %}
        {{field.name}} <= {{field.default}};
                {% endif %}
            {% endfor %}
        {% endfor %}
    end
end

//register read
always @(posedge clk or negedge rstb) begin
    if(~rstb) begin
        rdata <= 0;
    end else if(rd_en)begin
        case(rd_addr)
        {% for reg in regs %}
            {{reg.offset}}: begin
                {% for field in reg['fields'] %}
                rdata{{field.rd_range}} <= {{field.name}};
                {% endfor %}
            end
        {% endfor %}
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
