package objects.missiles 
{
	import flash.display.DisplayObjectContainer;
	import game.Game;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class MissileFactory 
	{
		
		public static const FRIENDLY_MISSILE : String	=	"friendlyMissile";
		public static const ENEMY_MISSILE : String	=	"enemyMissile";
		
		private function makeMissile( type : String ) : Missile
		{
			// lokale variabele waar we het nieuwe missile in opslaan
			var missile : Missile;
			
			if(type == FRIENDLY_MISSILE)
			{
				missile = new PlayerMissile();
			}
			else 
			{
				missile = new EnemyMissile();
			}
			return missile;
		}
		//functie om missiles in de game instance te zetten
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
				if (missileType == ENEMY_MISSILE)
				{
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
							newMissile.movePoint.x = 375;
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
				} else {
					if (i <= 15)
					{
						newMissile.x = 175 + 5*i;
					} else if ( i <= 30)
					{
						newMissile.x = 275 + 5*i;
					} else {
						newMissile.x = 375 + 5*i;
					}
					newMissile.y = 550;
				}
			}
			return missileArray;
		}
	}

}