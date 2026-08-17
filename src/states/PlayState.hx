package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
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

	function new(mapID:Int = 0)
	{
		super();

		this.mapID = mapID;
	}

	override function create()
	{
		super.create();

		map = new Map(mapID);
		add(map);

		carrot = new FlxSprite(map.carrotPoint[0], map.carrotPoint[1]).loadGraphic(Paths.image('carrot'));
		add(carrot);

		horses = new FlxTypedGroup<Horse>(2);
		add(horses);

		for (i in 0...horses.maxSize)
		{
			var horse = new Horse(map.startingPoint[0] + (i * 32), map.startingPoint[1], i);
			horses.add(horse);
		}

		FlxG.sound.playMusic(Paths.music('mus-${FlxG.random.int(1, 1)}'));
		FlxG.camera.setScrollBounds(0, FlxG.width, 0, map.isExtended ? FlxG.height * 2 : FlxG.height);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

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
}
