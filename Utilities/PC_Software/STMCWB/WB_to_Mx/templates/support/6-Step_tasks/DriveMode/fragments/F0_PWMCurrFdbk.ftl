<#import "../../../ui.ftl" as ui >

<#macro CM_F0XX_PWMCurrFdbk motor device driveMode>
    <#local topComment>CM_F0XX_PWMCurrFdbk: motor=${motor} device=${device} driveMode=${driveMode}</#local>
    <@ui.comment topComment />
    <#if motor == 2 >
        <@ui.box "The STM32F0 devices doesn't support DUALDRIVE mode" '' '.' />
        <#return>
    </#if>
    <#import "F0/CM/F0_CM_all_settings.ftl" as F0_CM>
    <@F0_CM.F0_CM_all_settings motor device driveMode />
</#macro>


