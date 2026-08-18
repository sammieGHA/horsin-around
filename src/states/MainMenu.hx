package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;

@:publicFields
class MainMenu extends FlxState
{
	override function create()
	{
		super.create();

		FlxG.mouse.load(Paths.image('cursor'));
		#if debug
		FlxG.switchState(() -> new states.PlayState(4));
		#end

		// make it better
		var bg = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [FlxColor.BLACK, FlxColor.GRAY], 1, 45, true);
		add(bg);

		var grid = new FlxBackdrop(FlxGridOverlay.createGrid(125, 88, 250, 175, true, 0x55FFFFFF, 0x3FFFFFFF));
		grid.velocity.set(-40, -40);
		add(grid);
	}

	override function update(dt:Float)
	{
		// replace for button or som shit && make it go to MapSelect
		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.switchState(() -> new states.MapSelect());
		}

		super.update(dt);
	}
}
