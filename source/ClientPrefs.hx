package;

import Controls;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSave;
import lime.app.Application;

/**
 * Class containing all settings.
 * Automatically saves and loads.
 */
class ClientPrefs {
	public static var settings:Map<String, Dynamic> = [
		// Name, Value
		// Bools
		"downScroll" => false,
		"middleScroll" => false,
		"showFPS" => true,
		"autoPause" => true,
		"flashing" => true,
		"globalAntialiasing" => true,
		"noteSplashes" => false,
		"lowQuality" => false,
		"ogIcons" => false,
		"animateMouse" => true,
		"camZooms" => true,
		"camPans" => true,
		"hideHud" => false,
		"ghostTapping" => true,
		"scoreZoom" => true,
		"noReset" => true,
		"watermarks" => true,
		"ratingsDisplay" => true,
		"gsMiss" => false,
		"ogHp" => false,
		"wrongCamera" => false,
		"msPopup" => true,
		"flinching" => true,
		"disableBotIcon" => false,
		"checkForUpdates" => true,
		"subtitles" => true,
		"complexAccuracy" => false,
		"sustainsAreNotes" => true,
		"ratingVisibility" => true,
		"rainbowFPS" => false,
		"missSoundShit" => false,
		"strumVisibility" => true,
		"healthBarVisibility" => true,
		"ffmpegMode" => false,
		"ffmpegInfo" => false,
		"coolFreeplay" => true,
		"shadersEnabled" => true,
		"modifierVisibility" => true,
		// Ints
		"framerate" => 60,
		"noteOffset" => 0,
		"ratingOffset" => 0,
		"perfectWindow" => 15,
		"sickWindow" => 45,
		"goodWindow" => 90,
		"badWindow" => 135,
		"shitWindow" => 180,
		"targetFPS" => 60,
		// Floats
		"hitsoundVolume" => 0,
		"safeFrames" => 10,
		"colorblindIntensity" => 1,
		"renderBitrate" => 5.00,
		"mobileCAlpha" => (FlxG.onMobile) ? 0.6 : 0,
		// Strings
		"resolution" => "1280x720",
		"uiSkin" => "Kade",
		"noteColor" => "Default",
		"iconAnim" => "Bop",
		"scoreDisplay" => "DenpaEx",
		"timeBarType" => "Elapsed / Left",
		"pauseMusic" => "Breakfast",
		"cutscenes" => "Story Mode Only",
		"colorblindMode" => "None",
		#if android "storageType" => "EXTERNAL_DATA", #end
		// Arrays
		"crossFadeData" => ['Default', 'Healthbar', [255, 255, 255], 0.3, 0.35],
	];

	public static var gameplaySettings:Map<String, Dynamic> = [
		'scrollspeed' => 1.0,
		'scrolltype' => 'multiplicative',
		'songspeed' => 1.0,
		'healthgain' => 1.0,
		'healthloss' => 1.0,
		'instakill' => false,
		'practice' => false,
		'botplay' => false,
		'poison' => false,
		'sickonly' => false,
		'freeze' => false,
		'flashlight' => false,
		'quartiz' => false,
		'ghostmode' => false,
		'randommode' => false,
		'flip' => false
	];

