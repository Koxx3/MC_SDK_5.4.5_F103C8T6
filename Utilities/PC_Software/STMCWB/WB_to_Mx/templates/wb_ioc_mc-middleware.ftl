<#setting locale="en_US">
<#setting number_format="computer">
<#setting boolean_format="true,false" >
<#import "support/ui.ftl" as ui >
<#import "header.ftl" as hh>
<#import "support/fp.ftl" as fp >
<#assign file_name = .current_template_name>
<@hh.header file_name>
    This file Update an existing IOC file with the Motor Control Parameters provided by Workbench.
</@hh.header>
<#-- -->

<@ui.boxed "CubeMX versions" '~'>
    <#include "ioc_seed/extras/cubemx_version.ftl">
</@ui.boxed>

<#import "ioc_seed/extras/project_settings.ftl" as prj_mng>
<@ui.boxed "Project settings" '~'>
    <@prj_mng._project_settings />
</@ui.boxed>

<#-- HAL or LL DRIVERS -->
<#function is_Mcu_IP key >
    <#return key?starts_with("Mcu.IP") && key != "Mcu.IPNb">
</#function>
<#function param_value parameters, key >
    <#return parameters[key]>
</#function>
<#function get_used_IPs parameters >
    <#local ks = fp.filter(is_Mcu_IP, parameters?keys) >
    <#return fp.map_ctx(parameters, param_value, ks)>
</#function>
<#--<#import "support/hal_ll_drivers/driver_mng.ftl" as ns_dr>
<@ns_dr.apply_selected_driver get_used_IPs(ioc_parameters!{}) />-->


<#-- MotorControl Middleware parameters -->
<#import "support/conditional_task.ftl" as task >
<@task.task "FORWARDs the WB generated #defines to MX" true >
  <#--  <#include "support/data_model/forward_defines_to_mx.ftl" >-->
    <#import "support/data_model/forward_defines_to_mx.ftl" as mc_middleware >
   <@ui.boxed "ExtraMW_MotorControl & VP_MotorControl generated defines">
        <@mc_middleware.motorControl_IP_settings/>
    </@ui.boxed>
    <@ui.boxed "ST Workbench generated defines">
        <@mc_middleware.export_ExtraMW true />
    </@ui.boxed>
</@task.task>

<@task.task "ORIGINAL ioc Parameters" ioc_parameters?? "ioc parameters NOT PROVIDED">
    <@ui.boxed "ORIGINAL ioc Parameters">
        <@listProperties  ioc_parameters />
    </@ui.boxed>
</@task.task>

<#function accept_key key>
    <#return ! (key?starts_with("ProjectManager.") && !key?starts_with("ProjectManager.functionlistsort"))
          && ! [ "File.Version"
               , "MxCube.Version"
               , "MxDb.Version"
               ]?seq_contains(key)
          >
</#function>

<#macro listProperties xs>
    <#local needToGenerateDriver = false />
    <#local sortedKeys = xs?keys?sort />
    <#list sortedKeys as key>
        <#if accept_key(key)>
            <#if !(key?starts_with("ProjectManager.functionlistsort") && xs[key] == "")>
                <@ui.line "${key}=${ xs[key] }" />
            <#else>
                <#local needToGenerateDriver = true />
            </#if>
        </#if>
    </#list>
    <#if needToGenerateDriver!false>
        <@ui.boxed "Empty ProjectManager.functionlistsort need to generate HAL or LL drivers">
        <#import "support/hal_ll_drivers/driver_mng.ftl" as ns_dr>
        <@ns_dr.apply_selected_driver get_used_IPs(xs!{}) />
        </@ui.boxed>
    </#if>
</#macro>

