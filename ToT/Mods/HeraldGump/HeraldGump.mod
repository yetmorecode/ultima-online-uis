<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="HeraldGump" version="1.0" date="10/06/2013">

		<Author name="None" email="none" />
		<Description text="New Herald Gump" />
		 
		<Files>
			<File name="Loader.lua" />
			<File name="HeraldGumpLoader.lua" />
		</Files>
		
		<OnInitialize>
			<CallFunction name="HeraldGumpLoader.Initialize" />
		</OnInitialize>		
        
	</UiMod>
</ModuleFile>
