	const_def 2 ; object constants
	const ROUTE15_YOUNGSTER1
	const ROUTE15_YOUNGSTER2
	const ROUTE15_YOUNGSTER3
	const ROUTE15_YOUNGSTER4
	const ROUTE15_TEACHER1
	const ROUTE15_TEACHER2
	const ROUTE15_POKE_BALL

Route15_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

TrainerTwinsKayandTia1:
	trainer TWINS, KAYANDTIA1, EVENT_BEAT_TWINS_KAYANDTIA, TwinsKayandTiaSeenText, TwinsKayandTiaBeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_TWINS_KAY_AND_TIA
	opentext
	checkflag ENGINE_KAY_AND_TIA
	iftrue KayandTiaWantsBattle
	checkcellnum PHONE_TWINS_KAY_AND_TIA
	iftrue KayandTia1Defeated
	checkevent EVENT_KAY_AND_TIA_ASKED_FOR_PHONE_NUMBER
	iftrue KayandTiaAskedBefore
	writetext TwinsKayandTiaAfterBattleText1
	waitbutton
	setevent EVENT_KAY_AND_TIA_ASKED_FOR_PHONE_NUMBER
	scall Route15FAskNumber1
	jump KayandTiaAskForNumber

KayandTiaAskedBefore:
	scall Route15FAskNumber2
KayandTiaAskForNumber:
	askforphonenumber PHONE_TWINS_KAY_AND_TIA
	ifequal PHONE_CONTACTS_FULL, Route15FPhoneFull
	ifequal PHONE_CONTACT_REFUSED, Route15FNumberDeclined
	trainertotext TWINS, KAYANDTIA1, MEM_BUFFER_0
	scall Route15FRegisteredNumber
	jump Route15FNumberAccepted

KayandTiaWantsBattle:
	scall Route15FRematch
	winlosstext TwinsKayandTiaBeatenText, 0
	checkevent EVENT_BEAT_BLUE
	iftrue KayandTiaLoadFight2
	checkevent ENGINE_FLYPOINT_PEWTER
	iftrue KayandTiaLoadFight1
	loadtrainer TWINS, KAYANDTIA1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_KAY_AND_TIA
	end

TrainerTwinsKayandTia2:
	trainer TWINS, KAYANDTIA1, EVENT_BEAT_TWINS_KAYANDTIA, TwinsKayandTiaSeenText, TwinsKayandTiaBeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_TWINS_KAY_AND_TIA
	opentext
	checkflag ENGINE_KAY_AND_TIA
	iftrue KayandTiaWantsBattle
	checkcellnum PHONE_TWINS_KAY_AND_TIA
	iftrue KayandTia2Defeated
	checkevent EVENT_KAY_AND_TIA_ASKED_FOR_PHONE_NUMBER
	iftrue KayandTiaAskedBefore
	writetext TwinsKayandTiaAfterBattleText2
	waitbutton
	setevent EVENT_KAY_AND_TIA_ASKED_FOR_PHONE_NUMBER
	scall Route15FAskNumber1
	jump KayandTiaAskForNumber

KayandTiaLoadFight1:
	loadtrainer TWINS, KAYANDTIA2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_KAY_AND_TIA
	end

KayandTiaLoadFight2:
	loadtrainer TWINS, KAYANDTIA3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_KAY_AND_TIA
	end

KayandTia1Defeated:
	writetext TwinsKayandTiaAfterBattleText1
	waitbutton
	closetext
	end

KayandTia2Defeated:
	writetext TwinsKayandTiaAfterBattleText2
	waitbutton
	closetext
	end

TrainerPokefanEleanor:
	trainer POKEFANF, ELEANOR, EVENT_BEAT_POKEFANF_ELEANOR, PokefanEleanorSeenText, PokefanEleanorBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanEleanorAfterBattleText
	waitbutton
	closetext
	end

TrainerPokefanBoone:
	trainer POKEFANM, BOONE, EVENT_BEAT_POKEFANM_BOONE, PokefanBooneSeenText, PokefanBooneBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanBooneAfterBattleText
	waitbutton
	closetext
	end

TrainerTeacherColette:
	trainer TEACHER, COLETTE, EVENT_BEAT_TEACHER_COLETTE, TeacherColetteSeenText, TeacherColetteBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TeacherColetteAfterBattleText
	waitbutton
	closetext
	end

TrainerTeacherHillary:
	trainer TEACHER, HILLARY1, EVENT_BEAT_TEACHER_HILLARY, TeacherHillarySeenText, TeacherHillaryBeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_TEACHER_HILLARY
	opentext
	checkflag ENGINE_HILLARY
	iftrue .WantsBattle
	checkcellnum PHONE_TEACHER_HILLARY
	iftrue .HillaryDefeated
	checkevent EVENT_HILLARY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedBefore
	writetext TeacherHillaryAfterBattleText
	waitbutton
	setevent EVENT_HILLARY_ASKED_FOR_PHONE_NUMBER
	scall Route15FAskNumber1
	jump .AskForNumber

