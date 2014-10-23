package game 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.SharedObject;
	import hud.Hud;
	import objects.CarFactory;
	import objects.City;
	import objects.CityFactory;
	import objects.ExplosionFactory;
	import objects.Explosion;
	import objects.missiles.EnemyMissileFactory;
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
		private var _level:Array;
		private var _hud:Hud;
		private var _loseMenu:LoseMenu;
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
			_loseMenu = new LoseMenu();
			_hud = new Hud();
			_playerMissiles = [];
			_enemyMissiles = [];
			_explosions = [];
			_cars = [];
			_citys = [];
			_score = 0;
			_wave = 1;
			
			_allObjects = [_playerMissiles, _enemyMissiles, _explosions, _citys, _cars];
			
			addChild(_background);
			addChild(_hud);
			addChild(_loseMenu);
			
			_loseMenu.visible = false;
			
			var missileFactory:MissileFactory = new MissileFactory;
			var enemyMissileFactory:EnemyMissileFactory = new EnemyMissileFactory;
			_enemyMissiles = enemyMissileFactory.createMissiles(25, EnemyMissileFactory.NORMAL_MISSILE, this);
			_playerMissiles = missileFactory.createMissiles(45, MissileFactory.FRIENDLY_MISSILE, this);
			_cars = _carFactory.createCars(25, this);
			_citys = _cityFactory.createCitys(4, this);
			
			addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(MouseEvent.CLICK, mouseClicked);
		}
		private function loop(e:Event):void 
		{
			collisionHitTest(_cars);
			collisionHitTest(_citys);
			collisionHitTest(_playerMissiles);
			collisionHitTest(_enemyMissiles);
			
			updateArray(_playerMissiles);
			updateArray(_enemyMissiles);
			updateArray(_explosions);
			updateArray(_cars);
			
			checkRemoveAble(_explosions);
			checkRemoveAble(_cars);
			checkRemoveAble(_citys);
			
			createExplosionOnRemoveable(_playerMissiles);
			createExplosionOnRemoveable(_enemyMissiles);
		}
		//check arrays for hittest etc.
		//to do for diffirent projects: dispatch event with e.target
		private function updateArray(currentArray:Array):void
		{
			var arrayLength:int = currentArray.length;
			for( var i:int = arrayLength - 1; i >= 0; i-- )
			{
				currentArray[i].Update();
			}
		}
		private function checkRemoveAble(currentArray:Array):void
		{
			var arrayLength:int = currentArray.length;
			for( var i:int = arrayLength - 1; i >= 0; i-- )
			{
				if (currentArray[i].removeable) 
				{
					removeChild(currentArray[i]);
					currentArray.splice(i, 1);
					if (currentArray == _citys && _citys.length == 0)
					{
						loseGame();
					}
				}
			}
		}
		private function collisionHitTest(currentArray:Array):void
		{
			var arrayLength:int = currentArray.length;
			var explosionLength:int = _explosions.length;
			for( var i:int = arrayLength - 1; i >= 0; i-- )
			{
				for (var j:int = 0; j < explosionLength; j++) 
				{
					if (_explosions[j].hitTestObject(currentArray[i]))
					{
						currentArray[i].removeable = true;
					}
				}
			}
		}
		private function createExplosionOnRemoveable(currentArray:Array):void
		{
			var arrayLength:int = currentArray.length;
			for( var i:int = arrayLength - 1; i >= 0; i-- )
			{
				if (currentArray[i].removeable) 
				{
					_explosionFactory.createExplosion(currentArray[i].x, currentArray[i].y, _explosions, this);
					SoundManager.playSound(SoundManager.SOUND_EXPLOSION);
					
					if (currentArray == _enemyMissiles)
					{
						_score += currentArray[i].score;
						_hud.updateText(_wave, _score);
					}
					
					removeChild(currentArray[i]);
					currentArray.splice(i, 1);
					
					if (currentArray == _enemyMissiles && currentArray.length == 0)
					{
						nextWave();
					}
				}
			}
		}
		private function nextWave():void
		{
			var random:int = Math.random() * 3;
			_score += 100;
			_wave += 1;
			_hud.updateText(_wave, _score);
			clearPlayerMissiles();
			var missileFactory:MissileFactory = new MissileFactory;
			var enemyMissileFactory:EnemyMissileFactory = new EnemyMissileFactory;
			_playerMissiles = missileFactory.createMissiles(45, MissileFactory.FRIENDLY_MISSILE, this);
			if (_wave == 1)
			{
				_enemyMissiles = enemyMissileFactory.createMissiles(15, EnemyMissileFactory.FAST_MISSILE, this);
			} else if(_wave == 2) {
				_enemyMissiles = enemyMissileFactory.createMissiles(35, EnemyMissileFactory.BIG_MISSILE, this);
			} else if (_wave == 3) {
				_enemyMissiles = enemyMissileFactory.createMissiles(25, EnemyMissileFactory.FAST_MISSILE, this);
			} else if (_wave == 4) {
				_enemyMissiles = enemyMissileFactory.createMissiles(35, EnemyMissileFactory.FAST_MISSILE, this);
			} else {
				switch(random)
				{
					case 0:
						_enemyMissiles = enemyMissileFactory.createMissiles(_wave * 5, EnemyMissileFactory.NORMAL_MISSILE, this);
						break;
					case 1:
						_enemyMissiles = enemyMissileFactory.createMissiles(_wave * 5, EnemyMissileFactory.BIG_MISSILE, this);
						break;
					case 2:
						_enemyMissiles = enemyMissileFactory.createMissiles(_wave * 5, EnemyMissileFactory.FAST_MISSILE, this);
						break;
					default:
						_enemyMissiles = enemyMissileFactory.createMissiles(_wave * 5, EnemyMissileFactory.NORMAL_MISSILE, this);
						break;
				}
			}
		}
		private function clearPlayerMissiles():void
		{
			var playerMissilesLength:int = _playerMissiles.length;
			for( var i:int = playerMissilesLength - 1; i >= 0; i-- )
			{
				removeChild(_playerMissiles[i]);
				_playerMissiles.splice(i, 1);
			}
		}
		private function mouseClicked(e:MouseEvent):void 
		{
			_missileManager.fireMissile(e.stageX, e.stageY, _playerMissiles);
		}
		private function loseGame():void
		{
			var highScore:SharedObject = SharedObject.getLocal("highScore");
			if (_score > highScore.data.score)
			{
				highScore.data.score = _score;
				highScore.flush();
			}
			_soundManager.stopBackgroundMusic();
			removeEventListener(Event.ENTER_FRAME, loop);
			stage.removeEventListener(MouseEvent.CLICK, mouseClicked);
			_loseMenu.visible = true;
		}
	}
}