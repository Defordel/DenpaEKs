package;

import Shaders.ColorSwap;
import editors.ChartingState;
import flixel.FlxSprite;
import flixel.math.FlxRect;

typedef EventNote = {
	strumTime:Float,
	event:String,
	value1:String,
	value2:String
}

typedef PreloadedChartNote = {
	strumTime:Float,
	noteData:Int,
	mustPress:Bool,
	noteType:String,
	animSuffix:String,
	noteskin:String,
	texture:String,
	noAnimation:Bool,
	noMissAnimation:Bool,
	gfNote:Bool,
	isSustainNote:Bool,
	isSustainEnd:Bool,
	sustainLength:Float,
	sustainScale:Float,
	parent:PreloadedChartNote,
	prevNote:Note,
	strum:StrumNote,
	mania:Int,
	hitHealth:Float,
	missHealth:Float,
	hitCausesMiss:Null<Bool>,
	wasHit:Bool,
	spawnTimeMult:Float,
	wasSpawned:Bool,
	canBeHit:Bool,
	ignoreNote:Bool,
	wasMissed:Bool
}

/**
 * Basic class for all `Note`s.
 */
class Note extends FlxSprite {
	public static final gfxLetter:Array<String> = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

	public static final scales:Array<Float> = [0.9, 0.85, 0.8, 0.7, 0.66, 0.6, 0.55, 0.50, 0.46, 0.42, 0.38, 0.34, 0.31, 0.29, 0.27, 0.25, 0.23, 0.21, 0.21, 0.2, 0.19, 0.18, 0.18, 0.18, 0.17, 0.17]; // scale
	public static final lessX:Array<Int> = [0, 0, 0, 0, 0, 8, 7, 8, 8, 7, 8, 6, 7, 6, 6, 6, 5, 4, 4, 4, 4, 4, 4, 4, 4, 4]; // gap width/distance between notes
	public static final separator:Array<Int> = [0, 0, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5]; // i have no clue what this is ngl
	public static final xtra:Array<Int> = [150, 89, 0, 0, 0, 0, 0, 0, 0, 0, 25, 40, 55, 65, 75, 95, 110, 125, 115, -50, -40, -30, -40, -50, -50, -50]; // x offset
	public static final posRest:Array<Int> = [0, 0, 0, 0, 25, 32, 46, 52, 60, 75, 82, 96, 102, 110, 125, 132, 146, 152, 160]; // x offset (inverted axis)
	public static final minMania:Int = 0;
	public static final maxMania:Int = 25;
	public static final defaultMania:Int = 3;

