SweetScentFromMenu:
	ld hl, .SweetScent
	call QueueScript
	ld a, $1
	ld [wFieldMoveSucceeded], a
	ret

.SweetScent:
	reloadmappart
	special UpdateTimePals
	callasm GetPartyNick
	writetext UnknownText_0x50726
	waitbutton
	callasm SweetScentEncounter
	iffalse SweetScentNothing
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .BugCatchingContest
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

.BugCatchingContest:
	farjump BugCatchingContestBattleScript

SweetScentNothing:
	writetext UnknownText_0x5072b
	waitbutton
	closetext
	end

SweetScentEncounter:
	farcall CanUseSweetScent
	jr nc, .no_battle
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .not_in_bug_contest_or_safari_zone
	bit STATUSFLAGS2_SAFARI_GAME_F, [hl]
	jr nz, .not_in_bug_contest_or_safari_zone
	farcall GetMapEncounterRate
	ld a, b
	and a
	jr z, .no_battle
	farcall ChooseWildEncounter
	jr nz, .no_battle
	jr .start_battle

.not_in_bug_contest_or_safari_zone
	farcall ChooseWildEncounter_BugContestOrSafariZone

.start_battle
	ld a, $1
	ld [wScriptVar], a
	ret

.no_battle
	xor a
	ld [wScriptVar], a
	ld [wBattleType], a
	ret

UnknownText_0x50726:
	; used SWEET SCENT!
	text_jump UnknownText_0x1c0b03
	db "@"

UnknownText_0x5072b:
	; Looks like there's nothing here…
	text_jump UnknownText_0x1c0b1a
	db "@"
