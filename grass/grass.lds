OUTPUT_ARCH("riscv")

ENTRY(grass_enter)

MEMORY
{
    ram (arw!xi) : ORIGIN = 0x08002800, LENGTH = 0x2800
}

PHDRS
{
    ram PT_LOAD;
}

SECTIONS
{
    __heap_size = 0x800;

    .text : ALIGN(8) {
        *(.text .text.*)
    } >ram :ram

    .rodata : ALIGN(8) {
        *(.rdata)
        *(.rodata .rodata.*)
        . = ALIGN(8);
        *(.srodata .srodata.*)
    } >ram :ram

    .data : ALIGN(8) {
        *(.data .data.*)
        . = ALIGN(8);
        *(.sdata .sdata.* .sdata2.*)
    } >ram :ram

    .bss (NOLOAD): ALIGN(8) {
        *(.sbss*)
        *(.bss .bss.*)
        *(COMMON)
    } >ram :ram

    .heap (NOLOAD) : ALIGN(8) {
          PROVIDE( __heap_start = . );
          . = __heap_size;
    } >ram :ram
    PROVIDE( __heap_end = 0x08005000 );
}
