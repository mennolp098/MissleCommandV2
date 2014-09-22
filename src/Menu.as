package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class Menu extends Sprite 
	{
		private var _myMenuBackground:MenuBackground;
		private var _myStartButton:PlayButton;
		
		public static const STARTGAME		:	String	=	"startgame";
		
		public function Menu():void
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_myMenuBackground = new MenuBackground();
			addChild(_myMenuBackground);
			_myMenuBackground.x = 400;
			_myMenuBackground.y = 300;
			_myMenuBackground.scaleX = 2;
			_myMenuBackground.scaleY = 2;
			
			_myStartButton = new PlayButton();
			_myStartButton.x = 400;
			_myStartButton.y = 300;
			addChild(_myStartButton);
			
			var buttonsHolder:MovieClip = new MovieClip();
			addChild(buttonsHolder);
			buttonsHolder.addChild(_myStartButton);
			buttonsHolder.addEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(e:MouseEvent):void 
		{
			if (e.target == _myStartButton)
			{
				dispatchEvent(new Event(STARTGAME));
			}
		}
	}
}