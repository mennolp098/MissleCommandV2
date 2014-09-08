package objects 
{
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class EnemyMissile extends Missile
	{
		
		public function EnemyMissile() 
		{
			movieClip = new MissileArt();
			super();
			speed = 3;
		}
		
	}

}