.AskedBefore:
	scall Route15FAskNumber2
.AskForNumber:
	askforphonenumber PHONE_TEACHER_HILLARY
	ifequal PHONE_CONTACTS_FULL, Route15FPhoneFull
	ifequal PHONE_CONTACT_REFUSED, Route15FNumberDeclined
	trainertotext TEACHER, HILLARY1, MEM_BUFFER_0
	scall Route15FRegisteredNumber
	jump Route15FNumberAccepted

.WantsBattle:
	scall Route15FRematch
	winlosstext TeacherHillaryBeatenText, 0
	checkevent EVENT_BEAT_BLUE
	iftrue .LoadFight2
	checkevent ENGINE_FLYPOINT_PEWTER
	iftrue .LoadFight1
	loadtrainer TEACHER, HILLARY1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_HILLARY
	end

.LoadFight1:
	loadtrainer TEACHER, HILLARY2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_HILLARY
	end

.LoadFight2:
	loadtrainer TEACHER, HILLARY3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_HILLARY
	end

.HillaryDefeated:
	writetext TeacherHillaryAfterBattleText
	waitbutton
	closetext
	end

Route15FAskNumber1:
	jumpstd asknumber1f
	end

Route15FAskNumber2:
	jumpstd asknumber2f
	end

Route15FRegisteredNumber:
	jumpstd registerednumberf
	end

Route15FNumberAccepted:
	jumpstd numberacceptedf
	end

Route15FNumberDeclined:
	jumpstd numberdeclinedf
	end

Route15FPhoneFull:
	jumpstd phonefullf
	end

Route15FRematch:
	jumpstd rematchf
	end

TrainerSchoolboyKipp:
	trainer SCHOOLBOY, KIPP, EVENT_BEAT_SCHOOLBOY_KIP, SchoolboyKippSeenText, SchoolboyKippBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SchoolboyKippAfterBattleText
	waitbutton
	closetext
	end

TrainerSchoolboyTommy:
	trainer SCHOOLBOY, TOMMY, EVENT_BEAT_SCHOOLBOY_TOMMY, SchoolboyTommySeenText, SchoolboyTommyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SchoolboyTommyAfterBattleText
	waitbutton
	closetext
	end

TrainerSchoolboyJohnny:
	trainer SCHOOLBOY, JOHNNY, EVENT_BEAT_SCHOOLBOY_JOHNNY, SchoolboyJohnnySeenText, SchoolboyJohnnyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SchoolboyJohnnyAfterBattleText
	waitbutton
	closetext
	end

TrainerSchoolboyBilly:
	trainer SCHOOLBOY, BILLY1, EVENT_BEAT_SCHOOLBOY_BILLY, SchoolboyBillySeenText, SchoolboyBillyBeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_SCHOOLBOY_BILLY
	opentext
	checkflag ENGINE_BILLY
	iftrue .WantsBattle
	checkcellnum PHONE_SCHOOLBOY_BILLY
	iftrue .BillyDefeated
	checkevent EVENT_BILLY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedBefore
	writetext SchoolboyBillyAfterBattleText
	waitbutton
	setevent EVENT_BILLY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	jump .AskForNumber

.AskedBefore:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_SCHOOLBOY_BILLY
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	trainertotext SCHOOLBOY, BILLY1, MEM_BUFFER_0
	scall .RegisteredNumber
	jump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext SchoolboyBillyBeatenText, 0
	checkevent EVENT_BEAT_BLUE
	iftrue .LoadFight2
	checkevent ENGINE_FLYPOINT_PEWTER
	iftrue .LoadFight1
	loadtrainer SCHOOLBOY, BILLY1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BILLY
	end

.LoadFight1:
	loadtrainer SCHOOLBOY, BILLY2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BILLY
	end

.LoadFight2:
	loadtrainer SCHOOLBOY, BILLY3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BILLY
	end

.BillyDefeated:
	writetext SchoolboyBillyAfterBattleText
	waitbutton
	closetext
	end

.AskNumber1:
	jumpstd asknumber1m
	end

.AskNumber2:
	jumpstd asknumber2m
	end

.RegisteredNumber:
	jumpstd registerednumberm
	end

.NumberAccepted:
	jumpstd numberacceptedm
	end

.NumberDeclined:
	jumpstd numberdeclinedm
	end

.PhoneFull:
	jumpstd phonefullm
	end

.Rematch:
	jumpstd rematchm
	end

Route15Sign:
	jumptext Route15SignText

Route15PPUp:
	itemball PP_UP

