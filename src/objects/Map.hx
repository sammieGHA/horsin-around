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
		{ // 0
			startingPoint: [25, 25],
			carrotPoint: [45, 310],
			gradient: [0xFF1e4620, 0xFF0f2410]
		},
		{ // 1
			startingPoint: [50, 60],
			carrotPoint: [211, 248],
			gradient: [0xFF1f5f6b, 0xFF0d2e33]
		},
		{ // 2
			startingPoint: [75, 40],
			carrotPoint: [490, 420],
			gradient: [0xFF810023, 0xFF40142f]
		},
		{ // 3
			startingPoint: [75, 40],
			carrotPoint: [40, 242],
			gradient: [0xff3350d4, 0xFF190971]
		},
		{ // 4
			startingPoint: [10, 40],
			carrotPoint: [545, 850],
			gradient: [0xFFb03e6b, 0xFF4a1a33],
			isExtended: true
		},
		{ // 5
			startingPoint: [250, 150],
			carrotPoint: [590, 225],
			gradient: [0xFFc98a3e, 0xFF5c3b1a]
		},
		{ // 6
			startingPoint: [50, 40],
			carrotPoint: [130, 240],
			gradient: [0xFF4b1f6b, 0xFF1f0d33]
		},
		{ // 7
			startingPoint: [30, 40],
			carrotPoint: [395, 260],
			gradient: [0xFF8a4a1f, 0xFF3d1f0d]
		},
		{ // 8
			startingPoint: [35, 25],
			carrotPoint: [380, 270],
			gradient: [0xFF1f5f6b, 0xFF0d2e33]
		},
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

		background = FlxGradient.createGradientFlxSprite(FlxG.width, mapList[map].isExtended ? FlxG.height * 2 : FlxG.height, mapList[map].gradient);
		mapSpr = new FlxSprite().loadGraphic(Paths.image('map-$map'));
		mapSpr.shader = new GradientShader(mapList[map].gradient);
		add(background);
		add(mapSpr);
	}
}
