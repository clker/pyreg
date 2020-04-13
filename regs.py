from jinja2 import Environment, FileSystemLoader, select_autoescape
from collections import OrderedDict
import json
import sys
import os

env = Environment(
        loader=FileSystemLoader([
            os.path.join(os.getcwd(),'html_template'),
            os.path.join(os.getcwd(),'verilog_template')]),
        autoescape=select_autoescape(['html', 'xml']),
        trim_blocks = True,
        lstrip_blocks = True,
        keep_trailing_newline = True,
)

def get_object_from_json(json_fn):
    with open(json_fn) as f:
        s = f.read()
    return json.loads(s,object_pairs_hook=OrderedDict)

def reorg_regs(regs):
    new_regs = []
    for reg in regs:
        new_reg = {'offset':reg['offset'],'fields':reg['fields']}
        #update length
        for field in reg['fields']:
            field['name'] += ('_' + field['attr'])
            if type(field['bits']) == type(0):
                field.update({'len':1})
                field.update({'rd_range':'[%d]'%field['bits']})
            else:
                field.update({'len':field['bits'][0] - field['bits'][1] + 1})
                field.update({'rd_range':'[%d:%d]'%(field['bits'][0],field['bits'][1])})

        #split the field to seg_fields
        fields = [[],[],[],[]]
        for field in reg['fields']:
            wdata_range = [[None,None],[None,None],[None,None],[None,None]]
            bits = field['bits']
            if type(bits) == type(0):
                upper = bits
                lower = bits
            else:
                upper = bits[0]
                lower = bits[1]
            if lower < 8:  
                wdata_range[0][0] = lower
                if upper < 8: 
                    wdata_range[0][1] = upper
                elif upper < 16: 
                    wdata_range[0][1] = 7
                    wdata_range[1][0] = 8
                    wdata_range[1][1] = upper
                elif upper < 24: 
                    wdata_range[0][1] = 7
                    wdata_range[1][0] = 8
                    wdata_range[1][1] = 15
                    wdata_range[2][0] = 16
                    wdata_range[2][1] = upper
                else: 
                    wdata_range[0][1] = 7
                    wdata_range[1][0] = 8
                    wdata_range[1][1] = 15
                    wdata_range[2][0] = 16
                    wdata_range[2][1] = 23
                    wdata_range[3][0] = 24
                    wdata_range[3][1] = upper
            elif lower < 16: 
                wdata_range[1][0] = lower
                if upper < 16: 
                    wdata_range[1][1] = upper
                elif upper < 24: 
                    wdata_range[1][1] = 15
                    wdata_range[2][0] = 16
                    wdata_range[2][1] = upper
                else: 
                    wdata_range[1][1] = 15
                    wdata_range[2][0] = 16
                    wdata_range[2][1] = 23
                    wdata_range[3][0] = 24
                    wdata_range[3][1] = upper
            elif lower < 24: 
                wdata_range[2][0] = lower
                if upper < 24: 
                    wdata_range[2][1] = upper
                else: 
                    wdata_range[2][1] = 23
                    wdata_range[3][0] = 24
                    wdata_range[3][1] = upper
            else: 
                wdata_range[3][0] = lower
                wdata_range[3][1] = upper
            i = 0
            lower_bits = 0
            for w_range in wdata_range:
                if w_range[0] != None:
                    length = w_range[1] - w_range[0] + 1
                    new_field = {'name':field['name'],'attr':field['attr'],'default':field['default']}
                    new_field.update({'field_range':"[%d:%d]"%(lower_bits + length - 1,lower_bits), 
                                      'wdata_range':"[%d:%d]"%(w_range[1],w_range[0])})
                    fields[i].append(new_field)
                    lower_bits += length
                i += 1
        #    print(wdata_range)
        #    print(json.dumps(fields,indent=4))
        new_reg.update({'seg_fields':fields})
        new_regs.append(new_reg)
    return new_regs

def gen_from_json(json_fn):
    if 'output' not in os.listdir():
        os.system('mkdir output')
    regs = get_object_from_json(json_fn)
    html = render('regs_tpl.html',{'regs':regs})
    with open(os.getcwd() + os.sep + "output" + os.sep + 'regs.html','w') as f:
        f.write(html)

    new_regs = reorg_regs(regs)
    verilog = render('regs_tpl.v',{'regs':new_regs})
    with open(os.getcwd() + os.sep + "output" + os.sep + 'regs.v','w') as f:
        f.write(verilog)

    reg_conn = render('reg_conn_tpl.v',{'regs':new_regs})
    with open(os.getcwd() + os.sep + "output" + os.sep + 'reg_conn.vh','w') as f:
        f.write(reg_conn)

    reg_decl = render('reg_decl_tpl.v',{'regs':new_regs})
    with open(os.getcwd() + os.sep + "output" + os.sep + 'reg_decl.vh','w') as f:
        f.write(reg_decl)


def render(tpl,context):
    t = env.get_template(tpl) 
    return t.render(context)


if __name__ == '__main__':
    gen_from_json(sys.argv[1])
