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
		
		private function makeMissile( type : String ) : Missile
		{
			// lokale variabele waar we het nieuwe missile in opslaan
			var missile : Missile;
			
			if(type == FRIENDLY_MISSILE)
			{
				missile = new PlayerMissile();
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
				
				if (i <= 15)
				{
					newMissile.x = 175 + 3*i;
				} else if ( i <= 30)
				{
					newMissile.x = 325 + 3*i;
				} else {
					newMissile.x = 500 + 3*i;
				}
				newMissile.y = 550;
			}
			return missileArray;
		}
	}
}