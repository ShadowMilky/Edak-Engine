package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.FlxG;

function onCutscene() {
    var blackScreen:FlxSprite = new FlxSprite().makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2));
	blackScreen.color = 0x000000;
	/*while (game.inCutscene) {
		PlayState.boyfriend.playAnim("scared");
		PlayState.gf.playAnim("scared");
	}*/
	
	blackScreen.scrollFactor.set();
	game.camHUD.alpha = 0;
	game.add(blackScreen);

	new FlxTimer().start(0.1, function(tmr:FlxTimer)
	{
		// trace(blackScreen);
		// game.remove(blackScreen);
		blackScreen.alpha = .4;
		blackScreen.color = 0xA00505;
		
		FlxG.sound.play(Paths.sound('xmas/Lights_Turn_On'));
		game.camFollow.y = -2050;
		game.camFollow.x -= 200;
		FlxG.camera.focusOn(game.camFollow.getPosition());
		FlxG.camera.zoom = 1.7;
		new FlxTimer().start(0.8, function(tmr:FlxTimer)
		{
			FlxTween.tween(game.camHUD, { alpha: 1 }, 2.5, { ease: FlxEase.quadInOut });
			FlxTween.tween(blackScreen, { alpha: 0 }, 2.5, {
				ease: FlxEase.quadInOut,
				onComplete: t -> { 
					game.remove(blackScreen);
					blackScreen.destroy();
				}
			});
			
			FlxTween.tween(FlxG.camera, {zoom: game.defaultCamZoom}, 2.5, {
				ease: FlxEase.quadInOut,
				onComplete: function(twn:FlxTween)
				{
					game.startCountdown();
				}
			});
		});
	});
}

function onCountdownTick(tick) {
	if (tick == 0) {
		var offsetX = PlayState.boyfriend.displaceData.camX;
	    var offsetY = PlayState.boyfriend.displaceData.camY;
        game.camFollow.setPosition(PlayState.boyfriend.getMidpoint().x - 100 + offsetX, PlayState.boyfriend.getMidpoint().y - 100 + offsetY);
	}
}
