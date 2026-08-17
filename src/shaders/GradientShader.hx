package shaders;

import flixel.system.FlxAssets.FlxShader;

class GradientShader extends FlxShader
{
	@:glFragmentSource('
		#pragma header

		uniform vec4 topColor;
		uniform vec4 bottomColor;

		void main()
		{
			vec4 pixel = flixel_texture2D(bitmap, openfl_TextureCoordv);

			float t = openfl_TextureCoordv.y;

			vec4 gradient = mix(topColor, bottomColor, t);

			gl_FragColor = vec4(gradient.rgb, pixel.a);
		}
	')

	public function new(colors:Array<Int>)
	{
		super();

		topColor.value = colorToArray(colors[0]);
		bottomColor.value = colorToArray(colors[1]);
	}

	static function colorToArray(color:Int):Array<Float>
	{
		return [
			((color >> 16) & 0xFF) / 255,
			((color >> 8) & 0xFF) / 255,
			(color & 0xFF) / 255,
			((color >> 24) & 0xFF) / 255
		];
	}
}