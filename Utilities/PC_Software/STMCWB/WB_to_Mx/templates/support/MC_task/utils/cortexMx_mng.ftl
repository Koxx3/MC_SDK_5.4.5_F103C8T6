<#--<#if cr.use_Cortex()>-->
<#--    <#import "../../support/MC_task/utils/cortexMx_mng.ftl" as ns_cortex_ip>-->
<#--    <#local regIP_onCortex = "ns_cortex_ip.${WB_CORTEX_TYPE}">-->
<#--    <@regIP_onCortex?eval mwName "\\:I" />-->
<#--</#if>-->

<#macro collectCortexIP ip I="\\:I">
    <#local regIP_onCortex = "${WB_CORTEX_TYPE}">
    <@regIP_onCortex?eval ip I />
</#macro>


<#function collect_CortexM4_IP ip I="">
<#--####################################################################################################################
 #-- HERE THE SIDE EFFECT
 #-->
    <#--<#if ipDB()[ip]?? >-->
       <#-- <#global CortexM4_IPs = cortexM4_ipDB() + { ip: true } >-->
     <@CortexM4 ip I/>
    <#--</#if>-->
<#--#################################################################################################################-->

    <#return ip >
</#function>

<#function collect_CortexM7_IP ip I="">
<#--####################################################################################################################
 #-- HERE THE SIDE EFFECT
 #-->
    <#--<#if ipDB()[ip]?? >-->
      <#-- <#global CortexM7_IPs = cortexM7_ipDB() + { ip: true } >-->
    <@CortexM7 ip I/>
    <#--</#if>-->
<#--#################################################################################################################-->

    <#return ip >
</#function>


<#macro used_McuCortexMx_IPs>
    <#if cr.use_Cortex()>
        <#import "used_Mcu_xs.ftl" as used_ips >
        <@used_ips.used_Cortex_xs "CortexM4" cortexM4_ipDB()?keys />
        <@used_ips.used_Cortex_xs "CortexM7" cortexM7_ipDB()?keys />
    </#if>
</#macro>


<#macro CortexM7 ip I="">
    <#global CortexM7_IPs = cortexM7_ipDB() + { ip + I : true } >
</#macro>

<#macro CortexM4 ip I="">
    <#global CortexM4_IPs = cortexM4_ipDB() + { ip + I : true } >
</#macro>


<#function cortexM4_ipDB>
    <#return CortexM4_IPs!{} >
</#function>

<#function cortexM7_ipDB>
    <#return CortexM7_IPs!{} >
</#function>
