package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import objects.Horse;
import objects.Map.MapData;
import objects.Map;

class PlayState extends FlxState
{
	var selectedHorse:Horse;
	var horses:FlxTypedGroup<Horse>;
	var map:Map;

	override public function create()
	{
		super.create();

		map = new Map(0, {startingPoint: [25, 25], carrotPoint: [200, 200]});
		add(map);

		horses = new FlxTypedGroup<Horse>(2);
		add(horses);

		for (i in 0...horses.maxSize)
		{
			var horse = new Horse(map.startingPoint[0] + (i * 32), map.startingPoint[1], i);
			horses.add(horse);
		}

		FlxG.sound.playMusic(Paths.music('mus-1'));
		FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
	}

	override public function update(elapsed:Float)
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
				FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.quadInOut});
			}
			else
			{
				selectedHorse = null;
				FlxG.camera.follow(null);
				FlxTween.tween(FlxG.camera, {zoom: 1}, 0.4, {ease: FlxEase.quadInOut});
			}
		}
	}
}
