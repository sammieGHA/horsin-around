package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import objects.Map;

class MapSelect extends FlxState
{
	var buttons:FlxTypedGroup<Button>;
	var selectIndex:Int = 0;
	var spacing:Float = 150;

	override function create()
	{
		super.create();

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		buttons = new FlxTypedGroup<Button>();
		add(buttons);

		for (i in 0...Map.mapList.length)
		{
			var btn = new Button(0, 0, i);
			btn.screenCenter(Y);
			buttons.add(btn);
		}

		updatePositions(false);
	}

	override function update(dt:Float)
	{
		super.update(dt);

		if (FlxG.keys.anyJustPressed([LEFT, A]) && selectIndex > 0)
		{
			selectIndex--;
			updatePositions(true);
		}

		if (FlxG.keys.anyJustPressed([RIGHT, D]) && selectIndex < Map.mapList.length - 1)
		{
			selectIndex++;
			updatePositions(true);
		}

		// if (FlxG.keys.anyJustPressed([SPACE, ENTER]))
		// 	FlxG.switchState(() -> new states.PlayState(selectIndex));

		if (FlxG.keys.anyJustPressed([SPACE, ENTER]))
			openSubState(new states.sub.BettingSub());
	}

	function updatePositions(tween:Bool)
	{
		var centerX = FlxG.width / 2;

		for (i in 0...buttons.length)
		{
			var btn = buttons.members[i];
			var targetX = centerX + (i - selectIndex) * spacing - btn.width / 2;

			var isSelected = (i == selectIndex);
			var targetScale = isSelected ? .5 : 0.25;
			var targetAlpha = isSelected ? 1 : 0.5;

			if (tween)
			{
				FlxTween.cancelTweensOf(btn);
				FlxTween.tween(btn, {x: targetX, alpha: targetAlpha}, 0.1, {ease: FlxEase.quadOut});
				FlxTween.tween(btn.scale, {x: targetScale, y: targetScale}, 0.1, {ease: FlxEase.quadOut});
			}
			else
			{
				btn.x = targetX;
				btn.alpha = targetAlpha;
				btn.scale.set(targetScale, targetScale);
			}
		}
	}
}

@:publicFields
class Button extends FlxSpriteGroup
{
	var mapID:Int;
	var buttonBg:FlxSprite;
	var mapThumb:FlxSprite;

	function new(x:Float, y:Float, id:Int)
	{
		super(x, y);

		mapID = id;

		buttonBg = new FlxSprite().loadGraphic(Paths.image('button'));
		add(buttonBg);

		mapThumb = new FlxSprite().loadGraphic(Paths.image('map-$id'));

		mapThumb.setGraphicSize(25, 25); // AAAAAAAAAAAAAAAAH
		mapThumb.updateHitbox();

		mapThumb.x = (buttonBg.width - mapThumb.width) / 2;
		mapThumb.y = (buttonBg.height - mapThumb.height) / 2;
		add(mapThumb);
	}
}
