package states.sub;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import objects.Horse;

@:publicFields
class WinSub extends FlxSubState
{
	var winningHorse:Horse;
	var subCamera:FlxCamera;

	function new(horse:Horse)
	{
		super();
		winningHorse = horse;
	}

	override function create()
	{
		super.create();

		subCamera = new FlxCamera();
		subCamera.bgColor = 0x99000000;
		FlxG.cameras.add(subCamera, false);

		FlxG.sound.play(Paths.sound('win'));

		var winText = new FlxText(0, FlxG.height / 2 - 20, FlxG.width, 'Replac later but horse ${winningHorse.horseID} won');
		winText.setFormat(Paths.data('terminal.ttf'), 32, 0xFFFFFFFF, CENTER);
		winText.camera = subCamera;
		add(winText);

		new FlxTimer().start(3, (t:FlxTimer) -> FlxG.switchState(() -> new states.MapSelect()));
	}

	override function destroy()
	{
		FlxG.cameras.remove(subCamera);
		super.destroy();
	}
}
