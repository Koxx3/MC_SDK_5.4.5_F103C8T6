<#import "../../../../../MC_task/utils/meta_parameters.ftl" as meta>
<#import "../../../../../utils.ftl" as utils>
<#import "../../../../ADC/ADC_cs_info.ftl" as info >
<#import "../../../../../MC_task/utils/ips_mng.ftl" as ns_ip>
<#import "../../../../../MC_task/utils/ips_mng.ftl"  as ns_pin>

<#import "../../Fx_commons/cs_cmn_create_adc_pin.ftl" as adc_pin>

<#-- this has to be managed with assign and not global! It has to remain within the namespace -->
<#assign cs_create_adc_pins = adc_pin.cs_create_adc_pins >


<#function cs_adc_irq ip >
    <#import "../../../../../names_map.ftl" as rr>
    <#import "../../../../../ui.ftl" as ui>

    <#local irqs = utils.mx_name("ADC_IRQs") >
    <#if irqs?is_hash && irqs[ip]?? >
       <#-- <#return ns_ip.ip_irq(irqs[ip], [true, 2, 0, true, false, false, true]) >-->
<#--        <#local set_irq_adc = rr["SET_IRQ_ADC"]!([true, 2, 0, true, false, false, true]) >-->
        <#local set_irq_adc = [true, 0, 1, true, false, false, true] >
        <#return ns_ip.ip_irq(irqs[ip], set_irq_adc) >
    <#else>
        <#return ui._comment("ERROR: unable to find ADC IRQ name for ${ip}, it should be defined within ParameterConversion file") >
    </#if>
</#function>





