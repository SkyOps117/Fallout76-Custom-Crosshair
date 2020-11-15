package cfg 
{
	/**
	 * Configuration options of the corsshair.
	 * Variables here will be equals of those in the Xml when loaded in the Main.
	 * They are declared here and assigned a default value for safety.
	 * @author Bolbman
	 */
	public class CrosshairConfig
	{
		//OffTarget
		public var crosshairColor:uint = 0x00ff00;
		public var crosshairBrightness:Number = -40;
		public var crosshairContrast:Number = 5;
		public var crosshairSaturation:Number = 5;
		
		//OnTarget
		public var targetCrosshairColor:uint = 0xff0000;
		public var targetCrosshairBrightness:Number = -90
		public var targetCrosshairContrast:Number = 15;
		public var targetCrosshairSaturation:Number = 25;
		
		//Glow
		public var glowLength:Number = 14;
		public var glowStrength:Number = 1;
		
		//Gun crosshair
		public var gunDotSize:Number = 4;
		public var gunCircleRadius:Number = 16;
		public var gunCircleThickness:Number = 2;
		public var gunCrossThickness:Number = 2;
		public var gunCrossLength:Number = 8;
		public var gunCrossGap:Number = 8;
		
		//Melee crosshair
		public var meleeDotSize:Number = 4;
		public var meleeCircleRadius:Number = 16;
		public var meleeCircleThickness:Number = 2;
		public var meleeCrossThickness:Number = 2;
		public var meleeCrossLength:Number = 8;
		public var meleeCrossGap:Number = 8;
		
		//Activate crosshair
		public var activateDotSize:Number = 4;
		public var activateCircleRadius:Number = 16;
		public var activateCircleThickness:Number = 2;
		public var activateCrossThickness:Number = 2;
		public var activateCrossLength:Number = 8;
		public var activateCrossGap:Number = 8;
		
		//Sight crosshair
		public var sightDotSize:Number = 4;
		public var sightCircleRadius:Number = 16;
		public var sightCircleThickness:Number = 2;
		public var sightCrossThickness:Number = 2;
		public var sightCrossLength:Number = 8;
		public var sightCrossGap:Number = 8;
		
		//Booleans
		public var drawDot:Boolean = false;
		public var drawCircle:Boolean = false;
		public var drawCross:Boolean = false;
		public var drawGlow:Boolean = false;
		public var drawInnerShadow:Boolean = false;
		public var drawOuterShadow:Boolean = false;
		public var fo76CrosshairVisible:Boolean = false;
		
		//Gun has
		public var gunHasDot:Boolean = false;
		public var gunHasCircle:Boolean = false;
		public var gunHasCross:Boolean = false;
		
		//Melee has
		public var meleeHasDot:Boolean = false;
		public var meleeHasCircle:Boolean = false;
		public var meleeHasCross:Boolean = false;
		
		//Activate has
		public var activateHasDot:Boolean = false;
		public var activateHasCircle:Boolean = false;
		public var activateHasCross:Boolean = false;
		
		//Sight has
		public var sightHasDot:Boolean = false;
		public var sightHasCircle:Boolean = false;
		public var sightHasCross:Boolean = false;
		
		public function CrosshairConfig() { }
		
	}

}