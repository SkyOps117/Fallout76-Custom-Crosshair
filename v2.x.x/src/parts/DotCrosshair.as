package parts 
{
	import flash.display.Sprite;
	import figures.Circle;
	import figures.Rectangle;
	/**
	 * ...
	 * @author Bolbman
	 */
	public class DotCrosshair extends Sprite
	{
		public var type:String;
		public var rect:Rectangle;
		public var circle:Circle;
		
		public function DotCrosshair(_x:Number, _y:Number, _size:int, _color:uint):void
		{
			circle = new Circle(_x, _y, _size, _color);
			addChild(circle);
			visible = true;
		}
		
		public function setSize(_size:int):void
		{
			circle.setRadius(_size);
		}
		
		public function getColor():uint
		{
			return circle.color;
		}
		
	}

}