	// IJ = Space
	// EFGH = Left Down Up Right
	// KLMN = LDUR 2
	// ABCD = Sharp LDUR 1
	// OPQR = Sharp LDUR 2
	// STUV = Power LDUR 1
	// WXYZ = Power LDUR 2
	public static final keysShit:Map<Int, Map<String, Dynamic>> = [
		0 => [
			"letters" => ["I"],
			"anims" => ["SPACE"],
			"strumAnims" => ["SPACE"],
			"pixelAnimIndex" => [4]
		],
		1 => [
			"letters" => ["E", "H"],
			"anims" => ["LEFT", "RIGHT"],
			"strumAnims" => ["LEFT", "RIGHT"],
			"pixelAnimIndex" => [0, 3]
		],
		2 => [
			"letters" => ["E", "I", "H"],
			"anims" => ["LEFT", "SPACE", "RIGHT"],
			"strumAnims" => ["LEFT", "SPACE", "RIGHT"],
			"pixelAnimIndex" => [0, 4, 3]
		],
		3 => [
			"letters" => ["E", "F", "G", "H"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3]
		],
		4 => [
			"letters" => ["E", "F", "I", "G", "H"],
			"anims" => ["LEFT", "DOWN", "SPACE", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "SPACE", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 4, 2, 3]
		],
		5 => [
			"letters" => ["E", "F", "H", "K", "G", "N"],
			"anims" => ["LEFT", "DOWN", "RIGHT", "LEFT", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "RIGHT", "LEFT", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 2, 3, 5, 1, 8]
		],
		6 => [
			"letters" => ["E", "F", "H", "I", "K", "G", "N"],
			"anims" => ["LEFT", "DOWN", "RIGHT", "SPACE", "LEFT", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "RIGHT", "SPACE", "LEFT", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 2, 3, 4, 5, 1, 8]
		],
		7 => [
			"letters" => ["E", "F", "G", "H", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 5, 6, 7, 8]
		],
		8 => [
			"letters" => ["E", "F", "G", "H", "I", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "SPACE", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SPACE", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 4, 5, 6, 7, 8]
		],
		9 => [
			"letters" => ["E", "F", "G", "H", "I", "J", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "SPACE", "SPACE", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SPACE", "SPACE", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 4, 4, 5, 6, 7, 8]
		],
		10 => [
			"letters" => ["E", "F", "G", "H", "I", "J", "I", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "SPACE", "SPACE", "SPACE", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SPACE", "SPACE", "SPACE", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 4, 4, 4, 5, 6, 7, 8]
		],
		11 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "C", "D", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 7, 8, 5, 6, 7, 8]
		],
		12 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "I", "C", "D", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "SPACE", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SPACE", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 4, 7, 8, 5, 6, 7, 8]
		],
		13 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "D", "O", "C", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "RIGHT", "LEFT", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPRIGHT", "SHARPLEFT", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 2, 3, 5, 1, 8, 5, 6, 7, 8]
		],
		14 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "D", "I", "O", "C", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "RIGHT", "SPACE", "LEFT", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPRIGHT", "SPACE", "SHARPLEFT", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 2, 3, 4, 5, 1, 8, 5, 6, 7, 8]
		],
		15 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "C", "D", "O", "P", "Q", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 2, 3, 5, 6, 7, 8, 5, 6, 7, 8]
		],
		16 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "C", "D", "I", "O", "P", "Q", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "SPACE", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "SPACE", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 2, 3, 4, 5, 6, 7, 8, 5, 6, 7, 8]
		],
		17 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "C", "D", "I", "J", "O", "P", "Q", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "SPACE", "SPACE", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "SPACE", "SPACE", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 2, 3, 4, 4, 5, 6, 7, 8, 5, 6, 7, 8]
		],
		18 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "C", "D", "I", "J", "I", "O", "P", "Q", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "SPACE", "SPACE", "SPACE", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "SPACE", "SPACE", "SPACE", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 2, 3, 4, 4, 4, 5, 6, 7, 8, 5, 6, 7, 8]
		],
		19 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "C", "D", "S", "T", "U", "V", "O", "P", "Q", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "POWERLEFT", "POWERDOWN", "POWERUP", "POWERRIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]
		],
		20 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "C", "D", "S", "T", "I", "U", "V", "O", "P", "Q", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "SPACE", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "POWERLEFT", "POWERDOWN", "SPACE", "POWERUP", "POWERRIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 4, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]
		],
		21 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "C", "D", "S", "T", "V", "W", "U", "Z", "O", "P", "Q", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "RIGHT", "LEFT", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "POWERLEFT", "POWERDOWN", "POWERRIGHT", "POWERLEFT", "POWERUP", "POWERRIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 2, 3, 0, 2, 3, 5, 1, 8, 5, 6, 7, 8, 5, 6, 7, 8]
		],
		22 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "C", "D", "S", "T", "V", "I", "W", "U", "Z", "O", "P", "Q", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "RIGHT", "SPACE", "LEFT", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "POWERLEFT", "POWERDOWN", "POWERRIGHT", "SPACE", "POWERLEFT", "POWERUP", "POWERRIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 2, 3, 0, 2, 3, 4, 5, 1, 8, 5, 6, 7, 8, 5, 6, 7, 8]
		],
		23 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "C", "D", "S", "T", "U", "V", "W", "X", "Y", "Z", "O", "P", "Q", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "POWERLEFT", "POWERDOWN", "POWERUP", "POWERRIGHT", "POWERLEFT", "POWERDOWN", "POWERUP", "POWERRIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 7, 8, 0, 1, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]
		],
		24 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "C", "D", "S", "T", "U", "V", "I", "W", "X", "Y", "Z", "O", "P", "Q", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "SPACE", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "POWERLEFT", "POWERDOWN", "POWERUP", "POWERRIGHT", "SPACE", "POWERLEFT", "POWERDOWN", "POWERUP", "POWERRIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 7, 8, 4, 0, 1, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]
		],
		25 => [
			"letters" => ["E", "F", "G", "H", "A", "B", "C", "D", "S", "T", "U", "V", "I", "J", "W", "X", "Y", "Z", "O", "P", "Q", "R", "K", "L", "M", "N"],
			"anims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "SPACE", "SPACE", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "POWERLEFT", "POWERDOWN", "POWERUP", "POWERRIGHT", "SPACE", "SPACE", "POWERLEFT", "POWERDOWN", "POWERUP", "POWERRIGHT", "SHARPLEFT", "SHARPDOWN", "SHARPUP", "SHARPRIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			"pixelAnimIndex" => [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 7, 8, 4, 4, 0, 1, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8]
		],
	];

	public static final ammo:Array<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26];
	public static final pixelScales:Array<Float> = [1.2, 1.15, 1.1, 1, 0.9, 0.83, 0.8, 0.74, 0.7, 0.63, 0.6, 0.54, 0.5, 0.43, 0.4, 0.34, 0.3, 0.23, 0.2, 0.14, 0.1, 0.03, 0.02, 0.01, 0.005, 0.004];

	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var ignoreNote:Bool = false;
	public var hitByOpponent:Bool = false;
	public var noteWasHit:Bool = false;
	public var prevNote:Note;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;
	public var isSustainEnd:Bool = false;
	public var noteType(default, set):String = null;

	public var eventName:String = '';
	public var eventLength:Int = 0;
	public var eventVal1:String = '';
	public var eventVal2:String = '';

	public var colorSwap:ColorSwap;
	public var inEditor:Bool = false;
	public var gfNote:Bool = false;
	public var strum:Int = 0; // used to sort the note to strums in playstate
	public var strumToFollow:StrumNote = null; // used when we need to make the note follow a strum

	private var earlyHitMult:Float = 0.6;

	public static final swagWidth:Float = 160 * 0.7;

	// Lua shit
	public var noteSplashDisabled:Bool = false;
	public var forceNoteSplash:Bool = false;
	public var noteSplashTexture:String = null;
	public var noteSplashHue:Float = 0;
	public var noteSplashSat:Float = 0;
	public var noteSplashBrt:Float = 0;

	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
	public var offsetAngle:Float = 0;
	public var multAlpha:Float = 1;

	public var copyX:Bool = true;
	public var copyY:Bool = true;
	public var copyAngle:Bool = true;
	public var copyAlpha:Bool = true;
	public var copyVisible:Bool = true;
	public var copyScale:Bool = false;
	public var scaleHackHitbox:Bool = true;
	public var spawnTimeMult:Float = 1;

	public var hitHealth:Float = 0.023;
	public var missHealth:Float = 0.0475;
	public var rating:String = 'unknown';
	public var ratingDisabled:Bool = false;

	public var sustainScale:Float = 1;

	public var texture(default, set):String = null;

	public var noAnimation:Bool = false;
	public var hitCausesMiss:Bool = false;
	public var distance:Float = 2000;

	public var hitsoundDisabled:Bool = false;

	public var mania:Int = 3;

	var defaultWidth:Float = 0;
	var defaultHeight:Float = 0;

	static final beats:Array<Int> = [
		4, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192, 256, 384, 512, 768, 1024, 1536, 2048, 3072, 6144
	];

	public function checkNoteQuant(note:Note, timeToCheck:Float):Void {
		if (note.colorSwap != null && ClientPrefs.settings.get("noteColor") == 'Quant') {
			var theCurBPM = Conductor.bpm;
			var stepCrochet:Float = (60 / theCurBPM) * 1000;
			var latestBpmChangeIndex = -1;
			var latestBpmChange = null;

			for (i in 0...Conductor.bpmChangeMap.length) {
				var bpmchange = Conductor.bpmChangeMap[i];
				if (timeToCheck >= bpmchange.songTime) {
					latestBpmChangeIndex = i; // Update index of latest change
					latestBpmChange = bpmchange;
				}
			}
			if (latestBpmChangeIndex >= 0) {
				theCurBPM = latestBpmChange.bpm;
				timeToCheck -= latestBpmChange.songTime;
				stepCrochet = (60 / theCurBPM) * 1000;
			}

			var beat = Math.round((timeToCheck / stepCrochet) * 48);
			for (i in 0...beats.length) {
				if (beat % (192 / beats[i]) == 0) {
					beat = beats[i];
					break;
				}
			}
			switch (beat) {
				case 4: // red
					note.colorSwap.hue = 0;
					note.colorSwap.saturation = 0;
					note.colorSwap.brightness = 0;
				case 8: // blue
					note.colorSwap.hue = -0.34;
					note.colorSwap.saturation = 0;
					note.colorSwap.brightness = 0;
				case 12: // purple
					note.colorSwap.hue = 0.8;
					note.colorSwap.saturation = 0;
					note.colorSwap.brightness = 0;
				case 16: // yellow
					note.colorSwap.hue = 0.16;
					note.colorSwap.saturation = 0;
					note.colorSwap.brightness = 0;
				case 24: // pink
					note.colorSwap.hue = 0.91;
					note.colorSwap.saturation = 0;
					note.colorSwap.brightness = 0;
				case 32: // orange
					note.colorSwap.hue = 0.06;
					note.colorSwap.saturation = 0;
					note.colorSwap.brightness = 0;
				case 48: // cyan
					note.colorSwap.hue = -0.53;
					note.colorSwap.saturation = 0;
					note.colorSwap.brightness = 0;
				case 64: // green
					note.colorSwap.hue = -0.7;
					note.colorSwap.saturation = 0;
					note.colorSwap.brightness = 0;
				case 96: // salmon lookin ass
					note.colorSwap.hue = 0;
					note.colorSwap.saturation = -0.33;
					note.colorSwap.brightness = 0;
				case 128: // light purple shit
					note.colorSwap.hue = -0.24;
					note.colorSwap.saturation = -0.33;
					note.colorSwap.brightness = 0;
				case 192: // turquioe i cant spell
					note.colorSwap.hue = 0.44;
					note.colorSwap.saturation = 0.31;
					note.colorSwap.brightness = 0;
				case 256: // shit (the color of it)
					note.colorSwap.hue = 0.03;
					note.colorSwap.saturation = 0;
					note.colorSwap.brightness = -0.63;
				case 384: // dark green ugly shit
					note.colorSwap.hue = 0.29;
					note.colorSwap.saturation = 1;
					note.colorSwap.brightness = -0.89;
				case 512: // darj blue
					note.colorSwap.hue = -0.33;
					note.colorSwap.saturation = 0.29;
					note.colorSwap.brightness = -0.7;
				case 768: // gray ok
					note.colorSwap.hue = 0.04;
					note.colorSwap.saturation = -0.86;
					note.colorSwap.brightness = -0.23;
				case 1024: // turqyuarfhiouhifueaig but dark
					note.colorSwap.hue = 0.46;
					note.colorSwap.saturation = 0;
					note.colorSwap.brightness = -0.46;
				case 1536: // pure death
					note.colorSwap.hue = 0;
					note.colorSwap.saturation = 0;
					note.colorSwap.brightness = -1;
				case 2048: // piss and shit color
					note.colorSwap.hue = 0.2;
					note.colorSwap.saturation = -0.36;
					note.colorSwap.brightness = -0.74;
				case 3072: // boring ass color
					note.colorSwap.hue = 0.17;
					note.colorSwap.saturation = -0.57;
					note.colorSwap.brightness = -0.27;
				case 6144: // why did i do this? idk tbh, it just funni
					note.colorSwap.hue = 0.23;
					note.colorSwap.saturation = 0.76;
					note.colorSwap.brightness = -0.83;
				default: // white/gray
					note.colorSwap.hue = 0.04;
					note.colorSwap.saturation = -0.86;
					note.colorSwap.brightness = -0.23;
			}
		}
	}

	private function set_texture(value:String):String {
		if (!PlayState.isPixelStage) {
			if (!Paths.noteSkinFramesMap.exists(value))
				Paths.initNote(value);
			frames = @:privateAccess Paths.noteSkinFramesMap.get(value);
			animation.copyFrom(@:privateAccess Paths.noteSkinAnimsMap.get(value));
			antialiasing = ClientPrefs.settings.get("globalAntialiasing");
			if (inEditor)
				scale.set(0.7, 0.7);
			else
				scale.set(Note.scales[PlayState.mania], Note.scales[PlayState.mania]);
			updateHitbox();
		}
		texture = value;
		return value;
	}

	private function set_noteType(value:String):String {
		noteSplashTexture = PlayState.SONG.assets.splashSkin;
		if (ClientPrefs.settings.get("noteColor") == 'Default') {
			colorSwap.hue = ClientPrefs.arrowHSV[
				Std.int(Note.keysShit.get(mania).get('pixelAnimIndex')[noteData] % Note.ammo[mania])
			][0] / 360;
			colorSwap.saturation = ClientPrefs.arrowHSV[
				Std.int(Note.keysShit.get(mania).get('pixelAnimIndex')[noteData] % Note.ammo[mania])
			][1] / 100;
			colorSwap.brightness = ClientPrefs.arrowHSV[
				Std.int(Note.keysShit.get(mania).get('pixelAnimIndex')[noteData] % Note.ammo[mania])
			][2] / 100;
		}
		if (noteData > -1 && noteType != value) {
			switch (value) {
				case 'Hurt Note':
					ignoreNote = mustPress;
					reloadNote('HURT', 'NOTE_assets');
					noteSplashTexture = 'splashes/HURTnoteSplashes';
					colorSwap.hue = colorSwap.saturation = colorSwap.brightness = 0;
					missHealth = (isSustainNote ? 0.1 : 0.3);
					hitCausesMiss = true;
				case 'No Animation':
					noAnimation = true;
				case 'GF Sing' | 'GF Cross Fade':
					gfNote = true;
				case 'Third Strum':
					strum = 2;
					spawnTimeMult = 2;
				#if MODS_ALLOWED
				case '' | 'Hey!' | 'Cross Fade' | 'Alt Animation' | 'Normal':
					// do nothing dumbass
				default:
					final prefix = value.split(" ")[0].toUpperCase();
					if (Paths.fileExists('images/${value.toUpperCase()}_assets.png', IMAGE)) {
						reloadNote(prefix, '_assets');
						colorSwap.hue = colorSwap.saturation = colorSwap.brightness = 0;
					}
				#end
			}
			noteType = value;
		}
		noteSplashHue = colorSwap.hue;
		noteSplashSat = colorSwap.saturation;
		noteSplashBrt = colorSwap.brightness;
		return value;
	}

	public function new(?inEditor:Bool = false) {
		super();

		if (prevNote == null)
			prevNote = this;

		mania = PlayState.mania;

		this.inEditor = inEditor;

		y -= 2000;

		if (noteData > -1) {
			texture = Paths.defaultSkin;
			colorSwap = new ColorSwap();
			shader = colorSwap.shader;

			x += swagWidth * (noteData % Note.ammo[mania]);
			if (!isSustainNote) {
				animation.play(Note.keysShit.get(mania).get('letters')[noteData % Note.ammo[mania]]);
			}
		}

		if (isSustainNote && prevNote != null) {
			alpha = 0.65;
			multAlpha = 0.65;
			hitsoundDisabled = true;
			if (ClientPrefs.settings.get("downScroll"))
				flipY = true;

			offsetX += width / 2;
			copyAngle = false;

			animation.play('${Note.keysShit.get(mania).get('letters')[noteData]} tail');
			isSustainEnd = true;
			hitHealth = 0;
			missHealth = 0;

			updateHitbox();

			offsetX -= width / 2;

			if (PlayState.isPixelStage)
				offsetX += 30 * Note.pixelScales[mania];

			if (prevNote.isSustainNote) {
				prevNote.animation.play('${Note.keysShit.get(mania).get('letters')[prevNote.noteData]} hold');
				prevNote.isSustainEnd = false;
				prevNote.hitHealth = (0.023 / 2) / (PlayState.SONG.header.bpm / 150);
				prevNote.missHealth = (0.0475 / 2) / (PlayState.SONG.header.bpm / 150);

				prevNote.scale.y *= Conductor.stepCrochet / 100 * (PlayState.isPixelStage ? 1.05 : 1.055);
				if (PlayState.instance != null)
					prevNote.scale.y *= PlayState.instance.songSpeed;

				if (PlayState.isPixelStage) {
					prevNote.scale.y *= 1.19;
					prevNote.scale.y *= (6 / height); // Auto adjust note size
				}
				prevNote.updateHitbox();
			}

			if (PlayState.isPixelStage) {
				scale.y *= PlayState.daPixelZoom;
				updateHitbox();
			}
		} else if (!isSustainNote) {
			earlyHitMult = 1.2; // set this so that you can hit within like 210 ms or so (so you can wtf)
		}
		moves = false; // notes dont use velocity!
		x += offsetX;
	}

	var lastNoteOffsetXForPixelAutoAdjusting:Float = 0;
	var lastNoteScaleToo:Float = 1;

	public var originalHeightForCalcs:Float = 6;

	function reloadNote(?prefix:String = '', ?texture:String = '', ?suffix:String = '') {
		if (prefix == null)
			prefix = '';
		if (texture == null)
			texture = '';
		if (suffix == null)
			suffix = '';

		var skin:String = texture;
		if (texture.length < 1) {
			skin = PlayState.SONG.assets.arrowSkin;
			if (skin == null || skin.length < 1)
				skin = 'NOTE_assets';
		}

		var animName:String = null;
		if (animation.curAnim != null)
			animName = animation.curAnim.name;

		var arraySkin:Array<String> = skin.split('/');
		arraySkin[arraySkin.length - 1] = prefix + arraySkin[arraySkin.length - 1] + suffix;

		var lastScaleY:Float = scale.y;
		var blahblah:String = arraySkin.join('/');

		defaultWidth = 157;
		defaultHeight = 154;
		if (PlayState.isPixelStage) {
			if (isSustainNote) {
				// get yo nerdy ass outta here with your "width / 18" math mf
				originalHeightForCalcs = 12;
				loadGraphic(Paths.image('pixelUI/${blahblah}ENDS'), true, 7, 6);
			} else {
				loadGraphic(Paths.image('pixelUI/$blahblah'), true, 17, 17);
			}
			defaultWidth = width;
			setGraphicSize(Std.int(width * PlayState.daPixelZoom * Note.pixelScales[mania]));
			loadPixelNoteAnims();
			antialiasing = false;

			if (isSustainNote) {
				offsetX += lastNoteOffsetXForPixelAutoAdjusting;
				lastNoteOffsetXForPixelAutoAdjusting = (width - 7) * (PlayState.daPixelZoom / 2);
				offsetX -= lastNoteOffsetXForPixelAutoAdjusting;
			}
		} else {
			frames = Paths.getSparrowAtlas(blahblah);
			loadNoteAnims();
		}
		if (isSustainNote)
			scale.y = lastScaleY;
		updateHitbox();

		if (animName != null)
			animation.play(animName, true);

		if (inEditor) {
			setGraphicSize(ChartingState.GRID_SIZE, ChartingState.GRID_SIZE);
			updateHitbox();
		}
	}

	function loadNoteAnims() {
		for (letter in gfxLetter) {
			if (isSustainNote) {
				animation.addByPrefix('$letter hold', '$letter hold');
				animation.addByPrefix('$letter tail', '$letter tail');
			} else {
				animation.addByPrefix(letter, letter + '0');
			}
		}
		setGraphicSize(Std.int(defaultWidth * scales[mania]), (isSustainNote ? Std.int(defaultHeight * scales[0]) : 0));
		updateHitbox();
	}

	function loadPixelNoteAnims() {
		if (isSustainNote) {
			for (i => letter in gfxLetter) {
				animation.add('$letter hold', [i]);
				animation.add('$letter tail', [i + 18]);
			}
		} else {
			for (i => letter in gfxLetter) {
				animation.add(letter, [i + 18]);
			}
		}
	}

	public function applyManiaChange() {
		if (isSustainNote)
			scale.y = 1;
		reloadNote(texture);
		if (isSustainNote)
			offsetX = width / 2;
		if (!isSustainNote) {
			var animToPlay:String = '';
			animToPlay = Note.keysShit.get(mania).get('letters')[noteData % Note.ammo[mania]];
			animation.play(animToPlay);
		}

		if (isSustainNote && prevNote != null) {
			animation.play(Note.keysShit.get(mania).get('letters')[noteData % Note.ammo[mania]] + ' tail');
			if (prevNote.isSustainNote) {
				// after some debugging, it appears prevNote has a null animation controller
				// why? no fucking clue
				if (prevNote.animation != null) {
					prevNote.animation.play(Note.keysShit.get(mania).get('letters')[noteData % Note.ammo[mania]] + ' hold');
					prevNote.updateHitbox();
				}
			}
		}

		updateHitbox();
	}

	public var correctionOffset:Int = 0;

	// remove later possibly??
	override function update(elapsed:Float) {
		super.update(elapsed);

		if (mustPress) {
			canBeHit = (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
				&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * earlyHitMult));
			tooLate = (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit);
		} else {
			// why is this updated every frame ??
			canBeHit = false;

			if (!(strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * earlyHitMult)))
				return;
			wasGoodHit = ((isSustainNote && prevNote.wasGoodHit) || strumTime <= Conductor.songPosition);
		}
	}

	public function followStrum(strum:StrumNote, fakeCrochet:Float, songSpeed:Float = 1):Void {
		if (isSustainNote) {
			flipY = strum.downScroll;
			offsetX = 50 * Note.scales[PlayState.mania];
			scale.set(Note.scales[PlayState.mania], isSustainEnd ? 1 : Conductor.stepCrochet * 0.0105 * (songSpeed / spawnTimeMult) * sustainScale);
			if (PlayState.isPixelStage) {
				scale.x *= PlayState.daPixelZoom;
				scale.y *= PlayState.daPixelZoom * 1.2;
			}

			updateHitbox();
		}

		if (strum == null)
			noteData = PlayState.mania;
		distance = (0.45 * (Conductor.songPosition - strumTime) * songSpeed * spawnTimeMult);
		if (!strum.downScroll)
			distance *= -1;

		if (animation != null && animation.curAnim != null && animation.curAnim.name.endsWith('end')) {
			y -= height - 2;
		}

		if (copyAngle)
			angle = strum.direction - 90 + strum.angle + offsetAngle;

		if (copyAlpha)
			alpha = strum.alpha * multAlpha;

		if (copyX)
			x = strum.x + offsetX + Math.cos(strum.direction * Math.PI / 180) * distance;

		if (copyY) {
			y = strum.y + offsetY + correctionOffset + Math.sin(strum.direction * Math.PI / 180) * distance;
			if (strum.downScroll && isSustainNote) {
				if (PlayState.isPixelStage) {
					y -= PlayState.daPixelZoom * 9.5;
				}
				y -= (frameHeight * scale.y) - (Note.swagWidth / 2);
			}
		}
	}

	public function clipToStrumNote(myStrum:StrumNote) {
		final center:Float = myStrum.y + offsetY + Note.swagWidth / 2;
		var flag1:Bool = (mustPress || !ignoreNote);
		var flag2:Bool = (!mustPress || (wasGoodHit || (prevNote.wasGoodHit && !canBeHit)));

		if (flag1 && flag2) {
			final swagRect:FlxRect = clipRect != null ? clipRect : new FlxRect(0, 0, frameWidth, frameHeight);

			if (myStrum.downScroll) {
				if (y - offset.y * scale.y + height >= center) {
					swagRect.width = frameWidth;
					swagRect.height = (center - y) / scale.y;
					swagRect.y = frameHeight - swagRect.height;
				}
			} else if (y + offset.y * scale.y <= center) {
				swagRect.y = (center - y) / scale.y;
				swagRect.width = width / scale.x;
				swagRect.height = (height / scale.y) - swagRect.y;
			}
			clipRect = swagRect;
		}
	}

	@:noCompletion
	override function set_clipRect(rect:FlxRect):FlxRect {
		clipRect = rect;

		if (frames != null)
			frame = frames.frames[animation.frameIndex];

		return rect;
	}

	// this is used for note recycling
	public function setupNoteData(chartNoteData:PreloadedChartNote):Note {
		wasGoodHit = hitByOpponent = tooLate = canBeHit = false; // Don't make an update call of this for the note group

		strumTime = chartNoteData.strumTime;
		if (!inEditor)
			strumTime += ClientPrefs.settings.get("noteOffset");
		noteData = Std.int(chartNoteData.noteData % ammo[PlayState.mania]);
		noteType = chartNoteData.noteType;
		noAnimation = chartNoteData.noAnimation;
		mustPress = chartNoteData.mustPress;
		gfNote = chartNoteData.gfNote;
		isSustainNote = chartNoteData.isSustainNote;
		if (chartNoteData.noteskin.length > 0 && chartNoteData.noteskin != '' && chartNoteData.noteskin != texture)
			texture = 'noteskins/' + chartNoteData.noteskin;
		if (chartNoteData.texture.length > 0 && chartNoteData.texture != texture)
			texture = chartNoteData.texture;
		if (chartNoteData.texture.length < 1 && texture != Paths.defaultSkin)
			texture = Paths.defaultSkin;
		sustainLength = chartNoteData.sustainLength;

		strumToFollow = chartNoteData.strum;
		mania = chartNoteData.mania;
		hitHealth = chartNoteData.hitHealth;
		missHealth = chartNoteData.missHealth;
		hitCausesMiss = chartNoteData.hitCausesMiss;
		spawnTimeMult = chartNoteData.spawnTimeMult;
		isSustainEnd = chartNoteData.isSustainEnd;

		if (!isSustainEnd && isSustainNote) {
			hitHealth = (0.023 / 2) / (PlayState.SONG.header.bpm / 150);
			missHealth = (0.0475 / 2) / (PlayState.SONG.header.bpm / 150);
		}

		if (PlayState.isPixelStage)
			reloadNote('', texture);
		animation.play(Note.keysShit.get(mania).get('letters')[noteData % Note.ammo[mania]]);

		if (isSustainNote) {
			animation.play('${Note.keysShit.get(mania).get('letters')[noteData]}' + (chartNoteData.isSustainEnd ? ' tail' : ' hold'));
			correctionOffset = ClientPrefs.settings.get("downScroll") ? 0 : 55;
			alpha = multAlpha = 0.6;
		} else
			alpha = multAlpha = 1;

		if (ClientPrefs.settings.get("middleScroll") && !mustPress) {
			alpha *= PlayState.middleAlpha;
			multAlpha *= PlayState.middleAlpha;
		}

		sustainScale = chartNoteData.sustainScale;

		switch (ClientPrefs.settings.get("noteColor")) {
			case 'Quant':
				checkNoteQuant(this, isSustainNote ? chartNoteData.parent.strumTime : chartNoteData.strumTime);
			case 'Rainbow':
				colorSwap.hue = ((strumTime / 5000 * 360) / 360) % 1;
			case 'Default':
				colorSwap.hue = ClientPrefs.arrowHSV[
					Std.int(Note.keysShit.get(mania).get('pixelAnimIndex')[noteData] % Note.ammo[mania])
				][0] / 360;
				colorSwap.saturation = ClientPrefs.arrowHSV[
					Std.int(Note.keysShit.get(mania).get('pixelAnimIndex')[noteData] % Note.ammo[mania])
				][1] / 100;
				colorSwap.brightness = ClientPrefs.arrowHSV[
					Std.int(Note.keysShit.get(mania).get('pixelAnimIndex')[noteData] % Note.ammo[mania])
				][2] / 100;
			default:
		}

		clipRect = null;
		return this;
	}

	override function destroy() {
		shader = null;
		colorSwap = null;
		super.destroy();
	}
}

