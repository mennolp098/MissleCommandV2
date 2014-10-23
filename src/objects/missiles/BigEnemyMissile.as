package objects.missiles 
{
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class BigEnemyMissile extends Missile
	{
		
		public function BigEnemyMissile() 
		{
			movieClip = new BigMissileArt();
			super();
			this.scaleX = 0.35;
			this.scaleY = 0.35;
			speed = 2;
			score = 5;
		}
		
	}

}