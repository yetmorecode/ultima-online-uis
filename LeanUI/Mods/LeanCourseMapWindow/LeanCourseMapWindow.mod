<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="LeanCourseMapWindow" version="1.0" date="04/18/2018">
        <Description text="CourseMapWindow with zoom support for treassure maps" />
     
        <Files>
            <File name="LeanCourseMapWindow.lua" />
        </Files>
        
        <OnInitialize>
            <CallFunction name="LeanCourseMapWindow.Hook" />
        </OnInitialize> 
        <OnShutdown>
            <CallFunction name="LeanCourseMapWindow.Unhook" />
        </OnShutdown>
    </UiMod>
</ModuleFile>
