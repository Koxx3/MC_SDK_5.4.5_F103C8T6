<#include "STSPIN32/SPIN - base.ftl">
<#include "STSPIN32/SPIN - 48 int.ftl">


<#if WB_DRIVE_TYPE == "SIX_STEP" && WB_DRIVE_MODE == "CM">
    <#include "STSPIN32/SPIN F0 - 6STEP_CM- Pin12.ftl">
<#else>
    <#include "STSPIN32/SPIN F0A - Pin12.ftl">
</#if>




