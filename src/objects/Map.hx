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
	var ?isExtended:Bool;
}

@:publicFields
class Map extends FlxGroup
{
	static var instance:Map;
	static var mapList:Array<MapData> = [
		{
			startingPoint: [25, 25],
			carrotPoint: [45, 310],
			gradient: [0xFF1e4620, 0xFF0f2410]
		},
		{
			startingPoint: [50, 60],
			carrotPoint: [211, 248],
			gradient: [0xFF1f5f6b, 0xFF0d2e33]
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
			carrotPoint: [545, 850],
			gradient: [0xFFb03e6b, 0xFF4a1a33],
			isExtended: true
		},
		{
			startingPoint: [250, 150],
			carrotPoint: [590, 225],
			gradient: [0xFFc98a3e, 0xFF5c3b1a]
		},
		{
			startingPoint: [50, 40],
			carrotPoint: [130, 240],
			gradient: [0xFF4b1f6b, 0xFF1f0d33]
		},
		{
			startingPoint: [30, 40],
			carrotPoint: [395, 260],
			gradient: [0xFF8a4a1f, 0xFF3d1f0d]
		},
		{
			startingPoint: [35, 25],
			carrotPoint: [380, 270],
			gradient: [0xFF1f5f6b, 0xFF0d2e33]
		},
	];

	var mapSpr:FlxSprite;
	var background:FlxSprite;

	var startingPoint:Array<Int>;
	var carrotPoint:Array<Int>;
	var isExtended:Bool = false;

	var mapID:Int = -1;

	function new(map:Int)
	{
		super();

		if (map < 0 || map >= mapList.length)
			return;

		instance = this;

		var data = mapList[map];

		if (data == null)
			return;

		if (data.startingPoint == null || data.carrotPoint == null || data.gradient == null)
			return;

		mapID = map;

		startingPoint = data.startingPoint;
		carrotPoint = data.carrotPoint;
		isExtended = data.isExtended == true;

		if (!Assets.exists(Paths.image('map-$map')))
			return;

		background = FlxGradient.createGradientFlxSprite(FlxG.width, isExtended ? FlxG.height * 2 : FlxG.height, data.gradient);

		if (background == null)
			return;

		mapSpr = new FlxSprite().loadGraphic(Paths.image('map-$map'));

		if (mapSpr == null)
			return;

		mapSpr.shader = new GradientShader(data.gradient);

		add(background);
		add(mapSpr);
	}

	override function destroy()
	{
		if (instance == this)
			instance = null;

		super.destroy();
	}
}