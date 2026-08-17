package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxCollision;
import flixel.util.FlxSpriteUtil;
import objects.Map;

@:publicFields
class Horse extends FlxSprite
{
	var speed:Float = 100;

	function new(x:Float, y:Float, horseID:Int)
	{
		super(x, y);

		loadGraphic(Paths.image('horses/horse-$horseID'));
		velocity.x = 50;
		velocity.y = 50;
	}

	override function update(dt:Float)
	{
		var moveX:Float = velocity.x * dt;
		var moveY:Float = velocity.y * dt;

		// okay now its better
		var steps = Math.ceil(Math.max(Math.abs(moveX), Math.abs(moveY)) / 2);

		for (i in 0...steps)
		{
			x += moveX / steps;
			y += moveY / steps;

			if (FlxCollision.pixelPerfectCheck(this, Map.instance.mapSpr))
			{
				x -= moveX / steps;
				y -= moveY / steps;

				randomDirection();

				FlxG.sound.play(Paths.sound('hit'));
			}
		}

		super.update(0);
	}

	function randomDirection()
	{
		if (Math.abs(velocity.x) > Math.abs(velocity.y))
		{
			velocity.x *= -1;
			velocity.y = FlxG.random.float(-speed, speed);
		}
		else
		{
			velocity.y *= -1;
			velocity.x = FlxG.random.float(-speed, speed);
		}

		var length = Math.sqrt(velocity.x * velocity.x + velocity.y * velocity.y);

		velocity.x = velocity.x / length * speed;
		velocity.y = velocity.y / length * speed;
	}
}