/**
 * Basic class for all `StrumNote`s.
 * This class is used to create the strum line.
 */
class StrumNote extends FlxSprite {
	public var colorSwap:ColorSwap;
	public var resetAnim:Float = 0;
	public var noteData:Int = 0;
	public var direction:Float = 90;
	public var downScroll:Bool = false;
	public var sustainReduce:Bool = true;

	private var animationLengths:Array<Int> = [0, 0, 0];

	public var strum:Int = 0;

	private var player:Int;

	private var skinThing:Array<String> = ['static', 'pressed'];

	public var texture(default, set):String = null;

	inline private function set_texture(value:String):String {
		if (texture != value) {
			texture = value;
			reloadNote();
		}
		return value;
	}

	public function new(x:Float, y:Float, leData:Int, player:Int) {
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;
		noteData = leData;
		this.player = player;
		this.noteData = leData;
		super(x, y);

		var stat:String = Note.keysShit.get(PlayState.mania).get('strumAnims')[leData];
		var pres:String = Note.keysShit.get(PlayState.mania).get('letters')[leData];
		skinThing[0] = stat;
		skinThing[1] = pres;

		var skin:String = 'NOTE_assets';
		if (PlayState.SONG.assets.arrowSkin != null && PlayState.SONG.assets.arrowSkin.length > 1)
			skin = PlayState.SONG.assets.arrowSkin;
		else
			skin = Paths.defaultSkin;
		texture = skin; // Load texture and anims

		scrollFactor.set();
		moves = false;
	}

