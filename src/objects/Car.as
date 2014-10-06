package objects 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class Car extends Car01
	{
		private var speed:Number = 3;
		public var removeable:Boolean;
		public function Car():void
		{
			this.scaleX = 0.1;
			this.scaleY = 0.1;
			var random:int = Math.random() * 3;
			if (random == 2)
			{
				random = -1;
			}
			this.scaleX = this.scaleX * random;
			speed = speed * random;
		}
		public function Update():void
		{
			this.x += speed;
			if (this.x > 798 || this.x < 2)
			{
				speed = speed * -1;
				this.scaleX = this.scaleX * -1;
			}
		}
	}
}