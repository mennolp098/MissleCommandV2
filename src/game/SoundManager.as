package game 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Menno Jongejan
	 */
	public class SoundManager 
	{
		public static const SOUND_MISSILE : String	=	"soundMissile";
		public static const SOUND_EXPLOSION : String	=	"soundExplosion";
		
		public static var soundChannel:SoundChannel;
		private var backgroundSoundChannel:SoundChannel;
		
		private var _backgroundMusic:Sound;
		public function SoundManager() 
		{
			soundChannel = new SoundChannel();
			backgroundSoundChannel = new SoundChannel();
			
			var backgroundReq:URLRequest = new URLRequest("sounds/backgroundMusic.mp3");
			_backgroundMusic = new Sound(backgroundReq);
			
			backgroundSoundChannel = _backgroundMusic.play();
		}
		public static function playSound(sound:String):void
		{
			var soundToPlay:Sound;
			var rocketReq:URLRequest = new URLRequest("sounds/rocketSound.mp3"); 
			var explosionReq:URLRequest = new URLRequest("sounds/Arcade Explosion.mp3");
			if (sound == SOUND_MISSILE)
			{
				soundToPlay = new Sound(rocketReq);
			} 
			else if (sound == SOUND_EXPLOSION)
			{
				soundToPlay = new Sound(explosionReq);
			}
			soundChannel = soundToPlay.play();
		}
		public function stopBackgroundMusic():void
		{
			backgroundSoundChannel.stop();
		}
	}
}