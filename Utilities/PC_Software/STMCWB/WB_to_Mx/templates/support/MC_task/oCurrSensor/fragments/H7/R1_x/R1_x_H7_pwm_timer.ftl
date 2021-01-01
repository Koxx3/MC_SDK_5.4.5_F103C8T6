<#import "../../../../../utils.ftl" as utils>
<#import "../../../../../fp.ftl" as fp>

<#import "../../../../utils/meta_parameters.ftl" as meta>
<#import "../../../../utils/pins_mng.ftl"  as ns_pin>
<#import "../../../../utils/ips_mng.ftl"   as ns_ip>

<#import "../com/H7_pwm_timer.ftl" as cmns>

<#function cs_PWM_TIMER_patameters timer motor >
    <#return cmns.cs_PWM_TIMER_patameters(timer, 4..6, motor) +
        { "CounterMode"              : "TIM_COUNTERMODE_CENTERALIGNED3"
        , "TIM_MasterOutputTrigger"  : "TIM_TRGO_RESET"
        , "TIM_MasterOutputTrigger2" : "TIM_TRGO2_OC5REF_RISING_OC6REF_RISING"
        }>
</#function>