	public static var arrowHSV:Array<Array<Int>> = [
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0]
	];
	public static var comboOffset:Array<Int> = [0, 0, 0, 0, 0, 0];

	// Every key has two binds, default, and alt.
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		// Key Bind, Name for ControlsSubState
		'note_41' => [D],
		'note_42' => [F],
		'note_43' => [J],
		'note_44' => [K], // who actually used WASD by choice
		'ui_left' => [LEFT],
		'ui_down' => [DOWN],
		'ui_up' => [UP],
		'ui_right' => [RIGHT],
		'accept' => [SPACE, ENTER],
		'back' => [BACKSPACE, ESCAPE],
		'pause' => [ENTER, ESCAPE],
		'reset' => [R],
		'volume_mute' => [ZERO],
		'volume_up' => [NUMPADPLUS, PLUS],
		'volume_down' => [NUMPADMINUS, MINUS],
		'debug_1' => [SEVEN],
		'debug_2' => [EIGHT],
		'manual' => [F12],
		'note_11' => [SPACE, UP],
		'note_21' => [D, LEFT],
		'note_22' => [K, RIGHT],
		'note_31' => [D, LEFT],
		'note_32' => [SPACE, UP],
		'note_33' => [K, RIGHT],
		'note_51' => [D, LEFT],
		'note_52' => [F, DOWN],
		'note_53' => [SPACE, NUMPADZERO],
		'note_54' => [J, UP],
		'note_55' => [K, RIGHT],
		'note_61' => [S, LEFT],
		'note_62' => [D, DOWN],
		'note_63' => [F, NUMPADFOUR],
		'note_64' => [J, NUMPADSIX],
		'note_65' => [K, UP],
		'note_66' => [L, RIGHT],
		'note_71' => [S, LEFT],
		'note_72' => [D, DOWN],
		'note_73' => [F, NUMPADFOUR],
		'note_74' => [SPACE, NUMPADZERO],
		'note_75' => [J, NUMPADSIX],
		'note_76' => [K, UP],
		'note_77' => [L, RIGHT],
		'note_81' => [A, LEFT],
		'note_82' => [S, DOWN],
		'note_83' => [D, UP],
		'note_84' => [F, RIGHT],
		'note_85' => [H, NUMPADFOUR],
		'note_86' => [J, NUMPADEIGHT],
		'note_87' => [K, NUMPADSIX],
		'note_88' => [L, NUMPADTWO],
		'note_91' => [A, LEFT],
		'note_92' => [S, DOWN],
		'note_93' => [D, UP],
		'note_94' => [F, RIGHT],
		'note_95' => [SPACE, NUMPADZERO],
		'note_96' => [H, NUMPADFOUR],
		'note_97' => [J, NUMPADEIGHT],
		'note_98' => [K, NUMPADSIX],
		'note_99' => [L, NUMPADTWO],
		'note_101' => [A, LEFT],
		'note_102' => [S, DOWN],
		'note_103' => [D, UP],
		'note_104' => [F, RIGHT],
		'note_105' => [C, NUMPADZERO],
		'note_106' => [M, NUMPADZERO],
		'note_107' => [H, NUMPADFOUR],
		'note_108' => [J, NUMPADEIGHT],
		'note_109' => [K, NUMPADSIX],
		'note_1010' => [L, NUMPADTWO],
		'note_111' => [A, LEFT],
		'note_112' => [S, DOWN],
		'note_113' => [D, UP],
		'note_114' => [F, RIGHT],
		'note_115' => [C, NUMPADZERO],
		'note_116' => [SPACE, NUMPADZERO],
		'note_117' => [M, NUMPADZERO],
		'note_118' => [H, NUMPADFOUR],
		'note_119' => [J, NUMPADEIGHT],
		'note_1110' => [K, NUMPADSIX],
		'note_1111' => [L, NUMPADTWO],
		'note_121' => [A, LEFT],
		'note_122' => [S, DOWN],
		'note_123' => [D, UP],
		'note_124' => [F, RIGHT],
		'note_125' => [C, NUMPADZERO],
		'note_126' => [V, NUMPADZERO],
		'note_127' => [N, NUMPADZERO],
		'note_128' => [M, NUMPADZERO],
		'note_129' => [H, NUMPADFOUR],
		'note_1210' => [J, NUMPADEIGHT],
		'note_1211' => [K, NUMPADSIX],
		'note_1212' => [L, NUMPADTWO],
		'note_131' => [A, LEFT],
		'note_132' => [S, DOWN],
		'note_133' => [D, UP],
		'note_134' => [F, RIGHT],
		'note_135' => [C, NUMPADZERO],
		'note_136' => [V, NUMPADZERO],
		'note_137' => [SPACE, NUMPADZERO],
		'note_138' => [N, NUMPADZERO],
		'note_139' => [M, NUMPADZERO],
		'note_1310' => [H, NUMPADFOUR],
		'note_1311' => [J, NUMPADEIGHT],
		'note_1312' => [K, NUMPADSIX],
		'note_1313' => [L, NUMPADTWO],
		'note_141' => [A, LEFT],
		'note_142' => [S, DOWN],
		'note_143' => [D, UP],
		'note_144' => [F, RIGHT],
		'note_145' => [X, NUMPADZERO],
		'note_146' => [C, NUMPADZERO],
		'note_147' => [V, NUMPADZERO],
		'note_148' => [N, NUMPADZERO],
		'note_149' => [M, NUMPADZERO],
		'note_1410' => [COMMA, NUMPADZERO],
		'note_1411' => [H, NUMPADFOUR],
		'note_1412' => [J, NUMPADEIGHT],
		'note_1413' => [K, NUMPADSIX],
		'note_1414' => [L, NUMPADTWO],
		'note_151' => [A, LEFT],
		'note_152' => [S, DOWN],
		'note_153' => [D, UP],
		'note_154' => [F, RIGHT],
		'note_155' => [X, NUMPADZERO],
		'note_156' => [C, NUMPADZERO],
		'note_157' => [V, NUMPADZERO],
		'note_158' => [SPACE, NUMPADZERO],
		'note_159' => [N, NUMPADZERO],
		'note_1510' => [M, NUMPADZERO],
		'note_1511' => [COMMA, NUMPADZERO],
		'note_1512' => [H, NUMPADFOUR],
		'note_1513' => [J, NUMPADEIGHT],
		'note_1514' => [K, NUMPADSIX],
		'note_1515' => [L, NUMPADTWO],
		'note_161' => [Q, LEFT],
		'note_162' => [W, DOWN],
		'note_163' => [E, UP],
		'note_164' => [R, RIGHT],
		'note_165' => [A, NUMPADZERO],
		'note_166' => [S, NUMPADZERO],
		'note_167' => [D, NUMPADZERO],
		'note_168' => [F, NUMPADZERO],
		'note_169' => [H, NUMPADZERO],
		'note_1610' => [J, NUMPADZERO],
		'note_1611' => [K, NUMPADZERO],
		'note_1612' => [L, NUMPADZERO],
		'note_1613' => [U, NUMPADFOUR],
		'note_1614' => [I, NUMPADEIGHT],
		'note_1615' => [O, NUMPADSIX],
		'note_1616' => [P, NUMPADTWO],
		'note_171' => [Q, LEFT],
		'note_172' => [W, DOWN],
		'note_173' => [E, UP],
		'note_174' => [R, RIGHT],
		'note_175' => [A, NUMPADZERO],
		'note_176' => [S, NUMPADZERO],
		'note_177' => [D, NUMPADZERO],
		'note_178' => [F, NUMPADZERO],
		'note_179' => [SPACE, NUMPADZERO],
		'note_1710' => [H, NUMPADZERO],
		'note_1711' => [J, NUMPADZERO],
		'note_1712' => [K, NUMPADZERO],
		'note_1713' => [L, NUMPADZERO],
		'note_1714' => [U, NUMPADFOUR],
		'note_1715' => [I, NUMPADEIGHT],
		'note_1716' => [O, NUMPADSIX],
		'note_1717' => [P, NUMPADTWO],
		'note_181' => [Q, LEFT],
		'note_182' => [W, DOWN],
		'note_183' => [E, UP],
		'note_184' => [R, RIGHT],
		'note_185' => [A, NUMPADZERO],
		'note_186' => [S, NUMPADZERO],
		'note_187' => [D, NUMPADZERO],
		'note_188' => [F, NUMPADZERO],
		'note_189' => [C, NUMPADZERO],
		'note_1810' => [M, NUMPADZERO],
		'note_1811' => [H, NUMPADZERO],
		'note_1812' => [J, NUMPADZERO],
		'note_1813' => [K, NUMPADZERO],
		'note_1814' => [L, NUMPADZERO],
		'note_1815' => [U, NUMPADFOUR],
		'note_1816' => [I, NUMPADEIGHT],
		'note_1817' => [O, NUMPADSIX],
		'note_1818' => [P, NUMPADTWO],
		'note_191' => [Q, LEFT],
		'note_192' => [W, DOWN],
		'note_193' => [E, UP],
		'note_194' => [R, RIGHT],
		'note_195' => [A, NUMPADZERO],
		'note_196' => [S, NUMPADZERO],
		'note_197' => [D, NUMPADZERO],
		'note_198' => [F, NUMPADZERO],
		'note_199' => [C, NUMPADZERO],
		'note_1910' => [SPACE, NUMPADZERO],
		'note_1911' => [M, NUMPADZERO],
		'note_1912' => [H, NUMPADZERO],
		'note_1913' => [J, NUMPADZERO],
		'note_1914' => [K, NUMPADZERO],
		'note_1915' => [L, NUMPADZERO],
		'note_1916' => [U, NUMPADFOUR],
		'note_1917' => [I, NUMPADEIGHT],
		'note_1918' => [O, NUMPADSIX],
		'note_1919' => [P, NUMPADTWO],
		'note_201' => [Q, LEFT],
		'note_202' => [W, DOWN],
		'note_203' => [E, UP],
		'note_204' => [R, RIGHT],
		'note_205' => [A, NUMPADZERO],
		'note_206' => [S, NUMPADZERO],
		'note_207' => [D, NUMPADZERO],
		'note_208' => [F, NUMPADZERO],
		'note_209' => [C, NUMPADZERO],
		'note_2010' => [V, NUMPADZERO],
		'note_2011' => [M, NUMPADZERO],
		'note_2012' => [COMMA, NUMPADZERO],
		'note_2013' => [H, NUMPADZERO],
		'note_2014' => [J, NUMPADZERO],
		'note_2015' => [K, NUMPADZERO],
		'note_2016' => [L, NUMPADZERO],
		'note_2017' => [U, NUMPADFOUR],
		'note_2018' => [I, NUMPADEIGHT],
		'note_2019' => [O, NUMPADSIX],
		'note_2020' => [P, NUMPADTWO],
		'note_211' => [Q, LEFT],
		'note_212' => [W, DOWN],
		'note_213' => [E, UP],
		'note_214' => [R, RIGHT],
		'note_215' => [A, NUMPADZERO],
		'note_216' => [S, NUMPADZERO],
		'note_217' => [D, NUMPADZERO],
		'note_218' => [F, NUMPADZERO],
		'note_219' => [C, NUMPADZERO],
		'note_2110' => [V, NUMPADZERO],
		'note_2111' => [SPACE, NUMPADZERO],
		'note_2112' => [M, NUMPADZERO],
		'note_2113' => [COMMA, NUMPADZERO],
		'note_2114' => [H, NUMPADZERO],
		'note_2115' => [J, NUMPADZERO],
		'note_2116' => [K, NUMPADZERO],
		'note_2117' => [L, NUMPADZERO],
		'note_2118' => [U, NUMPADFOUR],
		'note_2119' => [I, NUMPADEIGHT],
		'note_2120' => [O, NUMPADSIX],
		'note_2121' => [P, NUMPADTWO],
		'note_221' => [Q, LEFT],
		'note_222' => [W, DOWN],
		'note_223' => [E, UP],
		'note_224' => [R, RIGHT],
		'note_225' => [A, NUMPADZERO],
		'note_226' => [S, NUMPADZERO],
		'note_227' => [D, NUMPADZERO],
		'note_228' => [F, NUMPADZERO],
		'note_229' => [X, NUMPADZERO],
		'note_2210' => [C, NUMPADZERO],
		'note_2211' => [V, NUMPADZERO],
		'note_2212' => [M, NUMPADZERO],
		'note_2213' => [COMMA, NUMPADZERO],
		'note_2214' => [PERIOD, NUMPADZERO],
		'note_2215' => [H, NUMPADZERO],
		'note_2216' => [J, NUMPADZERO],
		'note_2217' => [K, NUMPADZERO],
		'note_2218' => [L, NUMPADZERO],
		'note_2219' => [U, NUMPADFOUR],
		'note_2220' => [I, NUMPADEIGHT],
		'note_2221' => [O, NUMPADSIX],
		'note_2222' => [P, NUMPADTWO],
		'note_231' => [Q, LEFT],
		'note_232' => [W, DOWN],
		'note_233' => [E, UP],
		'note_234' => [R, RIGHT],
		'note_235' => [A, NUMPADZERO],
		'note_236' => [S, NUMPADZERO],
		'note_237' => [D, NUMPADZERO],
		'note_238' => [F, NUMPADZERO],
		'note_239' => [X, NUMPADZERO],
		'note_2310' => [C, NUMPADZERO],
		'note_2311' => [V, NUMPADZERO],
		'note_2312' => [SPACE, NUMPADZERO],
		'note_2313' => [M, NUMPADZERO],
		'note_2314' => [COMMA, NUMPADZERO],
		'note_2315' => [PERIOD, NUMPADZERO],
		'note_2316' => [H, NUMPADZERO],
		'note_2317' => [J, NUMPADZERO],
		'note_2318' => [K, NUMPADZERO],
		'note_2319' => [L, NUMPADZERO],
		'note_2320' => [U, NUMPADFOUR],
		'note_2321' => [I, NUMPADEIGHT],
		'note_2322' => [O, NUMPADSIX],
		'note_2323' => [P, NUMPADTWO],
		'note_241' => [Q, LEFT],
		'note_242' => [W, DOWN],
		'note_243' => [E, UP],
		'note_244' => [R, RIGHT],
		'note_245' => [A, NUMPADZERO],
		'note_246' => [S, NUMPADZERO],
		'note_247' => [D, NUMPADZERO],
		'note_248' => [F, NUMPADZERO],
		'note_249' => [Z, NUMPADZERO],
		'note_2410' => [X, NUMPADZERO],
		'note_2411' => [C, NUMPADZERO],
		'note_2412' => [V, NUMPADZERO],
		'note_2413' => [B, NUMPADZERO],
		'note_2414' => [N, NUMPADZERO],
		'note_2415' => [M, NUMPADZERO],
		'note_2416' => [COMMA, NUMPADZERO],
		'note_2417' => [H, NUMPADZERO],
		'note_2418' => [J, NUMPADZERO],
		'note_2419' => [K, NUMPADZERO],
		'note_2420' => [L, NUMPADZERO],
		'note_2421' => [U, NUMPADFOUR],
		'note_2422' => [I, NUMPADEIGHT],
		'note_2423' => [O, NUMPADSIX],
		'note_2424' => [P, NUMPADTWO],
		'note_251' => [Q, LEFT],
		'note_252' => [W, DOWN],
		'note_253' => [E, UP],
		'note_254' => [R, RIGHT],
		'note_255' => [A, NUMPADZERO],
		'note_256' => [S, NUMPADZERO],
		'note_257' => [D, NUMPADZERO],
		'note_258' => [F, NUMPADZERO],
		'note_259' => [Z, NUMPADZERO],
		'note_2510' => [X, NUMPADZERO],
		'note_2511' => [C, NUMPADZERO],
		'note_2512' => [V, NUMPADZERO],
		'note_2513' => [SPACE, NUMPADZERO],
		'note_2514' => [B, NUMPADZERO],
		'note_2515' => [N, NUMPADZERO],
		'note_2516' => [M, NUMPADZERO],
		'note_2517' => [COMMA, NUMPADZERO],
		'note_2518' => [H, NUMPADZERO],
		'note_2519' => [J, NUMPADZERO],
		'note_2520' => [K, NUMPADZERO],
		'note_2521' => [L, NUMPADZERO],
		'note_2522' => [U, NUMPADFOUR],
		'note_2523' => [I, NUMPADEIGHT],
		'note_2524' => [O, NUMPADSIX],
		'note_2525' => [P, NUMPADTWO],
		'note_261' => [Q, LEFT],
		'note_262' => [W, DOWN],
		'note_263' => [E, UP],
		'note_264' => [R, RIGHT],
		'note_265' => [A, NUMPADZERO],
		'note_266' => [S, NUMPADZERO],
		'note_267' => [D, NUMPADZERO],
		'note_268' => [F, NUMPADZERO],
		'note_269' => [Z, NUMPADZERO],
		'note_2610' => [X, NUMPADZERO],
		'note_2611' => [C, NUMPADZERO],
		'note_2612' => [V, NUMPADZERO],
		'note_2613' => [SPACE, NUMPADZERO],
		'note_2614' => [G, NUMPADZERO],
		'note_2615' => [B, NUMPADZERO],
		'note_2616' => [N, NUMPADZERO],
		'note_2617' => [M, NUMPADZERO],
		'note_2618' => [COMMA, NUMPADZERO],
		'note_2619' => [H, NUMPADZERO],
		'note_2620' => [J, NUMPADZERO],
		'note_2621' => [K, NUMPADZERO],
		'note_2622' => [L, NUMPADZERO],
		'note_2623' => [U, NUMPADFOUR],
		'note_2624' => [I, NUMPADEIGHT],
		'note_2625' => [O, NUMPADSIX],
		'note_2626' => [P, NUMPADTWO]
	];

	// gamepad keybinds yeye
	// TODO: though, they arent programmed into the actual playstate yet
	public static var gamepadBinds:Map<String, Array<FlxGamepadInputID>> = [
		'note_41' => [X, DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT, RIGHT_STICK_DIGITAL_LEFT],
		'note_42' => [A, DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN, RIGHT_STICK_DIGITAL_DOWN],
		'note_43' => [Y, DPAD_UP, LEFT_STICK_DIGITAL_UP, RIGHT_STICK_DIGITAL_UP],
		'note_44' => [B, DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT, RIGHT_STICK_DIGITAL_RIGHT],
		'ui_left' => [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'ui_down' => [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
		'ui_up' => [DPAD_UP, LEFT_STICK_DIGITAL_UP],
		'ui_right' => [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
		'accept' => [A, START],
		'back' => [B, BACK],
		'pause' => [START],
		'reset' => [LEFT_STICK_CLICK],
		'note_11' => [Y, DPAD_UP, LEFT_STICK_DIGITAL_UP, RIGHT_STICK_DIGITAL_UP],
		'note_21' => [X, DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT, RIGHT_STICK_DIGITAL_LEFT],
		'note_22' => [B, DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT, RIGHT_STICK_DIGITAL_RIGHT],
		'note_31' => [X, DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT, RIGHT_STICK_DIGITAL_LEFT],
		'note_32' => [Y, DPAD_UP, LEFT_STICK_DIGITAL_UP, RIGHT_STICK_DIGITAL_UP],
		'note_33' => [B, DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT, RIGHT_STICK_DIGITAL_RIGHT],
		'note_51' => [X, DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT, RIGHT_STICK_DIGITAL_LEFT],
		'note_52' => [A, DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN, RIGHT_STICK_DIGITAL_DOWN],
		'note_53' => [LEFT_STICK_CLICK, RIGHT_STICK_CLICK], // Kinda hard to figure out??
		'note_54' => [Y, DPAD_UP, LEFT_STICK_DIGITAL_UP, RIGHT_STICK_DIGITAL_UP],
		'note_55' => [B, DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT, RIGHT_STICK_DIGITAL_RIGHT],
		'note_61' => [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'note_62' => [A, DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN, RIGHT_STICK_DIGITAL_DOWN],
		'note_63' => [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
		'note_64' => [X, RIGHT_STICK_DIGITAL_LEFT],
		'note_65' => [Y, DPAD_UP, LEFT_STICK_DIGITAL_UP, RIGHT_STICK_DIGITAL_UP],
		'note_66' => [B, RIGHT_STICK_DIGITAL_RIGHT],
		'note_71' => [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'note_72' => [A, DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN, RIGHT_STICK_DIGITAL_DOWN],
		'note_73' => [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
		'note_74' => [LEFT_STICK_CLICK, RIGHT_STICK_CLICK],
		'note_75' => [X, RIGHT_STICK_DIGITAL_LEFT],
		'note_76' => [Y, DPAD_UP, LEFT_STICK_DIGITAL_UP, RIGHT_STICK_DIGITAL_UP],
		'note_77' => [B, RIGHT_STICK_DIGITAL_RIGHT],
		'note_81' => [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'note_82' => [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
		'note_83' => [DPAD_UP, LEFT_STICK_DIGITAL_UP],
		'note_84' => [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
		'note_85' => [X, RIGHT_STICK_DIGITAL_LEFT],
		'note_86' => [A, RIGHT_STICK_DIGITAL_DOWN],
		'note_87' => [Y, RIGHT_STICK_DIGITAL_UP],
		'note_88' => [B, RIGHT_STICK_DIGITAL_RIGHT],
		'note_91' => [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'note_92' => [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
		'note_93' => [DPAD_UP, LEFT_STICK_DIGITAL_UP],
		'note_94' => [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
		'note_95' => [LEFT_STICK_CLICK, RIGHT_STICK_CLICK],
		'note_96' => [X, RIGHT_STICK_DIGITAL_LEFT],
		'note_97' => [A, RIGHT_STICK_DIGITAL_DOWN],
		'note_98' => [Y, RIGHT_STICK_DIGITAL_UP],
		'note_99' => [B, RIGHT_STICK_DIGITAL_RIGHT],
		'note_101' => [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'note_102' => [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
		'note_103' => [DPAD_UP, LEFT_STICK_DIGITAL_UP],
		'note_104' => [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
		'note_105' => [LEFT_STICK_CLICK, RIGHT_STICK_CLICK],
		'note_106' => [X, RIGHT_STICK_DIGITAL_LEFT],
		'note_107' => [A, RIGHT_STICK_DIGITAL_DOWN],
		'note_108' => [Y, RIGHT_STICK_DIGITAL_UP],
		'note_109' => [B, RIGHT_STICK_DIGITAL_RIGHT],
		'note_1010' => [B, RIGHT_STICK_DIGITAL_RIGHT],
		'note_111' => [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'note_112' => [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
		'note_113' => [DPAD_UP, LEFT_STICK_DIGITAL_UP],
		'note_114' => [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
		'note_115' => [LEFT_STICK_CLICK, RIGHT_STICK_CLICK],
		'note_116' => [X, RIGHT_STICK_DIGITAL_LEFT],
		'note_117' => [A, RIGHT_STICK_DIGITAL_DOWN],
		'note_118' => [Y, RIGHT_STICK_DIGITAL_UP],
		'note_119' => [B, RIGHT_STICK_DIGITAL_RIGHT],
		'note_1110' => [B, RIGHT_STICK_DIGITAL_RIGHT],
		'note_1111' => [B, RIGHT_STICK_DIGITAL_RIGHT]
	];
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	public static var controllerEnabled:Bool = FlxG.onMobile; // we use this shit to make sure not to check for controller inputs unless needed
	private static var controlsPostfix:String = '_';
	private static var FORCE_CASE_SENSITIVITY:Bool = false;

	/**
	 * Returns a `Bool` dictating whether a specific keybind is pressed/released.
	 * 
	 * @param keyToCheck `String` dictating the key that will be checked. Adding `_p` to the end of the key name checks for just pressed, and adding `_r` checks for just released. Otherwise, pressed will be checked
	 */
	public static function control(keyToCheck:String):Bool {
		final individualKey:Array<String> = FORCE_CASE_SENSITIVITY ? keyToCheck.split(controlsPostfix) : keyToCheck.toLowerCase().split(controlsPostfix);
		final pureBindName:String = individualKey.join(controlsPostfix).replace(controlsPostfix + individualKey[individualKey.length - 1], '');
		final keyArray:Array<FlxKey> = keyBinds.get(pureBindName);
		final gamepadArray:Array<FlxGamepadInputID> = (gamepadBinds.exists(pureBindName) ? gamepadBinds.get(pureBindName) : [NONE]);

		final check = individualKey[individualKey.length - 1].toLowerCase();
		switch (check) {
			case 'p':
				return (FlxG.keys.anyJustPressed(keyArray) ? true : getGamepad(gamepadArray, check));
			case 'r':
				return (FlxG.keys.anyJustReleased(keyArray) ? true : getGamepad(gamepadArray, check));
			default:
				return (FlxG.keys.anyPressed(keyArray) ? true : getGamepad(gamepadArray, check));
		}
		return false;
	}

	private static function getGamepad(keys:Array<FlxGamepadInputID>, check:String):Bool {
		if (keys == null || keys.contains(NONE))
			return false;
		for (key in keys) {
			// may look strange but this is bcs you cant do anyJustPressed and shit on gamepads
			// it doesnt return false because that would break the loop and return early
			switch (check) {
				case 'p':
					if (FlxG.gamepads.anyJustPressed(key)) {
						return true;
					}
				case 'r':
					if (FlxG.gamepads.anyJustReleased(key)) {
						return true;
					}
				default:
					if (FlxG.gamepads.anyPressed(key)) {
						return true;
					}
			}
		}
		return false;
	}

	// for why?
	inline public static function loadDefaultKeys() {
		defaultKeys = keyBinds.copy();
	}

	public static function saveSettings() {
		var settingsSave:FlxSave = new FlxSave();
		settingsSave.bind('settings');
		settingsSave.data.arrowHSV = arrowHSV;
		settingsSave.data.comboOffset = comboOffset;
		settingsSave.data.settings = settings;
		settingsSave.data.gameplaySettings = gameplaySettings;
		settingsSave.close();

		var controlsSave:FlxSave = new FlxSave();
		controlsSave.bind('controls_v3'); // Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		controlsSave.data.customControls = keyBinds;
		controlsSave.close();

		FlxG.log.add("Settings saved!");
	}

	public static function loadPrefs() {
		var settingsSave:FlxSave = new FlxSave();
		settingsSave.bind('settings');

		if (settingsSave != null) {
			// something about settings.set
			if (settingsSave.data.settings != null) {
				var savedMap:Map<String, Dynamic> = settingsSave.data.settings;
				for (name => value in savedMap) {
					switch (name) {
						case "framerate":
							// need to do this because flixel big weird
							if (value > FlxG.drawFramerate) {
								FlxG.updateFramerate = value;
								FlxG.drawFramerate = value;
							} else {
								FlxG.drawFramerate = value;
								FlxG.updateFramerate = value;
							}
						case "globalAntialiasing":
							flixel.FlxSprite.defaultAntialiasing = value;
							FlxG.mouse.unload();
							flixel.input.mouse.FlxMouse.antialiasing = value;
							FlxG.mouse.load();
						case "animateMouse":
							flixel.input.mouse.FlxMouse.animated = value;
						case "resolution":
							var val = cast(value, String);
							var split = val.split("x");
							CoolUtil.resetResolutionScaling(Std.parseInt(split[0]), Std.parseInt(split[1]));
							#if !mobile
							FlxG.resizeGame(Std.parseInt(split[0]), Std.parseInt(split[1]));
							Application.current.window.width = Std.parseInt(split[0]);
							Application.current.window.height = Std.parseInt(split[1]);
							#end
						#if !html5
						case "autoPause":
							FlxG.autoPause = value;
						#end
					}
					settings.set(name, value);
				}
			}

			if (settingsSave.data.gameplaySettings != null) {
				var savedMap:Map<String, Dynamic> = settingsSave.data.gameplaySettings;
				for (name => value in savedMap) {
					gameplaySettings.set(name, value);
				}
			}

			if (settingsSave.data.arrowHSV != null)
				arrowHSV = settingsSave.data.arrowHSV;
			if (settingsSave.data.comboOffset != null)
				comboOffset = settingsSave.data.comboOffset;
		}
		settingsSave.destroy();

		var controlsSave:FlxSave = new FlxSave();
		controlsSave.bind('controls_v3');
		if (controlsSave != null && controlsSave.data.customControls != null) {
			var loadedControls:Map<String, Array<FlxKey>> = controlsSave.data.customControls;
			for (control => keys in loadedControls) {
				keyBinds.set(control, keys);
			}
			reloadControls();
		}
		controlsSave.destroy();

		// flixel automatically saves your volume!
		if (FlxG.save.data.volume != null)
			FlxG.sound.volume = FlxG.save.data.volume;
		if (FlxG.save.data.mute != null)
			FlxG.sound.muted = FlxG.save.data.mute;
	}

	inline public static function getGameplaySetting(name:String, defaultValue:Dynamic):Dynamic {
		return (gameplaySettings.exists(name) ? gameplaySettings.get(name) : defaultValue);
	}

	public static function reloadControls() {
		PlayerSettings.player1.controls.setKeyboardScheme(KeyboardScheme.Solo);
		InitState.muteKeys = keyBinds.get('volume_mute').copy();
		InitState.volumeDownKeys = keyBinds.get('volume_down').copy();
		InitState.volumeUpKeys = keyBinds.get('volume_up').copy();
		FlxG.sound.muteKeys = InitState.muteKeys;
		FlxG.sound.volumeDownKeys = InitState.volumeDownKeys;
		FlxG.sound.volumeUpKeys = InitState.volumeUpKeys;
	}

	@:deprecated("`ClientPrefs.fillKeys` is deprecated, use `ClientPrefs.getManiaKeys` instead.")
	inline public static function fillKeys():Array<Array<Array<FlxKey>>> {
		var returArr:Array<Array<Array<FlxKey>>> = [];
		var tempArr:Array<Array<FlxKey>> = [];
		for (i in 1...10) {
			for (j in 1...i + 1) {
				tempArr.push(keyBinds.get('note_$i$j').copy());
			}
			returArr.push(tempArr);
			tempArr = [];
		}
		return returArr;
	}

	inline public static function getManiaKeys(mania:Int):Array<Array<FlxKey>> {
		var returArr:Array<Array<FlxKey>> = [];
		for (i in 1...mania + 2)
			returArr.push(keyBinds.get('note_${mania + 1}$i').copy());
		return returArr;
	}
}
