<#import "../../fp.ftl" as fp >
<#import "../../utils.ftl" as utils >
<#import "../../MC_task/utils/meta_parameters.ftl" as meta >
<#import "../../../ioc_seed/hw_info.ftl" as hw >

<#function Temp_Bus_sense_adc_parameters sensors>
    <#if !sensors?has_content >
        <#return {} >
    </#if>

    <#local _size= 1 > <#--Sostituisce sensors?size perche' fanno una sola conversione regolare-->
    <#local scanModeEnable  = (ScanConvMode_V.ENABLE )!"ADC_SCAN_ENABLE"  >
    <#local scanModeDisable = (ScanConvMode_V.DISABLE)!"ADC_SCAN_DISABLE" >

    <#--<#local scanMode = (sensors?size lt 2)?then(scanModeDisable, scanModeEnable)>-->
    <#local scanMode = (_size lt 2)?then(scanModeDisable, scanModeEnable)>

    <#local timer = utils.v("PWM_TIMER_SELECTION", motor) >
    <#local tmr_idx = utils._last_char( timer ) >
    <#local ExternalTrigConv = "ADC_EXTERNALTRIG_T${tmr_idx}_TRGO" >
        <#-- I look at no more than 4 items -->
        <#--<#local sensors = sensors[0..*4] >-->

        <#local parameters =
        { "EnableRegularConversion" : "ENABLE"
        , meta.blankLn_key()        : ""

        , "ExternalTrigConv"        :  ExternalTrigConv
        , "ExternalTrigConvEdge"    : "ADC_EXTERNALTRIGCONVEDGE_FALLING"
        , meta.blankLn_key()        : ""

        <#--, "ScanConvMode"            : (sensors?size lt 2)?then("ADC_SCAN_DISABLE", "ADC_SCAN_ENABLE")-->
        , "ScanConvMode"            : scanMode
       <#-- , "NbrOfConversionFlag"     : (sensors?size gt 0)?then("1", "0")
        , "NbrOfConversion"         : sensors?size-->

        , "NbrOfConversionFlag"     : (_size gt 0)?then("1", "0")
        , "NbrOfConversion"         : _size
        }>



        <#local sensor = sensors[0]>
        <#local idx = 1  >

        <#local sampl_suffix = (sensor.sampling_time > 1)?then("CYCLES", "CYCLE") >
        <#if sensor.sampling_cycles gt 0 >
            <#local sampl_suffix = "${sampl_suffix}_${sensor.sampling_cycles}" >
        </#if>


        <#local parameters = parameters +
        { "Rank-${        idx}\\#ChannelRegularConversion" : "1"
        , "Channel-${     idx}\\#ChannelRegularConversion" : sensor.channel?upper_case
        , "SamplingTime-${idx}\\#ChannelRegularConversion" : "ADC_SAMPLETIME_${sensor.sampling_time}${sampl_suffix}"
        , "OffsetNumber-${idx}\\#ChannelRegularConversion" : "ADC_OFFSET_NONE"
        , "Offset-${      idx}\\#ChannelRegularConversion" : 0
        } >



      <#--  <#local addComments = sensors?size gt 1>
        <#list sensors as sensor>
            <#local idx = 1 + sensor?index >

            <#if addComments >
                <#local parameters = parameters + meta.comment( sensor.label ) >
            </#if>

            <#local sampl_suffix = (sensor.sampling_time > 1)?then("CYCLES", "CYCLE") >
            <#if sensor.sampling_cycles gt 0 >
                <#local sampl_suffix = "${sampl_suffix}_${sensor.sampling_cycles}" >
            </#if>


            <#local parameters = parameters +
            { "Rank-${        idx}\\#ChannelRegularConversion" : sensor?index + 1
            , "Channel-${     idx}\\#ChannelRegularConversion" : sensor.channel?upper_case
            , "SamplingTime-${idx}\\#ChannelRegularConversion" : "ADC_SAMPLETIME_${sensor.sampling_time}${sampl_suffix}"
            , "OffsetNumber-${idx}\\#ChannelRegularConversion" : "ADC_OFFSET_NONE"
            , "Offset-${      idx}\\#ChannelRegularConversion" : 0
            } >

        </#list>-->

        <#return parameters >
   </#function>
