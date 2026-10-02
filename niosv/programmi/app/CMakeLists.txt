cmake_minimum_required(VERSION 3.14)

add_subdirectory(../bsp bsp)

include(../bsp/toolchain.cmake)

project(onchip_mem)

enable_language(ASM)
enable_language(C)
enable_language(CXX)

add_executable(onchip_mem.elf)

target_sources(onchip_mem.elf
    PRIVATE
        onchip_mem.c
)

target_include_directories(onchip_mem.elf
    PRIVATE
    PUBLIC
)

target_link_libraries(onchip_mem.elf
    PRIVATE
        -T "${BspLinkerScript}" -nostdlib
        "${ExtraArchiveLibraries}"
        -Wl,--start-group "${BspLibraryName}" -lc -lstdc++ -lgcc -lm -Wl,--end-group
)

# Create objdump from ELF.
set(objdump onchip_mem.elf.objdump)
add_custom_command(
    OUTPUT "${objdump}"
    DEPENDS onchip_mem.elf
    COMMAND "${ToolchainObjdump}" "${ToolchainObjdumpFlags}" onchip_mem.elf >
            "${objdump}"
    COMMENT "Creating ${objdump}."
    VERBATIM
)
add_custom_target(create-objdump ALL DEPENDS "${objdump}")

# Report space free for stack + heap. Note that the file below is never created
# so the report is always output on build.
set(stack_report_file onchip_mem.elf.stack_report)
add_custom_command(
    OUTPUT "${stack_report_file}"
    DEPENDS onchip_mem.elf
    COMMAND niosv-stack-report -p "${ToolchainPrefix}" onchip_mem.elf
    COMMENT "Reporting memory available for stack + heap in onchip_mem.elf."
    VERBATIM
)
add_custom_target(niosv-stack-report ALL DEPENDS "${stack_report_file}")

# Generate HEX file(s) from onchip_mem.elf using elf2hex tool.
# Note : If ECC Full is enabled, width of 39 is set for NiosV TCM. Otherwise, 32.
add_custom_command(
    OUTPUT "onchip_memory2_0.hex"
    DEPENDS onchip_mem.elf
    COMMAND elf2hex onchip_mem.elf -o onchip_memory2_0.hex -b 0x00010000 -w 32 -e 0x0001FFFF -r 4
    COMMENT "Creating onchip_memory2_0.hex."
    VERBATIM
)
add_custom_target(create-hex ALL DEPENDS "onchip_memory2_0.hex")
