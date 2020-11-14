package cfg 
{
	/**
	 * ...
	 * @author Bolbman
	 */
	public class CrosshairConfig
	{
		public var crosshairColor:uint = 0x00ff00;
		public var crosshairBrightness:Number = -40;
		public var crosshairContrast:Number = 5;
		public var crosshairSaturation:Number = 5;
		
		public var targetCrosshairColor:uint = 0xff0000;
		public var targetCrosshairBrightness:Number = -90
		public var targetCrosshairContrast:Number = 15;
		public var targetCrosshairSaturation:Number = 25;
		
		public var glowLength:Number = 14;
		public var glowStrength:Number = 1;
		
		public var dotSize:Number = 4;
		public var circleRadius:Number = 16;
		public var circleThickness:Number = 2;
		public var crossThickness:Number = 2;
		public var crossLength:Number = 8;
		public var crossGap:Number = 8;
		
		public var drawDot:Boolean = false;
		public var drawCircle:Boolean = false;
		public var drawCross:Boolean = false;
		public var drawGlow:Boolean = false;
		public var drawInnerShadow:Boolean = false;
		public var drawOuterShadow:Boolean = false;
		public var fo76CrosshairVisible:Boolean = false;
		public var showCustomCrosshairOnAIm:Boolean = false;
		
		public var gunHasDot:Boolean = false;
		public var gunHasCircle:Boolean = false;
		public var gunHasCross:Boolean = false;
		public var meleeHasDot:Boolean = false;
		public var meleeHasCircle:Boolean = false;
		public var meleeHasCross:Boolean = false;
		public var sightHasDot:Boolean = false;
		public var sightHasCircle:Boolean = false;
		public var sightHasCross:Boolean = false;
		
		public function CrosshairConfig() 
		{
			
		}
		
	}

}