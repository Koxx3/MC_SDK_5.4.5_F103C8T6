<#import "../../../ui.ftl" as ui >

<#macro ICS__H7XX_PWMCurrFdbk motor device sense>
    <#local topComment>ICS__H7XX_PWMCurrFdbk: motor=${motor} device=${device} sense=${sense}</#local>#
    <@ui.box topComment />
    <#import "H7/ICS/ICS_H7_all_settings.ftl" as ics>
    <@ics.ICS_H7_all_settings motor device sense />
</#macro>

<#macro R1___H7XX_PWMCurrFdbk motor device sense>
    <#local topComment>R1___H7XX_PWMCurrFdbk M${motor} ${device} ${sense}</#local>
    <@ui.comment topComment />
    <#if motor == 2  >
        <@ui.box "The STM32H7xx device doesn't support DUALDRIVE mode" '' '.' />
        <#return>
    </#if>
    <#import "H7/R1_x/R1_x_H7_all_settings.ftl" as all>
    <@all.R1_x_H7_all_settings motor device sense />
</#macro>

<#macro R3_1_H7XX_PWMCurrFdbk motor device sense>
    <#local topComment>R3_1_H7XX_PWMCurrFdbk: motor=${motor} device=${device} sense=${sense}</#local>
    <@ui.comment topComment />
    <#if motor == 2 >
        <@ui.box "The STM32H7xx device doesn't support DUALDRIVE mode" '' '.' />
        <#return>
    </#if>
    <#import "H7/R3_1/R3_1_H7_all_settings.ftl" as R3_1_H7>
    <@R3_1_H7.R3_1_H7_all_settings motor device sense />
</#macro>



<#macro R3_4_H7XX_PWMCurrFdbk motor device sense>
    <#import "H7/R3_4/R3_4_H7_all_settings.ftl" as ns>
    <@ns.R3_4_H7_all_settings motor device sense />
</#macro>
