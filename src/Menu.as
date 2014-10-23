package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class Menu extends Sprite 
	{
		public static const STARTGAME		:	String	=	"startgame";
		
		private var _myMenuBackground:MenuBackground;
		private var _myStartButton:PlayButton;
		private var _myFullScreenButton:FullScreenButton;
		private var _highScore:int;
		private var _highScoreText:TextField;
		
		public function Menu(highscore:int):void
		{
			_highScore = highscore;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			
			var tf:TextFormat;
			var gf:GlowFilter;
			tf = new TextFormat("Hobo Std", 24, 0xFF0000, true);
			gf = new GlowFilter(0x000000, 1.0, 2.0, 2.0, 10);
			
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
			
			_myFullScreenButton = new FullScreenButton();
			_myFullScreenButton.x = _myStartButton.x - _myFullScreenButton.width/2;
			_myFullScreenButton.y = _myStartButton.y + 100;
			addChild(_myFullScreenButton);
			
			_highScoreText = new TextField();
			_highScoreText.text = "HighScore: " + _highScore;
			_highScoreText.width = _highScoreText.textWidth + 900;
			_highScoreText.x = 300;
			_highScoreText.y = 150;
			
			_highScoreText.defaultTextFormat = tf;
			_highScoreText.setTextFormat(tf);
			_highScoreText.filters = [(gf)];
			_highScoreText.selectable = false;
			
			var buttonsHolder:MovieClip = new MovieClip();
			addChild(buttonsHolder);
			buttonsHolder.addChild(_myStartButton);
			buttonsHolder.addChild(_myFullScreenButton);
			buttonsHolder.addEventListener(MouseEvent.CLICK, onClick);
			
			addChild(_highScoreText);
		}
		private function onClick(e:MouseEvent):void 
		{
			if (e.target == _myStartButton)
			{
				dispatchEvent(new Event(STARTGAME));
			}
			if (e.target == _myFullScreenButton)
			{
				if (stage.displayState == StageDisplayState.FULL_SCREEN) {
					stage.displayState = StageDisplayState.NORMAL; 
				} else {
					stage.displayState = StageDisplayState.FULL_SCREEN;
				}
			}
		}
		public function updateHighScore():void
		{
			var highScore:SharedObject = SharedObject.getLocal("highScore");
			_highScore = highScore.data.score;
			_highScoreText.text = "HighScore: " + _highScore;
		}
	}
}