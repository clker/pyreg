    {% for reg in regs %}
        {% for field in reg.fields %}
            .{{field.name}}({{field.name}}),
        {% endfor %}
    {% endfor %}
