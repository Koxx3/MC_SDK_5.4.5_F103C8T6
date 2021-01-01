<#import "../utils.ftl" as utils>
<#import "../ui.ftl" as ui >
<#import "../../ioc_seed/hw_info.ftl" as hw>
<#import "../Cortex/cortex_utils.ftl" as cr>

<#global WB_DRIVE_TYPE = WB_DRIVE_TYPE!"FOC">

<#if (hw.cpu.family == "H7")>
    <#if cr.use_Cortex()>
        <#global WB_CORTEX_TYPE = "Cortex${ utils._last_word(WB_CORTEX_TYPE) }">
    <#else>
        <@ui.messageBox "CORTEX_TYPE data model not found" "Setted by default to CortexM4" />
        <#global WB_CORTEX_TYPE = "CortexM4">
    </#if>
</#if>

<#global PHASE_CURRENTS_READING = PHASE_CURRENTS_READING!false>
<#global EN_DRIVER_AVAILABLE = EN_DRIVER_AVAILABLE!false>
<#global DEBUG_COMM = DEBUG_COMM!false>
<#global DEBUG_ZC   = DEBUG_ZC!false>

<#--<#if ! OCP_SELECTION?? >-->
<#--    <#stop "Missing OCP_SELECTION definition from wb_def file: it must be part of the datamodel">-->
<#--</#if>-->

<#--<#global OCP_SELECTION = OCP_SELECTION!"COMP_Selection_COMP1">-->
<#-- in 1Sh these keys are really not necessary but some part of the code still try to use them -->

<#global OCP_SELECTION  = OCP_SELECTION!"COMP_Selection_COMP1">
<#global OCPA_SELECTION = OCPA_SELECTION!OCP_SELECTION>
<#global OCPB_SELECTION = OCPB_SELECTION!OCP_SELECTION>
<#global OCPC_SELECTION = OCPC_SELECTION!OCP_SELECTION>
