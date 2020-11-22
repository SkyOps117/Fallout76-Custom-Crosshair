package 
{
	
	import figures.Circle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import parts.DotCrosshair;
	import parts.CircleCrosshair;
	import parts.CrossCrosshair;
	import cfg.CrosshairConfig;
	
	/**
	 * Shown on different state of the crosshair in the main
	 * @author Bolbman
	 */
	public class CrosshairState extends Sprite
	{
		public static var GUN_STATE:String = "GUN";
		public static var MELEE_STATE:String = "MELEE";
		public static var ACTIVATE_STATE:String = "ACTIVATE";
		public static var SIGHT_STATE:String = "SIGHT";
		public static var NONE_STATE:String = "NONE"; //Not used in constructor.
		public var state:String;
		
		public var dot:DotCrosshair;
		public var circle:CircleCrosshair;
		public var cross:CrossCrosshair;
		
		public function CrosshairState(stateParam:String, crosshairPosX:Number, crosshairPosY:Number, xcfg:CrosshairConfig) 
		{
			state = stateParam;
			
			switch (state) 
			{
				case GUN_STATE: 
					dot = new DotCrosshair(crosshairPosX, crosshairPosY, xcfg.gunDotSize, 0xF5CB5B);
					circle = new CircleCrosshair(crosshairPosX, crosshairPosY, xcfg.gunCircleRadius, xcfg.gunCircleThickness, 0xF5CB5B);
					cross = new CrossCrosshair(crosshairPosX, crosshairPosY, xcfg.gunCrossGap, xcfg.gunCrossLength, xcfg.gunCrossThickness, 0xF5CB5B);
				break;
				case MELEE_STATE: 
					dot = new DotCrosshair(crosshairPosX, crosshairPosY, xcfg.meleeDotSize, 0xF5CB5B);
					circle = new CircleCrosshair(crosshairPosX, crosshairPosY, xcfg.meleeCircleRadius, xcfg.meleeCircleThickness, 0xF5CB5B);
					cross = new CrossCrosshair(crosshairPosX, crosshairPosY, xcfg.meleeCrossGap, xcfg.meleeCrossLength, xcfg.meleeCrossThickness, 0xF5CB5B);
				break;
				case ACTIVATE_STATE: 
					dot = new DotCrosshair(crosshairPosX, crosshairPosY, xcfg.activateDotSize, 0xF5CB5B);
					circle = new CircleCrosshair(crosshairPosX, crosshairPosY, xcfg.activateCircleRadius, xcfg.activateCircleThickness, 0xF5CB5B);
					cross = new CrossCrosshair(crosshairPosX, crosshairPosY, xcfg.activateCrossGap, xcfg.activateCrossLength, xcfg.activateCrossThickness, 0xF5CB5B);
				break;
				case SIGHT_STATE: 
					dot = new DotCrosshair(crosshairPosX, crosshairPosY, xcfg.sightDotSize, 0xF5CB5B);
					circle = new CircleCrosshair(crosshairPosX, crosshairPosY, xcfg.sightCircleRadius, xcfg.sightCircleThickness, 0xF5CB5B);
					cross = new CrossCrosshair(crosshairPosX, crosshairPosY, xcfg.sightCrossGap, xcfg.sightCrossLength, xcfg.sightCrossThickness, 0xF5CB5B);
				break;
				default:
					dot = new DotCrosshair(crosshairPosX, crosshairPosY, xcfg.meleeDotSize, 0xF5CB5B);
					circle = new CircleCrosshair(crosshairPosX, crosshairPosY, xcfg.meleeCircleRadius, xcfg.meleeCircleThickness, 0xF5CB5B);
					cross = new CrossCrosshair(crosshairPosX, crosshairPosY, xcfg.meleeCrossGap, xcfg.meleeCrossLength, xcfg.meleeCrossThickness, 0xF5CB5B);
			}
			
			addChild(dot);
			addChild(circle);
			addChild(cross);
			visible = true;
		}
		
		public function setColor(_color:uint):void
		{
			dot.setColor(_color);
			circle.setColor(_color);
			cross.setColor(_color);
		}
		
	}

}