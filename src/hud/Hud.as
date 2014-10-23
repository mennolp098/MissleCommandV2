package hud 
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class Hud extends Sprite
	{
		private var _hudBackground:HudBackGroundArt;
		private var _waveText:TextField;
		private var _scoreText:TextField;
		public function Hud() 
		{
			var tf:TextFormat;
			var gf:GlowFilter;
			tf = new TextFormat("Hobo Std", 24, 0xFF0000, true);
			gf = new GlowFilter(0x000000, 1.0, 2.0, 2.0, 10);
			_hudBackground = new HudBackGroundArt();
			addChild(_hudBackground);
			_hudBackground.scaleX = 2;
			
			_waveText = new TextField();
			_scoreText = new TextField();
			
			addChild(_waveText);
			_waveText.x = 2;
			_waveText.y = 10;
			_waveText.width = _waveText.textWidth + 900;
			
			addChild(_scoreText);
			_scoreText.x = 2;
			_scoreText.y = 75;
			_scoreText.width = _scoreText.textWidth + 900;
			
			_waveText.defaultTextFormat = tf;
			_waveText.setTextFormat(tf);
			_waveText.filters = [(gf)];
			_waveText.selectable = false;
			
			_scoreText.defaultTextFormat = tf;
			_scoreText.setTextFormat(tf);
			_scoreText.filters = [(gf)];
			_scoreText.selectable = false;
			
			_waveText.text = "Wave: 1";
			_scoreText.text = "Score: 0";
		}
		public function updateText(wave:int,score:int):void
		{
			_waveText.text = "Wave: " + wave;
			_scoreText.text = "Score: " + score;
		}
	}
}