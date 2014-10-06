package game 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import objects.CarFactory;
	import objects.City;
	import objects.CityFactory;
	import objects.ExplosionFactory;
	import objects.Explosion;
	import objects.missiles.MissileManager;
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
		private	var _cityFactory:CityFactory;
		private var _explosionFactory:ExplosionFactory;
		private var _carFactory:CarFactory;
		private var _score:Number;
		private var _wave:int;
		private var _cars:Array;
		private var _missileManager:MissileManager;
		private var _soundManager:SoundManager;
		public function Game() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			_cityFactory = new CityFactory();
			_carFactory = new CarFactory();
			_explosionFactory = new ExplosionFactory();
			_background = new Background();
			_missileManager = new MissileManager();
			_soundManager = new SoundManager();
			_playerMissiles = [];
			_enemyMissiles = [];
			_explosions = [];
			_cars = [];
			_citys = [];
			_score = 0;
			_wave = 1;
			
			_allObjects = [_playerMissiles, _enemyMissiles, _explosions, _citys, _cars];
			
			addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(MouseEvent.CLICK, mouseClicked);
			
			addChild(_background);
			
			_cars = _carFactory.createCars(25, this);
			_enemyMissiles = MissileFactory.createMissiles(30, MissileFactory.ENEMY_MISSILE, this);
			_playerMissiles = MissileFactory.createMissiles(45, MissileFactory.FRIENDLY_MISSILE, this);
			_citys = _cityFactory.createCitys(4, this);
			
		}
		private function loop(e:Event):void 
		{
			checkArray(_playerMissiles, true, true, true);
			checkArray(_enemyMissiles, true, true, true);
			checkArray(_explosions, false, false, true);
			checkArray(_citys, false, true, false);
			checkArray(_cars, false, false, true);
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
						_explosionFactory.createExplosion(currentArray[i].x, currentArray[i].y, _explosions, this);
						SoundManager.playSound(SoundManager.SOUND_EXPLOSION);
					}
					removeChild(currentArray[i]);
					currentArray.splice(i, 1);
					
					if (currentArray == _citys && _citys.length == 0)
					{
						loseGame();
					}
					if (currentArray == _enemyMissiles && currentArray.length == 0)
					{
						_score += 100;
						_wave += 1;
						_enemyMissiles = MissileFactory.createMissiles(30, MissileFactory.ENEMY_MISSILE, this);
						_playerMissiles = MissileFactory.createMissiles(45, MissileFactory.FRIENDLY_MISSILE, this);
					}
				}
			}
		}
		private function mouseClicked(e:MouseEvent):void 
		{
			_missileManager.fireMissile(e.stageX, e.stageY, _playerMissiles);
		}
		private function loseGame():void
		{
			trace("you lost");
			trace(_score);
			removeEventListener(Event.ENTER_FRAME, loop);
		}
	}
}