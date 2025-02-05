; StartMenu.Items indexes
	const_def
	const STARTMENUITEM_POKEDEX  ; 0
	const STARTMENUITEM_POKEMON  ; 1
	const STARTMENUITEM_PACK     ; 2
	const STARTMENUITEM_STATUS   ; 3
	const STARTMENUITEM_SAVE     ; 4
	const STARTMENUITEM_OPTION   ; 5
	const STARTMENUITEM_EXIT     ; 6
	const STARTMENUITEM_POKEGEAR ; 7
	const STARTMENUITEM_QUIT     ; 8
	const STARTMENUITEM_RETIRE   ; 9


StartMenu::

	call ClearWindowData

	ld de, SFX_MENU
	call PlaySFX

	farcall ReanchorBGMap_NoOAMUpdate

	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ld hl, .MenuHeader
	jr z, .GotMenuData
	ld hl, .ContestMenuHeader
.GotMenuData:

	call LoadMenuHeader
	call .SetUpMenuItems
	ld a, [wBattleMenuCursorBuffer]
	ld [wMenuCursorBuffer], a
	call .DrawMenuAccount_
	call DrawVariableLengthMenuBox
	call .DrawBugContestStatusBox
	call .DrawSafariZoneStatusBox
	call SafeUpdateSprites
	call _OpenAndCloseMenu_HDMATransferTileMapAndAttrMap
	farcall LoadFonts_NoOAMUpdate
	call .DrawBugContestStatus
	call .DrawSafariZoneStatus
	call UpdateTimePals
	jr .Select

.Reopen:
	call UpdateSprites
	call UpdateTimePals
	call .SetUpMenuItems
	ld a, [wBattleMenuCursorBuffer]
	ld [wMenuCursorBuffer], a

.Select:
	call .GetInput
	jr c, .Exit
	call .DrawMenuAccount
	ld a, [wMenuCursorBuffer]
	ld [wBattleMenuCursorBuffer], a
	call PlayClickSFX
	call PlaceHollowCursor
	call .OpenMenu

; Menu items have different return functions.
; For example, saving exits the menu.
	ld hl, .MenuReturns
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.MenuReturns:
	dw .Reopen
	dw .Exit
	dw .ExitMenuCallFuncCloseText
	dw .ExitMenuRunScriptCloseText
	dw .ExitMenuRunScript
	dw .ReturnEnd
	dw .ReturnRedraw

.Exit:
	ld a, [hOAMUpdate]
	push af
	ld a, 1
	ld [hOAMUpdate], a
	call LoadFontsExtra
	pop af
	ld [hOAMUpdate], a
.ReturnEnd:
	call ExitMenu
.ReturnEnd2:
	call CloseText
	call UpdateTimePals
	ret

.GetInput:
; Return carry on exit, and no-carry on selection.
	xor a
	ld [hBGMapMode], a
	call .DrawMenuAccount
	call SetUpMenu
	ld a, $ff
	ld [wMenuSelection], a
.loop
	call .PrintMenuAccount
	call GetScrollingMenuJoypad
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b
	cp A_BUTTON
	jr z, .a
	jr .loop
.a
	call PlayClickSFX
	and a
	ret
.b
	scf
	ret

.ExitMenuRunScript:
	call ExitMenu
	ld a, HMENURETURN_SCRIPT
	ld [hMenuReturn], a
	ret

.ExitMenuRunScriptCloseText:
	call ExitMenu
	ld a, HMENURETURN_SCRIPT
	ld [hMenuReturn], a
	jr .ReturnEnd2

.ExitMenuCallFuncCloseText:
	call ExitMenu
	ld hl, wQueuedScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wQueuedScriptBank]
	rst FarCall
	jr .ReturnEnd2

.ReturnRedraw:
	call .Clear
	jp .Reopen

.Clear:
	call ClearBGPalettes
	call Call_ExitMenu
	call ReloadTilesetAndPalettes
	call .DrawMenuAccount_
	call DrawVariableLengthMenuBox
	call .DrawBugContestStatus
	call .DrawSafariZoneStatus
	call UpdateSprites
	call ret_d90
	call FinishExitMenu
	ret


.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 10, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default selection

.ContestMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 10, 2, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default selection

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_ENABLE_START ; flags
	dn 0, 0 ; rows, columns
	dw wMenuItemsList
	dw .MenuString
	dw .Items

.Items:
; entries correspond to STARTMENUITEM_* constants
	dw StartMenu_Pokedex,  .PokedexString,  .PokedexDesc
	dw StartMenu_Pokemon,  .PartyString,    .PartyDesc
	dw StartMenu_Pack,     .PackString,     .PackDesc
	dw StartMenu_Status,   .StatusString,   .StatusDesc
	dw StartMenu_Save,     .SaveString,     .SaveDesc
	dw StartMenu_Option,   .OptionString,   .OptionDesc
	dw StartMenu_Exit,     .ExitString,     .ExitDesc
	dw StartMenu_Pokegear, .PokegearString, .PokegearDesc
	dw StartMenu_Quit,     .QuitString,     .QuitDesc
	dw StartMenu_Retire,   .RetireString,   .RetireDesc

