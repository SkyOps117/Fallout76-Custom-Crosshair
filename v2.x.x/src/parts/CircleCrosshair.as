package parts 
{
	import flash.display.Sprite;
	import figures.HollowCircle;
	/**
	 * ...
	 * @author Bolbman
	 */
	public class CircleCrosshair extends Sprite
	{
		public var hollowCircle:HollowCircle;
		
		public function CircleCrosshair(_x:Number, _y:Number, _radius:int, _thickness:int, _color:uint) 
		{
			hollowCircle = new HollowCircle(_x, _y, _radius, _thickness, _color);
			addChild(hollowCircle);
			visible = true;
		}
		
		public function setColor(_color:uint):void
		{
			hollowCircle.setColor(_color);
		}
		
		public function setRadius(_size:int):void
		{
			hollowCircle.setRadius(_size);
		}
		
		
	}

}