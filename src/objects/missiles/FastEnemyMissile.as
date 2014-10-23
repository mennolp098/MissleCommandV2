package objects.missiles 
{
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class FastEnemyMissile extends Missile
	{
		
		public function FastEnemyMissile() 
		{
			movieClip = new FastMissileArt();
			super();
			speed = 4;
			score = 25;
		}
		
	}

}