	public function reloadNote() {
		var lastAnim:String = null;
		if (animation.curAnim != null)
			lastAnim = animation.curAnim.name;

		if (PlayState.isPixelStage) {
			loadGraphic(Paths.image('pixelUI/$texture'), true, 17, 17);
			var daFrames:Array<Int> = Note.keysShit.get(PlayState.mania).get('pixelAnimIndex');

			setGraphicSize(Std.int(width * PlayState.daPixelZoom * Note.pixelScales[PlayState.mania]));
			updateHitbox();
			antialiasing = false;
			animation.add('static', [daFrames[noteData]]);
			animation.add('pressed', [daFrames[noteData] + 18, daFrames[noteData] + 36], 12, false);
			animation.add('confirm', [daFrames[noteData] + 54, daFrames[noteData] + 72], 24, false);
		} else {
			frames = Paths.getSparrowAtlas(texture);

			setGraphicSize(Std.int(width * Note.scales[PlayState.mania]));
			antialiasing = ClientPrefs.settings.get("globalAntialiasing");

			animation.addByPrefix('static', 'arrow' + skinThing[0]);
			animation.addByPrefix('pressed', skinThing[1] + ' press', 24, false);
			animation.addByPrefix('confirm', skinThing[1] + ' confirm', 24, false);
		}
		for (i => anim in ['static', 'pressed', 'confirm'])
			animationLengths[i] = (animation.getByName(anim) != null ? animation.getByName('pressed').numFrames : 1);

		updateHitbox();

		if (lastAnim != null)
			playAnim(lastAnim, true);
		animation.callback = function(name:String, frameNumber:Int, frameIndex:Int) {
			if (name != 'confirm')
				return;
			centerOrigin();
		}
	}

