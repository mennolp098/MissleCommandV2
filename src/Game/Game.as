package game 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import objects.City;
	import objects.EnemyMissile;
	import objects.Explosion;
	import objects.Missile;
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
		private var _citys:Array;
		
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
			_citys = [];
			
			_allObjects = [_playerMissiles, _enemyMissiles, _explosions, _citys];
			
			addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(MouseEvent.CLICK, mouseClicked);
			createMissiles(30, EnemyMissile, _enemyMissiles);
			createMissiles(45, PlayerMissile, _playerMissiles);
			createCitys(4);
		}
		private function createCitys(citys:int):void
		{
			for (var i:int = 0; i < citys; i++) 
			{
				var city:City = new City();
				addChild(city);
				city.x = 200 * i + 100;
				city.y = 500;
				_citys.push(city);
			}
		}
		//function to create missiles.
		private function createMissiles(missiles:int,MissileClass:Class,missileArray:Array):void
		{
			for (var i:int = 0; i < missiles; i++) 
			{
				var randomX:Number = Math.random() * 500 + 100,
					randomY:Number = Math.random() * -2000 - 50,
					newMissile:Missile = new MissileClass();
					
				addChild(newMissile);
				newMissile.x = randomX;
				newMissile.y = randomY;
				missileArray.push(newMissile);
				if (missileArray == _enemyMissiles)
				{
					var random:uint = Math.random() * 6;
					switch(random) {
						case 0:
							newMissile.movePoint.x = 100;
							break;
						case 1:
							newMissile.movePoint.x = 300;
							break;
						case 2:
							newMissile.movePoint.x = 225;
							break;
						case 3:
							newMissile.movePoint.x = 500;
							break;
						case 4:
							newMissile.movePoint.x = 375;
							break;
						case 5:
							newMissile.movePoint.x = 700;
							break;
						default:
							newMissile.movePoint.x = 100;
							break;
					}
					newMissile.movePoint.y = 500;
					newMissile.active = true;
				} else {
					if (i <= 15)
					{
						newMissile.x = 175 + 5*i;
					} else if ( i <= 30)
					{
						newMissile.x = 275 + 5*i;
					} else {
						newMissile.x = 375 + 5*i;
					}
					newMissile.y = 550;
				}
			}
		}
		private function loop(e:Event):void 
		{
			checkArray(_playerMissiles, true, true);
			checkArray(_enemyMissiles, true, true);
			checkArray(_explosions, false, false);
			checkArray(_citys, false, true);
		}
		//check arrays for hittest etc.
		private function checkArray(currentArray:Array,explodeAble:Boolean,hitAble:Boolean):void
		{
			var arrayLength:int = currentArray.length;
			var explosionLength:int = _explosions.length;
			for( var i:int = arrayLength - 1; i >= 0; i-- )
			{
				if (currentArray != _citys)
				{
					currentArray[i].Update();
				}
				if (hitAble)
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
					if (explodeAble)
					{
						createExplosion(currentArray[i].x, currentArray[i].y);
					}
					removeChild(currentArray[i]);
					currentArray.splice(i, 1);
				}
			}
		}
		//create a explosion on the x and y
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
			var closestMissile:PlayerMissile;
			closestMissile = getClosestMissile(e.stageX,e.stageY);
			if (_playerMissiles.length > 0) 
			{
				if (!closestMissile.active)
				{
					closestMissile.movePoint.x = e.stageX;
					closestMissile.movePoint.y = e.stageY;
					closestMissile.active = true;
				}
			}
		}
		//return the closest missile
		private function getClosestMissile(x:Number,y:Number):PlayerMissile
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
						mousePoint = new Point(x, y);
						elementPoint = new Point(_playerMissiles[i].x,_playerMissiles[i].y);
						dist = Point.distance(mousePoint, elementPoint);
						
						if (i == 0 || dist < _closestDist) 
						{
							_closestDist = dist;
							closestMissile = _playerMissiles[i];
						}
					}
				}
			}
			return closestMissile;
		}
	}
}