.PokedexString:  db "#DEX@"
.PartyString:    db "#MON@"
.PackString:     db "PACK@"
.StatusString:   db "<PLAYER>@"
.SaveString:     db "SAVE@"
.OptionString:   db "OPTION@"
.ExitString:     db "EXIT@"
.PokegearString: db "<POKE>GEAR@"
.QuitString:     db "QUIT@"
.RetireString:   db "RETIRE@"

.PokedexDesc:
	db   "#MON"
	next "database@"

.PartyDesc:
	db   "Party <PKMN>"
	next "status@"

.PackDesc:
	db   "Contains"
	next "items@"

.PokegearDesc:
	db   "Trainer's"
	next "key device@"

.StatusDesc:
	db   "Your own"
	next "status@"

.SaveDesc:
	db   "Save your"
	next "progress@"

.OptionDesc:
	db   "Change"
	next "settings@"

.ExitDesc:
	db   "Close this"
	next "menu@"

.QuitDesc:
	db   "Quit and"
	next "be judged.@"

.RetireDesc:
	db   "Leave the"
	next "SAFARI.@"


.OpenMenu:
	ld a, [wMenuSelection]
	call .GetMenuAccountTextPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.MenuString:
	push de
	ld a, [wMenuSelection]
	call .GetMenuAccountTextPointer
	inc hl
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret

.MenuDesc:
	push de
	ld a, [wMenuSelection]
	cp $ff
	jr z, .none
	call .GetMenuAccountTextPointer
rept 4
	inc hl
endr
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret
.none
	pop de
	ret


.GetMenuAccountTextPointer:
	ld e, a
	ld d, 0
	ld hl, wMenuDataPointerTableAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
rept 6
	add hl, de
endr
	ret


.SetUpMenuItems:
	xor a
	ld [wWhichIndexSet], a
	call .FillMenuList

	ld hl, wStatusFlags
	bit STATUSFLAGS_POKEDEX_F, [hl]
	jr z, .no_pokedex
	ld a, STARTMENUITEM_POKEDEX
	call .AppendMenuList
.no_pokedex

	ld a, [wPartyCount]
	and a
	jr z, .no_pokemon
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_SAFARI_GAME_F, [hl]
	jr nz, .no_pokemon
	ld a, STARTMENUITEM_POKEMON
	call .AppendMenuList
.no_pokemon

	ld a, [wLinkMode]
	and a
	jr nz, .no_pack
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .no_pack
	ld a, STARTMENUITEM_PACK
	call .AppendMenuList
.no_pack

	ld hl, wPokegearFlags
	bit POKEGEAR_OBTAINED_F, [hl]
	jr z, .no_pokegear
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_SAFARI_GAME_F, [hl]
	jr nz, .no_pokegear
	ld a, STARTMENUITEM_POKEGEAR
	call .AppendMenuList
.no_pokegear

	ld a, STARTMENUITEM_STATUS
	call .AppendMenuList

	ld a, [wLinkMode]
	and a
	jr nz, .no_save
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ld a, STARTMENUITEM_QUIT
	jr nz, .write
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_SAFARI_GAME_F, [hl]
	ld a, STARTMENUITEM_RETIRE
	jr nz, .write
	ld a, STARTMENUITEM_SAVE
.write
	call .AppendMenuList
.no_save

	ld a, STARTMENUITEM_OPTION
	call .AppendMenuList
	ld a, STARTMENUITEM_EXIT
	call .AppendMenuList
	ld a, c
	ld [wMenuItemsList], a
	ret


.FillMenuList:
	xor a
	ld hl, wMenuItemsList
	ld [hli], a
	ld a, -1
	ld bc, wMenuItemsListEnd - (wMenuItemsList + 1)
	call ByteFill
	ld de, wMenuItemsList + 1
	ld c, 0
	ret

.AppendMenuList:
	ld [de], a
	inc de
	inc c
	ret

.DrawMenuAccount_:
	jp .DrawMenuAccount

.PrintMenuAccount:
	call .IsMenuAccountOn
	ret z
	call .DrawMenuAccount
	decoord 0, 14
	jp .MenuDesc

.DrawMenuAccount:
	call .IsMenuAccountOn
	ret z
	hlcoord 0, 13
	lb bc, 5, 10
	call ClearBox
	hlcoord 0, 13
	ld b, 3
	ld c, 8
	jp TextBoxPalette

.IsMenuAccountOn:
	ld a, [wOptions2]
	and 1 << MENU_ACCOUNT
	ret

.DrawBugContestStatusBox:
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ret z
	farcall StartMenu_DrawBugContestStatusBox
	ret

.DrawBugContestStatus:
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .contest
	ret
.contest
	farcall StartMenu_PrintBugContestStatus
	ret

.DrawSafariZoneStatusBox:
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_SAFARI_GAME_F, [hl]
	ret z
	farcall StartMenu_DrawSafariZoneStatusBox
	ret

