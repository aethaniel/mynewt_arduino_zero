#!/usr/local/bin/dash
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

openocd -f arduino_zero.cfg -c "gdb_port 3333;init;reset halt" &
echo "target remote localhost:3333 " > $GDB_CMD_FILE
arm-none-eabi-gdb -x $GDB_CMD_FILE $FILE_NAME
rm $GDB_CMD_FILE


 


