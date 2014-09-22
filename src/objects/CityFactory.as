package objects 
{
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class CityFactory 
	{
		
		public function createCitys(amount:int, targetContainer:DisplayObjectContainer):Array
		{
			var cityArray:Array = [];
			for (var i:int = 0; i < amount; i++) 
			{
				var city:City = new City();
				targetContainer.addChild(city);
				city.x = 200 * i + 100;
				city.y = 500;
				cityArray.push(city);
			}
			return cityArray;
		}
	}
}