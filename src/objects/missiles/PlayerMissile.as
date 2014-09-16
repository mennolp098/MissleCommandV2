package objects.missiles 
{
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class PlayerMissile extends Missile
	{
		public function PlayerMissile() 
		{
			movieClip = new MissileArt();
			super();
		}
	}
}