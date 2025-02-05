MACRO engine_flag
; location, bit
; (all locations are in WRAM bank 1)
	dwb \1 + (\2 / 8), 1 << (\2 % 8)
ENDM

EngineFlags:
; entries correspond to ENGINE_* constants

	; pokegear
	engine_flag wPokegearFlags, POKEGEAR_RADIO_CARD_F ; $0
	engine_flag wPokegearFlags, POKEGEAR_MAP_CARD_F
	engine_flag wPokegearFlags, POKEGEAR_PHONE_CARD_F
	engine_flag wPokegearFlags, POKEGEAR_PAGER_CARD_F
	engine_flag wPokegearFlags, POKEGEAR_EXPN_CARD_F
	engine_flag wPokegearFlags, POKEGEAR_OBTAINED_F

	; pager
	engine_flag wPagerFlags, PAGER_CUT_F
	engine_flag wPagerFlags, PAGER_FLY_F
	engine_flag wPagerFlags, PAGER_SURF_F
	engine_flag wPagerFlags, PAGER_STRENGTH_F
	engine_flag wPagerFlags, PAGER_FLASH_F
	engine_flag wPagerFlags, PAGER_WHIRLPOOL_F
	engine_flag wPagerFlags, PAGER_ROCK_SMASH_F

	; day-care
	engine_flag wDayCareMan, DAYCAREMAN_HAS_EGG_F
	engine_flag wDayCareMan, DAYCAREMAN_HAS_MON_F
	engine_flag wDayCareLady, DAYCARELADY_HAS_MON_F

	engine_flag wMomSavingMoney, MOM_SAVING_SOME_MONEY_F ; $8
	engine_flag wMomSavingMoney, MOM_ACTIVE_F

	engine_flag wUnusedTwoDayTimerOn, 0 ; unused, possibly related to a 2-day timer

	engine_flag wStatusFlags, STATUSFLAGS_POKEDEX_F
	engine_flag wStatusFlags, STATUSFLAGS_UNOWN_DEX_F
	engine_flag wStatusFlags, STATUSFLAGS_CAUGHT_POKERUS_F
	engine_flag wStatusFlags, STATUSFLAGS_ROCKET_SIGNAL_F
	engine_flag wStatusFlags, STATUSFLAGS_HALL_OF_FAME_F
	engine_flag wStatusFlags, STATUSFLAGS_MAIN_MENU_MOBILE_CHOICES_F

	engine_flag wStatusFlags2, STATUSFLAGS2_BUG_CONTEST_TIMER_F
	engine_flag wStatusFlags2, STATUSFLAGS2_SAFARI_GAME_F
	engine_flag wStatusFlags2, STATUSFLAGS2_ROCKETS_IN_RADIO_TOWER_F
	engine_flag wStatusFlags2, STATUSFLAGS2_BIKE_SHOP_CALL_F
	engine_flag wStatusFlags2, STATUSFLAGS2_UNUSED_5_F
	engine_flag wStatusFlags2, STATUSFLAGS2_REACHED_GOLDENROD_F
	engine_flag wStatusFlags2, STATUSFLAGS2_ROCKETS_IN_MAHOGANY_F

	engine_flag wBikeFlags, BIKEFLAGS_STRENGTH_ACTIVE_F ; $18
	engine_flag wBikeFlags, BIKEFLAGS_ALWAYS_ON_BIKE_F
	engine_flag wBikeFlags, BIKEFLAGS_DOWNHILL_F

	engine_flag wJohtoBadges, ZEPHYRBADGE
	engine_flag wJohtoBadges, HIVEBADGE
	engine_flag wJohtoBadges, PLAINBADGE
	engine_flag wJohtoBadges, FOGBADGE
	engine_flag wJohtoBadges, MINERALBADGE
	engine_flag wJohtoBadges, STORMBADGE ; $20
	engine_flag wJohtoBadges, GLACIERBADGE
	engine_flag wJohtoBadges, RISINGBADGE

	engine_flag wKantoBadges, BOULDERBADGE
	engine_flag wKantoBadges, CASCADEBADGE
	engine_flag wKantoBadges, THUNDERBADGE
	engine_flag wKantoBadges, RAINBOWBADGE
	engine_flag wKantoBadges, SOULBADGE
	engine_flag wKantoBadges, MARSHBADGE ; $28
	engine_flag wKantoBadges, VOLCANOBADGE
	engine_flag wKantoBadges, EARTHBADGE

	; unown sets (see data/wild/unlocked_unowns.asm)
	engine_flag wUnlockedUnowns, 0 ; A-K
	engine_flag wUnlockedUnowns, 1 ; L-R
	engine_flag wUnlockedUnowns, 2 ; S-W
	engine_flag wUnlockedUnowns, 3 ; X-Z
	engine_flag wUnlockedUnowns, 4 ; unused
	engine_flag wUnlockedUnowns, 5 ; unused ; $30
	engine_flag wUnlockedUnowns, 6 ; unused
	engine_flag wUnlockedUnowns, 7 ; unused

	; fly
	engine_flag wVisitedSpawns, SPAWN_HOME
	engine_flag wVisitedSpawns, SPAWN_DEBUG
	engine_flag wVisitedSpawns, SPAWN_PALLET
	engine_flag wVisitedSpawns, SPAWN_VIRIDIAN
	engine_flag wVisitedSpawns, SPAWN_PEWTER
	engine_flag wVisitedSpawns, SPAWN_CERULEAN ; $38
	engine_flag wVisitedSpawns, SPAWN_ROCK_TUNNEL
	engine_flag wVisitedSpawns, SPAWN_VERMILION
	engine_flag wVisitedSpawns, SPAWN_LAVENDER
	engine_flag wVisitedSpawns, SPAWN_SAFFRON
	engine_flag wVisitedSpawns, SPAWN_CELADON
	engine_flag wVisitedSpawns, SPAWN_FUCHSIA
	engine_flag wVisitedSpawns, SPAWN_CINNABAR
	engine_flag wVisitedSpawns, SPAWN_INDIGO ; $40
	engine_flag wVisitedSpawns, SPAWN_NEW_BARK
	engine_flag wVisitedSpawns, SPAWN_CHERRYGROVE
	engine_flag wVisitedSpawns, SPAWN_VIOLET
	engine_flag wVisitedSpawns, SPAWN_AZALEA
	engine_flag wVisitedSpawns, SPAWN_CIANWOOD
	engine_flag wVisitedSpawns, SPAWN_SAFARI_GATE
	engine_flag wVisitedSpawns, SPAWN_GOLDENROD
	engine_flag wVisitedSpawns, SPAWN_OLIVINE
	engine_flag wVisitedSpawns, SPAWN_ECRUTEAK ; $48
	engine_flag wVisitedSpawns, SPAWN_MAHOGANY
	engine_flag wVisitedSpawns, SPAWN_LAKE_OF_RAGE
	engine_flag wVisitedSpawns, SPAWN_BLACKTHORN
	engine_flag wVisitedSpawns, SPAWN_MT_SILVER
	engine_flag wVisitedSpawns, NUM_SPAWNS ; unused

	engine_flag wLuckyNumberShowFlag, LUCKYNUMBERSHOW_GAME_OVER_F

	engine_flag wStatusFlags2, STATUSFLAGS2_UNUSED_3_F

	engine_flag wDailyFlags, DAILYFLAGS_KURT_MAKING_BALLS_F ; $50
	engine_flag wDailyFlags, DAILYFLAGS_BUG_CONTEST_F
	engine_flag wDailyFlags, DAILYFLAGS_SWARM_F
	engine_flag wDailyFlags, DAILYFLAGS_TIME_CAPSULE_F
	engine_flag wDailyFlags, DAILYFLAGS_ALL_FRUIT_TREES_F
	engine_flag wDailyFlags, DAILYFLAGS_GOT_SHUCKIE_TODAY_F
	engine_flag wDailyFlags, DAILYFLAGS_GOLDENROD_UNDERGROUND_BARGAIN_F
	engine_flag wDailyFlags, DAILYFLAGS_TRAINER_HOUSE_F
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE29_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE29_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE30_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE30_BERRY2
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE30_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE30_APRICORN2
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE31_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE31_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_VIOLET_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_VIOLET_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE33_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE33_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE33_APRICORN2
	engine_flag wDailyFlags, DAILYFLAGS_AZALEA_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE35_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE35_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE36_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE36_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE37_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE37_APRICORN2
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE37_APRICORN3
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE38_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE38_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE39_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE39_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE42_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE42_APRICORN2
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE42_APRICORN3
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE43_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE43_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE44_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE44_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE45_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE45_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE46_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE46_BERRY2
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE46_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE46_APRICORN2
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE26_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE26_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE1_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE1_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_VIRIDIAN_FOREST_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_VIRIDIAN_FOREST_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_PEWTER_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_PEWTER_BERRY2
	engine_flag wDailyFlags, DAILYFLAGS_PEWTER_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_PEWTER_APRICORN2
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE8_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE8_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE11_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_ROUTE11_APRICORN
	engine_flag wDailyFlags, DAILYFLAGS_FUCHSIA_BERRY
	engine_flag wDailyFlags, DAILYFLAGS_FUCHSIA_APRICORN

	engine_flag wWeeklyFlags, WEEKLYFLAGS_MT_MOON_SQUARE_CLEFAIRY_F ; $58
	engine_flag wWeeklyFlags, WEEKLYFLAGS_UNION_CAVE_LAPRAS_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_GOLDENROD_UNDERGROUND_GOT_HAIRCUT_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_GOLDENROD_DEPT_STORE_TM27_RETURN_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_DAISYS_GROOMING_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_INDIGO_PLATEAU_RIVAL_FIGHT_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_DAILY_MOVE_TUTOR_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_BUENAS_PASSWORD_F

	engine_flag wSwarmFlags, SWARMFLAGS_BUENAS_PASSWORD_F ; $60
	engine_flag wSwarmFlags, SWARMFLAGS_GOLDENROD_DEPT_STORE_SALE_F

	engine_flag wGameTimerPause, GAMETIMERPAUSE_MOBILE_7_F

	engine_flag wPlayerGender, PLAYERGENDER_FEMALE_F

	engine_flag wCelebiEvent, CELEBIEVENT_FOREST_IS_RESTLESS_F

	; rematches
	engine_flag wDailyRematchFlags,  0 ; jack
	engine_flag wDailyRematchFlags,  1 ; huey
	engine_flag wDailyRematchFlags,  2 ; gaven
	engine_flag wDailyRematchFlags,  3 ; beth ; $68
	engine_flag wDailyRematchFlags,  4 ; jose
	engine_flag wDailyRematchFlags,  5 ; reena
	engine_flag wDailyRematchFlags,  6 ; joey
	engine_flag wDailyRematchFlags,  7 ; wade
	engine_flag wDailyRematchFlags,  8 ; ralph
	engine_flag wDailyRematchFlags,  9 ; liz
	engine_flag wDailyRematchFlags, 10 ; anthony
	engine_flag wDailyRematchFlags, 11 ; todd ; $70
	engine_flag wDailyRematchFlags, 12 ; gina
	engine_flag wDailyRematchFlags, 13 ; arnie
	engine_flag wDailyRematchFlags, 14 ; alan
	engine_flag wDailyRematchFlags, 15 ; dana
	engine_flag wDailyRematchFlags, 16 ; chad
	engine_flag wDailyRematchFlags, 17 ; tully
	engine_flag wDailyRematchFlags, 18 ; brent
	engine_flag wDailyRematchFlags, 19 ; tiffany ; $78
	engine_flag wDailyRematchFlags, 20 ; vance
	engine_flag wDailyRematchFlags, 21 ; wilton
	engine_flag wDailyRematchFlags, 22 ; parry
	engine_flag wDailyRematchFlags, 23 ; erin
	engine_flag wDailyRematchFlags, 24 ; Ian
	engine_flag wDailyRematchFlags, 25 ; Walt
	engine_flag wDailyRematchFlags, 26 ; Krise
	engine_flag wDailyRematchFlags, 27 ; Alfred
	engine_flag wDailyRematchFlags, 28 ; Doug
	engine_flag wDailyRematchFlags, 29 ; Rob
	engine_flag wDailyRematchFlags, 30 ; Kyle
	engine_flag wDailyRematchFlags, 31 ; Tanner
	engine_flag wDailyRematchFlags, 32 ; Kenny
	engine_flag wDailyRematchFlags, 33 ; Tim & Sue
	engine_flag wDailyRematchFlags, 34 ; Jamie
	engine_flag wDailyRematchFlags, 35 ; Torin
	engine_flag wDailyRematchFlags, 36 ; Billy
	engine_flag wDailyRematchFlags, 37 ; Hillary
	engine_flag wDailyRematchFlags, 38 ; Kay & Tia
	engine_flag wDailyRematchFlags, 39 ; Aiden
	engine_flag wDailyRematchFlags, 40 ; Eoin
	engine_flag wDailyRematchFlags, 41 ; Reese

	engine_flag wDailyPhoneItemFlags, 0 ; beverly has nugget
	engine_flag wDailyPhoneItemFlags, 1 ; jose has star piece
	engine_flag wDailyPhoneItemFlags, 2 ; wade has berry
	engine_flag wDailyPhoneItemFlags, 3 ; gina has leaf stone ; $80
	engine_flag wDailyPhoneItemFlags, 4 ; alan has fire stone
	engine_flag wDailyPhoneItemFlags, 5 ; dana has thunderstone
	engine_flag wDailyPhoneItemFlags, 6 ; derek has nugget
	engine_flag wDailyPhoneItemFlags, 7 ; tully has water stone
	engine_flag wDailyPhoneItemFlags, 8 ; tiffany has pink bow
	engine_flag wDailyPhoneItemFlags, 9 ; gina gave a leaf stone today
	engine_flag wDailyPhoneItemFlags, 10 ; alan gave a fire stone today
	engine_flag wDailyPhoneItemFlags, 11 ; dana gave a thunderstone today
	engine_flag wDailyPhoneItemFlags, 12 ; tully gave a water stone today
	engine_flag wDailyPhoneItemFlags, 13 ; tiffany gave a pink bow today
	engine_flag wDailyPhoneItemFlags, 14 ; beverly gave a nugget today
	engine_flag wDailyPhoneItemFlags, 15 ; jose gave a star piece today
	engine_flag wDailyPhoneItemFlags, 16 ; derek gave a nugget today
	engine_flag wDailyPhoneItemFlags, 17 ; wilton has a ball item today
	engine_flag wDailyPhoneItemFlags, 18 ; wilton gave a ball item today
	engine_flag wDailyPhoneItemFlags, 19 ; wade gave a berry today
	engine_flag wDailyPhoneItemFlags, 20 ; doug has berry
	engine_flag wDailyPhoneItemFlags, 21 ; doug gave a berry today
	engine_flag wDailyPhoneItemFlags, 22 ; rob has berry
	engine_flag wDailyPhoneItemFlags, 23 ; rob gave a berry today
	engine_flag wDailyPhoneItemFlags, 24 ; tanner has sun stone
	engine_flag wDailyPhoneItemFlags, 25 ; tanner gave a sun stone today

	engine_flag wPlayerSpriteSetupFlags, PLAYERSPRITESETUP_FEMALE_TO_MALE_F

	engine_flag wSwarmFlags, SWARMFLAGS_ALT_SWARM_F ; $a0
	engine_flag wSwarmFlags, SWARMFLAGS_SWARM_ACTIVE

