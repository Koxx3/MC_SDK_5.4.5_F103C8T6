<#import "../ui.ftl" as ui>
<#import "../fp.ftl" as fp>

<#function driverFunctionName ip >
    <#if ip == "RCC">
        <#return "SystemClock_Config">
    <#elseif ip?starts_with("USART") || ip?starts_with("UART")>
        <#return "MX_${ip}_UART_Init">
    <#else>
        <#return "MX_${ip}_Init">
    </#if>
</#function>
<#function driverVisibility ip >
    <#return (ip != "RCC")?c >
</#function>

<#function mc_used_ips ip >
    <#return ! ["NVIC1", "NVIC2", "NVIC"
               , "SYS_M4", "SYS"
               , "FREERTOS", "FREERTOS_M4", "FREERTOS_M7"
               , "FATFS", "FATFS_M4", "FATFS_M7"           <#-- do not support Driver -->
               , "MotorControl", "RCC", "DMA" <#-- their rank have to be modified -->
               ]?seq_contains(ip) >
</#function>

<#function supportDriverLL ip >
    <#return ! ["MotorControl"]?seq_contains(ip) >
</#function>
<#function driver ip>
    <#return supportDriverLL(ip)?then(TARGET_DRIVER!"HAL", "HAL") >
</#function>

<#function item_for_Cortex_M4 ip  >
    <#return (ip != "CORTEX_M7" && ip != "RCC") >
</#function>
<#function item_for_Cortex_M7 ip  >
    <#return (ip != "CORTEX_M4") >
</#function>

<#function to_driver_item rank ip cortex=[]>
    <#--<#return "${driverFunctionName(ip) }-${ip}-false-${driver(ip)}-true(-cortex_M4|_M7)?" >-->
    <#return
    ([ rank
        , driverFunctionName(ip)
        , ip
        , "false"
        , driver(ip)
        , driverVisibility(ip)
        ] + cortex)?join("-") >
</#function>

<#function _apply_selected_driver used_IPs>
    <#local ips = (used_IPs?seq_contains("DMA"))?then([ "GPIO", "RCC", "DMA" ] , ["GPIO", "RCC"])
    + fp.filter(mc_used_ips, used_IPs?sort)
    + ["MotorControl"] >

    <#local items = [] >
    <#import "../Cortex/cortex_utils.ftl"  as cr>

    <#if cr.use_Cortex()>
        <#local m4 =(WB_CORTEX_TYPE=="CortexM4")?then(fp.filter(item_for_Cortex_M4, ips), ["CORTEX_M4"] )>
        <#local m7 = (WB_CORTEX_TYPE=="CortexM7")?then(fp.filter(item_for_Cortex_M7, ips), ["RCC", "CORTEX_M7"] )>

        <#local fls_ips = [{"core":["CortexM4"], "ip_items":m4} , {"core":["CortexM7"], "ip_items": m7} ]>
    <#else>
        <#local fls_ips = [{"core":[], "ip_items":ips}]>
    </#if>

    <#list fls_ips as item>
        <#list item.ip_items as ip>
            <#local rank = (ip?index + 1)?c >
            <#local items += [ to_driver_item(rank, ip, item.core) ] >
        </#list>
    </#list>

    <#local target_driver = TARGET_DRIVER!"HAL">
    <#local draw = (target_driver == "HAL")?then(ui.comment, ui.line) >
    <#return
        { "draw" : draw
        , "body" : [ "ProjectManager.functionlistsort=\\" ] + items?join(",\\\n")?split("\n")
        , "target_driver" : target_driver
        }>
</#function>

<#macro apply_selected_driver used_IPs>
    <#local drv = _apply_selected_driver(used_IPs) >
    <@ui.boxed "DRIVER management - ${drv.target_driver}">
        <@drv.draw drv.body />
    </@ui.boxed>
</#macro>
