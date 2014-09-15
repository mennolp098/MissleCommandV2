package objects 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class City extends Sprite
	{
		private var _city:Town;
		public var removeable:Boolean;
		public function City() 
		{
			_city = new Town();
			addChild(_city);
			removeable = false;
		}
	}
}