.DrawSafariZoneStatus:
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_SAFARI_GAME_F, [hl]
	jr nz, .safari_zone
	ret
.safari_zone
	farcall StartMenu_PrintSafariZoneStatus
	ret


StartMenu_Exit:
; Exit the menu.

	ld a, 1
	ret


StartMenu_Quit:
; Retire from the bug catching contest.

	ld hl, wStatusFlags2
	bit STATUSFLAGS2_SAFARI_GAME_F, [hl]
	jr nz, .safari_quit
	ld hl, .EndTheContestText
	call StartMenuYesNo
	jr c, .DontEndContest
	ld a, BANK(BugCatchingContestReturnToGateScript)
	ld hl, BugCatchingContestReturnToGateScript
	call FarQueueScript
	ld a, 4
	ret

.safari_quit:
	ld hl, .EndTheSafariGameText
	call StartMenuYesNo
	jr c, .DontEndContest
	ld a, BANK(SafariZoneReturnToGateScript)
	ld hl, SafariZoneReturnToGateScript
	call FarQueueScript
	ld a, 4
	ret

.DontEndContest:
	ld a, 0
	ret

.EndTheContestText:
	text_jump UnknownText_0x1c1a6c
	db "@"

.EndTheSafariGameText:
	text_jump EndTheSafariGame_text
	db "@"

StartMenu_Retire:
; Retire from the Safari Zone Game.

	ld hl, .EndTheSafariGameText
	call StartMenuYesNo
	jr c, .DontEndGame
	ld a, BANK(SafariZoneReturnToGateScript)
	ld hl, SafariZoneReturnToGateScript
	call FarQueueScript
	ld a, 4
	ret

.DontEndGame:
	ld a, 0
	ret

.EndTheSafariGameText:
	text_jump EndTheSafariGame_text
	db "@"


StartMenu_Save:
; Save the game.

	call BufferScreen
	farcall SaveMenu
	jr nc, .asm_12919
	ld a, 0
	ret
.asm_12919
	ld a, 1
	ret


StartMenu_Option:
; Game options.

	call FadeToMenu
	farcall OptionsMenu
	ld a, 6
	ret


StartMenu_Status:
; Player status.

	call FadeToMenu
	farcall TrainerCard
	call CloseSubmenu
	ld a, 0
	ret


StartMenu_Pokedex:

	ld a, [wPartyCount]
	and a
	jr z, .asm_12949

	call FadeToMenu
	farcall Pokedex
	call CloseSubmenu

.asm_12949
	ld a, 0
	ret


StartMenu_Pokegear:
	call FadeToMenu
	farcall PokeGear
	call CloseSubmenu
	ld a, [wJumptableIndex]
	and $7f
	ret


StartMenu_Pack:

	call FadeToMenu
	farcall Pack
	ld a, [wPackUsedItem]
	and a
	jr nz, .used_item
	call CloseSubmenu
	ld a, 0
	ret

.used_item
	call ExitAllMenus
	ld a, 4
	ret


StartMenu_Pokemon:

	ld a, [wPartyCount]
	and a
	jr z, .return

	call FadeToMenu

.choosemenu
	xor a
	ld [wPartyMenuActionText], a ; Choose a POKéMON.
	call ClearBGPalettes

.menu
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX

.menunoreload
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	call WaitBGMap
	call SetPalettes ; load regular palettes?
	call DelayFrame
	farcall PartyMenuSelect
	jr c, .return ; if cancelled or pressed B

	call PokemonActionSubmenu
	cp 3
	jr z, .menu
	cp 0
	jr z, .choosemenu
	cp 1
	jr z, .menunoreload
	cp 2
	jr z, .quit

.return
	call CloseSubmenu
	ld a, 0
	ret

.quit
	ld a, b
	push af
	call ExitAllMenus
	pop af
	ret

HasNoItems:
	ld a, [wNumItems]
	and a
	ret nz
	ld a, [wNumKeyItems]
	and a
	ret nz
	ld a, [wNumBalls]
	and a
	ret nz
	ld hl, wTMsHMs
	ld b, NUM_TMS + NUM_HMS
.loop
	ld a, [hli]
	and a
	jr nz, .done
	dec b
	jr nz, .loop
	scf
	ret
.done
	and a
	ret

TossItemFromPC:
	push de
	call PartyMonItemName
	farcall _CheckTossableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .key_item
	ld hl, .TossHowMany
	call MenuTextBox
	farcall SelectQuantityToToss
	push af
	call CloseWindow
	call ExitMenu
	pop af
	jr c, .quit
	ld hl, .ConfirmToss
	call MenuTextBox
	call YesNoBox
	push af
	call ExitMenu
	pop af
	jr c, .quit
	pop hl
	ld a, [wCurItemQuantity]
	call TossItem
	call PartyMonItemName
	ld hl, .TossedThisMany
	call MenuTextBox
	call ExitMenu
	and a
	ret

.key_item
	call .CantToss
.quit
	pop hl
	scf
	ret

.TossHowMany:
	; Toss out how many @ (S)?
	text_jump UnknownText_0x1c1a90
	db "@"

