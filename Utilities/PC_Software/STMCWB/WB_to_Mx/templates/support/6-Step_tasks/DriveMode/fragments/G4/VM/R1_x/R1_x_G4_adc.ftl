<#import "../../../../../../utils.ftl" as utils>

<#import "../../../../../../MC_task/utils/ips_mng.ftl"  as ns_ip>
<#import "../../../../../../MC_task/utils/pins_mng.ftl" as ns_pin>

<#import "../../../../../../fp.ftl" as fp >
<#import "../../../../../../ui.ftl" as ui >
<#import "../../com/G4_adc.ftl"     as ap >

<#function cs_ADC_settings motor>
    <#local timer = utils.v("PWM_TIMER_SELECTION", motor) >

    <#local adc  = ns_ip.collectIP( utils.v("ADC_PERIPH", motor) )>
    <#local sectionTitle = "${adc} settings for Current Sensing" >


    <#local vps = {} >
    <#local virtualPin = "">
    <#if adc=="ADC1">
        <#local signal  =  "${adc}_Vref_Input">
        <#local mode    =  "IN-Vrefint"  >

        <#local vp = "VP_${signal}" >
        <#local vps = vps + { vp : [ "${vp}.Mode=${mode}", "${vp}.Signal=${signal}"]}>

        <#local registered_vps = fp.map(ns_pin.collectPin, vps?keys) >
        <#local virtualPin = "Virtual_pin${signal}_${mode}">
    </#if>


    <#return
    { "settings" :
    { sectionTitle : ui._comment("The ${adc} settings section was POSTPONED.\nIt will be part of a cumulative section dedicated to all ADCs")
    , "${adc} IRQ" : ap.cs_adc_irq(adc)
    , "${virtualPin}" : fp.flatten(vps?values)
    }
    , "GPIOs"    :  []
    }>
</#function>


