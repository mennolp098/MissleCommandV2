package game 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class LoseMenu extends Sprite
	{
		public static const RETRYGAME		:	String	=	"retrygame";
		public static const BACKTOMENU		:	String	=	"backtomenu";
		
		private var _loseMenuBackground:losemenu;
		private var _backToMenuButton:BackButton;
		private var _retryGameButton:RetryButton;

		public function LoseMenu() 
		{
			_loseMenuBackground = new losemenu();
			_backToMenuButton = new BackButton();
			_retryGameButton = new RetryButton();
			
			addChild(_loseMenuBackground);
			addChild(_backToMenuButton);
			addChild(_retryGameButton);
			
			_loseMenuBackground.x = 800 / 2;
			_loseMenuBackground.y = 600 / 2;
			_backToMenuButton.x = _loseMenuBackground.x - 100;
			_backToMenuButton.y = _loseMenuBackground.y + 50;
			_retryGameButton.x = _backToMenuButton.x + 125;
			_retryGameButton.y = _backToMenuButton.y - 5;
			
			var buttonsHolder:MovieClip = new MovieClip();
			addChild(buttonsHolder);
			buttonsHolder.addChild(_retryGameButton);
			buttonsHolder.addChild(_backToMenuButton);
			buttonsHolder.addEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(e:MouseEvent):void
		{
			if (e.target == _retryGameButton)
			{
				dispatchEvent(new Event(RETRYGAME,true));
			}
			if (e.target == _backToMenuButton)
			{
				dispatchEvent(new Event(BACKTOMENU,true));
			}
		}
	}
}