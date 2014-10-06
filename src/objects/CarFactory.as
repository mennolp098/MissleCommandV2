package objects 
{
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class CarFactory 
	{
		
		public function createCars(amount:int, targetContainer:DisplayObjectContainer):Array
		{
			var carArray:Array = [];
			for (var i:int = 0; i < amount; i++) 
			{
				var car:Car = new Car();
				targetContainer.addChild(car);
				car.x = Math.random() * 500 + 30;
				car.y = Math.random() * 30 + 510;
				carArray.push(car);
			}
			return carArray;
		}
		
	}

}