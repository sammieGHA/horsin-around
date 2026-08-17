package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxGradient;
import openfl.Assets;

typedef MapData =
{
	var startingPoint:Array<Int>;
	var carrotPoint:Array<Int>;
	var gradient:Array<Int>;
}

@:publicFields
class Map extends FlxGroup
{
	static var instance:Map;
	static var mapList:Array<MapData> = [
		{
			startingPoint: [25, 25],
			carrotPoint: [45, 310],
			gradient: [0xFF4e4e4e, 0xFF292929]
		}
	];

	var mapSpr:FlxSprite;
	var background:FlxSprite;

	var startingPoint:Array<Int>;
	var carrotPoint:Array<Int>;

	function new(map:Int)
	{
		super();

		if (instance == null)
			instance = this;

		if (map < 0 || map >= mapList.length)
			return;

		var data = mapList[map];
		this.startingPoint = data.startingPoint;
		this.carrotPoint = data.carrotPoint;

		if (!Assets.exists(Paths.image('map-$map')))
			return;

		background = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, mapList[map].gradient);
		mapSpr = new FlxSprite().loadGraphic(Paths.image('map-$map'));
		add(background);
		add(mapSpr);
	}
}