TwinsKayandTiaSeenText:
	text "We're the twins"
	line "KAY and TIA!"

	para "Do you know which"
	line "one I am?"

	para "We're the twins"
	line "KAY and TIA!"

	para "Do you know which"
	line "one I am?"
	done

TwinsKayandTiaBeatenText:
	text "TIA and KAY"
	line "both lost…"

	para "KAY and TIA"
	line "both lost…"
	done

TwinsKayandTiaAfterBattleText1:
	text "Maybe truth--"
	line "I'm TIA!"
	cont "Absolutely!"
	done

TwinsKayandTiaAfterBattleText2:
	text "Absolute truth--"
	line "I'm KAY!"
	cont "Maybe…"
	done

PokefanBooneSeenText:
	text "HeY, your"
	line "#MON…"

	para "Show me. Show me."
	line "Show me!"
	done

PokefanBooneBeatenText:
	text "Yay!"
	line "That was great!"
	done

PokefanBooneAfterBattleText:
	text "When you battle"
	line "#MON,"

	para "you get to see a"
	line "bunch of #MON"
	cont "you've never seen"
	cont "before."

	para "It's so great!"
	done

PokefanEleanorSeenText:
	text "All right,"
	line "#MON, time for"
	cont "battle!"
	done

PokefanEleanorBeatenText:
	text "Oh, well…"
	done

PokefanEleanorAfterBattleText:
	text "It's not that my"
	line "#MON are weak!"

	para "It's that your"
	line "#MON are too"
	cont "strong!"
	done

TeacherColetteSeenText:
	text "Have you forgotten"
	line "anything?"
	done

TeacherColetteBeatenText:
	text "Kyaaah!"
	done

TeacherColetteAfterBattleText:
	text "Before I became a"
	line "teacher, I used to"

	para "forget a lot of"
	line "things."
	done

TeacherHillarySeenText:
	text "On sunny days, I"
	line "think that the"

	para "kids would rather"
	line "be playing in the"

	para "schoolyard than"
	line "studying in class."
	done

TeacherHillaryBeatenText:
	text "I didn't want to"
	line "lose…"
	done

TeacherHillaryAfterBattleText:
	text "Studying is impor-"
	line "tant, but exercise"
	cont "is just as vital."
	done

SchoolboyKippSeenText:
	text "Hang on. I have to"
	line "phone my mom."
	done

SchoolboyKippBeatenText:
	text "Sorry, Mom!"
	line "I was beaten!"
	done

SchoolboyKippAfterBattleText:
	text "My mom worries so"
	line "much about me, I"

	para "have to phone her"
	line "all the time."
	done

SchoolboyTommySeenText:
	text "Let's battle."
	line "I won't lose!"
	done

SchoolboyTommyBeatenText:
	text "I forgot to do my"
	line "homework!"
	done

SchoolboyTommyAfterBattleText:
	text "Sayonara! I just"
	line "learned that in my"
	cont "Japanese class."
	done

SchoolboyJohnnySeenText:
	text "We're on a field"
	line "trip to LAVENDER"

	para "RADIO TOWER for"
	line "social studies."
	done

SchoolboyJohnnyBeatenText:
	text "You're wickedly"
	line "tough!"
	done

SchoolboyJohnnyAfterBattleText:
	text "I'm tired of walk-"
	line "ing. I need to"
	cont "take a break."
	done

SchoolboyBillySeenText:
	text "My favorite class"
	line "is gym!"
	done

SchoolboyBillyBeatenText:
	text "Oh, no!"
	line "How could I lose?"
	done

SchoolboyBillyAfterBattleText:
	text "If #MON were a"
	line "subject at school,"
	cont "I'd be the best!"
	done

Route15SignText:
	text "ROUTE 15"

	para "FUCHSIA CITY -"
	line "LAVENDER TOWN"
	done

Route15_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  2,  8, ROUTE_15_FUCHSIA_GATE, 3
	warp_event  2,  9, ROUTE_15_FUCHSIA_GATE, 4

	db 0 ; coord events

	db 1 ; bg events
	bg_event 33,  9, BGEVENT_READ, Route15Sign

	db 11 ; object events
	object_event 10, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerSchoolboyKipp, -1
	object_event 20, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSchoolboyTommy, -1
	object_event 48, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSchoolboyJohnny, -1
	object_event 39, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSchoolboyBilly, -1
	object_event 38,  5, SPRITE_TEACHER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerTeacherColette, -1
	object_event 20,  5, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_TRAINER, 1, TrainerTwinsKayandTia1, -1
	object_event 21,  5, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_TRAINER, 1, TrainerTwinsKayandTia2, -1
	object_event 16,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerPokefanEleanor, -1
	object_event 44, 12, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerPokefanBoone, -1
	object_event 32, 10, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerTeacherHillary, -1
	object_event 12,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route15PPUp, EVENT_ROUTE_15_PP_UP
