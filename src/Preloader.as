package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class Preloader extends MovieClip 
	{
		private var _loadingBar:loadingBar;
		private var _loadingText:TextField;
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			_loadingText = new TextField();
			addChild(_loadingText);
			_loadingText.x = 400;
			_loadingText.y = 300;
			
			_loadingBar = new loadingBar();
			addChild(_loadingBar);
			_loadingBar.x = 400;
			_loadingBar.y = 300;
			
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			var total:Number = e.bytesTotal;
			var loaded:Number = e.bytesLoaded;
			
			_loadingBar.scaleX = loaded/total;
			_loadingText.text = Math.floor((loaded/total)*100)+ "%";
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			_loadingBar.visible = false;
			_loadingText.visible = false;
			
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}