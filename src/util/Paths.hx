package util;

@:publicFields
class Paths
{
	static inline function image(k:String)
		return 'res/images/$k.png';

	static inline function data(k:String)
		return 'res/data/$k';

	static inline function music(k:String)
		return 'res/music/$k.ogg';

	static inline function sound(k:String)
		return 'res/sounds/$k.ogg';
}
