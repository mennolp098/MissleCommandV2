package{
	import flash.display.Sprite;

	public class EnemyShip extends Sprite {
		
		private var _shipName	:	String;
		private var _directionX	:	Number;
		private var _directionY	:	Number;
		private var _damage		:	Number;
		private var _speed		:	Number;
		private var _ability	:   String;
		
		public function followHeroShip() : void
		{
			trace(shipName + " is following the hero with a speed of " + speed);
		}
		
		public function shoot() : void
		{
			trace(shipName + " attacks and does " + damage + " damage to hero");
		}
		
		public function useAbility() : void
		{
			trace(shipName + " uses " + ability);
		}
		
		public function get damage() : Number {
			return _damage;
		}
		
		public function set damage(damage : Number) : void {
			_damage = damage;
		}

		public function get shipName() : String {
			return _shipName;
		}
		
		public function set shipName(shipName : String) : void {
			_shipName = shipName;
		}
		
		public function get speed()	:  Number {
			return _speed;
		}
		
		public function set speed(speed : Number) : void {
			_speed = speed;
		}
		
		public function get ability() : String {
			return _ability;
		}
		
		public function set ability(ability : String) : void {
			_ability = ability;
		}
	}
}
