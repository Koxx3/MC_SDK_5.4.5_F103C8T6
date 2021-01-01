<#import "../conditional_task.ftl" as task >

<#macro SixStep_tasks config>
    <@task.task "CURRENT SENSING" config.currentSense!false >
        <#include "DriveMode/oCurrSensor.ftl">
        <@oCurrSensor />
    </@task.task>

  <#--################################################################################################################
     #  COMPLETE: HALL is complete                                                                                     #
     #            ENCODER is complete                                                                                  #
     ################################################################################################################-->
    <@task.task "SPEED SENSING" config.speedSense!false >
        <#include "../MC_task/oSpeedSensor/oSpeedSensor.ftl">
        <@oSpeedSensor />
    </@task.task>

    <#--################################################################################################################
     #  COMPLETE: Temperature, VBUS, CURRENTS and  BEMF_U_V_W settings                                                 #
     ################################################################################################################-->
    <@task.task "BUS , TEMPERATURE , CURRENTS SENSING and BEMF" config.tempAndBusSense!false >
        <#include "oTemp_Bus_Sense_and_Bemf/oTemp_Bus_CurntSense_and_Bemf.ftl" >
        <@oTemp_Bus_CurntSense_and_Bemf />
    </@task.task>

    <#--################################################################################################################
     #  COMPLETE: GPIOs - BEMF_DIVIDER - EN_DRIVER - DEBUG_COMM - DEBUG_ZC - settings                                                 #
     ################################################################################################################-->
    <@task.task  "GPIOs - BEMF_DIVIDER - EN_DRIVER - DEBUG_COMM - DEBUG_ZC - settings" config.GPIOsSixStep!false >
        <#include "GPIO/bemf_divider_ en_driver_ debug_comm_debug_zc.ftl">
        <#import "../ui.ftl"      as ui   >

        <@ui.boxed "BEMF_DIVIDER">
            <@ui.line bemf_divider_settings() />
        </@ui.boxed>

        <@ui.boxed "EN_DRIVER">
            <@ui.line en_divider_settings() />
        </@ui.boxed>

        <@ui.boxed "DEBUG_COMM">
            <@ui.line debug_comm_settings() />
        </@ui.boxed>

        <@ui.boxed "DEBUG_ZC">
            <@ui.line debug_zc_settings() />
        </@ui.boxed>
    </@task.task>

    <#--################################################################################################################
     #  NONE: GATE DRIVING                                                                                             #
     ################################################################################################################-->
    <@task.task "GATE DRIVING" config.gateDriver!false >
        <#include "../MC_task/oGateDriver/oGateDriver.ftl" >
        <@oGateDriver />
    </@task.task>


    <#-- Consolidate the ADCs settings for the ones used in Current, Temperature and VBus sensing -->
    <#import "../shared_ip/ip_overlap.ftl" as ip_ov>
    <#import "../MC_task/oCurrSensor/extra_settings.ftl" as adc_extra >
    <#local dummy = adc_extra.manage_extras(ip_ov) >
<#--
    <@ui.comment "Consolidated IPs" />
    <@ip_ov.consolidated_IPs_settings />
-->

    <#--################################################################################################################
     #  COMPLETE: Digital Output                                                                                       #
     ################################################################################################################-->
    <@task.task "DIGITAL I/O" config.digitalIO!false >
        <#import "../MC_task/digital_output/utils.ftl"                       as io  >
        <#import "../MC_task/digital_output/oOCPDisabling/oOCPDisabling.ftl" as ocp >
        <#import "../MC_task/digital_output/oR_Brake/oR_Brake.ftl"           as dbo >
        <#import "../MC_task/digital_output/oICL/oICL.ftl"                   as icl >

        <@ui.box "DIGITAL OUTPUTs" "#" '#' />
        <@ui.hline ' '/>
        <#list
        [ { "title": "OVER CURRENT PROTECTION", "io_description": ocp.io_description}
        , { "title": "DISSIPATIVE BRAKE"      , "io_description": dbo.io_description}
        , { "title": "INRUSH CURRRENT LIMIT"  , "io_description": icl.io_description}
        ] as io_section>
            <@io.block io_section.title fp.map(io_section.io_description, 1..WB_NUM_MOTORS) '=' '~'/>
            <#sep>
                <@ui.hline ' '/>
            </#sep>
        </#list>
    </@task.task>
</#macro>