	public function postAddedToGroup() {
		playAnim('static');
		switch (PlayState.mania) {
			case 0 | 1 | 2:
				x += width * noteData;
			case 3:
				x += (Note.swagWidth * noteData);
			default:
				x += ((width - Note.lessX[PlayState.mania]) * noteData);
		}

		x += Note.xtra[PlayState.mania];

		x += 50;
		x += ((FlxG.width / 2) * player);
		ID = noteData;
		x -= Note.posRest[PlayState.mania];
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (resetAnim <= 0)
			return;

		resetAnim -= elapsed;
		if (resetAnim <= 0) {
			playAnim('static');
			resetAnim = 0;
		}
	}

	override function destroy() {
		shader = null;
		colorSwap = null;
		super.destroy();
	}

	public function playAnim(anim:String, ?force:Bool = false, ?hsb:Array<Float>) {
		animation.play(anim, force);
		centerOffsets();
		centerOrigin();
		active = true;
		// hopefully makes it not fuck up animations for custom notes lol
		if (animation.curAnim != null) {
			switch (animation.curAnim.name) {
				case 'static':
					if (animationLengths[0] < 2)
						active = false;
				case 'confirm':
					if (animationLengths[1] < 2)
						active = false;
				case 'pressed':
					if (animationLengths[2] < 2)
						active = false;
			}
		} else {
			active = false;
		}

		if (animation.curAnim == null || animation.curAnim.name == 'static') {
			colorSwap.hue = 0;
			colorSwap.saturation = 0;
			colorSwap.brightness = 0;
		} else {
			if (hsb == null || ClientPrefs.settings.get("noteColor") == 'Normal') {
				colorSwap.hue = ClientPrefs.arrowHSV[
					Std.int(Note.keysShit.get(PlayState.mania).get('pixelAnimIndex')[noteData] % Note.ammo[PlayState.mania])
				][0] / 360;
				colorSwap.saturation = ClientPrefs.arrowHSV[
					Std.int(Note.keysShit.get(PlayState.mania).get('pixelAnimIndex')[noteData] % Note.ammo[PlayState.mania])
				][1] / 100;
				colorSwap.brightness = ClientPrefs.arrowHSV[
					Std.int(Note.keysShit.get(PlayState.mania).get('pixelAnimIndex')[noteData] % Note.ammo[PlayState.mania])
				][2] / 100;
			} else {
				colorSwap.hue = hsb[0];
				colorSwap.saturation = hsb[1];
				colorSwap.brightness = hsb[2];
			}

			if (PlayState.isPixelStage)
				return;
			if (animation.curAnim.name == 'confirm')
				centerOrigin();
		}
	}
}

