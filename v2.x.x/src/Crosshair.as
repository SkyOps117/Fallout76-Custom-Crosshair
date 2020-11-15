package 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import parts.DotCrosshair;
	import parts.CircleCrosshair;
	import parts.CrossCrosshair;
	import cfg.CrosshairConfig;
	import CrosshairState;
	
	/**
	 * Custom crosshair
	 * @author Bolbman
	 */
	public class Crosshair extends Sprite
	{
		/*
		private var gunCrosshair:Sprite;
		private var gunDot:DotCrosshair;
		private var gunCircle:CircleCrosshair;
		private var gunCross:CrossCrosshair;
		*/
		
		public var gun:CrosshairState;
		public var melee:CrosshairState;
		public var activate:CrosshairState;
		public var sight:CrosshairState;
		
		public function Crosshair(crosshairPosX:Number, crosshairPosY:Number, xcfg:CrosshairConfig) 
		{
			gun = new CrosshairState(CrosshairState.GUN_STATE, crosshairPosX, crosshairPosY, xcfg);
			gun.dot.visible = xcfg.gunHasDot;
			gun.circle.visible = xcfg.gunHasCircle;
			gun.cross.visible = xcfg.gunHasCross;
			
			melee = new CrosshairState(CrosshairState.MELEE_STATE, crosshairPosX, crosshairPosY, xcfg);
			melee.dot.visible = xcfg.meleeHasDot;
			melee.circle.visible = xcfg.meleeHasCircle;
			melee.cross.visible = xcfg.meleeHasCross;
			
			activate = new CrosshairState(CrosshairState.ACTIVATE_STATE, crosshairPosX, crosshairPosY, xcfg);
			activate.dot.visible = xcfg.activateHasDot;
			activate.circle.visible = xcfg.activateHasCircle;
			activate.cross.visible = xcfg.activateHasCross;
			
			sight = new CrosshairState(CrosshairState.SIGHT_STATE, crosshairPosX, crosshairPosY, xcfg);
			sight.dot.visible = xcfg.sightHasDot;
			sight.circle.visible = xcfg.sightHasCircle;
			sight.cross.visible = xcfg.sightHasCross;
			
			addChild(gun);
			addChild(melee);
			addChild(activate);
			addChild(sight);
			visible = true;
		}
		
		public function setGunCrosshairVisible():void
		{
			gun.visible = true;
			melee.visible = false;
			activate.visible = false;
			sight.visible = false;
		}
		
		public function setMeleeCrosshairVisible():void
		{
			gun.visible = false;
			melee.visible = true;
			activate.visible = false;
			sight.visible = false;
		}
		
		public function setActivateCrosshairVisible():void
		{
			gun.visible = false;
			melee.visible = false;
			activate.visible = true;
			sight.visible = false;
		}
		
		public function setSightCrosshairVisible():void
		{
			gun.visible = false;
			activate.visible = false;
			melee.visible = false;
			sight.visible = true;
		}
		
		public function setCustomCrosshairHidden():void
		{
			gun.visible = false;
			activate.visible = false;
			melee.visible = false;
			sight.visible = false;
		}
		
	}

}