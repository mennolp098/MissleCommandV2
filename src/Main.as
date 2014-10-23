package 
{
	import adobe.utils.CustomActions;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.SharedObject;
	import game.Game;
	import flash.display.StageDisplayState;
	import game.LoseMenu;
	
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		private var _game:Game;
		private var _menu:Menu;
		private var _highScore:int;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var highScore:SharedObject = SharedObject.getLocal("highScore");
			if (highScore.data.score == null)
			{
				highScore.data.score = 0;
				highScore.flush();
			}
			_highScore = highScore.data.score;
			_menu = new Menu(_highScore);
			_game = new Game();
			addChild(_menu);
			addChild(_game);
			_game.visible = false;
			_menu.addEventListener(Menu.STARTGAME, startGame);
			addEventListener(LoseMenu.BACKTOMENU, showMenu);
			addEventListener(LoseMenu.RETRYGAME, retryGame);
		}
		private function startGame(e:Event):void
		{
			if (!_game.stage)
			{
				addChild(_game);
			}
			_game.visible = true;
			_menu.visible = false;
		}
		public function showMenu(e:Event):void
		{
			removeChild(_game);
			_menu.visible = true;
			_menu.updateHighScore();
		}
		public function retryGame(e:Event):void
		{
			removeChild(_game);
			addChild(_game);
		}
	}
}