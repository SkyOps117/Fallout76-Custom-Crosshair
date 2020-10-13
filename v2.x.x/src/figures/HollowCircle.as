package figures 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Bolbman
	 */
	public class HollowCircle extends Sprite
	{
		public var radius:int;
		public var thickness:int;
		public var color:uint;
		
		public function HollowCircle(_x:Number, _y:Number, _radius:int, _thickness:int, _color:uint):void
		{
			radius = _radius;
			thickness = _thickness;
			color = _color;
			draw(_x, _y);
			visible = true;
		}
		
		private function draw(_x:Number, _y:Number):void
		{
			graphics.clear();
			graphics.lineStyle(thickness, color, 1, false, "normal", null, null, 3);
			graphics.drawCircle(_x, _y, radius);
			graphics.endFill();
		}
		
		public function setRadius(_radius:int):void
		{
			radius = _radius;
			draw(x, y);
		}
		
		public function setThickness(_thickness:int):void
		{
			thickness = _thickness;
			draw(x, y);
		}
		
	}

}