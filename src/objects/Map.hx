package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxGradient;
import openfl.Assets;
import shaders.GradientShader;

typedef MapData =
{
	var startingPoint:Array<Int>;
	var carrotPoint:Array<Int>;
	var gradient:Array<Int>;
	var ?isExtended:Bool; // for 640x960 map
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
		},
		{
			startingPoint: [50, 60],
			carrotPoint: [211, 248],
			gradient: [0xFF4e4e4e, 0xFF292929]
		},
		{
			startingPoint: [75, 40],
			carrotPoint: [490, 420],
			gradient: [0xFF810023, 0xFF40142f]
		},
		{
			startingPoint: [75, 40],
			carrotPoint: [40, 242],
			gradient: [0xff3350d4, 0xFF190971]
		},
		{
			startingPoint: [10, 40],
			carrotPoint: [40, 242],
			gradient: [0xff3350d4, 0xFF190971],
			isExtended: true
		}
	];

	var mapSpr:FlxSprite;
	var background:FlxSprite;

	var startingPoint:Array<Int>;
	var carrotPoint:Array<Int>;
	var isExtended:Bool;

	var mapID:Int;

	function new(map:Int)
	{
		super();

		if (instance == null)
			instance = this;

		if (map < 0 || map >= mapList.length)
			return;

		mapID = map;

		var data = mapList[map];
		this.startingPoint = data.startingPoint;
		this.carrotPoint = data.carrotPoint;
		this.isExtended = data.isExtended == true;

		if (!Assets.exists(Paths.image('map-$map')))
			return;

		background = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, mapList[map].gradient);
		mapSpr = new FlxSprite().loadGraphic(Paths.image('map-$map'));
		mapSpr.shader = new GradientShader(mapList[map].gradient);
		add(background);
		add(mapSpr);
	}
}
