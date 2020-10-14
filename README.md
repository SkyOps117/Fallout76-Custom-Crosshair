# Custom-Crosshair
Crosshair mod for Fallout 76. 

## Preview video
<a href="http://www.youtube.com/watch?feature=player_embedded&v=rSAlH52bP04" target="_blank"><img src="http://img.youtube.com/vi/rSAlH52bP04/0.jpg" alt="PREVIEW VIDEO" width="960" height="540" border="10" /></a>

## + Mod ability
  - Add a dot, circle and static cross.
  - Display it when using melee, guns or aim down sight.
  - Glowing effect radius, strength and color.
  - Change size, length, thickness and radius of dot/circle/crosshair.
  - Chose your color for on target and off target.
  - Remove the default dynamic crosshair.
  - Toggle inner and outer shadow effect.
  - Always show thirst and hunger meter.
  - ↳ They will just fade in and out sometimes but stay visible most of the time.

## ? Installation and configuration
For compatibility with ChatMod, load ChatMod after CustomCrosshair.

⇨ If you have trouble with any mods not applying or still applying, do a scan and repair in the launcher.

⇨ Manual installation guide: https://www.nexusmods.com/fallout76/articles/42

⇨ How to use xml configuration: https://www.nexusmods.com/fallout76/articles/46

⇨ Current version configuration: https://www.nexusmods.com/fallout76/articles/49

⇨ Optional tool, Notepad++ for better read of xml: https://notepad-plus-plus.org/


## ↑ New potential features
### General
□ In the long run, outside the game interface or in game. Less likely in game and would take longer for me.
#### Crosshair
○ Different color for when using melee, guns, aiming down sight or aiming objects/allies.

○ Animated crosshair based on ammo spent per second, movement or mouse click.

○ More xml configuration options.
#### HUD interface
◊ Move compass, sneak meter, enemy health bars, and ally health bars to the bottom or top.

◊ Move player status icons somewhere more visible. The one bottom right.

◊ Change color or glow indicator when meter is low. Meters: player health, target health, thirst or hunger.

◊ Always show thirst or hunger meter.
#### Completed
√ Different crosshair for when using melee, guns, aiming down sight or aiming at objects/allies.

√ Compatibility with major HUD interface mods.

√ Configurable mod.

* Post a comment if you have a new idea. Always looking for new one :)

## 🖒 Recommended mods
→ Perk Loadout Manager (PLM)
↳https://www.nexusmods.com/fallout76/mods/124

→ Improved Health Bars
↳https://www.nexusmods.com/fallout76/mods/368

→ Text Chat
↳https://www.nexusmods.com/fallout76/mods/151

→ Better Inventory
↳https://www.nexusmods.com/fallout76/mods/32

→ Save everything
↳https://www.nexusmods.com/fallout76/mods/148

→ Inventory Plus
↳https://www.nexusmods.com/fallout76/mods/125

## ♠ Creation of this mod
This mod consist of a swf loaded into fallout76 hud menu. Some functionality are limited.

It is not possible to save data. You can look inside this mode swf with Jpexs after extracting them with Archive2.

Editing complex actionscript of Fallout 76 with Jpexs is not recomended.

If so, I suggest you download the project source code for a better read.

Using Jpexs only, first version of this mod was made by editing the svg inside shapes folder.

Svg files are scalable vector graphics insted of rasterized pictures like PNG.

First I was extracting the svg, edit them then replace it with Jpexs.

But, doing so you lose some functionalities like transparency. Might have been corrected with latest release of Jpexs.

For some shapes like squares and rectangles, it doesn't matter transparency.

The best is by using raw edit without replacing svg in shapes folder.

#### FlashDevelop
https://www.flashdevelop.org/

#### JPEXS
https://github.com/jindrapetrik/jpexs-decompiler

#### Archive2
For Ba2 files. It comes with fallout 4 creation tool.

You can download it in the bethesda launcher.

Default location: Bethesda.net Launcher\games\CK\Tools\Archive2\Archive2.exe



### ♥ People to thanks
Big thanks to Keretus and Liyalai for helping improving compatibility with other major HUD interface mods.

They are the one making this mod up to date with Fo76 by decompiling and recompiling the most recent hudmenu.swf 

to include a swf loader for this mod.
You can even do the update for this mod yourself by adding plm hudmenu.swf into this mod Ba2.

That being said, I couldn't have make every options of this mod under one download without Keretus and Liyalai

work.

### ⟳ Versioning
· How to read versioning

X.Y.Z

X = Major update. When a lot of stuff change to my interpretation.

Y = Feature update. You need to update your XML configuration.

Z = Compatibility and bug fixes update. No need to update XML configuration.

Each letter get incremented once per updates.

### · Version archive section
Versioning is currently inconsistent in the nexus changelog before 2.0.0

1.2+ Conflic with mods which direct edit interface/hudmenu.swf.

1.2 Optional centered dot, glow effect and you can now make all color combo.

1.2 Compatibility with chatmod, PLM and improved health bar.

1.1 Added PLM, Improved Health Bar and Event Notification compatibility.

1.1 Must be placed after PLM, Improved Health Bar and Event Notification.

1.1 Know to conflic with: Unstretched ultrawide, Chat mod.

