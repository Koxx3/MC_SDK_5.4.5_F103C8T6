<#function use_Cortex >
    <#return WB_CORTEX_TYPE?has_content?then(true, false) >
</#function>



<#function cortexPinAttribute pin_def>
    <#if use_Cortex()>
        <#local gpio_cortex_Label = ",PinAttribute">
        <#local gpio_cortex_PinAttribute ="${pin_def}.PinAttribute=${WB_CORTEX_TYPE}">
        <#local gpio_cortex_ContextOwner ="${pin_def}.ContextOwner=${WB_CORTEX_TYPE}">
    <#else>
        <#local gpio_cortex_Label = "">
        <#local gpio_cortex_PinAttribute ="">
        <#local gpio_cortex_ContextOwner ="">
    </#if>
    <#return { "cortexLabel" : gpio_cortex_Label
             , "cortexPinAttribute" : gpio_cortex_PinAttribute
             , "cortexContextOwner" : gpio_cortex_ContextOwner  }>
</#function>
