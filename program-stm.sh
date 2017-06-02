#!/bin/sh

# BOOT1 BOOT0     Boot mode
#   x     0       Main Flash memory  Main Flash memory is selected as the boot space
#   0     1       System memory      System memory is selected as the boot space
#   1     1       Embedded SRAM      Embedded SRAM is selected as the boot space
# BOOT1 = 0 (Pull-Down)
# BOOT0 = PE6 (134)
#
#################################################
#           BOOT FROM SYSTEM MEMORY
#################################################
#        BOOT0 = 1, BOOT1 = 0
#################################################
#echo -e "GPIO0=1"
echo "134" > "/sys/class/gpio/unexport"
echo "134" >  "/sys/class/gpio/export"
echo "out" > "/sys/class/gpio/gpio134/direction"
echo "1" > "/sys/class/gpio/gpio134/value"
#################################################
#        RESET STM32  (Pulse on NRST PE0 (128))
#################################################
#echo -e "PULSE ON NRST"
echo "128" > "/sys/class/gpio/unexport"
echo "128" > "/sys/class/gpio/export"
echo "out" > "/sys/class/gpio/gpio128/direction"
echo "0" > "/sys/class/gpio/gpio128/value"
sleep 1 &&
echo "1" > "/sys/class/gpio/gpio128/value"
#################################################
#        PROGRAM STM32  (openocd)
#################################################
#echo -e "Release GPIOs"
echo "134" > "/sys/class/gpio/unexport"
echo "128" > "/sys/class/gpio/unexport"
/usr/bin/openocd -f /home/chip/chip-pro.cfg
#################################################
#           BOOT FROM FLASH MEMORY
#################################################
#        BOOT0 = 0, BOOT1 = 0
#################################################
#echo "134" > "/sys/class/gpio/unexport"
echo "134" > "/sys/class/gpio/export"
echo "out" > "/sys/class/gpio/gpio134/direction"
echo "0" > "/sys/class/gpio/gpio134/value"
#################################################
#        RESET STM32  (Pulse on NRST PE0 (128))
#################################################
#echo "128" > "/sys/class/gpio/unexport"
echo "128" > "/sys/class/gpio/export"
echo "out" > "/sys/class/gpio/gpio128/direction"
echo "0" > "/sys/class/gpio/gpio128/value"
sleep 1 &&
echo "1" > "/sys/class/gpio/gpio128/value"

echo "130" > "/sys/class/gpio/unexport"
echo "130" > "/sys/class/gpio/export"
echo "out" > "/sys/class/gpio/gpio130/direction"
sleep 1 &&
echo "in" > "/sys/class/gpio/gpio130/direction"
echo "130" > "/sys/class/gpio/unexport"