/**
 * Basic class for all `NoteSplash`s.
 */
class NoteSplash extends FlxSprite {
	public var colorSwap:ColorSwap = null;

	private var idleAnim:String;
	private var textureLoaded:String = null;

	var sc:Array<Float> = [1.3, 1.2, 1.1, 1, 1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1];

	public function new(x:Float = 0, y:Float = 0, ?note:Int = 0) {
		super(x, y);

		var skin:String = switch (ClientPrefs.settings.get("noteColor")) {
			default: (PlayState.isPixelStage ? 'splashes/pixelSplashes' : 'splashes/noteSplashes');
			case 'Greyscale': (PlayState.isPixelStage ? 'splashes/GREYSCALE_pixelSplashes' : 'splashes/GREYSCALE_noteSplashes');
			case 'Rainbow', 'Quant': (PlayState.isPixelStage ? 'splashes/RED_pixelSplashes' : 'splashes/RED_noteSplashes');
		}

		if (PlayState.SONG.assets.splashSkin != null && PlayState.SONG.assets.splashSkin.length > 0)
			skin = PlayState.SONG.assets.splashSkin;

		loadAnims(skin);
		textureLoaded = skin;

		colorSwap = new ColorSwap();
		shader = colorSwap.shader;

		// setupNoteSplash(x, y, note, skin);
		moves = false;
	}

