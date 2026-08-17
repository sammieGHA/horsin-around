package;

import flixel.FlxGame;
import openfl.display.Sprite;
import util.Reg;

class Main extends Sprite
{
	public function new()
	{
		super();

		Reg.init();
		addChild(new FlxGame(0, 0, states.MainMenu));
	}
}