.ConfirmToss:
	; Throw away @ @ (S)?
	text_jump UnknownText_0x1c1aad
	db "@"

.TossedThisMany:
	; Discarded @ (S).
	text_jump UnknownText_0x1c1aca
	db "@"

.CantToss:
	ld hl, .TooImportantToToss
	call MenuTextBoxBackup
	ret

.TooImportantToToss:
	; That's too impor- tant to toss out!
	text_jump UnknownText_0x1c1adf
	db "@"

CantUseItem:
	ld hl, CantUseItemText
	call MenuTextBoxWaitButton
	ret

CantUseItemText:
	text_jump UnknownText_0x1c1b03
	db "@"


PartyMonItemName:
	ld a, [wCurItem]
	ld [wTempSpecies], a
	call GetItemName
	call CopyName1
	ret


CancelPokemonAction:
	farcall InitPartyMenuWithCancel
	farcall UnfreezeMonIcons
	ld a, 1
	ret


PokemonActionSubmenu:
	hlcoord 1, 15
	lb bc, 2, 18
	call ClearBox
	farcall MonSubmenu
	call GetCurNick
	ld a, [wMenuSelection]
	ld hl, .Actions
	ld de, 3
	call IsInArray
	jr nc, .nothing

	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.nothing
	ld a, 0
	ret

.Actions:
	dbw MONMENUITEM_CUT,        MonMenu_Cut
	dbw MONMENUITEM_FLY,        MonMenu_Fly
	dbw MONMENUITEM_SURF,       MonMenu_Surf
	dbw MONMENUITEM_STRENGTH,   MonMenu_Strength
	dbw MONMENUITEM_FLASH,      MonMenu_Flash
	dbw MONMENUITEM_WHIRLPOOL,  MonMenu_Whirlpool
	dbw MONMENUITEM_DIG,        MonMenu_Dig
	dbw MONMENUITEM_TELEPORT,   MonMenu_Teleport
	dbw MONMENUITEM_SOFTBOILED, MonMenu_Softboiled_MilkDrink
	dbw MONMENUITEM_MILKDRINK,  MonMenu_Softboiled_MilkDrink
	dbw MONMENUITEM_HEADBUTT,   MonMenu_Headbutt
	dbw MONMENUITEM_WATERFALL,  MonMenu_Waterfall
	dbw MONMENUITEM_ROCKSMASH,  MonMenu_RockSmash
	dbw MONMENUITEM_SWEETSCENT, MonMenu_SweetScent
	dbw MONMENUITEM_STATS,      OpenPartyStats
	dbw MONMENUITEM_SWITCH,     SwitchPartyMons
	dbw MONMENUITEM_ITEM,       GiveTakePartyMonItem
	dbw MONMENUITEM_CANCEL,     CancelPokemonAction
	dbw MONMENUITEM_MOVE,       ManagePokemonMoves
	dbw MONMENUITEM_MAIL,       MonMailAction


SwitchPartyMons:

; Don't try if there's nothing to switch!
	ld a, [wPartyCount]
	cp 2
	jr c, .DontSwitch

	ld a, [wCurPartyMon]
	inc a
	ld [wSwitchMon], a

	farcall HoldSwitchmonIcon
	farcall InitPartyMenuNoCancel

	ld a, PARTYMENUACTION_MOVE
	ld [wPartyMenuActionText], a
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText

	hlcoord 0, 1
	ld bc, SCREEN_WIDTH * 2
	ld a, [wSwitchMon]
	dec a
	call AddNTimes
	ld [hl], "▷"
	call WaitBGMap
	call SetPalettes
	call DelayFrame

	farcall PartyMenuSelect
	bit 1, b
	jr c, .DontSwitch

	farcall _SwitchPartyMons

	xor a
	ld [wPartyMenuActionText], a

	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX

	ld a, 1
	ret

.DontSwitch:
	xor a
	ld [wPartyMenuActionText], a
	call CancelPokemonAction
	ret


GiveTakePartyMonItem:

; Eggs can't hold items!
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .cancel

	ld hl, GiveTakeItemMenuData
	call LoadMenuHeader
	call VerticalMenu
	call ExitMenu
	jr c, .cancel

	call GetCurNick
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld a, [wMenuCursorY]
	cp 1
	jr nz, .take

	call LoadStandardMenuHeader
	call ClearPalettes
	call .GiveItem
	call ClearPalettes
	call LoadFontsBattleExtra
	call ExitMenu
	ld a, 0
	ret

.take
	call TakePartyItem
	ld a, 3
	ret

.cancel
	ld a, 3
	ret


.GiveItem:

	farcall DepositSellInitPackBuffers

.loop
	farcall DepositSellPack

	ld a, [wcf66]
	and a
	jr z, .quit

	ld a, [wcf65]
	cp 2
	jr z, .next

	call CheckTossableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .next

	call TryGiveItemToPartymon
	jr .quit

.next
	ld hl, CantBeHeldText
	call MenuTextBoxBackup
	jr .loop

.quit
	ret


