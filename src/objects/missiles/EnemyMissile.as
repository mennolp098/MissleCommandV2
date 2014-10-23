package objects.missiles 
{
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class EnemyMissile extends Missile
	{
		
		public function EnemyMissile() 
		{
			movieClip = new EnemyMissileArt();
			super();
			speed = 3;
			score = 10;
		}
	}
}