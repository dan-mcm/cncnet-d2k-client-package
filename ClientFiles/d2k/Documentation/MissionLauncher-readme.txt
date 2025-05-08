Created by FunkyFr3sh, maintained and developed further by Feda.

PLEASE READ BELOW. 
Also please read the Dune2000MissionLauncherManual.pdf
=================

======= FAQ =======

==== MISSION CREATORS, READ BELOW ====

### Possible Keys/Values ###
All settings must be placed into a .ini file which has the same name as your .map. Settings will be read from the [Basic] section of the .ini

Name= The name displayed inside of the MissionLauncher mission selection screen
SideId= The house of the human player - 0=Atreides 1=Harkonnen 2=Ordos 3=Emperor 4=Fremen 5=Smugglers 6=Mercenaries (not sure if the values are correct, please let me know if there are problems)
MissionNumber=If this key is missing the game will display the "Briefing=" from the .ini file in-game. If the number is higher than 0 the game will try to find the matching .UIL file, example: IGH112MIS.UIL, H = harkonnen, 112 = mission number - you must create a new file for custom missions, else the game will freeze when the briefing button was clicked - Possible side values = A,H,O,E,F,S,M - Possible mission numbers 0-255
TextUibBriefingKey= This is the name of the key where the custom mission briefing was saved in text.uib, any name is possible (you don't need to override the original briefings anymore)
TextUib= This key is optional, it was mainly added to keep support for older campaigns which are using a custom text.uib file - Newly made campaigns should use the text.uib included in this package (the one from gruntmods) as base to avoid the mess of having tons of different text.uib files - Keep custom .uib filename short, the game might crash if the name is too long
Briefing= You can use this key to save your briefing, this way you can avoid editing text.uib. The launcher will ignore the "TextUibBriefingKey=" completely when this key was added. Every _ in the text will be replaced with a line break. Text events (in-game messages) can be added to map .ini files instead of text.uib, check the forums for more informations: http://forum.dune2k.com/topic/26661-dune-2000-106p-game-patching-bug-fixes-new-features/page-14#entry390486 


### Examples ###
[Basic]
Name=Original Campaign - Atreides Mission 1a
SideId=0
MissionNumber=1
TextUibBriefingKey=AM1Text2

[Basic]
Name=War Of Assassins - Ordos Mission 2
SideId=2
TextUibBriefingKey=o2brief
TextUib=woatext.uib

[Basic]
Name=My Cool Mission
SideId=0
MissionNumber=1
Briefing=Destroy all enemies!
