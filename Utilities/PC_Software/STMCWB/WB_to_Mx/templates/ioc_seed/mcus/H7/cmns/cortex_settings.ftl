# CORTEX Configuration


#######################################################
${ Mcu.IPs ("CORTEX_M4","CORTEX_M7") }
#######################################################

Mcu.Context0=CortexM7
Mcu.Context1=CortexM4
Mcu.ContextNb=2
#

#######################################################
${ Mcu.CortexM4_IPs("CORTEX_M4\\:I","RCC","SYS_M4\\:I","DMA\\:I","NVIC2\\:I") }
${ Mcu.CortexM7_IPs("CORTEX_M7\\:I","RCC\\:I","SYS\\:I","DMA","NVIC1:\\I") }

<#--${ Mcu.CortexM4_IPs("CORTEX_M4\\:I","DEBUG","FATFS_M4\\:I","FREERTOS_M4\\:I","IWDG2\\:I","PDM2PCM_M4\\:I","PWR","RCC","RESMGR_UTILITY","SYS_M4\\:I","USB_DEVICE_M4\\:I","USB_HOST_M4\\:I","VREFBUF\\:I","WWDG2\\:I","DMA\\:I","BDMA\\:I","MDMA\\:I","NVIC2\\:I") }-->
<#--${ Mcu.CortexM7_IPs("CORTEX_M7\\:I","DEBUG\\:I","FATFS_M7\\:I","FREERTOS_M7\\:I","IWDG1\\:I","PDM2PCM_M7\\:I","PWR\\:I","RCC\\:I","RESMGR_UTILITY\\:I","SYS\\:I","USB_DEVICE_M7\\:I","USB_HOST_M7\\:I","DMA","BDMA","MDMA", "VREFBUF", "WWDG1:\\I","NVIC1:\\I") }-->

#######################################################
