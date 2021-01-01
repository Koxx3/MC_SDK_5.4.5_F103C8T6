<#--

  +-------------+-------------------------------+---------+-------------+--------+-------------------------------------------+
  | wb define   | wb_combo_label                | Packege | MX Part No  | Family | ioc seed file                             |
  +-------------+-------------------------------+---------+-------------+--------+-------------------------------------------+
  |             |                               | LQFP144 | STM32H745ZI |   H7   | STM32H745ZI - ${clk_MHz} MHz              |
  | STM32H745XX | STM32H745XX                   |---------+-------------+--------+-------------------------------------------+
  |             |                               |         |             |        |                                           |
  +-------------+-------------------------------+---------+-------------+--------+-------------------------------------------+
 -->


<#import "../../../support/utils.ftl" as utils>
<#import "../../../support/ui.ftl" as ui>

<#function h7_ioc_seed wb_mcu_define hw>
    <#local file_prefix = wb_mcu_define?switch(
    <#-- wb define        | file prefix   -->

    "STM32H745XX"     , "STM32H745ZI"
    "STM32H745ZI"     , "STM32H745ZI"

    <#-- otherwise -->  ""            )
    >
    <#local src =  hw.int_clk_src?then(" - int", "") >

    <#return file_prefix?has_content?then
        ( "${file_prefix}/${file_prefix} - ${hw.clk_MHz} MHz${ src }.ftl"
        , "../ERROR_unsupported_device.ftl"
        )>
</#function>

<#macro include_h7_seed_file wb_mcu_define hw>
    <#local file = h7_ioc_seed(wb_mcu_define, hw) >

    <@ui.comment
        [ "mcu: ${wb_mcu_define}"
        , "seed file: ${file}"
        , "clk: ${clk_MHz} MHz"
        ]?join("\n") />
    <@ui.hline "x" />

    <#global DAC1 = "DAC1" >
    <#include file >
    <#--<#include "../cmns/basic_ips_and_pins_int.ftl">-->
    <#--<#include "../F7/cmns/cortex_settings.ftl">-->
</#macro>
<@include_h7_seed_file cpu.PN hw/>
