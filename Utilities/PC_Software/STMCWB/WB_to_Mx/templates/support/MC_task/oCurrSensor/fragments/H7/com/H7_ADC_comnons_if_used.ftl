
<#function ADC_common_parameters>
    <#import "../../../../utils/meta_parameters.ftl" as meta >
    <#import "../../../../../utils.ftl" as utils >
    <#return
    { "ClockPrescaler"          : "${ utils.mx_name('ADC_CLOCK_SYNC_PCLK_DIV') }${ ADC_CLOCK_WB_DIV }"
    , "Resolution"              : "ADC_RESOLUTION_14B"
    , "ContinuousConvMode"      : "DISABLE"
    , "DiscontinuousConvMode"   : "DISABLE"
    , "ConversionDataManagement":"ADC_CONVERSIONDATA_DR"
    , "EOCSelection"            : "ADC_EOC_SINGLE_CONV"
    , "Overrun"                 : "ADC_OVR_DATA_PRESERVED"
    , "LowPowerAutoWait"        : "DISABLE"

    , "master"                : 1

    , meta.blankLn_key():""
    , "EnableAnalogWatchDog1"     : "false"
    , "EnableAnalogWatchDog2"     : "false"
    , "EnableAnalogWatchDog3"     : "false"
    }>
</#function>
