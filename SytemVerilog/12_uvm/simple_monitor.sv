class simple_monitor_t extends uvm_monitor;
uvm_analysis_imp #(simple_item_t, simple_monitor_t) analysis_export;

uvm_analysis_port #(simple_item_t) item_collected_port;

bit header_printed;

`uvm_component_utils_begin(simple_monitor_t)
    `uvm_field_int(header_printed, UVM_DEFAULT)
`uvm_component_utils_end

function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
    item_collected_port = new("item_collecter_port", this);
endfunction

extern function void write(simple_item_t item);
extern function void print_header();
extern function void print(simple_item_t item);

endclass

function void simple_monitor_t::write(simple_item_t item);
    if( !header_printed)
        print_header;
    print(item);
    item_collected_port.write(item);
endfunction

function void simple_monitor_t::print_header();
    $write("    reset load up_down");
    $write("%-5s", "d");
    $write("%-5s", "q");
    $write("%-5s", "qn");
    $write("   command\n");

    header_printed = 1;
endfunction

function void simple_monitor_t::print(simple_item_t item);
string msg;

   msg = get_msg(item);

    $display("@%3d:  %b     %b     %b     %b %b %b%s",
        $time, item.reset, item.load, item.up_down, item.d, item.q, item.qn, msg);
endfunction

function string get_msg(simple_item_t item);
   if(item.reset  ) return " RESET";
   if(item.load   ) return " LOAD";
   if(item.up_down) return " UP";
                    return " DOWN";
endfunction
