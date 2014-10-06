package objects.missiles 
{
	import flash.geom.Point;
	import game.SoundManager;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class MissileManager 
	{
		public function fireMissile(x:Number,y:Number, missileArray:Array):void
		{
			var closestMissile:PlayerMissile;
			closestMissile = getClosestMissile(x, y, missileArray);
			if (closestMissile != null)
			{
				if (missileArray.length > 0 && !closestMissile.active) 
				{
					closestMissile.movePoint.x = x;
					closestMissile.movePoint.y = y;
					closestMissile.active = true;
					SoundManager.playSound(SoundManager.SOUND_MISSILE);
				}
			}
		}
		
		//return the closest missile
		private function getClosestMissile(x:Number,y:Number, missileArray:Array):PlayerMissile
		{
			var closestMissile:PlayerMissile,
				closestDist:Number,
				l:uint,
				mousePoint:Point,
				elementPoint:Point,
				dist:Number;
			
			if (missileArray.length > 0) 
			{
				closestMissile = missileArray[0];
				l = missileArray.length;
				for (var i:int = 0; i < l; i++) 
				{
					if (!missileArray[i].active)
					{
						mousePoint = new Point(x, y);
						elementPoint = new Point(missileArray[i].x,missileArray[i].y);
						dist = Point.distance(mousePoint, elementPoint);
						
						if (i == 0 || dist < closestDist) 
						{
							closestDist = dist;
							closestMissile = missileArray[i];
						}
					}
				}
			}
			return closestMissile;
		}
	}
}