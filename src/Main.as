package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.Game;
	import ships.*;
	
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class Main extends Sprite 
	{
		private var _game:Game;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_game = new Game();
			addChild(_game);
		}
	}
}