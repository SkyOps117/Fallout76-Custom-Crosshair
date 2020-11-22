package parts 
{
	import figures.Rectangle;
	import flash.display.Sprite;
	/**
	 * 
	 * @author Bolbman
	 */
	public class CrossCrosshair extends Sprite
	{
		public var gap:int;
		public var length:int;
		public var thickness:int;
		public var tickLeft:Rectangle;
		public var tickRight:Rectangle;
		public var tickUp:Rectangle;
		public var tickDown:Rectangle;
		
		public function CrossCrosshair(_x:Number, _y:Number, _gap:int, _length:int, _thickness:int, _color:uint):void
		{
			gap = _gap;
			length = _length;
			thickness = _thickness;
			tickLeft = new Rectangle(_x - (gap / 2) - length, _y - (thickness / 2), length, thickness, _color);
			tickRight = new Rectangle(_x + (gap / 2), _y - (thickness / 2), length, thickness, _color);
			tickUp = new Rectangle(_x - (thickness / 2), _y - (gap / 2) - length, thickness, length, _color);
			tickDown = new Rectangle(_x - (thickness / 2), _y + (gap / 2), thickness, length, _color);
			
			addChild(tickLeft);
			addChild(tickRight);
			addChild(tickUp);
			addChild(tickDown);
			visible = true;
		}
		
		public function setColor(_color:uint):void
		{
			tickLeft.setColor(_color);
			tickRight.setColor(_color);
			tickUp.setColor(_color);
			tickDown.setColor(_color);
		}
		
	}

}