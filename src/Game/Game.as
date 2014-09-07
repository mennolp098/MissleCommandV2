package Game 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import Objects.PlayerMissile;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class Game extends MovieClip
	{
		private var playerMissiles:Array;
		private var closestDist:Number;
		
		public function Game() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			playerMissiles = [];
			
			for (var i:int = 0; i < 30; i++) 
			{
				var randomX:Number = Math.random() * 500 + 100;
				var newMissile:PlayerMissile = new PlayerMissile();
				addChild(newMissile);
				newMissile.x = randomX;
				newMissile.y = 500;
				playerMissiles.push(newMissile);
			}
			addEventListener(Event.ENTER_FRAME, Loop);
			stage.addEventListener(MouseEvent.CLICK, MouseClicked);
		}
		private function Loop(e:Event):void {
			for( var i:int = playerMissiles.length - 1; i >= 0; i-- )
			{
				playerMissiles[i].Update();
				if (playerMissiles[i].removeable == true) 
				{
					removeChild(playerMissiles[i]);
					playerMissiles.splice(i, 1);
				}
			}
		}
		private function MouseClicked(e:MouseEvent):void 
		{
			if (playerMissiles.length > 0) 
			{
				var closestMissile:PlayerMissile = playerMissiles[0];
				
				var l:int = playerMissiles.length;
				for (var i:int = 0; i < l; i++) 
				{
					if (!playerMissiles[i].active)
					{
						var mousePoint:Point = new Point(e.stageX, e.stageY);
						var elementPoint:Point = new Point(playerMissiles[i].x,playerMissiles[i].y);
						var dist:Number = Point.distance(mousePoint, elementPoint);
						if (i == 0 || dist < closestDist) 
						{
							closestDist = dist;
							closestMissile = playerMissiles[i];
						}
					}
				}
				if (!closestMissile.active)
				{
					closestMissile.movePoint.x = e.stageX;
					closestMissile.movePoint.y = e.stageY;
					closestMissile.active = true;
				}
			}
		}
	}
}