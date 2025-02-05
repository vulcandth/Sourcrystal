	const_def 2 ; object constants
	const SAFARI_ZONE_GATE_POKECENTER_1F_NURSE
	const SAFARI_ZONE_GATE_CENTER_1F_HIKER

SafariZoneGatePokecenter1F_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

SafariZoneGatePokecenter1FNurseScript:
	jumpstd pokecenternurse

SafariZoneGatePokecenter1FHikerScript:
	jumptextfaceplayer SafariZoneGatePokecenter1FHikerText

SafariZoneGatePokecenter1FHikerText:
	text "After a long walk"
	line "in the mountains"
	cont "to find a #MON"
	cont "CENTER, when you"
	cont "are just about to"
	cont "fall flat…"
	
	para "Then it feels like"
	line "you are in para-"
	cont "dise."
	done

SafariZoneGatePokecenter1F_MapEvents:
	db 0, 0 ; filler

	db 3 ; warp events
	warp_event  3,  7, SAFARI_ZONE_GATE, 2
	warp_event  4,  7, SAFARI_ZONE_GATE, 2
	warp_event  0,  7, POKECENTER_2F, 1

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SafariZoneGatePokecenter1FNurseScript, -1
	object_event  6,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, SafariZoneGatePokecenter1FHikerScript, -1