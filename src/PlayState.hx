package;

import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import objects.Horse;
import objects.Map.MapData;
import objects.Map;

class PlayState extends FlxState
{
	var horses:FlxTypedGroup<Horse>;
	var map:Map;

	override public function create()
	{
		super.create();

		map = new Map(0, {startingPoint: [25, 25], carrotPoint: [200, 200]});
		add(map);

		horses = new FlxTypedGroup<Horse>(1);
		add(horses);

		for (i in 0...horses.maxSize)
		{
			var horse = new Horse(map.startingPoint[0] + (i * 32), map.startingPoint[1] + (i * 32), i);
			horses.add(horse);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
