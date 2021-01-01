<#import "../../ui.ftl"      as ui   >

<#import "../../MC_task/utils/pins_mng.ftl" as ns_pin>

<#function bemf_divider_settings>
    <#if SPEED_SENSOR_SELECTION == "SENSORLESS_ADC" >
        <#return bemf_divider_gpio()>
    <#else>
        <#return ui._comment("Disabled because the Speed sensor selection is ${SPEED_SENSOR_SELECTION}" ) >
    </#if>
</#function>

<#function bemf_divider_gpio>
    <#local pin = ns_pin.name_("BEMF_DIVIDER") >
    <#return
    [ "${pin}.GPIOParameters=PinState,GPIO_PuPd,GPIO_Label"
    , "${pin}.GPIO_Label=M1_BEMF_DIVIDER"
    , "${pin}.GPIO_PuPd=GPIO_PULLDOWN"
    , "${pin}.Locked=true"
    , "${pin}.PinState=GPIO_PIN_SET"
    , "${pin}.Signal=GPIO_Output"
    ]>
</#function>


<#function en_divider_settings>
    <#if EN_DRIVER_AVAILABLE >
        <#return en_divider_gpio() >
    <#else>
        <#return ui._comment("Disabled from WB") >
    </#if>
</#function>

<#function en_divider_gpio>
    <#local pin = ns_pin.name_("EN_DRIVER") >
    <#return
    [ "${pin}.GPIOParameters=PinState,GPIO_PuPd,GPIO_Label"
    , "${pin}.GPIO_Label=M1_EN_DRIVER"
    , "${pin}.GPIO_PuPd=GPIO_PULLDOWN"
    , "${pin}.Locked=true"
    , "${pin}.PinState=GPIO_PIN_SET"
    , "${pin}.Signal=GPIO_Output"
    ]>
</#function>


<#function debug_comm_settings>
    <#if DEBUG_COMM >
        <#return debug_comm_gpio() >
    <#else>
        <#return ui._comment("Disabled from WB") >
    </#if>
</#function>

<#function debug_comm_gpio>
    <#local pin = ns_pin.name_("COMM") >
    <#return
    [ "${pin}.GPIOParameters=GPIO_PuPd,GPIO_Label"
    , "${pin}.GPIO_Label=M1_GPIO_COMM"
    , "${pin}.GPIO_PuPd=GPIO_PULLDOWN"
    , "${pin}.Locked=true"
    , "${pin}.Signal=GPIO_Output"
    ]>
</#function>




<#function debug_zc_settings>
    <#if DEBUG_ZC >
        <#return debug_zc_gpio() >
    <#else>
        <#return ui._comment("Disabled from WB") >
    </#if>
</#function>

<#function debug_zc_gpio>
    <#local pin = ns_pin.name_("ZC") >
    <#return
    [ "${pin}.GPIOParameters=GPIO_PuPd,GPIO_Label"
    , "${pin}.GPIO_Label=M1_GPIO_ZCR"
    , "${pin}.GPIO_PuPd=GPIO_PULLDOWN"
    , "${pin}.Locked=true"
    , "${pin}.Signal=GPIO_Output"
    ]>
</#function>

