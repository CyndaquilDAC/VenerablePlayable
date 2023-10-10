package states.stages;

import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.math.FlxPoint;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.animation.FlxAnimationController;
import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;
import openfl.events.KeyboardEvent;
import tjson.TJSON as Json;
import backend.BaseStage;
import states.stages.objects.*;

class Venerable extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	public var finalBg:FlxSprite;
	public var fprHallBg:FlxSprite;
	public var lockerBg:FlxSprite;
	public var padBg:FlxSprite;
	public var hallThingBg:FlxSprite;
	public var officeBg:FlxSprite;
	public var startingBg:FlxSprite;

	override function create()
	{
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		finalBg = new FlxSprite(-347, -91).loadGraphic(Paths.image("venerable/final"));
		finalBg.scale.set(1.3, 1.3);
		finalBg.updateHitbox();
		finalBg.screenCenter();
		finalBg.antialiasing = true;
		add(finalBg);
		fprHallBg = new FlxSprite(-347, -91).loadGraphic(Paths.image("venerable/hall first person"));
		fprHallBg.scale.set(1.3, 1.3);
		fprHallBg.updateHitbox();
		fprHallBg.screenCenter();
		fprHallBg.antialiasing = true;
		add(fprHallBg);
		lockerBg = new FlxSprite(-347, -91).loadGraphic(Paths.image("venerable/lockers"));
		lockerBg.scale.set(1.3, 1.3);
		lockerBg.updateHitbox();
		lockerBg.screenCenter();
		lockerBg.antialiasing = true;
		add(lockerBg);
		padBg = new FlxSprite(-347, -91).loadGraphic(Paths.image("venerable/pad"));
		padBg.antialiasing = true;
		add(padBg);
		hallThingBg = new FlxSprite(-347, -91).loadGraphic(Paths.image("venerable/hall thing"));
		hallThingBg.scale.set(1.3, 1.3);
		hallThingBg.updateHitbox();
		hallThingBg.screenCenter();
		hallThingBg.antialiasing = true;
		add(hallThingBg);
		officeBg = new FlxSprite(-347, -91).loadGraphic(Paths.image("venerable/office"));
		officeBg.scale.set(1.3, 1.3);
		officeBg.updateHitbox();
		officeBg.screenCenter();
		officeBg.antialiasing = true;
		add(officeBg);
		startingBg = new FlxSprite(-347, -91).loadGraphic(Paths.image("venerable/starting"));
		startingBg.scale.set(1.3, 1.3);
		startingBg.updateHitbox();
		startingBg.screenCenter();
		startingBg.antialiasing = true;
		add(startingBg);
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
	}

	override function update(elapsed:Float)
	{
		// Code here
		if(curBeat == 438 || curBeat == 439)
		{
			officeBg.angle += 20 * elapsed;
		}
	}

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit()
	{
		// Code here
	}
	override function beatHit()
	{
		// Code here
		if(curBeat == 438)
		{
			remove(officeBg, true);
			add(officeBg);
			game.remove(game.dadGroup, true);
			game.remove(game.boyfriendGroup, true);
			game.add(game.dadGroup);
			game.add(game.boyfriendGroup);
			officeBg.scale.set(0.001, 0.001);
			FlxTween.tween(officeBg, {"scale.x": 1.3, "scale.y": 1.3}, Conductor.crochet / 500, {ease: FlxEase.circIn});
		}
		if(curBeat == 440)
		{
			FlxTween.completeTweensOf(officeBg);
			officeBg.angle = 0;
			officeBg.scale.set(1.3, 1.3);
			officeBg.updateHitbox();
			officeBg.screenCenter();
			startingBg.visible = false;
		}
	}
	override function sectionHit()
	{
		// Code here
	}

	// Substates for pausing/resuming tweens and timers
	override function closeSubState()
	{
		if(paused)
		{
			//timer.active = true;
			//tween.active = true;
		}
	}

	override function openSubState(SubState:flixel.FlxSubState)
	{
		if(paused)
		{
			//timer.active = false;
			//tween.active = false;
		}
	}

	// For events
	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "My Event":
		}
	}
	override function eventPushed(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events that doesn't need different assets based on its values
		switch(event.event)
		{
			case "My Event":
				//precacheImage('myImage') //preloads images/myImage.png
				//precacheSound('mySound') //preloads sounds/mySound.ogg
				//precacheMusic('myMusic') //preloads music/myMusic.ogg
		}
	}
	override function eventPushedUnique(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events where its values affect what assets should be preloaded
		switch(event.event)
		{
			case "My Event":
				switch(event.value1)
				{
					// If value 1 is "blah blah", it will preload these assets:
					case 'blah blah':
						//precacheImage('myImageOne') //preloads images/myImageOne.png
						//precacheSound('mySoundOne') //preloads sounds/mySoundOne.ogg
						//precacheMusic('myMusicOne') //preloads music/myMusicOne.ogg

					// If value 1 is "coolswag", it will preload these assets:
					case 'coolswag':
						//precacheImage('myImageTwo') //preloads images/myImageTwo.png
						//precacheSound('mySoundTwo') //preloads sounds/mySoundTwo.ogg
						//precacheMusic('myMusicTwo') //preloads music/myMusicTwo.ogg
					
					// If value 1 is not "blah blah" or "coolswag", it will preload these assets:
					default:
						//precacheImage('myImageThree') //preloads images/myImageThree.png
						//precacheSound('mySoundThree') //preloads sounds/mySoundThree.ogg
						//precacheMusic('myMusicThree') //preloads music/myMusicThree.ogg
				}
		}
	}
}