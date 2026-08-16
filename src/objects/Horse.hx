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

	var speed:Float = 100;
	// well its a way to stop phasing through blue walls but clearly it sucks at doing that
	var previousX:Float;
	var previousY:Float;
	var wasColliding:Bool = false;

	override function update(dt:Float)
	{
    	previousX = x;
    	previousY = y;

    	super.update(dt);

    	var collision = FlxCollision.pixelPerfectCheck(this, Map.instance.mapSpr);

    	if (collision && !wasColliding)
    	{
        	x = previousX;
        	y = previousY;

			FlxG.sound.play(Paths.sound('hit'));

        	randomDirection();
    	}

    	wasColliding = collision;
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
