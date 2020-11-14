package
{
	import flash.display.Shader;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard
	import flash.utils.Timer;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.utils.getQualifiedClassName;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.geom.Point;
	import fl.motion.Color;
	import fl.motion.ColorMatrix;
	import fl.motion.AdjustColor;
	import parts.DotCrosshair;
	import parts.CircleCrosshair;
	import parts.CrossCrosshair;
	import cfg.CrosshairConfig;
	import CrosshairIndex;
	import Crosshair;
	
	/**
	 * ...
	 * @author Bolbman
	 */
	public class Main extends MovieClip 
	{
		
		private var topLevel:* = null;
		private var crosshair:Crosshair;
		private var xcfg:CrosshairConfig;
		private var xmlConfig:XML;
		private var xmlLoader:URLLoader;
		private var updateTimer:Timer;
		
		private var debugText:TextField;
		private var debugTextFormat:TextFormat;
		private var debugTextShadow:DropShadowFilter;
		
		private var meleeDot:DotCrosshair;
		private var sightDot:DotCrosshair;
		private var activateDot:DotCrosshair;
		

		private var meleeCircle:CircleCrosshair;
		private var sightCircle:CircleCrosshair;
		private var activeCircle:CircleCrosshair;
		

		private var meleeCross:CrossCrosshair;
		private var sightCross:CrossCrosshair;
		private var activateCross:CrossCrosshair;
		
		private var meleeCrosshair:Sprite;
		private var sightCrosshair:Sprite;
		private var activateCrosshair:Sprite;
		
		private var ammoCount:int;
		
		private var crosshairColorMatrixFilter:ColorMatrixFilter;
		private var tragetColorMatrixFilter:ColorMatrixFilter;
		private var dropInnerShadow:DropShadowFilter;
		private var dropOuterShadow:DropShadowFilter;
		
		private var innerShadow:Number = 1;
		
		private var globalBottomPos:Point;
		private var globalTopPos:Point;
		
		public var targetGlowFilter:GlowFilter;
		
		public var crosshairGlowFilter:GlowFilter;
		
		public function Main() 
		{
			updateTimer = new Timer(21, 0);
			
			meleeCrosshair = new Sprite();
			sightCrosshair = new Sprite();
			
			crosshairGlowFilter = new GlowFilter(0x00ff00, 1, 14, 14, 1, BitmapFilterQuality.HIGH, false, false); 	//Default border color=0xf5cb5b hue=43
			targetGlowFilter = new GlowFilter(0xff0000, 1, 14, 14, 1, BitmapFilterQuality.HIGH, false, false);		//Default inside color=0xFFFFCB hue=60
			tragetColorMatrixFilter = ColorMath.getColorChangeFilter( -90, 15, 25, -50);
			crosshairColorMatrixFilter = ColorMath.getColorChangeFilter( 0, 0, 0, 60);
			
			dropInnerShadow = new DropShadowFilter(1, 45, 0x000000, 0.75, 4, 4, 1, BitmapFilterQuality.HIGH, true, false, false);
			dropOuterShadow = new DropShadowFilter(1, 45, 0x000000, 1, 2, 2, 1, BitmapFilterQuality.HIGH, false, false, false);
			
			debugTextShadow = new DropShadowFilter(1, 45, 0x000000, 0.75, 4, 4, 1, BitmapFilterQuality.HIGH, false, false, false);
			debugText = new TextField();
			debugTextFormat = new TextFormat("$MAIN_Font_Light", 18, 0xF0F0F0); //color: 16777163
			debugTextFormat.align = "left";
			debugText.defaultTextFormat = debugTextFormat;
			debugText.setTextFormat(debugTextFormat);
			debugText.multiline = true;
			debugText.width = 1920;
			debugText.height = 1080;
			debugText.name = "debugText";
			debugText.text = "";
			debugText.filters = [debugTextShadow];
			debugText.visible = false;
			
			visible = true;
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(e:Event):void
		{
			topLevel = stage.getChildAt(0);
			if(topLevel != null && getQualifiedClassName(topLevel) == "HUDMenu")
			{
				init();
			}
			else
			{
				displayText("Not injected into HUDMenu. Current: " + getQualifiedClassName(topLevel));
			}
		}
		
		private function init():void
		{
			stage.addChild(debugText);
			
			/*
			//Debug text
			displayText("topLevel numChildren: " + topLevel.numChildren.toString());
			for (var i:int = 0; i < topLevel.numChildren; i++ )
			{
				displayText("Name: " + topLevel.getChildAt(i).name + "Class: " + getQualifiedClassName(topLevel.getChildAt(i)));
			}
			*/
			
			globalBottomPos = topLevel.BottomCenterGroup_mc.localToGlobal(new Point(topLevel.BottomCenterGroup_mc.x, topLevel.BottomCenterGroup_mc.y));
			globalTopPos = topLevel.TopCenterGroup_mc.localToGlobal(new Point(topLevel.TopCenterGroup_mc.x, topLevel.TopCenterGroup_mc.y));
			
			//Scale ennemy/ally health bar
			//topLevel.TopCenterGroup_mc.scaleX = 1.5;
			//topLevel.TopCenterGroup_mc.scaleY = 1.5;
			
			/*
			displayText("globalTopPos: " + globalTopPos.toString());
			displayText("globalBottomPos: " + globalBottomPos.toString());
			displayText("localTopPos: " + new Point(topLevel.TopCenterGroup_mc.x, topLevel.TopCenterGroup_mc.y));
			displayText("localBottomPos: " + new Point(topLevel.BottomCenterGroup_mc.x, topLevel.BottomCenterGroup_mc.y));
			*/
			loadConfig();
		}
		
		private function loadConfig():void
		{
			try
			{
				/*
				var tempURLRequest:URLRequest = new URLRequest("../CustomCrosshair.xml");
				tempURLRequest.contentType = "application/xml";
				tempURLRequest.method = URLRequestMethod.GET;
				xmlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				xmlLoader.load(tempURLRequest);
				*/
				xmlLoader = new URLLoader();
				xmlLoader.addEventListener(Event.COMPLETE, onFileLoad);
				xmlLoader.load(new URLRequest("../CustomCrosshair.xml"));
			}
			catch (error:Error)
			{
				displayText("Error finding custom crosshair configuration file. " + error.message.toString());
			}
		}
		
		private function onFileLoad(e:Event):void
		{
			try
			{
				initCommands(e.target.data);
				
			}
			catch (error:Error)
			{
				displayText("Error loading CustomCrosshair.xml " + error.message.toString());
				
			}
			
			if (!xcfg.fo76CrosshairVisible)
			{
				removeFo76Crosshair();
				removeFo76ActivateCrosshair();
			}
			
			initCustomCrosshair();
			editCrosshair();
			updateTimer.addEventListener(TimerEvent.TIMER_COMPLETE, update);
			updateTimer.start();
			
			//topLevel.BottomCenterGroup_mc.CompassWidget_mc.scaleX = 1.4;
			//topLevel.BottomCenterGroup_mc.CompassWidget_mc.scaleY = 1.4;
			//topLevel.TopCenterGroup_mc.scaleX = 1.25;
			//topLevel.TopCenterGroup_mc.scaleY = 1.25;
			
			/*
			displayText("TopCenterGroup y: " + topLevel.TopCenterGroup_mc.y);
			displayText("BottomCenterGroup y: " + topLevel.BottomCenterGroup_mc.y);
			displayText("Compass y: " + topLevel.BottomCenterGroup_mc.CompassWidget_mc.y);
			displayText("CompassBar y: " + topLevel.BottomCenterGroup_mc.CompassWidget_mc.CompassBar_mc.y);
			*/
		}
		
		private function update(event:TimerEvent):void
		{
			editCrosshair();
			//editInterface();
			//editCompass();
			
			ammoCount = int(topLevel.RightMeters_mc.AmmoCount_mc.ClipCount_tf.text);
		}
		
		private function initCustomCrosshair():void
		{
			if(topLevel.CenterGroup_mc != null &&
				topLevel.CenterGroup_mc.HUDCrosshair_mc != null &&
				topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc != null)
			{
				//Get crosshair position
				var crosshairPosX:Number = topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.x;
				var crosshairPosY:Number = topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.y;
				
				crosshair = new Crosshair(crosshairPosX, crosshairPosY, xcfg);
				topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.addChild(crosshair);
				
				var crosshairFilters:Array = new Array();
				if (xcfg.drawInnerShadow)
					crosshairFilters.push(dropInnerShadow);
				if (xcfg.drawOuterShadow)
					crosshairFilters.push(dropOuterShadow);
				
				crosshair.filters = crosshairFilters;
				
				/*
				//Dot
				meleeDot = new DotCrosshair(crosshairPosX, crosshairPosY, xcfg.dotSize, 0xF5CB5B);
				meleeDot.visible = xcfg.meleeHasDot;
				sightDot = new DotCrosshair(crosshairPosX, crosshairPosY, xcfg.dotSize, 0xF5CB5B);
				sightDot.visible = xcfg.sightHasDot;
				//Circle
				gunCircle = new CircleCrosshair(crosshairPosX, crosshairPosY, xcfg.circleRadius, xcfg.circleThickness, 0xF5CB5B);
				gunCircle.visible = xcfg.gunHasCircle;
				meleeCircle = new CircleCrosshair(crosshairPosX, crosshairPosY, xcfg.circleRadius, xcfg.circleThickness, 0xF5CB5B);
				meleeCircle.visible = xcfg.meleeHasCircle;
				sightCircle = new CircleCrosshair(crosshairPosX, crosshairPosY, xcfg.circleRadius, xcfg.circleThickness, 0xF5CB5B);
				sightCircle.visible = xcfg.sightHasCircle;
				//Cross
				gunCross = new CrossCrosshair(crosshairPosX, crosshairPosY, xcfg.crossGap, xcfg.crossLength, xcfg.crossThickness, 0xF5CB5B);
				gunCross.visible = xcfg.gunHasCross;
				meleeCross = new CrossCrosshair(crosshairPosX, crosshairPosY, xcfg.crossGap, xcfg.crossLength, xcfg.crossThickness, 0xF5CB5B);
				meleeCross.visible = xcfg.meleeHasCross;
				sightCross = new CrossCrosshair(crosshairPosX, crosshairPosY, xcfg.crossGap, xcfg.crossLength, xcfg.crossThickness, 0xF5CB5B);
				sightCross.visible = xcfg.sightHasCross;
				
				//Gun crosshair
				gunCrosshair.addChild(gunDot);
				gunCrosshair.addChild(gunCircle);
				gunCrosshair.addChild(gunCross);
				gunCrosshair.filters = crosshairFilters;
				gunCrosshair.visible = true;
				topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.addChild(gunCrosshair);
				
				//Melee crosshair
				meleeCrosshair.addChild(meleeDot);
				meleeCrosshair.addChild(meleeCircle);
				meleeCrosshair.addChild(meleeCross);
				meleeCrosshair.filters = crosshairFilters;
				meleeCrosshair.visible = true;
				topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.addChild(meleeCrosshair);
				
				//Aim down sight corsshair
				sightCrosshair.addChild(sightDot);
				sightCrosshair.addChild(sightCircle);
				sightCrosshair.addChild(sightCross);
				sightCrosshair.filters  = crosshairFilters;
				sightCrosshair.visible = true;
				topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.addChild(sightCrosshair);
				*/
			}
		}
		
		private function editCrosshair(): void
		{
			//Verify first if CrosshairBase exist
			if (topLevel.CenterGroup_mc != null &&
				topLevel.CenterGroup_mc.HUDCrosshair_mc != null &&
				topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc != null)
			{
				//Shortcut variables
				var crosshairBase:MovieClip = topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc;
				var crosshairClips:MovieClip = topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc;
				var crosshairTicks:MovieClip = topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairTicks_mc;
				
				//Gun state
				if (crosshairTicks.visible)
				{
					setGunCrosshairVisible();
				}
				else
				{
					//Melee and arms down state
					if (crosshairClips.Dot_Dot.visible)
					{
						setMeleeCrosshairVisible();
					}
					//Aim down sight state
					else if (crosshairClips.None_None.visible)
					{
						setSightCrosshairVisible();
					}
					//Activate states
					else if (crosshairClips.Activate_Activate.visible && !crosshairClips.Dot_Activate.visible)
					{
						setActivateCrosshairVisible();
					}
					else if (crosshairClips.Dot_Activate.visible && !crosshairClips.Activate_Activate.visible)
					{
						setActivateCrosshairVisible();
					}
					else if (crosshairClips.Standard_Activate.visible && !crosshairClips.Activate_Activate.visible)
					{
						setActivateCrosshairVisible();
					}
					else if (crosshairClips.Activate_Standard.visible && !crosshairClips.Activate_Activate.visible)
					{
						setActivateCrosshairVisible();
					}
					else if (crosshairClips.Activate_Dot.visible && !crosshairClips.Activate_Activate.visible)
					{
						setActivateCrosshairVisible();
					}
					else if (crosshairClips.Dot_Standard.visible && !crosshairClips.Dot_Dot.visible)
					{
						setGunCrosshairVisible();
					}
					else if (crosshairClips.Standard_Dot.visible && !crosshairClips.Dot_Dot.visible)
					{
						setMeleeCrosshairVisible();
					}
					//Transition gun to aim down sight
					else if (crosshairClips.Standard_None.visible && !crosshairClips.None_None.visible)
					{
						setSightCrosshairVisible();
					}
					else if (crosshairClips.None_Standard.visible && !crosshairTicks.visible)
					{
						setGunCrosshairVisible();
					}
					else
					{
						setCustomCrosshairHidden();
					}
				}
				
				
				//Set compass at the top of the screen
				/*if (topLevel.BottomCenterGroup_mc != null && topLevel.BottomCenterGroup_mc.CompassWidget_mc != null)
				{
					var compass:MovieClip = topLevel.BottomCenterGroup_mc.CompassWidget_mc;
					compass.y = -760;
					compass.CompassBar_mc.alpha = 0.75;
					compass.alpha = 0.75;
				}*/
				
				
				//
				/*displayText(
					"Thirst visible " + topLevel.RightMeters_mc.HUDThirstMeter_mc.Meter_mc.visible + "\r" +
					"Thirst width " + topLevel.RightMeters_mc.HUDThirstMeter_mc.Meter_mc.width + "\r" +
					"Thirst ghost visible " + topLevel.RightMeters_mc.HUDThirstMeter_mc.GhostMeter_mc.visible
				);*/
				
				//Show thirst meter
				//topLevel.RightMeters_mc.fadeInThirst();
				//Show hunger meter
				//topLevel.RightMeters_mc.fadeInHunger();
				
				//Filters
				//Get current filters
				var tempFilters:Array = crosshairBase.filters;
				//Apply the filters to our array
				if (crosshairBase.targetIsHostile == false)
				{
					tempFilters[0] = crosshairColorMatrixFilter;
					if (xcfg.drawGlow)
						tempFilters[1] = crosshairGlowFilter;
				}
				else
				{
					tempFilters[0] = tragetColorMatrixFilter;
					if (xcfg.drawGlow)
						tempFilters[1] = targetGlowFilter;
				}
				//Adding back filters
				topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.filters = tempFilters;
			}
			
		}
		
		//Read the whole configuration string and assign values to our actionscript variables
		private function initCommands(wholeFileStr:String):void
		{
			XML.ignoreComments = true;
			xmlConfig = new XML(wholeFileStr);
			xcfg = new CrosshairConfig();
			
			//Color options
			xcfg.crosshairBrightness = Number(xmlConfig.Colors.OffTarget.ColorChange.Brightness);
			xcfg.crosshairContrast = Number(xmlConfig.Colors.OffTarget.ColorChange.Contrast);
			xcfg.crosshairSaturation = Number(xmlConfig.Colors.OffTarget.ColorChange.Saturation);
			xcfg.targetCrosshairBrightness = Number(xmlConfig.Colors.OnTarget.ColorChange.Brightness);
			xcfg.targetCrosshairContrast = Number(xmlConfig.Colors.OnTarget.ColorChange.Contrast);
			xcfg.targetCrosshairSaturation = Number(xmlConfig.Colors.OnTarget.ColorChange.Saturation);
			
			//Glow
			crosshairGlowFilter.color = uint("0x" + xmlConfig.Colors.OffTarget.Glow.RGB);
			xcfg.glowLength = Number(xmlConfig.Filters.Glow.Length);
			crosshairGlowFilter.blurX = xcfg.glowLength;
			crosshairGlowFilter.blurY = xcfg.glowLength;
			xcfg.glowStrength = Number(xmlConfig.Filters.Glow.Strength);
			crosshairGlowFilter.strength = xcfg.glowStrength;
			targetGlowFilter.color = uint("0x" + xmlConfig.Colors.OnTarget.Glow.RGB);
			
			//Target off
			xcfg.targetCrosshairColor = uint("0x" + xmlConfig.Colors.OffTarget.ColorChange.RGB);
			var crosshairHUE:Number = ColorMath.hex2hsb(xcfg.targetCrosshairColor)[0];
			crosshairColorMatrixFilter = ColorMath.getColorChangeFilter(xcfg.crosshairBrightness, xcfg.crosshairContrast, xcfg.crosshairSaturation, crosshairHUE-43); //-43 because default corsshair hue is 43
			
			//Target On
			xcfg.crosshairColor = uint("0x" + xmlConfig.Colors.OnTarget.ColorChange.RGB);
			var targetCrosshairHUE:Number = ColorMath.hex2hsb(xcfg.crosshairColor)[0];
			tragetColorMatrixFilter = ColorMath.getColorChangeFilter(xcfg.targetCrosshairBrightness, xcfg.targetCrosshairContrast, xcfg.targetCrosshairSaturation, targetCrosshairHUE-43);
			
			//Circle properties
			xcfg.circleRadius = Number(xmlConfig.Parts.Custom.Shapes.Circle.Radius);
			xcfg.circleThickness = Number(xmlConfig.Parts.Custom.Shapes.Circle.Thickness);
			
			//Dot properties
			xcfg.dotSize = Number(xmlConfig.Parts.Custom.Shapes.Dot.Size);
			
			//Cross properties
			xcfg.crossGap = Number(xmlConfig.Parts.Custom.Shapes.Cross.Gap);
			xcfg.crossLength = Number(xmlConfig.Parts.Custom.Shapes.Cross.Length);
			xcfg.crossThickness = Number(xmlConfig.Parts.Custom.Shapes.Cross.Thickness);
			
			//Booleans toggle
			xcfg.meleeHasDot = xmlConfig.Parts.Custom.MeleeState.ShowDot == "true";
			xcfg.meleeHasCircle = xmlConfig.Parts.Custom.MeleeState.ShowCircle == "true";
			xcfg.meleeHasCross = xmlConfig.Parts.Custom.MeleeState.ShowCross == "true";
			
			xcfg.gunHasDot = xmlConfig.Parts.Custom.GunState.ShowDot == "true";
			xcfg.gunHasCircle = xmlConfig.Parts.Custom.GunState.ShowCircle == "true";
			xcfg.gunHasCross = xmlConfig.Parts.Custom.GunState.ShowCross == "true";
			
			xcfg.sightHasDot = xmlConfig.Parts.Custom.OnSightState.ShowDot == "true";
			xcfg.sightHasCircle = xmlConfig.Parts.Custom.OnSightState.ShowCircle == "true";
			xcfg.sightHasCross = xmlConfig.Parts.Custom.OnSightState.ShowCross == "true";
			
			xcfg.drawGlow = xmlConfig.Filters.Glow.Visible == "true";
			xcfg.drawInnerShadow = xmlConfig.Filters.InnerShadow.Visible == "true";
			xcfg.drawOuterShadow = xmlConfig.Filters.OuterShadow.Visible == "true";
			xcfg.fo76CrosshairVisible = xmlConfig.Parts.Fo76.Visible == "true";
			xcfg.showCustomCrosshairOnAIm = xmlConfig.Parts.Custom.ShowOnAim == "true";
		}
		
		
		//Display a text top left in white. Text is written over last text if multiple call.
		private function displayText(_text:String):void
		{
			debugText.visible = true;
			debugText.text += _text + "\n";
		}
		
		
		private function newDisplayText(_text:String):void
		{
			debugText.visible = true;
			debugText.text = _text;
		}
		
		private function setGunCrosshairVisible():void
		{
			crosshair.gun.visible = true;
			crosshair.melee.visible = false;
			crosshair.activate.visible = false;
			crosshair.sight.visible = false;
		}
		
		private function setMeleeCrosshairVisible():void
		{
			crosshair.gun.visible = false;
			crosshair.melee.visible = true;
			crosshair.activate.visible = false;
			crosshair.sight.visible = false;
		}
		
		private function setActivateCrosshairVisible():void
		{
			crosshair.gun.visible = false;
			crosshair.melee.visible = false;
			crosshair.activate.visible = true;
			crosshair.sight.visible = false;
		}
		
		private function setSightCrosshairVisible():void
		{
			crosshair.gun.visible = false;
			crosshair.activate.visible = false;
			crosshair.melee.visible = false;
			crosshair.sight.visible = true;
		}
		
		private function setCustomCrosshairHidden():void
		{
			crosshair.gun.visible = false;
			crosshair.activate.visible = false;
			crosshair.melee.visible = false;
			crosshair.sight.visible = false;
		}
		
		private function removeFo76ActivateCrosshair():void
		{
			var offScreenPosition:Number = -5000;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.Activate_Activate.x = offScreenPosition;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.Activate_Standard.x = offScreenPosition;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.Activate_Dot.x = offScreenPosition;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.Dot_Activate.x = offScreenPosition;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.Standard_Activate.x = offScreenPosition;
			
		}
		
		private function removeFo76Crosshair():void
		{
			var offScreenPosition:Number = -5000;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairTicks_mc.x = offScreenPosition;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.None_Standard.x = offScreenPosition;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.None_Dot.x = offScreenPosition;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.Dot_Dot.x = offScreenPosition;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.Dot_None.x = offScreenPosition;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.Dot_Standard.x = offScreenPosition;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.Standard_Standard.x = offScreenPosition;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.Standard_None.x = offScreenPosition;
			topLevel.CenterGroup_mc.HUDCrosshair_mc.CrosshairBase_mc.CrosshairClips_mc.Standard_Dot.x = offScreenPosition;
		}
		
		public function editInterface():void
		{
			topLevel.TopCenterGroup_mc.y = topLevel.BottomCenterGroup_mc.y;
			//topLevel.BottomCenterGroup_mc.
			
			//topLevel.TopCenterGroup_mc.y = globalTopPos.y;
			//topLevel.BottomCenterGroup_mc.y = globalBottomPos.y;
			
			//topGroup.y = bottomGroup.y - (topGroup.height/2);
			//bottomGroup.y = bottomGroup.height/2;
		}
		
		private function editCompass():void
		{
			//var topY:Number = topLevel.TopCenterGroup_mc.y;
			//var newPosY:Number = topY + 200;
			//topLevel.BottomCenterGroup_mc.CompassWidget_mc.visible = false;
			//var sumY:Number = -topLevel.BottomCenterGroup_mc.y;
			//var bottomY:Number = topLevel.BottomCenterGroup_mc.y;
			var compass:MovieClip = new MovieClip;
			//topLevel.BottomCenterGroup_mc.CompassWidget_mc.y = -topLevel.BottomCenterGroup_mc.y + 50;
			//topLevel.BottomCenterGroup_mc.CompassWidget_mc.alpha = 0.65;
			//topLevel.BottomCenterGroup_mc.CompassWidget_mc.CompassBar_mc.visible = false;
			
			topLevel.TopCenterGroup_mc.y = topLevel.BottomCenterGroup_mc.y - 80;
			topLevel.BottomCenterGroup_mc.y = -topLevel.BottomCenterGroup_mc.y;
			
			topLevel.EnemyHealthMeter_mc.BabylonAILevel_mc.visible = true;
		}
		
		
		private function displayDebugText():void
		{
			/*
			displayText("MeterBarEnemy percent " + topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.MeterBarEnemy_mc.percent);
			displayText("MeterBarFriendly width " + topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.MeterBarFriendly_mc.width);
			displayText("MeterBarEnemy width " + topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.MeterBarEnemy_mc.width);
			displayText("MeterBarInternal width " + topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.MeterBarEnemy_mc.width);
			displayText("EnnemyHealth percent " + topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.percent);
			displayText(" ~ ");
			
			displayText("CrosshairTicks " + crosshairTicks.visible.toString());
			displayText("CrosshairClips " + crosshairClips.visible.toString());
			displayText("None_None " + crosshairClips.None_None.visible.toString());
			displayText("None_Dot " + crosshairClips.None_Dot.visible.toString());
			displayText("None_Standard " + crosshairClips.None_Standard.visible.toString());
			displayText("Dot_Dot " + crosshairClips.Dot_Dot.visible.toString());
			displayText("Dot_Standard " + crosshairClips.Dot_Standard.visible.toString());
			displayText("Dot_Activate " + crosshairClips.Dot_Activate.visible.toString());
			displayText("Standard_None " + crosshairClips.Standard_None.visible.toString());
			displayText("Standard_Dot " + crosshairClips.Standard_Dot.visible.toString());
			displayText("Standard_Activate " + crosshairClips.Standard_Activate.visible.toString());
			displayText("Activate_Activate " + crosshairClips.Activate_Activate.visible.toString());
			displayText("Activate_None " + crosshairClips.Activate_None.visible.toString());
			displayText("Activate_Dot " + crosshairClips.Activate_Dot.visible.toString());
			displayText("Activate_Standard " + crosshairClips.Activate_Standard.visible.toString());
			*/
		}
	}
	
}