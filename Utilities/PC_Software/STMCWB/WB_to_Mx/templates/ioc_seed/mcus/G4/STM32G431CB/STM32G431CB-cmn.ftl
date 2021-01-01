<#import "../../cmns/ioc_Mcu_PCC.ftl" as u >
<#include "../../../mcus/G4/cmns/JTMS_SWDIO-SWCLK_pins.ftl">


<#if  WB_DRIVE_TYPE!="SIX_STEP">
    <#include "../../../mcus/cmns/cordic.ftl">
</#if>

<#global DAC1 = "DAC1" >
<@u.ioc_Mcu_PCC
{ "Family"    : "STM32G4"
, "Package"   : "UFQFPN48"
, "Name"      : "STM32G431C(6-8-B)Ux"
, "UserName"  : "STM32G431CBUx"
, "Line"      : ""
} />
