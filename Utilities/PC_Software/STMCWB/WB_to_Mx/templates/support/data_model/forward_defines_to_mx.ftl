<#import "../MC_task/utils/pins_mng.ftl" as ns_pin>
<#import "../MC_task/utils/ips_mng.ftl" as ns_ip>
<#import "../ui.ftl" as ui>
<#import "../Cortex/cortex_utils.ftl" as cr>

<#macro motorControl_IP_settings>
    <#local prefix1="ExtraMW"/>
    <#local mwName = ns_ip.collectIP("MotorControl") />

    <#if cr.use_Cortex()>
        <#import "../../support/MC_task/utils/cortexMx_mng.ftl" as ns_cortex_ip>
        <@ns_cortex_ip.collectCortexIP mwName/>
    </#if>


    <#local signalName = "${mwName}_MC_ENABLED"/>
    <#local pinName= ns_pin.collectPin("VP_${signalName}") />

    <#local prefix2="${prefix1}.${mwName}"/>

    <#local theDataModel = updatedSet >

    <#local mode = "${prefix2}.Mode=${MCPack.mode}" >
    <#local root = "${prefix2}.Root=${MCPack.root}" >

<#-- DRIVE_TYPE is currently used to indicate which motor driving technique is
     used in the configuration. Possible values are: FOC or SIX_STEP. Both are implemented
     in different modes in the MotorControl_Modes.xml and MotorControl_Configs.xml files
     Here, we activate the right mode. -->
    <#if theDataModel["DRIVE_TYPE"]?? >
        <#if theDataModel["DRIVE_TYPE"] == "SIX_STEP">
            <#local modeName = "SixStep" />
        <#else>
            <#local modeName = "Enabled" />
        </#if>
    <#else>
        <#local modeName = "Enabled" />
    </#if>

    <@ui.line
    [ "${pinName}.Mode=${modeName}"
    , "${pinName}.Signal=${signalName}"
    , "${prefix1}=${mwName}"
    , "${prefix2}.Config=${mwName}"
    , "${prefix2}.Template=templates"
    ] + [mode, root] />
</#macro>


<#macro export_ExtraMW isUpdated>

    <#local mwName = "MotorControl" />
    <#local used_IPs=ns_ip.ipDB()?keys>

    <#local theDataModel = updatedSet + {'CUBE_MX_VER': (MxInfo.version)!"4.25.0" } + {'IPs':(used_IPs)?join(',')}>
    <#local wbKeys       = theDataModel?keys />
    <#local sortedWbKeys = wbKeys?sort     />


    <#list sortedWbKeys>
        <#-- Part executed once if we have more than 0 items -->
        <@ui.line "${mwName}.IPParameters=${sortedWbKeys?join(',')}" />
        <#--
        -->
        <#items as key>
            <#if key == "IPs" && isUpdated>
                <@ui.comment "${mwName}.${key}=${ _adapter(key, theDataModel[key]) }" />
            <#else>
                <#-- Part repeated for each item -->
                <@ui.line "${mwName}.${key}=${ _adapter(key, theDataModel[key]) }" />
            </#if>
        </#items>
        <#-- Part executed once if we have more than 0 items -->
        <@ui.comment "END of MotorControl parameters declaration" />
    <#else>
        <#-- Part executed when there are 0 items -->
        <@ui.comment "No MotorControl parameters found" />
    </#list>
</#macro>


<#-- STD Lib to LL Lib adapter -->
<#function _adapter key value>
    <#local translators = [safe_adc_clock_wb_div, ll_comp_opamp_selection, ll_gpio, ll_adc_channel] >
    <#list translators as translate>
        <#local str = translate(key, value) >
        <#if str?has_content >
            <#return str>
        </#if>
    </#list>
    <#-- if no one translator applied, return the original value -->
    <#return value>
</#function>

<#function safe_adc_clock_wb_div key value>
    <#return (key?starts_with("ADC_CLOCK_WB_DIV") && value == "0")?then("1","") >
</#function>


<#function ll_comp_opamp_selection key value>
    <#local res = value?matches("((?:COMP)|(?:OPAMP))_Selection_(((?:COMP)|(?:OPAMP))[0-9]+)") >
    <#return (res && res?groups[1] == res?groups[3])?then(res?groups[2], "") >
</#function>

<#function ll_gpio key value>
    <#return value?matches("GPIO_Pin_[0-9]+")?then("LL_${ value?upper_case}", "") >
</#function>

<#function ll_adc_channel key value>
    <#return value?matches("ADC_Channel_[0-9]+")?then(value?upper_case, "") >
</#function>
