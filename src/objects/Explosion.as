package objects 
{
	import flash.display.MovieClip;
	import game.Game;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class Explosion extends MovieClip
	{
		public var removeable:Boolean = false;
		private var explosion:ExplosionAnim;
		public function Explosion() 
		{
			explosion = new ExplosionAnim();
			addChild(explosion);
		}
		public function Update():void
		{
			if (explosion.currentFrame >= 30)
			{
				removeable = true;
			}
		}
	}
}