class simple_sequence_base_t extends uvm_sequence #(simple_item_t);
simple_sequence_reset_t     seq_reset;
simple_sequence_load_t      seq_load ;
simple_sequence_up_t        seq_up ;
simple_sequence_down_t      seq_down ;

uvm_phase ph;

`uvm_object_utils(simple_sequence_base_t)

function new(string name="simple_sequence_base_t");
    super.new(name);
endfunction

extern virtual task pre_body();
extern virtual task post_body();

endclass

task simple_sequence_base_t::pre_body();
    ph = get_starting_phase();
    if(ph != null)
        ph.raise_objection(this, "SEQ_CONTROL_SEQ_BASE");
endtask

task simple_sequence_base_t::post_body();
    if(ph != null)
        ph.drop_objection(this, "SEQ_CONTROL_SEQ_BASE");
endtask
