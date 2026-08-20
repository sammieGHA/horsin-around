package states.sub;

import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

class BettingSub extends FlxSubState
{
	var canSelect:Bool = false;
	var horseCount:Int = 8;
	var balanceLeft:Int = 0;

	var balance:FlxText;
	var pressEnter:FlxText;

	var selectIndex:Int = 0;

	public function new(index:Int)
	{
		super();

		selectIndex = index;
	}

	override function create()
	{
		trace('open'); // ugh sammie why did you

		var bg = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [FlxColor.BLACK, FlxColor.GRAY], 1, 45, true);
		bg.alpha = 0;
		add(bg);

		var grid = new FlxBackdrop(FlxGridOverlay.createGrid(125, 88, 250, 175, true,0x557300FF,0x3F75106C));
		grid.alpha = 0;
		grid.velocity.set(-40, -40);
		add(grid);

		var box:FlxSprite = new FlxSprite();
		box.makeGraphic(600, 400, FlxColor.LIME);
		box.screenCenter();
		box.alpha = 0;
		add(box);

		balance = new FlxText(450, 200, FlxG.width, 'Money: $0');
		balance.size *= 2;
		balance.alpha = 0;
		add(balance);

		pressEnter = new FlxText(180, 380, FlxG.width, 'Press Enter/Space to see the race!');
		pressEnter.alpha = 0;
		pressEnter.size *= 2;
		add(pressEnter);

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(grid, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(balance, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(pressEnter, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});

		for (obj in [balance, pressEnter])
			obj.font = Paths.data('terminal.ttf');

		FlxTween.tween(box, {alpha: 1}, 0.4, {
			ease: FlxEase.quartInOut,
			onComplete: function(tween:FlxTween)
			{
				canSelect = true;
			}
		});

		for (i in 0...horseCount)
		{
			var column = i % 3;
			var row = Std.int(i / 3);

			var bet = new BetIcon(50 + column * 120, 50 + row * 100, i);
			bet.alpha = 0;
			FlxTween.tween(bet, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
			add(bet);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE && canSelect)
			close();

		if (FlxG.keys.anyPressed([ENTER, SPACE]))
			FlxG.switchState(() -> new states.PlayState(selectIndex));
	}
}

class BetIcon extends FlxSpriteGroup
{
	public var horseID:Int;
	public var betAmount:Int = 0;

	var nameText:FlxText;
	var horseIcon:FlxSprite;
	var moneyText:FlxText;

	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	public function new(x:Float, y:Float, horseID:Int)
	{
		super(x, y);

		this.horseID = horseID;

		horseIcon = new FlxSprite(55, 0);
		horseIcon.loadGraphic(Paths.image('horses/horse-' + horseID));
		horseIcon.updateHitbox();
		add(horseIcon);

		nameText = new FlxText(-50, 0, 100, 'Horse', 16);
		nameText.alignment = RIGHT;
		nameText.font = Paths.data('terminal.ttf');
		add(nameText);

		moneyText = new FlxText(0, 35, 90, '$0', 14);
		moneyText.alignment = CENTER;
		moneyText.font = Paths.data('terminal.ttf');
		add(moneyText);

		leftArrow = new FlxSprite(0, 55);
		leftArrow.loadGraphic(Paths.image('left arrow'));
		add(leftArrow);

		rightArrow = new FlxSprite(60, 55);
		rightArrow.loadGraphic(Paths.image('right arrow'));
		add(rightArrow);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		moneyText.text = '$' + betAmount;

		if (FlxG.mouse.overlaps(leftArrow))
		{
			if (FlxG.mouse.justPressed)
				betAmount = Std.int(Math.max(0, betAmount - 100));
		}

		if (FlxG.mouse.overlaps(rightArrow))
		{
			if (FlxG.mouse.justPressed)
				betAmount += 50;
		}
	}
}