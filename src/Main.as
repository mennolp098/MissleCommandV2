package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.Game;
	
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class Main extends Sprite 
	{
		private var _game:Game;
		private var _menu:Menu;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_menu = new Menu();
			addChild(_menu);
			_menu.addEventListener(Menu.STARTGAME, startGame);
		}
		private function startGame(e:Event):void
		{
			_game = new Game();
			addChild(_game);
			removeChild(_menu);
		}
	}
}