package objects 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import game.Game;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class Missile extends MovieClip
	{
		protected var movieClip:MovieClip;
		protected var speed:Number;
		
		public var movePoint:Point;
		public var removeable:Boolean;
		public var active:Boolean;
		
		public function Missile() 
		{
			movePoint = new Point(0, 0);
			
			addChild(movieClip);
			this.scaleX = 0.25;
			this.scaleY = 0.25;
			speed = 10;
		}
		public function Update():void
		{
			if (active)
			{
				var pos:Point = new Point(this.x, this.y);
				var t:Point = new Point(movePoint.x, movePoint.y);
				var v:Point = new Point(t.x - pos.x, t.y - pos.y);
				var distance:Number = Math.sqrt(v.x * v.x + v.y * v.y);
				var unitVector:Point = new Point(v.x / Math.sqrt(v.x * v.x + v.y * v.y), v.y / Math.sqrt(v.x * v.x + v.y * v.y));
				unitVector.x = unitVector.x * speed;
				unitVector.y = unitVector.y * speed;
				pos.x = pos.x + unitVector.x;
				pos.y = pos.y + unitVector.y;
				this.x = pos.x;
				this.y = pos.y;
				var dir:Number = Math.atan2(this.y-movePoint.y,this.x-movePoint.x);
				this.rotation=dir*180/Math.PI+270;
				if (distance < speed)
				{
					Explode();
				}
			}
		}
		protected function Explode():void
		{
			removeable = true;
		}
	}
}