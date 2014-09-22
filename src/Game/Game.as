package game 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import objects.City;
	import objects.CityFactory;
	import objects.missiles.EnemyMissile;
	import objects.Explosion;
	import objects.missiles.Missile;
	import objects.missiles.MissileManager;
	import objects.missiles.PlayerMissile;
	import objects.missiles.MissileFactory;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class Game extends Sprite
	{
		private var _allObjects:Array;
		private var _playerMissiles:Array;
		private var _enemyMissiles:Array;
		private var _explosions:Array;
		private var _citys:Array;
		private var _background:Background;
		
		public function Game() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			var missileFactory:MissileFactory = new MissileFactory();
			var cityFactory:CityFactory = new CityFactory();
			
			_background = new Background();
			_playerMissiles = [];
			_enemyMissiles = [];
			_explosions = [];
			_citys = [];
			
			_allObjects = [_playerMissiles, _enemyMissiles, _explosions, _citys];
			
			addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(MouseEvent.CLICK, mouseClicked);
			
			addChild(_background);
			
			_enemyMissiles = missileFactory.createMissiles(30, MissileFactory.ENEMY_MISSILE, this);
			_playerMissiles = missileFactory.createMissiles(45, MissileFactory.FRIENDLY_MISSILE, this);
			_citys = cityFactory.createCitys(4, this);
			
		}
		private function loop(e:Event):void 
		{
			checkArray(_playerMissiles, true, true, true);
			checkArray(_enemyMissiles, true, true, true);
			checkArray(_explosions, false, false, true);
			checkArray(_citys, false, true, false);
		}
		//check arrays for hittest etc.
		private function checkArray(currentArray:Array, explodeAble:Boolean, hitAble:Boolean, updateAble:Boolean ):void
		{
			var arrayLength:int = currentArray.length;
			var explosionLength:int = _explosions.length;
			for( var i:int = arrayLength - 1; i >= 0; i-- )
			{
				if (updateAble)
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
			var missileManager:MissileManager = new MissileManager();
			missileManager.fireMissile(e.stageX, e.stageY, _playerMissiles);
		}
	}
}