TryGiveItemToPartymon:

	call SpeechTextBox
	call PartyMonItemName
	call GetPartyItemLocation
	ld a, [hl]
	and a
	jr z, .give_item_to_mon

	push hl
	ld d, a
	farcall ItemIsMail
	pop hl
	jr c, .please_remove_mail
	ld a, [hl]
	jr .already_holding_item

.give_item_to_mon
	call GiveItemToPokemon
	ld hl, MadeHoldText
	call MenuTextBoxBackup
	call GivePartyItem
	ret

.please_remove_mail
	ld hl, PleaseRemoveMailText
	call MenuTextBoxBackup
	ret

.already_holding_item
	ld [wTempSpecies], a
	call GetItemName
	ld hl, SwitchAlreadyHoldingText
	call StartMenuYesNo
	jr c, .abort

	call GiveItemToPokemon
	ld a, [wTempSpecies]
	push af
	ld a, [wCurItem]
	ld [wTempSpecies], a
	pop af
	ld [wCurItem], a
	call ReceiveItemFromPokemon
	jr nc, .bag_full

	ld hl, TookAndMadeHoldText
	call MenuTextBoxBackup
	ld a, [wTempSpecies]
	ld [wCurItem], a
	call GivePartyItem
	ret

.bag_full
	ld a, [wTempSpecies]
	ld [wCurItem], a
	call ReceiveItemFromPokemon
	ld hl, ItemStorageIsFullText
	call MenuTextBoxBackup

.abort
	ret


GivePartyItem:

	call GetPartyItemLocation
	ld a, [wCurItem]
	ld [hl], a
	ld d, a
	farcall ItemIsMail
	jr nc, .done
	call ComposeMailMessage

.done
	ret


TakePartyItem:

	call SpeechTextBox
	call GetPartyItemLocation
	ld a, [hl]
	and a
	jr z, .asm_12c8c

	ld [wCurItem], a
	call ReceiveItemFromPokemon
	jr nc, .asm_12c94

	farcall ItemIsMail
	call GetPartyItemLocation
	ld a, [hl]
	ld [wTempSpecies], a
	ld [hl], NO_ITEM
	call GetItemName
	ld hl, TookFromText
	call MenuTextBoxBackup
	jr .asm_12c9a

.asm_12c8c
	ld hl, IsntHoldingAnythingText
	call MenuTextBoxBackup
	jr .asm_12c9a

.asm_12c94
	ld hl, ItemStorageIsFullText
	call MenuTextBoxBackup

.asm_12c9a
	ret


GiveTakeItemMenuData:
	db MENU_SPRITE_ANIMS | MENU_BACKUP_TILES ; flags
	menu_coords 12, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .Items
	db 1 ; default option

.Items:
	db STATICMENU_CURSOR ; flags
	db 2 ; # items
	db "GIVE@"
	db "TAKE@"


TookAndMadeHoldText:
	text_jump UnknownText_0x1c1b2c
	db "@"

MadeHoldText:
	text_jump UnknownText_0x1c1b57
	db "@"

PleaseRemoveMailText:
	text_jump UnknownText_0x1c1b6f
	db "@"

IsntHoldingAnythingText:
	text_jump UnknownText_0x1c1b8e
	db "@"

ItemStorageIsFullText:
	text_jump UnknownText_0x1c1baa
	db "@"

TookFromText:
	text_jump UnknownText_0x1c1bc4
	db "@"

SwitchAlreadyHoldingText:
	text_jump UnknownText_0x1c1bdc
	db "@"

CantBeHeldText:
	text_jump UnknownText_0x1c1c09
	db "@"


GetPartyItemLocation:
	push af
	ld a, MON_ITEM
	call GetPartyParamLocation
	pop af
	ret


ReceiveItemFromPokemon:
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	jp ReceiveItem


GiveItemToPokemon:
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	jp TossItem

StartMenuYesNo:
	call MenuTextBox
	call YesNoBox
	jp ExitMenu


ComposeMailMessage:
	ld de, wTempMailMessage
	farcall _ComposeMailMessage
	ld hl, wPlayerName
	ld de, wTempMailAuthor
	ld bc, NAME_LENGTH - 1
	call CopyBytes
	ld hl, wPlayerID
	ld bc, 2
	call CopyBytes
	ld a, [wCurPartySpecies]
	ld [de], a
	inc de
	ld a, [wCurItem]
	ld [de], a
	ld a, [wCurPartyMon]
	ld hl, sPartyMail
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wTempMail
	ld bc, MAIL_STRUCT_LENGTH
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	call CopyBytes
	call CloseSRAM
	ret

MonMailAction:
; If in the time capsule or trade center,
; selecting the mail only allows you to
; read the mail.
	ld a, [wLinkMode]
	cp LINK_TIMECAPSULE
	jr z, .read
	cp LINK_TRADECENTER
	jr z, .read

; Show the READ/TAKE/QUIT menu.
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	call ExitMenu

; Interpret the menu.
	jp c, .done
	ld a, [wMenuCursorY]
	cp $1
	jr z, .read
	cp $2
	jr z, .take
	jp .done

