package states;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import objects.Horse;
import objects.Map;

@:publicFields
class PlayState extends FlxState
{
	var selectedHorse:Horse;
	var carrot:FlxSprite;
	var horses:FlxTypedGroup<Horse>;
	var map:Map;
	var mapID:Int;

	var roundEnded:Bool = false;
	var hudCamera:FlxCamera;

	var info:FlxText;
	var infoBG:FlxSprite;
	var time:Float = 0;
	var canPause:Bool = true;

	function new(mapID:Int = 0)
	{
		super();

		this.mapID = mapID;
	}

	override function create()
	{
		super.create();

		hudCamera = new FlxCamera();
		hudCamera.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(hudCamera, false);

		map = new Map(mapID);
		add(map);

		carrot = new FlxSprite(map.carrotPoint[0], map.carrotPoint[1]).loadGraphic(Paths.image('carrot'));
		add(carrot);

		horses = new FlxTypedGroup<Horse>(8);
		add(horses);

		for (i in 0...horses.maxSize)
		{
			var col = i % 4;
			var row = Math.floor(i / 4);

			var horseX = map.startingPoint[0] + (col * 32);
			var horseY = map.startingPoint[1] + (row * 32);

			var horse = new Horse(horseX, horseY, i, horses);
			horses.add(horse);
		}

		FlxG.sound.playMusic(Paths.music('mus-${FlxG.random.int(1, 2)}'));
		FlxG.camera.setScrollBounds(0, FlxG.width, 0, map.isExtended ? FlxG.height * 2 : FlxG.height);

		infoBG = new FlxSprite().makeGraphic(1, 1, 0x99000000);
		infoBG.camera = hudCamera;
		add(infoBG);

		info = new FlxText(0, 6, 0, 'Test');
		info.setFormat(Paths.data('terminal.ttf'), 32);
		info.alignment = CENTER;
		info.camera = hudCamera;
		info.scale.set(.5, .5);
		info.updateHitbox();
		add(info);

		if (map.isExtended)
		{
			var WSInfo:FlxSprite = new FlxSprite(FlxG.width - 80, 10, Paths.image('instructions'));
			WSInfo.camera = hudCamera;
			add(WSInfo);

			FlxTween.tween(WSInfo, {alpha: 0}, .5, {
				ease: FlxEase.quadOut,
				startDelay: 4,
				onComplete: function(t:FlxTween)
				{
					WSInfo.destroy();
				}
			});
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (roundEnded)
			return;

		if (canPause && FlxG.keys.justPressed.ESCAPE)
		{
			openSubState(new states.sub.PauseSub());
		}

		time += elapsed;
		info.text = 'm:$mapID | t:${Std.int(time)}';
		info.screenCenter(X);

		var py = 6;

		var tw = info.width * info.scale.x;
		var th = info.height * info.scale.y;

		infoBG.setGraphicSize(Std.int(tw + 12 * 2), Std.int(th + py * 2));
		infoBG.updateHitbox();

		infoBG.y = info.y - py;
		infoBG.screenCenter(X);

		// fix ts later idk what i was doing ^^

		if (map.isExtended)
		{
			if (FlxG.keys.anyPressed([W, UP]))
				FlxG.camera.scroll.y -= 300 * elapsed;
			if (FlxG.keys.anyPressed([S, DOWN]))
				FlxG.camera.scroll.y += 300 * elapsed;
		}

		#if debug
		if (FlxG.keys.justPressed.E)
			FlxG.camera.zoom -= .5;
		if (FlxG.keys.justPressed.Q)
			FlxG.camera.zoom += .5;
		#end

		FlxG.overlap(horses, carrot, win);

		if (FlxG.mouse.justPressed)
		{
			var daClickedHorse:Horse = null;

			for (horse in horses.members)
			{
				if (FlxG.mouse.overlaps(horse))
				{
					daClickedHorse = horse;
					break;
				}
			}

			if (daClickedHorse != null)
			{
				selectedHorse = daClickedHorse;
				FlxG.camera.follow(daClickedHorse, LOCKON);

				FlxTween.cancelTweensOf(FlxG.camera);
				FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.quadInOut});
			}
			else
			{
				selectedHorse = null;
				FlxG.camera.follow(null);

				FlxTween.cancelTweensOf(FlxG.camera);
				FlxTween.tween(FlxG.camera, {zoom: 1}, 0.4, {ease: FlxEase.quadInOut});
			}
		}
	}

	function win(horse:Horse, __carrot:FlxSprite)
	{
		if (roundEnded)
			return;

		roundEnded = true;
		canPause = false;
		selectedHorse = horse;

		horses.active = false;

		FlxG.sound.music.stop();
		FlxG.sound.play(Paths.sound('horse'));

		FlxG.camera.follow(horse, LOCKON);
		FlxTween.cancelTweensOf(FlxG.camera);

		FlxTween.tween(FlxG.camera, {zoom: 3}, 3, {
			ease: FlxEase.quadInOut,
			onComplete: function(_)
			{
				// open substate but do that later
				openSubState(new states.sub.WinSub(horse));
			}
		});
	}
}
