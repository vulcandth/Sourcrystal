PagerCardNames:
	db "SCYTHER CHOP@"
	db "PIDGEOT WING@"
	db "LAPRAS SURF@"
	db "MACHOKE PUSH@"
	db "MAREEP SHINE@"
	db "REMORAID WHIRL@"
	db "CUBONE SMASH@"

PagerMissingName:
	db "----------@"

PagerCardIconSpecies:
	db SCYTHER
	db PIDGEOT
	db LAPRAS
	db MACHOKE
	db MAREEP
	db REMORAID
	db CUBONE
	db 0 ; end

PagerCardSprites:
	; sprite anim index, pager flag bit
	db SPRITE_ANIM_INDEX_PAGER_MON_GREEN, PAGER_CUT_F
	db SPRITE_ANIM_INDEX_PAGER_MON_RED,   PAGER_FLY_F
	db SPRITE_ANIM_INDEX_PAGER_MON_BLUE,  PAGER_SURF_F
	db SPRITE_ANIM_INDEX_PAGER_MON_GREY,  PAGER_STRENGTH_F
	db SPRITE_ANIM_INDEX_PAGER_MON_BLUE,  PAGER_FLASH_F
	db SPRITE_ANIM_INDEX_PAGER_MON_BLUE,  PAGER_WHIRLPOOL_F
	db SPRITE_ANIM_INDEX_PAGER_MON_BROWN, PAGER_ROCK_SMASH_F
	db 0 ; end
