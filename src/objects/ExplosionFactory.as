package objects 
{
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class ExplosionFactory 
	{
		//create a explosion on the x and y
		public function createExplosion(x:int, y:int, explosionArray:Array, targetContainer:DisplayObjectContainer):void
		{
			var explosion:Explosion;
			
			explosion = new Explosion();
			targetContainer.addChild(explosion);
			explosion.x = x;
			explosion.y = y;
			explosionArray.push(explosion);
		}
	}
}