	private function isDefaultTexture(texture:String) {
		var normal:Bool = texture == 'splashes/noteSplashes';
		var grayed:Bool = texture == 'splashes/GREYSCALE_noteSplashes';
		var others:Bool = texture == 'splashes/RED_noteSplashes';
		return normal || grayed || others;
	}

	private function isPixelatedTexture(texture:String) {
		var normal:Bool = texture == 'splashes/pixelSplashes';
		var grayed:Bool = texture == 'splashes/GREYSCALE_pixelSplashes';
		var others:Bool = texture == 'splashes/RED_pixelSplashes';
		return normal || grayed || others;
	}

	public function setupNoteSplash(x:Float, y:Float, note:Int = 0, texture:String = null, hueColor:Float = 0, satColor:Float = 0, brtColor:Float = 0) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
		if (PlayState.isPixelStage) {
			setGraphicSize(Std.int(width * PlayState.daPixelZoom * sc[PlayState.mania]));
			antialiasing = false;
			setPosition((x + 150) - Note.swagWidth * 0.95, (y + 150) - Note.swagWidth);
		} else {
			setGraphicSize(Std.int(width * sc[PlayState.mania]));
		}

		alpha = 0.6;

		if (texture == null && PlayState.SONG.assets.splashSkin != null && PlayState.SONG.assets.splashSkin.length > 0)
			texture = PlayState.SONG.assets.splashSkin;

