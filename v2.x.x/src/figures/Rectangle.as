package figures 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Bolbman
	 */
	public class Rectangle extends Sprite
	{
		public var color:uint;
		
		public function Rectangle(_posX:int, _posY:int, _width:int, _height:int, _color:uint):void 
		{
			color = _color;
			draw(_posX, _posY, _width, _height, color);
			visible = true;
		}
		
		private function draw(_x:Number, _y:Number, _width:int, _heigth:int, _color:uint):void
		{
			graphics.clear();
			graphics.beginFill(_color, 1);
			graphics.drawRect(_x, _y, _width, _heigth);
			graphics.endFill();
		}
		
		public function setColor(_color:uint):void
		{
			color = _color;
			draw(x, y, width, height, color);
		}
		
		public function setSize(_size:int):void
		{
			draw(x, y, _size, _size, color);
		}
		
		public function setHeight(_height:int):void
		{
			draw(x, y, width, _height, color);
		}
		
		public function setWidth(_width:int):void
		{
			draw(x, y, _width, height, color);
		}
		
		public function centerX():Number
		{
			return x - (width / 2);
		}
		
		public function centerY():Number
		{
			return y - (height / 2);
		}
		
		public function bottom():Number
		{
			return y + width;
		}
		
	}

}