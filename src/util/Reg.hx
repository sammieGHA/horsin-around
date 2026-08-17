package util;

import flixel.util.FlxSave;

@:publicFields
class Reg
{
	static var money:Int = 0;
	static var gameSave:FlxSave;

	static function init()
	{
		gameSave = new FlxSave();
		gameSave.bind('horsinTests');

		load();
	} // init n laod all

	static function save()
	{
		gameSave.data.money = money;

		gameSave.flush();
	} // save on exit

	static function load()
	{
		if (gameSave.data.money != null)
			money = gameSave.data.money;
	} // load data at start
}
