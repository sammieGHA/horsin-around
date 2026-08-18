package states.sub;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

@:publicFields
class PauseSub extends FlxSubState
{
	var subCamera:FlxCamera;

	var leaveText:FlxText;
	var continueText:FlxText;

	override function create()
	{
		super.create();

		subCamera = new FlxCamera();
		subCamera.bgColor = 0x99000000;
		FlxG.cameras.add(subCamera, false);

		leaveText = format('Leave', FlxG.height / 2 - 40);
		continueText = format('Continue', FlxG.height / 2 + 10);
	}

	function format(label:String, y:Float):FlxText
	{
		var text = new FlxText(0, y, FlxG.width, label);
		text.setFormat(Paths.data('terminal.ttf'), 32, FlxColor.WHITE, CENTER);
		text.camera = subCamera;
		add(text);
		return text;
	}

	override function update(dt:Float)
	{
		super.update(dt);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			close();
			return;
		}

		if (FlxG.mouse.justPressed)
		{
			if (FlxG.mouse.overlaps(leaveText, subCamera))
				FlxG.switchState(() -> new states.MapSelect());
			else if (FlxG.mouse.overlaps(continueText, subCamera))
				close();
		}
	}

	override function destroy()
	{
		FlxG.cameras.remove(subCamera);
		super.destroy();
		subCamera = null;
	}
}
