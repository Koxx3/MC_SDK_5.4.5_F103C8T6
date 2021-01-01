<#import "../../../ioc_collect_pins_and_ips.ftl" as Mcu>

# Declares commonly used IPs
${ Mcu.IPs ("NVIC1", "NVIC2","RCC", "SYS","SYS_M4") }