.read
	farcall ReadPartyMonMail
	ld a, $0
	ret

.take
	ld hl, .sendmailtopctext
	call StartMenuYesNo
	jr c, .RemoveMailToBag
	ld a, [wCurPartyMon]
	ld b, a
	farcall SendMailToPC
	jr c, .MailboxFull
	ld hl, .sentmailtopctext
	call MenuTextBoxBackup
	jr .done

.MailboxFull:
	ld hl, .mailboxfulltext
	call MenuTextBoxBackup
	jr .done

.RemoveMailToBag:
	ld hl, .mailwilllosemessagetext
	call StartMenuYesNo
	jr c, .done
	call GetPartyItemLocation
	ld a, [hl]
	ld [wCurItem], a
	call ReceiveItemFromPokemon
	jr nc, .BagIsFull
	call GetPartyItemLocation
	ld [hl], $0
	call GetCurNick
	ld hl, .tookmailfrommontext
	call MenuTextBoxBackup
	jr .done

.BagIsFull:
	ld hl, .bagfulltext
	call MenuTextBoxBackup
	jr .done

.done
	ld a, $3
	ret


.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 12, 10, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
	db "READ@"
	db "TAKE@"
	db "QUIT@"


.mailwilllosemessagetext
; The MAIL will lose its message. OK?
	text_jump UnknownText_0x1c1c22
	db "@"

.tookmailfrommontext
; MAIL detached from <POKEMON>.
	text_jump UnknownText_0x1c1c47
	db "@"

.bagfulltext
; There's no space for removing MAIL.
	text_jump UnknownText_0x1c1c62
	db "@"

.sendmailtopctext
; Send the removed MAIL to your PC?
	text_jump UnknownText_0x1c1c86
	db "@"

.mailboxfulltext
; Your PC's MAILBOX is full.
	text_jump UnknownText_0x1c1ca9
	db "@"

.sentmailtopctext
; The MAIL was sent to your PC.
	text_jump UnknownText_0x1c1cc4
	db "@"


OpenPartyStats:
	call LoadStandardMenuHeader
	call ClearSprites
; PartyMon
	xor a
	ld [wMonType], a
	call LowVolume
	predef StatsScreenInit
	call MaxVolume
	call Call_ExitMenu
	ld a, 0
	ret


MonMenu_Cut:
	farcall CutFunction
	ld a, [wFieldMoveSucceeded]
	cp $1
	ret


MonMenu_Fly:
	farcall FlyFunction
	ld a, [wFieldMoveSucceeded]
	cp $1
	ret

MonMenu_Flash:
	farcall OWFlash
	ld a, [wFieldMoveSucceeded]
	cp $1
	ret

MonMenu_Strength:
	farcall StrengthFunction
	ld a, [wFieldMoveSucceeded]
	cp $1
	ret

MonMenu_Whirlpool:
	farcall WhirlpoolFunction
	ld a, [wFieldMoveSucceeded]
	cp $1
	ret

MonMenu_Waterfall:
	farcall WaterfallFunction
	ld a, [wFieldMoveSucceeded]
	cp $1
	jr nz, .Fail
	ld b, $4
	ld a, $2
	ret

.Fail:
	ld a, $3
	ret

MonMenu_Teleport:
	farcall TeleportFunction
	ld a, [wFieldMoveSucceeded]
	and a
	jr z, .Fail
	ld b, $4
	ld a, $2
	ret

.Fail:
	ld a, $3
	ret

MonMenu_Surf:
	farcall SurfFunction
	ld a, [wFieldMoveSucceeded]
	cp $1
	ret

MonMenu_Dig:
	farcall DigFunction
	ld a, [wFieldMoveSucceeded]
	cp $1
	jr nz, .Fail
	ld b, $4
	ld a, $2
	ret

.Fail:
	ld a, $3
	ret

MonMenu_Softboiled_MilkDrink:
	call .CheckMonHasEnoughHP
	jr nc, .NotEnoughHP
	farcall Softboiled_MilkDrinkFunction
	jr .finish

.NotEnoughHP:
	ld hl, .Text_NotEnoughHP
	call PrintText

.finish
	xor a
	ld [wPartyMenuActionText], a
	ld a, $3
	ret

.Text_NotEnoughHP:
	; Not enough HP!
	text_jump UnknownText_0x1c1ce3
	db "@"

.CheckMonHasEnoughHP:
; Need to have at least (MaxHP / 5) HP left.
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ld [hDividend + 0], a
	ld a, [hl]
	ld [hDividend + 1], a
	ld a, 5
	ld [hDivisor], a
	ld b, 2
	call Divide
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld a, [hQuotient + 2]
	sub [hl]
	dec hl
	ld a, [hQuotient + 1]
	sbc [hl]
	ret

MonMenu_Headbutt:
	farcall HeadbuttFunction
	ld a, [wFieldMoveSucceeded]
	cp $1
	jr nz, .Fail
	ld b, $4
	ld a, $2
	ret

.Fail:
	ld a, $3
	ret

