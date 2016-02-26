#!/bin/sh
#
# Called: $0 <binary> [identities...]
#  - binary is the path to prefix to target binary, .elf appended to name is
#    the ELF file
#  - identities is the project identities string.
# 
#
if [ $# -lt 1 ]; then
    echo "Need binary to debug"
    exit 1
fi

FILE_NAME=$1.elf
GDB_CMD_FILE=.gdb_cmds

echo "Debugging" $FILE_NAME

#
# Block Ctrl-C from getting passed to openocd.
# Exit openocd when gdb detaches.
#
echo "shell /bin/sh -c 'trap \"\" 2; openocd -f arduino_zero.cfg -c \"gdb_port 3333; telnet_port 4444; stm32f4x.cpu configure -event gdb-detach {shutdown}\" -c init -c \"reset halt\"' & " > $GDB_CMD_FILE
echo "target remote localhost:3333" >> $GDB_CMD_FILE
arm-none-eabi-gdb -x $GDB_CMD_FILE $FILE_NAME
rm $GDB_CMD_FILE
