package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxCollision;
import objects.Map;

@:publicFields
class Horse extends FlxSprite
{
	function new(x:Float, y:Float, horseID:Int)
	{
		super(x, y);

		loadGraphic(Paths.image('horses/horse-$horseID'));
		velocity.x = 50;
		velocity.y = 50;
	}

	override function update(dt:Float)
	{
		super.update(dt);

		if (FlxCollision.pixelPerfectCheck(this, Map.instance.mapSpr))
		{
			FlxG.sound.play(Paths.sound('hit'));

			velocity.x *= -1;
			velocity.y *= -1;
		}
	}
}
