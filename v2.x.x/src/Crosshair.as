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
		public static var gunIndex:int = 0;
		public static var meleeIndex:int = 1;
		public static var activateIndex:int = 2;
		public static var sightIndex:int = 3;
		
		public var currentIndex:int = 1;
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
		
		public function setColor(_color:uint):void
		{
			if (currentIndex == gunIndex)
			{
				gun.setColor(_color);
			}
			else if (currentIndex == meleeIndex)
			{
				melee.setColor(_color);
			}
			else if (currentIndex == activateIndex)
			{
				activate.setColor(_color);
			}
			else if (currentIndex == sightIndex)
			{
				sight.setColor(_color);
			}
		}
		
		
		public function setGunCrosshairVisible():void
		{
			gun.visible = true;
			melee.visible = false;
			activate.visible = false;
			sight.visible = false;
			currentIndex = gunIndex;
		}
		
		public function setMeleeCrosshairVisible():void
		{
			gun.visible = false;
			melee.visible = true;
			activate.visible = false;
			sight.visible = false;
			currentIndex = meleeIndex;
		}
		
		public function setActivateCrosshairVisible():void
		{
			gun.visible = false;
			melee.visible = false;
			activate.visible = true;
			sight.visible = false;
			currentIndex = activateIndex;
		}
		
		public function setSightCrosshairVisible():void
		{
			gun.visible = false;
			activate.visible = false;
			melee.visible = false;
			sight.visible = true;
			currentIndex = sightIndex;
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