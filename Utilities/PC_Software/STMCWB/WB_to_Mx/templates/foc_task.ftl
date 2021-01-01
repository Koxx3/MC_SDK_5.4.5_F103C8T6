

<#import "support/MC_task/MC_task.ftl" as mc_tasks>
<@mc_tasks.MC_tasks config />

<#import "support/UI_tasks/UI_tasks.ftl" as ui_tasks>
<@ui_tasks.UI_tasks (config.ui)!{} />

<#import "support/PFC_tasks/PFC_tasks.ftl" as pfc_tasks>
<@pfc_tasks.PFC_tasks (config.pfc)!{} />

<#import "support/FreeRTOS/FreeRTOS_tasks.ftl" as FreeRTOS>
<@FreeRTOS.FreeRTOS_tasks />

