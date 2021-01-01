<#import "../../../../../../utils.ftl" as utils>
<#import "../../../../../../fp.ftl" as fp>

<#import "../../../../../../MC_task/utils/meta_parameters.ftl" as meta>
<#import "../../../../../../MC_task/utils/pins_mng.ftl"  as ns_pin>
<#import "../../../../../../MC_task/utils/ips_mng.ftl"   as ns_ip>

<#import "../../com/G4_pwm_timer.ftl" as cmns>

<#function cs_PWM_TIMER_patameters timer motor>
    <#local motor_n = (motor == 2)?then ("2","")>
<#--    <#return cmns.cs_PWM_TIMER_patameters(timer, 4..6, motor) +-->
    <#return cmns.cs_PWM_TIMER_patameters(timer, [4], motor) +
        { "CounterMode"              : "TIM_COUNTERMODE_UP"
        , "TIM_MasterOutputTrigger"  : "TIM_TRGO_OC4REF"
        , "TIM_MasterOutputTrigger2" : "TIM_TRGO2_RESET"
        <#--, meta.no_chk("PulseNoDither_4"                       ) : "(((PWM_PERIOD_CYCLES${motor_n}) / 2) - (HTMIN${motor_n}))"-->
        }>

<#--
    <#list 4..6 as idx>
        <#local mode      = "PWM Generation${idx} No Output" >
        <#local vs_signal = "${timer.name}_VS_no_output${idx}" >
        <#local vp_pin    = ns_pin.collectPin("VP_${vs_signal}") >

        <#local parameters = parameters +
            { "Channel-PWM\\ Generation${idx}\\ No\\ Output" : "TIM_CHANNEL_${idx}" }
            + meta.text( "${vp_pin}.Mode=${mode}" )
            + meta.text( "${vp_pin}.Signal=${vs_signal}")
            >
    </#list>
-->
</#function>

