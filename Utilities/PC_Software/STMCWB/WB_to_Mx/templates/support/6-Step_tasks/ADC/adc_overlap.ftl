<#import "../../shared_ip/ip_overlap.ftl" as ip_ov>

<#function update_ADCs_IPParameters adc_parameters>
<#-- adc_parameters must have the following structure:
{ "title"          : title
, "ip"             : the used IP, like ADC1
, "parameters"     : parameters
, "str_parameters" : string representation of the parameters
, "IPParameters"   : keys of parameters without IPParameters and meta Items (comments | text | blank)
}

It can pe produced with the function IP_settings(title, ip, parameters)
-->


    <#if ! adc_cmns_mng_added?? >
        <#global adc_cmns_mng_added = true>
        <#local mngrs = ip_ov.add_ip_cmns_mng( adc_cmns_mng ) >
    </#if>

    <#return ip_ov.update_IP_parameters( adc_parameters )>
</#function>


<#import "../../../ioc_seed/hw_info.ftl" as hw >
<#function adc_cmns_mng ip>
    <#if ip?starts_with("ADC") >
        <#switch hw.cpu.family>
            <#case "F0">
                <#import "../DriveMode/fragments/F0/com/F0_ADC_cmns_if_used.ftl" as adc_cmns >
                <#return adc_cmns.ADC_common_parameters() >
                <#break >
            <#case "G4">
                <#import "../DriveMode/fragments/Fx_commons/ADC_commons_if_used.ftl" as adc_cmns >
                <#return adc_cmns.ADC_common_parameters(ip) >
                <#break >

        </#switch>
    </#if>

    <#return {}>
</#function>
