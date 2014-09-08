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
			
			instance = this;
			_playerMissiles = [];
			_enemyMissiles = [];
			_explosions = [];
			
			_allObjects = [_playerMissiles, _enemyMissiles, _explosions];
			
			
			for (var i:int = 0; i < 45; i++) 
			{
				var randomX:Number = Math.random() * 500 + 100;
				var newMissile:PlayerMissile = new PlayerMissile();
				addChild(newMissile);
				newMissile.x = randomX;
				newMissile.y = 550;
				_playerMissiles.push(newMissile);
			}
			addEventListener(Event.ENTER_FRAME, Loop);
			stage.addEventListener(MouseEvent.CLICK, MouseClicked);
			enemyAttack();
		}
		private function enemyAttack():void
		{
			for (var i:int = 0; i < 30; i++) 
			{
				var randomX:Number = Math.random() * 500 + 100;
				var randomY:Number = Math.random() * -300 - 50;
				var newMissile:EnemyMissile = new EnemyMissile();
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
		private function Loop(e:Event):void 
		{
			for( var i:int = _playerMissiles.length - 1; i >= 0; i-- )
			{
				_playerMissiles[i].Update();
				if (_playerMissiles[i].removeable) 
				{
					var explosion:Explosion;
					explosion = new Explosion();
					addChild(explosion);
					explosion.x = _playerMissiles[i].x;
					explosion.y = _playerMissiles[i].y;
					_explosions.push(explosion);
					
					removeChild(_playerMissiles[i]);
					_playerMissiles.splice(i, 1);
				}
				for (var k:int = _explosions.length - 1; k >= 0; k--) 
				{
					if (_explosions[k].hitTestObject(_playerMissiles[i]))
					{
						_playerMissiles[i].removeable = true;
					}
				}
			}
			for( var l:int = _enemyMissiles.length - 1; l >= 0; l-- )
			{
				_enemyMissiles[l].Update();
				if (_enemyMissiles[l].removeable) 
				{
					var explosion:Explosion;
					explosion = new Explosion();
					addChild(explosion);
					explosion.x = _enemyMissiles[l].x;
					explosion.y = _enemyMissiles[l].y;
					_explosions.push(explosion);
					
					removeChild(_enemyMissiles[l]);
					_enemyMissiles.splice(l, 1);
				}
				for (var z:int = _explosions.length - 1; z >= 0; z--) 
				{
					if (_explosions[z].hitTestObject(_enemyMissiles[l]))
					{
						_enemyMissiles[l].removeable = true;
					}
				}
			}
			for( var j:int = _explosions.length - 1; j >= 0; j-- )
			{
				_explosions[j].Update();
				if (_explosions[j].removeable)
				{
					removeChild(_explosions[j]);
					_explosions.splice(j, 1);
				}
			}
		}
		private function MouseClicked(e:MouseEvent):void 
		{
			if (_playerMissiles.length > 0) 
			{
				var closestMissile:PlayerMissile = _playerMissiles[0];
				
				var l:int = _playerMissiles.length;
				for (var i:int = 0; i < l; i++) 
				{
					if (!_playerMissiles[i].active)
					{
						var mousePoint:Point = new Point(e.stageX, e.stageY);
						var elementPoint:Point = new Point(_playerMissiles[i].x,_playerMissiles[i].y);
						var dist:Number = Point.distance(mousePoint, elementPoint);
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