MonMenu_RockSmash:
	farcall RockSmashFunction
	ld a, [wFieldMoveSucceeded]
	cp $1
	ret

MonMenu_SweetScent:
	farcall SweetScentFromMenu
	ld b, $4
	ld a, $2
	ret

ChooseMoveToDelete:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call LoadFontsBattleExtra
	call .ChooseMoveToDelete
	pop bc
	ld a, b
	ld [wOptions], a
	push af
	call ClearBGPalettes
	pop af
	ret

.ChooseMoveToDelete
	call SetUpMoveScreenBG
	ld de, DeleteMoveScreenAttrs
	call SetMenuAttributes
	call SetUpMoveList
	ld hl, w2DMenuFlags1
	set 6, [hl]
	jr .enter_loop

.loop
	call ScrollingMenuJoypad
	bit B_BUTTON_F, a
	jp nz, .b_button
	bit A_BUTTON_F, a
	jp nz, .a_button

.enter_loop
	call PrepareToPlaceMoveData
	call PlaceMoveData
	jp .loop

.a_button
	and a
	jr .finish

.b_button
	scf

.finish
	push af
	xor a
	ld [wSwitchMon], a
	ld hl, w2DMenuFlags1
	res 6, [hl]
	call ClearSprites
	call ClearTileMap
	pop af
	ret

DeleteMoveScreenAttrs:
	db 3, 1
	db 3, 1
	db $40, $00
	dn 2, 0
	db D_UP | D_DOWN | A_BUTTON | B_BUTTON

ManagePokemonMoves:
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call MoveScreenLoop
	pop af
	ld [wOptions], a
	call ClearBGPalettes

.egg
	ld a, $0
	ret

MoveScreenLoop:
	ld a, [wCurPartyMon]
	inc a
	ld [wPartyMenuCursor], a
	call SetUpMoveScreenBG
	call Function132d3
	ld de, MoveScreenAttributes
	call SetMenuAttributes
.loop
	call SetUpMoveList
	ld hl, w2DMenuFlags1
	set 6, [hl]
	jr .skip_joy

.joy_loop
	call ScrollingMenuJoypad
	bit 1, a
	jp nz, .b_button
	bit 0, a
	jp nz, .a_button
	bit 4, a
	jp nz, .d_right
	bit 5, a
	jp nz, .d_left

.skip_joy
	call PrepareToPlaceMoveData
	ld a, [wMoveSwapBuffer]
	and a
	jr nz, .moving_move
	call PlaceMoveData
	jp .joy_loop

.moving_move
	ld a, " "
	hlcoord 1, 11
	ld bc, 5
	call ByteFill
	hlcoord 1, 12
	lb bc, 5, SCREEN_WIDTH - 2
	call ClearBox
	hlcoord 1, 12
	ld de, String_MoveWhere
	call PlaceString
	jp .joy_loop
.b_button
	call PlayClickSFX
	call WaitSFX
	ld a, [wMoveSwapBuffer]
	and a
	jp z, .exit

	ld a, [wMoveSwapBuffer]
	ld [wMenuCursorY], a
	xor a
	ld [wMoveSwapBuffer], a
	hlcoord 1, 2
	lb bc, 8, SCREEN_WIDTH - 2
	call ClearBox
	jp .loop

.d_right
	ld a, [wMoveSwapBuffer]
	and a
	jp nz, .joy_loop

	ld a, [wCurPartyMon]
	ld b, a
	push bc
	call .cycle_right
	pop bc
	ld a, [wCurPartyMon]
	cp b
	jp z, .joy_loop
	jp MoveScreenLoop

.d_left
	ld a, [wMoveSwapBuffer]
	and a
	jp nz, .joy_loop
	ld a, [wCurPartyMon]
	ld b, a
	push bc
	call .cycle_left
	pop bc
	ld a, [wCurPartyMon]
	cp b
	jp z, .joy_loop
	jp MoveScreenLoop

.cycle_right
	ld a, [wCurPartyMon]
	inc a
	ld [wCurPartyMon], a
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .cycle_left
	cp EGG
	ret nz
	jr .cycle_right

.cycle_left
	ld a, [wCurPartyMon]
	and a
	ret z
.cycle_left_loop
	ld a, [wCurPartyMon]
	dec a
	ld [wCurPartyMon], a
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	cp EGG
	ret nz
	ld a, [wCurPartyMon]
	and a
	jr z, .cycle_right
	jr .cycle_left_loop

.a_button
	call PlayClickSFX
	call WaitSFX
	ld a, [wMoveSwapBuffer]
	and a
	jr nz, .place_move
	ld a, [wMenuCursorY]
	ld [wMoveSwapBuffer], a
	call PlaceHollowCursor
	jp .moving_move

.place_move
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	push hl
	call .copy_move
	pop hl
	ld bc, $15
	add hl, bc
	call .copy_move
	ld a, [wBattleMode]
	jr z, .swap_moves
	ld hl, wBattleMonMoves
	ld bc, $20
	ld a, [wCurPartyMon]
	call AddNTimes
	push hl
	call .copy_move
	pop hl
	ld bc, 6
	add hl, bc
	call .copy_move

