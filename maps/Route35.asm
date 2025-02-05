	const_def 2 ; object constants
	const ROUTE35_YOUNGSTER1
	const ROUTE35_YOUNGSTER2
	const ROUTE35_LASS1
	const ROUTE35_LASS2
	const ROUTE35_YOUNGSTER3
	const ROUTE35_FISHER
	const ROUTE35_BUG_CATCHER
	const ROUTE35_SUPER_NERD
	const ROUTE35_OFFICER
	const ROUTE35_BERRY
	const ROUTE35_APRICORN
	const ROUTE35_POKE_BALL

Route35_MapScripts:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_OBJECTS, .Fruittrees

.DummyScene0:
	end

.DummyScene1:
	end

.Fruittrees
.Berry:
	checkflag ENGINE_DAILY_ROUTE35_BERRY
	iftrue .NoBerry
	appear ROUTE35_BERRY
.NoBerry:
	;return

.Apricorn:
	checkflag ENGINE_DAILY_ROUTE35_APRICORN
	iftrue .NoApricorn
	appear ROUTE35_APRICORN
.NoApricorn:
	return

TrainerBirdKeeperBryan:
	trainer BIRD_KEEPER, BRYAN, EVENT_BEAT_BIRD_KEEPER_BRYAN, BirdKeeperBryanSeenText, BirdKeeperBryanBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperBryanAfterBattleText
	waitbutton
	closetext
	end

TrainerJugglerIrwin:
	trainer JUGGLER, IRWIN1, EVENT_BEAT_JUGGLER_IRWIN, JugglerIrwin1SeenText, JugglerIrwin1BeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_JUGGLER_IRWIN
	opentext
	checkcellnum PHONE_JUGGLER_IRWIN
	iftrue .IrwinDefeated
	checkevent EVENT_IRWIN_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext JugglerIrwinAfterBattleText
	buttonsound
	setevent EVENT_IRWIN_ASKED_FOR_PHONE_NUMBER
	scall Route35AskNumber1M
	jump .AskForNumber

.AskedAlready:
	scall Route35AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_JUGGLER_IRWIN
	ifequal PHONE_CONTACTS_FULL, Route35PhoneFullM
	ifequal PHONE_CONTACT_REFUSED, Route35NumberDeclinedM
	trainertotext JUGGLER, IRWIN1, MEM_BUFFER_0
	scall Route35RegisteredNumberM
	jump Route35NumberAcceptedM

.IrwinDefeated:
	writetext JugglerIrwinAfterBattleText
	buttonsound
	closetext
	end

Route35AskNumber1M:
	jumpstd asknumber1m
	end

Route35AskNumber2M:
	jumpstd asknumber2m
	end

Route35RegisteredNumberM:
	jumpstd registerednumberm
	end

Route35NumberAcceptedM:
	jumpstd numberacceptedm
	end

Route35NumberDeclinedM:
	jumpstd numberdeclinedm
	end

Route35PhoneFullM:
	jumpstd phonefullm
	end

Route35RematchM:
	jumpstd rematchm
	end

TrainerCamperIvan:
	trainer CAMPER, IVAN, EVENT_BEAT_CAMPER_IVAN, CamperIvanSeenText, CamperIvanBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CamperIvanAfterBattleText
	waitbutton
	closetext
	end

TrainerCamperElliot:
	trainer CAMPER, ELLIOT, EVENT_BEAT_CAMPER_ELLIOT, CamperElliotSeenText, CamperElliotBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CamperElliotAfterBattleText
	waitbutton
	closetext
	end

TrainerPicnickerBrooke:
	trainer PICNICKER, BROOKE, EVENT_BEAT_PICNICKER_BROOKE, PicnickerBrookeSeenText, PicnickerBrookeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PicnickerBrookeAfterBattleText
	waitbutton
	closetext
	end

TrainerPicnickerKim:
	trainer PICNICKER, KIM, EVENT_BEAT_PICNICKER_KIM, PicnickerKimSeenText, PicnickerKimBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PicnickerKimAfterBattleText
	waitbutton
	closetext
	end

TrainerBugCatcherArnie:
	trainer BUG_CATCHER, ARNIE1, EVENT_BEAT_BUG_CATCHER_ARNIE, BugCatcherArnieSeenText, BugCatcherArnieBeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_BUG_CATCHER_ARNIE
	opentext
	checkflag ENGINE_ARNIE
	iftrue .WantsBattle
	checkcellnum PHONE_BUG_CATCHER_ARNIE
	iftrue .ArnieDefeated
	checkevent EVENT_ARNIE_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext BugCatcherArnieAfterBattleText
	buttonsound
	setevent EVENT_ARNIE_ASKED_FOR_PHONE_NUMBER
	scall Route35AskNumber1M
	jump .AskForNumber

.AskedAlready:
	scall Route35AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_BUG_CATCHER_ARNIE
	ifequal PHONE_CONTACTS_FULL, Route35PhoneFullM
	ifequal PHONE_CONTACT_REFUSED, Route35NumberDeclinedM
	trainertotext BUG_CATCHER, ARNIE1, MEM_BUFFER_0
	scall Route35RegisteredNumberM
	jump Route35NumberAcceptedM

