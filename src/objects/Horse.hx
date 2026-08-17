package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxCollision;

@:publicFields
class Horse extends FlxSprite
{
	var speed:Float = 100;
	var horses:FlxTypedGroup<Horse>;
	var horseID:Int;

	function new(x:Float, y:Float, horseID:Int, horses:FlxTypedGroup<Horse>)
	{
		super(x, y);

		this.horses = horses;
		this.horseID = horseID;

		loadGraphic(Paths.image('horses/horse-$horseID'));

		velocity.x = 50;
		velocity.y = 50;
	}

	override function update(dt:Float)
	{
		var moveX:Float = velocity.x * dt;
		var moveY:Float = velocity.y * dt;

		// okay now its better
		var steps:Int = Math.ceil(Math.max(Math.abs(moveX), Math.abs(moveY)) / 2);

		for (i in 0...steps)
		{
			var stepX = moveX / steps;
			var stepY = moveY / steps;

			x += stepX;
			y += stepY;

			if (FlxCollision.pixelPerfectCheck(this, Map.instance.mapSpr))
			{
				x -= stepX;
				y -= stepY;

				randomDirection();

				var s = FlxG.sound.play(Paths.sound('hit'), .7);
				s.pitch = FlxG.random.float(0.8, 1.2);
			}

			for (horse in horses.members)
			{
				if (horse == null || horse == this)
					continue;

				if (overlaps(horse))
				{
					x -= stepX;
					y -= stepY;

					randomDirection();
				}
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
