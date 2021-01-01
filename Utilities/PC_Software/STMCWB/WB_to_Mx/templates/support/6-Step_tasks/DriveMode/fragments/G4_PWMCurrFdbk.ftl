<#import "../../../ui.ftl" as ui >

<#macro VM_G4XX_PWMCurrFdbk motor device driveMode>
    <#local topComment>VM_G4XX_PWMCurrFdbk: motor=${motor} device=${device} driveMode=${driveMode}</#local>
    <@ui.comment topComment />
    <#if motor == 1 >
        <#import "G4/VM/R1_x/R1_x_G4_all_settings.ftl" as G4>
        <@G4.R1_x_G4_all_settings motor device driveMode />
    <#else>
        <@ui.box "The STM32G4-SIX_STEP devices doesn't support DUALDRIVE mode" '' '.' />
    </#if>
</#macro>


