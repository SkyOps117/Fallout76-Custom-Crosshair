package figures 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Bolbman
	 */
	public class Circle extends Sprite
	{
		public var radius:int;
		public var color:uint;
		
		public function Circle(_x:Number, _y:Number, _radius:int, _color:uint):void
		{
			radius = _radius;
			color = _color;
			draw(_x, _y);
			visible = true;
		}
		
		private function draw(_x:Number, _y:Number):void 
		{
			graphics.clear();
			graphics.beginFill(color, 1);
			graphics.drawCircle(_x, _y, radius);
			graphics.endFill();
		}
		
		public function setRadius(_radius:int):void
		{
			radius = _radius;
			draw(x, y);
		}
		
		public function setColor(_color:uint):void
		{
			color = _color;
			draw(x, y);
		}
	}

}