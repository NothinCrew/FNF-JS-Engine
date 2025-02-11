package;

import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;
import flixel.FlxState;

/**
 * Handles initialization of variables when first opening the game.
**/
class InitState extends FlxState {
    override function create():Void {
        super.create();

        // -- FLIXEL STUFF -- //

        FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = funkin.TitleState.muteKeys;
		FlxG.sound.volumeDownKeys = funkin.TitleState.volumeDownKeys;
		FlxG.sound.volumeUpKeys = funkin.TitleState.volumeUpKeys;
		FlxG.keys.preventDefaultKeys = [TAB];

        FlxTransitionableState.skipNextTransIn = true;

        // -- SETTINGS -- //

		FlxG.save.bind('funkin', funkin.CoolUtil.getSavePath());

		#if (flixel >= "5.0.0")
		trace('save status: ${FlxG.save.status}');
		#end

		FlxG.fixedTimestep = false;

		funkin.PlayerSettings.init();

        // ClientPrefs.loadDefaultKeys();
		funkin.ClientPrefs.loadPrefs();

        /*
        #if ACHIEVEMNTS_ALLOWED
        Achievements.init();
        #end
        */

        // -- MODS -- //

		#if LUA_ALLOWED
		funkin.Paths.pushGlobalMods();
		#end
		// Just to load a mod on start up if ya got one. For mods that change the menu music and bg
		funkin.WeekData.loadTheFirstEnabledMod();

        // -- -- -- //

        funkin.Paths.clearStoredMemory();
		funkin.Paths.clearUnusedMemory();

        final state:Class<FlxState> = (funkin.ClientPrefs.disableSplash) ? funkin.TitleState : funkin.StartupState;

        FlxG.switchState(Type.createInstance(state, []));
    }
}