package lc3b_types;

typedef logic [15:0] lc3b_word;
typedef logic [7:0] lc3b_byte;
typedef logic [255:0] lc3b_cacheline;
typedef logic [2:0] lc3b_c_index;
typedef logic [7:0] lc3b_c_tag;
typedef logic [6:0] lc3b_7b_plru;

// IR output types
typedef logic [8:0]  lc3b_offset9;
typedef logic [5:0]  lc3b_offset6;
typedef logic [10:0] lc3b_offset11;
typedef logic [10:0] lc3b_ir_10_0;
typedef logic [4:0]  lc3b_imm5;
typedef logic [3:0]  lc3b_imm4;
typedef logic [7:0]  lc3b_trapvect8;


typedef logic  [2:0] lc3b_reg;
typedef logic  [2:0] lc3b_nzp;
typedef logic  [1:0] lc3b_mem_wmask;

typedef enum bit [3:0] {
    op_add  = 4'b0001,
    op_and  = 4'b0101,
    op_br   = 4'b0000,
    op_jmp  = 4'b1100,   /* also RET */
    op_jsr  = 4'b0100,   /* also JSRR */
    op_ldb  = 4'b0010,
    op_ldi  = 4'b1010,
    op_ldr  = 4'b0110,
    op_lea  = 4'b1110,
    op_not  = 4'b1001,
    op_rti  = 4'b1000,
    op_shf  = 4'b1101,
    op_stb  = 4'b0011,
    op_sti  = 4'b1011,
    op_str  = 4'b0111,
    op_trap = 4'b1111
} lc3b_opcode;

typedef enum bit [3:0] {
    alu_add,
    alu_and,
    alu_not,
    alu_pass,
    alu_sll,
    alu_srl,
    alu_sra
} lc3b_aluop;

typedef struct packed {
    lc3b_aluop aluop;
    logic offset6_lsse;
    logic marmux_EX_sel;
    logic[1:0] alumux_sel;
} lc3b_control_word_ex;

typedef struct packed {
    logic d_mem_read;
    logic d_mem_write;
    logic offset6_lsse;
    logic [1:0] forward_MEM_sel;
} lc3b_control_word_mem;

typedef struct packed {
    logic d_mem_read;               // need for LDI and STI
    logic d_mem_write;

    lc3b_opcode opcode;
    logic destmux_sel;
    logic[1:0] regfilemux_sel;

    logic load_cc;
    logic load_regfile;

    logic [1:0] forward_WB_sel;
} lc3b_control_word_wb;

typedef struct packed {
    logic src2mux_sel;
    lc3b_control_word_ex ex;
    lc3b_control_word_mem mem;
    lc3b_control_word_wb wb;
} lc3b_control_word;


typedef struct packed {
    logic load_d;
    logic load_v;
    logic load_TD;
    logic d_in;
    logic v_in;
} lc3b_cWay_ctl;


typedef struct packed {
    logic load_lru;
    lc3b_cWay_ctl way0;
    lc3b_cWay_ctl way1;
    lc3b_cWay_ctl way2;
    lc3b_cWay_ctl way3;
    lc3b_cWay_ctl way4;
    lc3b_cWay_ctl way5;
    lc3b_cWay_ctl way6;
    lc3b_cWay_ctl way7;
} lc3b_L2_ctl;

typedef struct packed {
    logic d_out;
    logic v_out;
    logic hit;
} lc3b_cWay_state;

typedef struct packed {
    lc3b_cWay_state way0;
    lc3b_cWay_state way1;
    lc3b_cWay_state way2;
    lc3b_cWay_state way3;
    lc3b_cWay_state way4;
    lc3b_cWay_state way5;
    lc3b_cWay_state way6;
    lc3b_cWay_state way7;
} lc3b_L2_state;


typedef struct packed {
    lc3b_reg dest_mem;
	lc3b_reg dest_wb;
	lc3b_reg src1_ex;
	lc3b_reg src2_ex;
	logic load_regfile_mem;
	logic load_regfile_wb;
} lc3b_forward_ex;

typedef struct packed {
    logic load_regfile_wb;
    lc3b_reg dest_wb;
    lc3b_reg sourceR_mem;
    lc3b_reg baseR_mem;
} lc3b_forward_mem;

typedef struct packed {
    logic load_regfile_wb;
    lc3b_word forward_val;
    lc3b_reg dest_wb;
} lc3b_forward_save;

typedef struct packed {
    logic valid;
    logic dirty;
    lc3b_word addr;
    lc3b_cacheline data;
} lc3b_eviction_array_entry;

endpackage : lc3b_types
