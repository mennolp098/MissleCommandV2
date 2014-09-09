package game 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import objects.EnemyMissile;
	import objects.Explosion;
	import objects.PlayerMissile;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class Game extends Sprite
	{
		private var _allObjects:Array;
		private var _playerMissiles:Array;
		private var _enemyMissiles:Array;
		private var _closestDist:Number;
		private var _explosions:Array;
		
		public static var instance:Game;
		
		public function Game() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			//make the gamestage as instance so you can add in via child classes
			instance = this;
			
			_playerMissiles = [];
			_enemyMissiles = [];
			_explosions = [];
			
			_allObjects = [_playerMissiles, _enemyMissiles, _explosions];
			
			//create missles.
			for (var i:int = 0; i < 45; i++) 
			{
				var randomX:Number = Math.random() * 500 + 100,
					newMissile:PlayerMissile = new PlayerMissile();
					
				addChild(newMissile);
				newMissile.x = randomX;
				newMissile.y = 550;
				_playerMissiles.push(newMissile);
			}
			addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(MouseEvent.CLICK, mouseClicked);
			enemyAttack(30);
		}
		private function enemyAttack(missiles:int):void
		{
			for (var i:int = 0; i < missiles; i++) 
			{
				var randomX:Number = Math.random() * 500 + 100,
					randomY:Number = Math.random() * -750 - 50,
					newMissile:EnemyMissile = new EnemyMissile();
					
				addChild(newMissile);
				newMissile.x = randomX;
				newMissile.y = randomY;
				_enemyMissiles.push(newMissile);
				if (i <= 10)
				{
					newMissile.movePoint.x = 100;
				} else if ( i <= 20)
				{
					newMissile.movePoint.x = 300;
				} else {
					newMissile.movePoint.x = 500;
				}
				newMissile.movePoint.y = 500;
				newMissile.active = true;
			}
		}
		private function loop(e:Event):void 
		{
			checkArray(_playerMissiles, true);
			checkArray(_enemyMissiles, true);
			checkArray(_explosions, false);
		}
		private function checkArray(currentArray:Array,isMissile:Boolean):void
		{
			var arrayLength:int = currentArray.length;
			var explosionLength:int = _explosions.length;
			for( var i:int = arrayLength - 1; i >= 0; i-- )
			{
				currentArray[i].Update();
				if (isMissile)
				{
					for (var j:int = 0; j < explosionLength; j++) 
					{
						if (_explosions[j].hitTestObject(currentArray[i]))
						{
							currentArray[i].removeable = true;
						}
					}
				}
				if (currentArray[i].removeable) 
				{
					if (isMissile)
					{
						createExplosion(currentArray[i].x, currentArray[i].y);
					}
					
					removeChild(currentArray[i]);
					currentArray.splice(i, 1);
				}
			}
		}
		private function createExplosion(x:int, y:int):void
		{
			var explosion:Explosion;
			
			explosion = new Explosion();
			addChild(explosion);
			explosion.x = x;
			explosion.y = y;
			_explosions.push(explosion);
		}
		private function mouseClicked(e:MouseEvent):void 
		{
			var closestMissile:PlayerMissile,
				l:uint,
				mousePoint:Point,
				elementPoint:Point,
				dist:Number;
			
			if (_playerMissiles.length > 0) 
			{
				closestMissile = _playerMissiles[0];
				l = _playerMissiles.length;
				
				for (var i:int = 0; i < l; i++) 
				{
					if (!_playerMissiles[i].active)
					{
						mousePoint = new Point(e.stageX, e.stageY);
						elementPoint = new Point(_playerMissiles[i].x,_playerMissiles[i].y);
						dist = Point.distance(mousePoint, elementPoint);
						
						if (i == 0 || dist < _closestDist) 
						{
							_closestDist = dist;
							closestMissile = _playerMissiles[i];
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