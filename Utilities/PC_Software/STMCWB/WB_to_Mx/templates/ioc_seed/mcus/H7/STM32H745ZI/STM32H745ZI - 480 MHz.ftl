<#import "../../cmns/ioc_Mcu_PCC.ftl" as u >
<@u.ioc_Mcu_PCC
{ "Family"    : "STM32H7"
, "Package"   : "LQFP144"
, "Name"      : "STM32H745ZITx"
, "UserName"  : "STM32H745ZITx"
, "Line"      : "STM32H745/755x9"
} />



############################################################
# PINs for OSCILLATOR                                      #
############################################################
#
<#import "../../../ioc_collect_pins_and_ips.ftl" as Mcu>
#
${ Mcu.PINs("PH0-OSC_IN (PH0)", "PH1-OSC_OUT (PH1)") }
#
PH0-OSC_IN\ (PH0).GPIOParameters=PinAttribute
PH0-OSC_IN\ (PH0).Locked=true
PH0-OSC_IN\ (PH0).Mode=HSE-External-Oscillator
PH0-OSC_IN\ (PH0).PinAttribute=CortexM7
PH0-OSC_IN\ (PH0).Signal=RCC_OSC_IN
#
PH1-OSC_OUT\ (PH1).GPIOParameters=PinAttribute
PH1-OSC_OUT\ (PH1).Locked=true
PH1-OSC_OUT\ (PH1).Mode=HSE-External-Oscillator
PH1-OSC_OUT\ (PH1).PinAttribute=CortexM7
PH1-OSC_OUT\ (PH1).Signal=RCC_OSC_OUT
############################################################


<#include "../../../mcus/H7/cmns/VP_SYS_VS-VP_SYS_M4_Systick.ftl">
<#include "../../../mcus/H7/cmns/cortex_settings.ftl">
<#include "../../../mcus/H7/cmns/Nvic1_Nvic2.ftl">
<#include "../../../mcus/H7/cmns/basic_ips_and_pins_int.ftl">


