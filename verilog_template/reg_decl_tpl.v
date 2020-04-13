    {% for reg in regs %}
        {% for field in reg.fields %}
            logic [{{field['len']-1}}:0] {{field.name}};
        {% endfor %}
    {% endfor %}
