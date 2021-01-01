
#############################################################
# SYS Debug Serial Wire                                     #
#############################################################
<#import "../../../ioc_collect_pins_and_ips.ftl" as Mcu>
${ Mcu.PINs ("PA13", "PA14") }

# JTMS/SWDIO
PA13\ (JTMS/SWDIO).GPIOParameters=PinAttribute
PA13\ (JTMS/SWDIO).Locked=true
PA13\ (JTMS/SWDIO).Mode=Serial_Wire
PA13\ (JTMS/SWDIO).PinAttribute=CortexM7
PA13\ (JTMS/SWDIO).Signal=DEBUG_JTMS-SWDIO

# JTCK/SWCLK
PA14\ (JTCK/SWCLK).GPIOParameters=PinAttribute
PA14\ (JTCK/SWCLK).Locked=true
PA14\ (JTCK/SWCLK).Mode=Serial_Wire
PA14\ (JTCK/SWCLK).PinAttribute=CortexM7
PA14\ (JTCK/SWCLK).Signal=DEBUG_JTCK-SWCLK
#############################################################
