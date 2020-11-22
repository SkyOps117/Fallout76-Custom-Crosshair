package figures 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Bolbman
	 */
	public class Circle extends Sprite
	{
		private var radius:int;
		private var color:uint;
		
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
			//graphics.lineStyle(1, 0x1a1a1a, 1, true, "normal", null, null, 3);
			graphics.beginFill(color, 1);
			graphics.drawCircle(_x, _y, radius);
			graphics.endFill();
		}
		
		public function setColor(_color:uint):void
		{
			color = _color;
			draw(x, y);
		}
		
		public function setRadius(_radius:int):void
		{
			radius = _radius;
			draw(x, y);
		}
		

	}

}