# 480 MHz specific settings
RCC.ADCFreq_Value=24000000
RCC.AHB12Freq_Value=240000000
RCC.AHB4Freq_Value=240000000
RCC.APB1Freq_Value=120000000
RCC.APB2Freq_Value=120000000
RCC.APB3Freq_Value=120000000
RCC.APB4Freq_Value=120000000
RCC.AXIClockFreq_Value=240000000
RCC.CECFreq_Value=32000
RCC.CKPERFreq_Value=64000000
RCC.CPU2Freq_Value=240000000
RCC.CPU2SystikFreq_Value=240000000
RCC.CortexFreq_Value=480000000
RCC.CpuClockFreq_Value=480000000
RCC.D1CPREFreq_Value=480000000
RCC.D1PPRE=RCC_APB3_DIV2
RCC.D2PPRE1=RCC_APB1_DIV2
RCC.D2PPRE2=RCC_APB2_DIV2
RCC.D3PPRE=RCC_APB4_DIV2
RCC.DFSDMACLkFreq_Value=480000000
RCC.DFSDMFreq_Value=120000000
RCC.DIVM1=2
RCC.DIVM2=6
RCC.DIVN1=240
RCC.DIVN2=180
RCC.DIVP1Freq_Value=480000000
RCC.DIVP2=10
RCC.DIVP2Freq_Value=24000000
RCC.DIVP3Freq_Value=16125000
RCC.DIVQ1Freq_Value=480000000
RCC.DIVQ2Freq_Value=120000000
RCC.DIVQ3Freq_Value=16125000
RCC.DIVR1Freq_Value=480000000
RCC.DIVR2Freq_Value=120000000
RCC.DIVR3Freq_Value=16125000
RCC.FDCANFreq_Value=480000000
RCC.FMCFreq_Value=240000000
RCC.FamilyName=M
RCC.HCLK3ClockFreq_Value=240000000
RCC.HCLKFreq_Value=240000000
RCC.HPRE=RCC_HCLK_DIV2
RCC.HRTIMFreq_Value=240000000
RCC.HSE_VALUE=8000000
RCC.I2C123Freq_Value=120000000
RCC.I2C4Freq_Value=120000000
RCC.IPParameters=ADCFreq_Value,AHB12Freq_Value,AHB4Freq_Value,APB1Freq_Value,APB2Freq_Value,APB3Freq_Value,APB4Freq_Value,AXIClockFreq_Value,CECFreq_Value,CKPERFreq_Value,CPU2Freq_Value,CPU2SystikFreq_Value,CortexFreq_Value,CpuClockFreq_Value,D1CPREFreq_Value,D1PPRE,D2PPRE1,D2PPRE2,D3PPRE,DFSDMACLkFreq_Value,DFSDMFreq_Value,DIVM1,DIVM2,DIVN1,DIVN2,DIVP1Freq_Value,DIVP2,DIVP2Freq_Value,DIVP3Freq_Value,DIVQ1Freq_Value,DIVQ2Freq_Value,DIVQ3Freq_Value,DIVR1Freq_Value,DIVR2Freq_Value,DIVR3Freq_Value,FDCANFreq_Value,FMCFreq_Value,FamilyName,HCLK3ClockFreq_Value,HCLKFreq_Value,HPRE,HRTIMFreq_Value,HSE_VALUE,I2C123Freq_Value,I2C4Freq_Value,LPTIM1Freq_Value,LPTIM2Freq_Value,LPTIM345Freq_Value,LPUART1Freq_Value,LTDCFreq_Value,MCO1PinFreq_Value,MCO2PinFreq_Value,PLL2FRACN,PLL3FRACN,PLLFRACN,PLLSourceVirtual,PWR_Regulator_Voltage_Scale,QSPIFreq_Value,RNGFreq_Value,RTCFreq_Value,SAI1Freq_Value,SAI23Freq_Value,SAI4AFreq_Value,SAI4BFreq_Value,SDMMCFreq_Value,SPDIFRXFreq_Value,SPI123Freq_Value,SPI45Freq_Value,SPI6Freq_Value,SWPMI1Freq_Value,SYSCLKFreq_VALUE,SYSCLKSource,SupplySource,Tim1OutputFreq_Value,Tim2OutputFreq_Value,TraceFreq_Value,USART16Freq_Value,USART234578Freq_Value,USBFreq_Value,VCO1OutputFreq_Value,VCO2OutputFreq_Value,VCO3OutputFreq_Value,VCOInput1Freq_Value,VCOInput2Freq_Value,VCOInput3Freq_Value
RCC.LPTIM1Freq_Value=120000000
RCC.LPTIM2Freq_Value=120000000
RCC.LPTIM345Freq_Value=120000000
RCC.LPUART1Freq_Value=120000000
RCC.LTDCFreq_Value=16125000
RCC.MCO1PinFreq_Value=64000000
RCC.MCO2PinFreq_Value=480000000
RCC.PLL2FRACN=0
RCC.PLL3FRACN=0
RCC.PLLFRACN=0
RCC.PLLSourceVirtual=RCC_PLLSOURCE_HSE
RCC.PWR_Regulator_Voltage_Scale=PWR_REGULATOR_VOLTAGE_SCALE0
RCC.QSPIFreq_Value=240000000
RCC.RNGFreq_Value=48000000
RCC.RTCFreq_Value=32000
RCC.SAI1Freq_Value=480000000
RCC.SAI23Freq_Value=480000000
RCC.SAI4AFreq_Value=480000000
RCC.SAI4BFreq_Value=480000000
RCC.SDMMCFreq_Value=480000000
RCC.SPDIFRXFreq_Value=480000000
RCC.SPI123Freq_Value=480000000
RCC.SPI45Freq_Value=120000000
RCC.SPI6Freq_Value=120000000
RCC.SWPMI1Freq_Value=120000000
RCC.SYSCLKFreq_VALUE=480000000
RCC.SYSCLKSource=RCC_SYSCLKSOURCE_PLLCLK
RCC.SupplySource=PWR_DIRECT_SMPS_SUPPLY
RCC.Tim1OutputFreq_Value=240000000
RCC.Tim2OutputFreq_Value=240000000
RCC.TraceFreq_Value=64000000
RCC.USART16Freq_Value=120000000
RCC.USART234578Freq_Value=120000000
RCC.USBFreq_Value=480000000
RCC.VCO1OutputFreq_Value=960000000
RCC.VCO2OutputFreq_Value=240000000
RCC.VCO3OutputFreq_Value=32250000
RCC.VCOInput1Freq_Value=4000000
RCC.VCOInput2Freq_Value=1333333.3333333333
RCC.VCOInput3Freq_Value=250000