.swap_moves
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	call WaitSFX
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	call WaitSFX
	hlcoord 1, 2
	lb bc, 8, 18
	call ClearBox
	hlcoord 10, 10
	lb bc, 1, 9
	call ClearBox
	jp .loop

.copy_move
	push hl
	ld a, [wMenuCursorY]
	dec a
	ld c, a
	ld b, $0
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wMoveSwapBuffer]
	dec a
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	ret

.exit
	xor a
	ld [wMoveSwapBuffer], a
	ld hl, w2DMenuFlags1
	res 6, [hl]
	call ClearSprites
	jp ClearTileMap

MoveScreenAttributes:
	db 3, 1
	db 3, 1
	db $40, $00
	dn 2, 0
	db D_UP | D_DOWN | D_LEFT | D_RIGHT | A_BUTTON | B_BUTTON

String_MoveWhere:
	db "Where?@"

SetUpMoveScreenBG:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	xor a
	ld [hBGMapMode], a
	farcall LoadStatsScreenPageTilesGFX
	farcall ClearSpriteAnims2
	ld a, [wCurPartyMon]
	ld e, a
	ld d, $0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	ld [wTempSpecies], a
	ld e, $2
	farcall LoadMenuMonIcon
	hlcoord 0, 1
	ld b, 9
	ld c, 18
	call TextBox
	hlcoord 0, 11
	ld b, 5
	ld c, 18
	call TextBox
	hlcoord 2, 0
	lb bc, 2, 3
	call ClearBox
	xor a
	ld [wMonType], a
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call GetNick
	hlcoord 5, 1
	call PlaceString
	push bc
	farcall CopyMonToTempMon
	pop hl
	call PrintLevel
	ld hl, wPlayerHPPal
	call SetHPPal
	ld b, SCGB_MOVE_LIST
	call GetSGBLayout
	hlcoord 16, 0
	lb bc, 1, 3
	jp ClearBox

SetUpMoveList:
	xor a
	ld [hBGMapMode], a
	ld [wMoveSwapBuffer], a
	ld [wMonType], a
	predef CopyMonToTempMon
	ld hl, wTempMonMoves
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	call CopyBytes
	ld a, SCREEN_WIDTH * 2
	ld [wBuffer1], a
	hlcoord 2, 3
	predef ListMoves
	hlcoord 10, 4
	predef ListMovePP
	call WaitBGMap
	call SetPalettes
	ld a, [wNumMoves]
	inc a
	ld [w2DMenuNumRows], a
	hlcoord 0, 11
	ld b, 5
	ld c, 18
	jp TextBox

PrepareToPlaceMoveData:
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld a, [wMenuCursorY]
	dec a
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	ld [wCurMove], a
	hlcoord 1, 12
	lb bc, 5, 18
	jp ClearBox

PlaceMoveData:
	xor a
	ld [hBGMapMode], a
	hlcoord 0, 10
	ld de, String_MoveType_Top
	call PlaceString
	hlcoord 0, 11
	ld de, String_MoveType_Bottom
	call PlaceString
	hlcoord 12, 12
	ld de, String_MoveAtk
	call PlaceString
	ld a, [wCurMove]
	ld b, a
	hlcoord 2, 12
	predef PrintMoveType
	ld a, [wCurMove]
	dec a
	ld hl, Moves + MOVE_POWER
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	hlcoord 16, 12
	cp 2
	jr c, .no_power
	ld [wTempSpecies], a
	ld de, wTempSpecies
	lb bc, 1, 3
	call PrintNum
	jr .description

.no_power
	ld de, String_MoveNoPower
	call PlaceString

.description
	hlcoord 1, 14
	predef PrintMoveDesc
	ld a, $1
	ld [hBGMapMode], a
	ret

String_MoveType_Top:
	db "┌─────┐@"
String_MoveType_Bottom:
	db "│TYPE/└@"
String_MoveAtk:
	db "ATK/@"
String_MoveNoPower:
	db "---@"

Function132d3:
	call Function132da
	call Function132fe
	ret

Function132da:
	ld a, [wCurPartyMon]
	and a
	ret z
	ld c, a
	ld e, a
	ld d, 0
	ld hl, wPartyCount
	add hl, de
.loop
	ld a, [hl]
	and a
	jr z, .prev
	cp EGG
	jr z, .prev
	cp NUM_POKEMON + 1
	jr c, .legal

.prev
	dec hl
	dec c
	jr nz, .loop
	ret

.legal
	hlcoord 16, 0
	ld [hl], "◀"
	ret

Function132fe:
	ld a, [wCurPartyMon]
	inc a
	ld c, a
	ld a, [wPartyCount]
	cp c
	ret z
	ld e, c
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
.loop
	ld a, [hl]
	cp -1
	ret z
	and a
	jr z, .next
	cp EGG
	jr z, .next
	cp NUM_POKEMON + 1
	jr c, .legal

.next
	inc hl
	jr .loop

.legal
	hlcoord 18, 0
	ld [hl], "▶"
	ret