		if (textureLoaded != texture) {
			loadAnims(texture);
			textureLoaded = texture;
		}

		colorSwap.hue = hueColor;
		colorSwap.saturation = satColor;
		colorSwap.brightness = brtColor;

		if (ClientPrefs.settings.get("noteColor") == 'Rainbow' || ClientPrefs.settings.get("noteColor") == 'Quant')
			note = 3; // if i use the red splash texture itll make a splash that plays twice

		offset.set(-34 * Note.scales[PlayState.mania], -23 * Note.scales[PlayState.mania]);
		if (PlayState.isPixelStage || !isDefaultTexture(texture))
			offset.set(20 / Note.scales[PlayState.mania], 7 / Note.scales[PlayState.mania]);

		var fps:Int = (isPixelatedTexture(texture) ? 42 : 24);

		animation.play('note' + Note.keysShit.get(PlayState.mania).get('pixelAnimIndex')[note] + (!PlayState.isPixelStage ? '-${FlxG.random.int(1, 2)}' : ''),
			true, false);

		if (animation.curAnim != null) {
			animation.curAnim.frameRate = fps + FlxG.random.int(-2, 2);
		}
		animation.finishCallback = name -> {
			kill();
			if (PlayState.instance != null)
				PlayState.instance.grpNoteSplashes.remove(this, true);
			destroy();
		}
	}

	function loadAnims(skin:String) {
		frames = Paths.getSparrowAtlas(skin);
		var usingDefault:Bool = isDefaultTexture(skin) && !isPixelatedTexture(skin);
		for (i in 0...26) {
			animation.addByPrefix('note$i${usingDefault ? '-1' : ''}', 'note splash ${Note.keysShit.get(8).get('letters')[i]} ${usingDefault ? '1 ' : ''}',
				48, false);
			if (!usingDefault)
				continue;
			animation.addByPrefix('note$i-2', 'note splash ${Note.keysShit.get(8).get('letters')[i]} 2 ', 48, false);
		}
		// Sys.println('Animation Count: ${animation.getNameList().length}');
	}

	override function destroy() {
		shader = null;
		colorSwap = null;
		super.destroy();
	}
}
