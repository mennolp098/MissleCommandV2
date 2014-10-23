package objects.missiles 
{
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class EnemyMissileFactory 
	{
		public static const NORMAL_MISSILE : String	=	"normalMissile";
		public static const FAST_MISSILE   : String	=	"fastMissile";
		public static const BIG_MISSILE    : String	=	"bigMissile";
		
		private function makeMissile( type : String ) : Missile
		{
			// lokale variabele waar we het nieuwe missile in opslaan
			var missile : Missile;
			
			if(type == NORMAL_MISSILE)
			{
				missile = new EnemyMissile();
			} else if (type == FAST_MISSILE)
			{
				missile = new FastEnemyMissile();
			} else if (type == BIG_MISSILE)
			{
				missile = new BigEnemyMissile();
			}
			return missile;
		}
		public function createMissiles(	amount:int, missileType:String, targetContainer:DisplayObjectContainer	):Array
		{
			var missileArray:Array = [];
			for (var i:int = 0; i < amount; i++) 
			{
				var randomX:Number = Math.random() * 500 + 100,
					randomY:Number = Math.random() * -2000 - 50,
					newMissile:Missile = makeMissile(missileType);
					
				targetContainer.addChild(newMissile);
				newMissile.x = randomX;
				newMissile.y = randomY;
				missileArray.push(newMissile);
				var random:uint = Math.random() * 6;
				switch(random) {
					case 0:
						newMissile.movePoint.x = 100;
						break;
					case 1:
						newMissile.movePoint.x = 300;
						break;
					case 2:
						newMissile.movePoint.x = 225;
						break;
					case 3:
						newMissile.movePoint.x = 500;
						break;
					case 4:
						newMissile.movePoint.x = 425;
						break;
					case 5:
						newMissile.movePoint.x = 700;
						break;
					default:
						newMissile.movePoint.x = 100;
						break;
				}
				newMissile.movePoint.y = 500;
				newMissile.active = true;
			}
			return missileArray;
		}
	}

}