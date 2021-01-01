<@ui.boxed "6-Step_Task"/>

<#import "support/6-Step_tasks/6-Step_task.ftl" as SixStep_tasks>
<@SixStep_tasks.SixStep_tasks config />

<#import "support/UI_tasks/UI_tasks.ftl" as ui_tasks>
<@ui_tasks.UI_tasks (config.ui)!{} />



