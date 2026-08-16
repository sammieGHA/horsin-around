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
}

@:publicFields
class Map extends FlxGroup
{
	static var instance:Map;

	var mapSpr:FlxSprite;
	var background:FlxSprite;

	var startingPoint:Array<Int>;
	var carrotPoint:Array<Int>;

	function new(map:Int, data:MapData)
	{
		super();

		if (instance == null)
			instance = this;

		this.startingPoint = data.startingPoint;
		this.carrotPoint = data.carrotPoint;

		if (!Assets.exists(Paths.image('map-$map')))
			return;

		background = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [0xFF4e4e4e, 0xFF292929]);
		mapSpr = new FlxSprite().loadGraphic(Paths.image('map-$map'));
		add(background);
		add(mapSpr);
	}
}
