<#import  "../../../ui.ftl" as ui >
<#--

-->
<#function dev_family_oCurrSensor >
<#-- support only SINGLEDRIVE -->
    <#if     STM32F0XX?? ><#return "STM32F0XX"             > <#-- exp -->
    <#elseif STM32G431RB??      ><#return "STM32G431RB"                  >
    <#else                      ><#return "NONE"                         >
    </#if>
</#function>


<#function supportedCurrSenseMacros devClass drive motor >

    <#local shortDev =
    { "STM32F0XX"        : "F0"
    , "STM32G431RB"      : "G4"
    } />

    <#local supportDual =
    { "STM32F0XX"  : false
    , "STM32G431RB": false
    } />

    <#local modes = ["CM", "VM"] >

    <#local devMap = {
    "STM32F0XX"  : modes,
    "STM32G431RB": modes,
    "NONE"       : []
    } />

    <#if devMap?keys?seq_contains(devClass) >
        <#local supporteDrive = devMap[devClass] >
        <#if supporteDrive?seq_contains( drive ) && (motor!=2 || supportDual[devClass] )>
            <#local d_prefix = shortDev[devClass]?right_pad(4, 'X')>
            <#local macroName>${drive}_${d_prefix}_PWMCurrFdbk</#local>
            <#return { "macroName" : macroName }>
        </#if>
    </#if>

<#-- as fallback calls a dummy doNothing macro so the caller can avoid extra check -->
    <#return {"macroName" : "oCurrSensor_doNothing"}>
</#function>

<#macro oCurrSensor_doNothing m d s>
    <@ui.comment
        [ "MOTOR:  ${m}"
        , "DEVICE: ${d}"
        , "SENSE:  ${s}"
        ]?join("\n") />
</#macro>



<#--


&lt;#&ndash;
    TTTTTT  EEEEEE  SSSSSS  TTTTTT
      TT    EE      SS        TT
      TT    EEEE    SSSSSS    TT
      TT    EE          SS    TT
      TT    EEEEEE  SSSSSS    TT
&ndash;&gt;
<#macro test_callAll >
    <#local devices =
    [ "STM32F0XX"
    , "STM32F2XX"
    , "STM32F302X8"
    , "STM32F30X"
    , "STM32F4XX"
    , "STM32F401XX"
    , "STM32HD"
    , "STM32PERFORMANCE"
    , "STM32VALUE"
    , "STM32L452XX"
    , "STM32F769XX"
    , "STM32F746XX"
    , "STM32G071XX"
    , "STM32G081XX"
    , "STM32G431RB"
    , "STM32G431CB"
    , "STM32G474QE"
    , "NONE" ] >

    <#local senses =
    [ "ICS_SENSORS"
    , "SINGLE_SHUNT"
    , "THREE_SHUNT"
    , "THREE_SHUNT_SHARED_RESOURCES"
    , "THREE_SHUNT_INDEPENDENT_RESOURCES" ]>

    <#list [1, 2] as m>
        <#list devices as d>
            <#list senses as s>
                <@callCurrSensorMacro supportedCurrSenseMacros(d,s,m).macroName m d s />
            </#list>
        </#list>
    </#list>
</#macro>
<#macro callCurrSensorMacro macroName motor device sense >
&lt;#&ndash;
    <#if .vars[macroName]?? && .vars[macroName]?is_macro >
        <@.vars[macroName] motor device sense />
&ndash;&gt;
    <#if (macroName?eval)?? && macroName?eval?is_macro >
        <@macroName?eval motor device sense />
    <#else>
        <@ui.box "ERROR: unable to find the definition for macro \"${ macroName }\""        '' '' false />
        <@ui.box "       to be called with: motor=${motor} device=${device} sense=${sense}" '' '' false />
    </#if>
</#macro>
-->
