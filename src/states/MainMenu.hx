package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;

@:publicFields
class MainMenu extends FlxState
{
	override function create()
	{
		super.create();

		// make it better
		var bg = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [FlxColor.BLACK, FlxColor.GRAY], 1, 45, true);
		add(bg);
	}

	override function update(dt:Float)
	{
		// replace for button or som shit && make it go to MapSelect
		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.switchState(() -> new states.PlayState(0));
		}

		super.update(dt);
	}
}