.WantsBattle:
	scall Route35RematchM
	winlosstext BugCatcherArnieBeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
	checkflag ENGINE_FLYPOINT_BLACKTHORN
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	iftrue .LoadFight1
	loadtrainer BUG_CATCHER, ARNIE1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE
	end

.LoadFight1:
	loadtrainer BUG_CATCHER, ARNIE2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE
	end

.LoadFight2:
	loadtrainer BUG_CATCHER, ARNIE3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE
	end

.LoadFight3:
	loadtrainer BUG_CATCHER, ARNIE4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE
	end

.LoadFight4:
	loadtrainer BUG_CATCHER, ARNIE5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE
	end

.ArnieDefeated:
	writetext BugCatcherArnieAfterBattleText
	buttonsound
	closetext
	end

TrainerFirebreatherWalt:
	trainer FIREBREATHER, WALT1, EVENT_BEAT_FIREBREATHER_WALT, FirebreatherWaltSeenText, FirebreatherWaltBeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_FIREBREATHER_WALT
	opentext
	checkflag ENGINE_WALT
	iftrue .WantsBattle
	checkcellnum PHONE_FIREBREATHER_WALT
	iftrue .WaltDefeated
	checkevent EVENT_WALT_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext FirebreatherWaltAfterBattleText
	buttonsound
	setevent EVENT_WALT_ASKED_FOR_PHONE_NUMBER
	scall Route35AskNumber1M
	jump .AskForNumber

.AskedAlready:
	scall Route35AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_FIREBREATHER_WALT
	ifequal PHONE_CONTACTS_FULL, Route35PhoneFullM
	ifequal PHONE_CONTACT_REFUSED, Route35NumberDeclinedM
	trainertotext FIREBREATHER, WALT1, MEM_BUFFER_0
	scall Route35RegisteredNumberM
	jump Route35NumberAcceptedM

.WantsBattle:
	scall Route35RematchM
	winlosstext FirebreatherWaltBeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_CIANWOOD
	iftrue .LoadFight1
	loadtrainer FIREBREATHER, WALT1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WALT
	end

.LoadFight1:
	loadtrainer FIREBREATHER, WALT2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WALT
	end

.LoadFight2:
	loadtrainer FIREBREATHER, WALT3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WALT
	end

.LoadFight3:
	loadtrainer FIREBREATHER, WALT4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WALT
	end

.LoadFight4:
	loadtrainer FIREBREATHER, WALT5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WALT
	end

.WaltDefeated:
	writetext FirebreatherWaltAfterBattleText
	buttonsound
	closetext
	end

TrainerOfficerDirk:
	faceplayer
	opentext
	checktime NITE
	iffalse .NotNight
	checkevent EVENT_BEAT_OFFICER_DIRK
	iftrue .AfterBattle
	playmusic MUSIC_OFFICER_ENCOUNTER
	writetext OfficerDirkSeenText
	waitbutton
	closetext
	winlosstext OfficerDirkBeatenText, 0
	loadtrainer OFFICER, DIRK
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_OFFICER_DIRK
	closetext
	end

.AfterBattle:
	writetext OfficerDirkAfterBattleText
	waitbutton
	closetext
	end

.NotNight:
	writetext OfficerDirkPrettyToughText
	waitbutton
	closetext
	end

Route35Sign:
	jumptext Route35SignText

Route35TMRollout:
	itemball TM_ROLLOUT

Route35BerryTree:
	opentext
	writetext Route35BerryTreeText
	buttonsound
	writetext Route35HeyItsBerryText
	buttonsound
	verbosegiveitem LEPPA_BERRY
	iffalse .NoRoomInBag
	disappear ROUTE35_BERRY
	setflag ENGINE_DAILY_ROUTE35_BERRY
.NoRoomInBag
	closetext
	end

Route35ApricornTree:
	opentext
	writetext Route35ApricornTreeText
	buttonsound
	writetext Route35HeyItsApricornText
	buttonsound
	verbosegiveitem GRN_APRICORN
	iffalse .NoRoomInBag
	disappear ROUTE35_APRICORN
	setflag ENGINE_DAILY_ROUTE35_APRICORN
.NoRoomInBag
	closetext
	end

Route35NoBerry:
	opentext
	writetext Route35BerryTreeText
	buttonsound
	writetext Route35NothingHereText
	waitbutton
	closetext
	end

Route35NoApricorn:
	opentext
	writetext Route35ApricornTreeText
	buttonsound
	writetext Route35NothingHereText
	waitbutton
	closetext
	end

CamperIvanSeenText:
	text "I've been getting"
	line "#MON data off"

	para "my radio. I think"
	line "I'm good."
	done

CamperIvanBeatenText:
	text "I give!"
	done

CamperIvanAfterBattleText:
	text "Music on the radio"
	line "changes the moods"
	cont "of wild #MON."
	done

CamperElliotSeenText:
	text "I'm gonna show my"
	line "girlfriend I'm hot"
	cont "stuff!"
	done

CamperElliotBeatenText:
	text "I wish you would"
	line "have lost for me…"
	done

