package;

import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.FlxG;

var fastCarCanDrive = true;
var dancersDanced = false;
var fastCar:Dynamic;
var grpLimoDancers:Dynamic;
var bgLimo:Dynamic;

function create() {
	stage.defaultCamZoom = 0.9;
    importLib("flixel.group.FlxTypedGroup");
    // importLib("BackgroundDancer");
    fastCarCanDrive = true;
    var skyBG = new FlxSprite(-120, -50).loadGraphic(Paths.image('limoSunset'));
	skyBG.scrollFactor.set(0.1, 0.1);
	stage.add(skyBG);

	bgLimo = new FlxSprite(-200, 480);
	bgLimo.frames = Paths.getSparrowAtlas('bgLimo');
	bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
	bgLimo.animation.play('drive');
	bgLimo.scrollFactor.set(0.4, 0.4);
	stage.add(bgLimo);

	grpLimoDancers = new FlxTypedGroup();
    if (FlxG.save.data.distractions) {
		stage.add(grpLimoDancers);
	
		for (i in 0...5) {
			var dancer = new FlxSprite((370 * i) + 130, bgLimo.y - 400);
			dancer.antialiasing = true;
			/*dancer.animation.remove("danceLeft");
			dancer.animation.remove("danceRight");*/
			dancer.frames = Paths.getSparrowAtlas('limoDancer');
			dancer.animation.addByIndices('danceLeft', 'bg dancer sketch PINK', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 12, false);
		    dancer.animation.addByIndices('danceRight', 'bg dancer sketch PINK', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 12, false);
			dancer.scrollFactor.set(0.4, 0.4);
			dancer.animation.play("danceLeft");
			grpLimoDancers.add(dancer);
		}
	}

	/* wanted to add this back but the shader is busted
    var overlayShit = new FlxSprite(-500, -600).loadGraphic(Paths.image('limoOverlay'));
	overlayShit.alpha = 0.5;
    stage.add(overlayShit);


    var shaderBullshit = new BlendModeEffect(new OverlayShader(), 0xf85151);
	trace("FUFUGH");
    FlxG.camera.setFilters([new ShaderFilter(shaderBullshit.shader)]);

	overlayShit.shader = shaderBullshit;*/

	var limoTex = Paths.getSparrowAtlas('limoDrive');

	var limo = new FlxSprite(-120, 550);
	limo.frames = limoTex;
	limo.animation.addByPrefix('drive', "Limo stage", 24);
	limo.animation.play('drive');
	limo.antialiasing = true;
    stage.infrontOfGf.add(limo);

	fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('fastCarLol'));
	fastCar.visible = false;
    if (Settings.get("distractions")) stage.add(fastCar);
}

function beatHit(beat) {
    if (Settings.get("distractions")) {
        grpLimoDancers.forEach(d -> d.animation.play(dancersDanced ? "danceLeft" : "danceRight"));
		dancersDanced = !dancersDanced;

        if (FlxG.random.bool(10) && fastCarCanDrive) fastCarDrive();
    }
}

function reposCharacters() {
    PlayState.boyfriend.y -= 220;
	PlayState.boyfriend.x += 260;
}

function fastCarDrive() {
    FlxG.sound.play(Paths.soundRandom('carPass', 0, 1, true), 0.7);

    fastCar.visible = true;
	fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
	fastCarCanDrive = false;
	
	new FlxTimer().start(2, t -> resetFastCar());
}

function resetFastCar() {
	fastCar.visible = false;
	fastCar.x = -12600;
	fastCar.y = FlxG.random.int(140, 250);
	fastCar.velocity.x = 0;
	fastCarCanDrive = true;
}