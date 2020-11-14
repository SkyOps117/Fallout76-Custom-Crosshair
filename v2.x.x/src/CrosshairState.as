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
	 * ...
	 * @author Bolbman
	 */
	public class CrosshairState extends Sprite
	{
		public static var GUN_STATE:String = "GUN_STATE";
		public static var MELEE_STATE:String = "MELEE_STATE";
		public static var ACTIVATE_STATE:String = "ACTIVATE_STATE";
		public static var SIGHT_STATE:String = "SIGHT_STATE";
		public var state:String;
		
		public var dot:DotCrosshair;
		public var circle:CircleCrosshair;
		public var cross:CrossCrosshair;
		
		public function CrosshairState(_state:String, _crosshairPosX:Number, _crosshairPosY:Number, _xcfg:CrosshairConfig) 
		{
			state = _state;
			dot = new DotCrosshair(_crosshairPosX, _crosshairPosY, _xcfg.dotSize, 0xF5CB5B);
			circle = new CircleCrosshair(_crosshairPosX, _crosshairPosY, _xcfg.circleRadius, _xcfg.circleThickness, 0xF5CB5B);
			cross = new CrossCrosshair(_crosshairPosX, _crosshairPosY, _xcfg.crossGap, _xcfg.crossLength, _xcfg.crossThickness, 0xF5CB5B);
			
			addChild(dot);
			addChild(circle);
			addChild(cross);
			visible = true;
		}
		
	}

}