CamperElliotAfterBattleText:
	text "I was humiliated"
	line "in front of my"
	cont "girlfriend…"
	done

PicnickerBrookeSeenText:
	text "My boyfriend's"
	line "weak, so I can't"
	cont "rely on him."
	done

PicnickerBrookeBeatenText:
	text "Oh, my! You're so"
	line "strong!"
	done

PicnickerBrookeAfterBattleText:
	text "I can count on my"
	line "#MON more than"
	cont "my boyfriend."
	done

PicnickerKimSeenText:
	text "Are you going to"
	line "the GYM? Me too!"
	done

PicnickerKimBeatenText:
	text "Oh. I couldn't"
	line "win…"
	done

PicnickerKimAfterBattleText:
	text "The GYM BADGES are"
	line "pretty. I collect"
	cont "them."
	done

BirdKeeperBryanSeenText:
	text "What kinds of"
	line "BALLS do you use?"
	done

BirdKeeperBryanBeatenText:
	text "Yikes! Not fast"
	line "enough!"
	done

BirdKeeperBryanAfterBattleText:
	text "Some #MON flee"
	line "right away."

	para "Try catching them"
	line "with KURT's FAST"
	cont "BALL."

	para "Whenever I find a"
	line "WHT APRICORN, I"
	cont "take it to KURT."

	para "He turns it into a"
	line "custom BALL."
	done

JugglerIrwin1SeenText:
	text "Behold my graceful"
	line "BALL dexterity!"
	done

JugglerIrwin1BeatenText:
	text "Whew! That was a"
	line "jolt!"
	done

JugglerIrwinAfterBattleText:
	text "I was going to"
	line "dazzle you with my"
	cont "prize #MON."

	para "But your prowess"
	line "electrified me!"
	done

BugCatcherArnieSeenText:
	text "I'll go anywhere"
	line "if bug #MON"
	cont "appear there."
	done

BugCatcherArnieBeatenText:
	text "Huh? I shouldn't"
	line "have lost that…"
	done

BugCatcherArnieAfterBattleText:
	text "My VENONAT won me"
	line "the Bug-Catching"

	para "Contest at the"
	line "NATIONAL PARK."
	done

FirebreatherWaltSeenText:
	text "I'm practicing my"
	line "fire breathing."
	done

FirebreatherWaltBeatenText:
	text "Ow! I scorched the"
	line "tip of my nose!"
	done

FirebreatherWaltAfterBattleText:
	text "The #MON March"
	line "on the radio lures"
	cont "wild #MON."
	done

OfficerDirkSeenText:
	text "Danger lurks in"
	line "the night!"
	done

OfficerDirkBeatenText:
	text "Whoops!"
	done

OfficerDirkAfterBattleText:
	text "You know, night-"
	line "time is fun in its"
	cont "own ways."

	para "But don't overdo"
	line "it, OK?"
	done

OfficerDirkPrettyToughText:
	text "Your #MON look"
	line "pretty tough."

	para "You could go any-"
	line "where safely."
	done

Route35SignText:
	text "ROUTE 35"
	done

Route35BerryTreeText:
	text "It's a"
	line "BERRY tree…"
	done

Route35HeyItsBerryText:
	text "Hey! It's"
	line "LEPPA BERRY!"
	done

Route35ApricornTreeText:
	text "It's an"
	line "APRICORN tree…"
	done

Route35HeyItsApricornText:
	text "Hey! It's"
	line "GRN APRICORN!"
	done

Route35NothingHereText:
	text "There's nothing"
	line "here…"
	done

Route35_MapEvents:
	db 0, 0 ; filler

	db 3 ; warp events
	warp_event  9, 33, ROUTE_35_GOLDENROD_GATE, 1
	warp_event 10, 33, ROUTE_35_GOLDENROD_GATE, 2
	warp_event  3,  5, ROUTE_35_NATIONAL_PARK_GATE, 3

	db 0 ; coord events

	db 4 ; bg events
	bg_event  1,  7, BGEVENT_READ, Route35Sign
	bg_event 11, 31, BGEVENT_READ, Route35Sign
	bg_event  1, 26, BGEVENT_READ, Route35NoBerry
	bg_event  2, 25, BGEVENT_READ, Route35NoApricorn

	db 12 ; object events
	object_event  4, 19, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerCamperIvan, -1
	object_event  8, 20, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerCamperElliot, -1
	object_event  7, 20, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerPicnickerBrooke, -1
	object_event 10, 26, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerPicnickerKim, -1
	object_event 14, 28, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 0, TrainerBirdKeeperBryan, -1
	object_event  2, 10, SPRITE_FISHER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerFirebreatherWalt, -1
	object_event 16,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 2, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherArnie, -1
	object_event  5, 10, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerJugglerIrwin, -1
	object_event  5,  6, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TrainerOfficerDirk, -1
	object_event  1, 26, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route35BerryTree, EVENT_ROUTE35_BERRY
	object_event  2, 25, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route35ApricornTree, EVENT_ROUTE35_APRICORN
	object_event 13, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route35TMRollout, EVENT_ROUTE_35_TM_ROLLOUT
