package;

import flixel.util.FlxTimer;
import CoolUtil;
import flixel.FlxG;

function onCutscene() {
    FlxG.sound.play(Paths.sound('weeb/ANGRY_TEXT_BOX'));
    new FlxTimer().start(1.3, t -> game.openDialogueBox("roses", CoolUtil.coolTextFile(Paths.txt('dialogue/rosesDialogue')), () -> { 
        // game.camHUD.visible = true;
        game.startCountdown();
    }));
}