; Legacy support for pre-2018 pokecrystal.
; Allows porting scripts with as few edits as possible.

; macros/rst.asm
callba EQUS "farcall"
callab EQUS "callfar"

; macros/scripts/audio.asm
unknownmusic0xde EQUS "sound_duty"


; macros/scripts/events.asm

checkmorn EQUS "checktime MORN"
checkday  EQUS "checktime DAY"
checknite EQUS "checktime NITE"

if_equal        EQUS "ifequal"
if_not_equal    EQUS "ifnotequal"
if_greater_than EQUS "ifgreater"
if_less_than    EQUS "ifless"
end_all         EQUS "endall"

checkmaptriggers EQUS "checkmapscene"
domaptrigger     EQUS "setmapscene"
checktriggers    EQUS "checkscene"
dotrigger        EQUS "setscene"

faceperson       EQUS "faceobject"
moveperson       EQUS "moveobject"
writepersonxy    EQUS "writeobjectxy"
spriteface       EQUS "turnobject"
objectface       EQUS "turnobject"

RAM2MEM           EQUS "vartomem"
loadfont          EQUS "opentext"
loadmenudata      EQUS "loadmenu"
loadmenuheader    EQUS "loadmenu"
writebackup       EQUS "closewindow"
interpretmenu     EQUS "_2dmenu"
interpretmenu2    EQUS "verticalmenu"
battlecheck       EQUS "randomwildmon"
loadtrainerdata   EQUS "loadmemtrainer"
loadpokedata      EQUS "loadwildmon"
returnafterbattle EQUS "reloadmapafterbattle"
trainerstatus     EQUS "trainerflagaction"
talkaftercancel   EQUS "endifjustbattled"
talkaftercheck    EQUS "checkjustbattled"
playrammusic      EQUS "encountermusic"
reloadmapmusic    EQUS "dontrestartmapmusic"
resetfuncs        EQUS "endall"
storetext         EQUS "battletowertext"
displaylocation   EQUS "landmarktotext"
givepokeitem      EQUS "givepokemail"
checkpokeitem     EQUS "checkpokemail"


; macros/scripts/maps.asm

MACRO mapconst
	map_const \1, \3, \2
ENDM

maptrigger EQUS "scene_script"

MACRO warp_def
	warp_event \2, \1, \4, \3
ENDM

MACRO xy_trigger
	coord_event \3, \2, \1, \5
ENDM

MACRO signpost
	bg_event \2, \1, \3, \4
ENDM

MACRO person_event
;	object_event \3, \2, \1, \4, \5, \6, \7, \8, \9, \10, \11, \12, \13
	db \1, \2 + 4, \3 + 4, \4
	dn \6, \5
	db \7, \8
	shift
	dn \8, \9
	shift
	db \9
	shift
	dw \9
	shift
	dw \9
ENDM

PERSONTYPE_SCRIPT   EQUS "OBJECTTYPE_SCRIPT"
PERSONTYPE_ITEMBALL EQUS "OBJECTTYPE_ITEMBALL"
PERSONTYPE_TRAINER  EQUS "OBJECTTYPE_TRAINER"


; macros/scripts/movement.asm

show_person   EQUS "show_object"
hide_person   EQUS "hide_object"
remove_person EQUS "remove_object"

turn_head_down        EQUS "turn_head DOWN"
turn_head_up          EQUS "turn_head UP"
turn_head_left        EQUS "turn_head LEFT"
turn_head_right       EQUS "turn_head RIGHT"
turn_step_down        EQUS "turn_step DOWN"
turn_step_up          EQUS "turn_step UP"
turn_step_left        EQUS "turn_step LEFT"
turn_step_right       EQUS "turn_step RIGHT"
slow_step_down        EQUS "slow_step DOWN"
slow_step_up          EQUS "slow_step UP"
slow_step_left        EQUS "slow_step LEFT"
slow_step_right       EQUS "slow_step RIGHT"
step_down             EQUS "step DOWN"
step_up               EQUS "step UP"
step_left             EQUS "step LEFT"
step_right            EQUS "step RIGHT"
big_step_down         EQUS "big_step DOWN"
big_step_up           EQUS "big_step UP"
big_step_left         EQUS "big_step LEFT"
big_step_right        EQUS "big_step RIGHT"
slow_slide_step_down  EQUS "slow_slide_step DOWN"
slow_slide_step_up    EQUS "slow_slide_step UP"
slow_slide_step_left  EQUS "slow_slide_step LEFT"
slow_slide_step_right EQUS "slow_slide_step RIGHT"
slide_step_down       EQUS "slide_step DOWN"
slide_step_up         EQUS "slide_step UP"
slide_step_left       EQUS "slide_step LEFT"
slide_step_right      EQUS "slide_step RIGHT"
fast_slide_step_down  EQUS "fast_slide_step DOWN"
fast_slide_step_up    EQUS "fast_slide_step UP"
fast_slide_step_left  EQUS "fast_slide_step LEFT"
fast_slide_step_right EQUS "fast_slide_step RIGHT"
turn_away_down        EQUS "turn_away DOWN"
turn_away_up          EQUS "turn_away UP"
turn_away_left        EQUS "turn_away LEFT"
turn_away_right       EQUS "turn_away RIGHT"
turn_in_down          EQUS "turn_in DOWN"
turn_in_up            EQUS "turn_in UP"
turn_in_left          EQUS "turn_in LEFT"
turn_in_right         EQUS "turn_in RIGHT"
turn_waterfall_down   EQUS "turn_waterfall DOWN"
turn_waterfall_up     EQUS "turn_waterfall UP"
turn_waterfall_left   EQUS "turn_waterfall LEFT"
turn_waterfall_right  EQUS "turn_waterfall RIGHT"
slow_jump_step_down   EQUS "slow_jump_step DOWN"
slow_jump_step_up     EQUS "slow_jump_step UP"
slow_jump_step_left   EQUS "slow_jump_step LEFT"
slow_jump_step_right  EQUS "slow_jump_step RIGHT"
jump_step_down        EQUS "jump_step DOWN"
jump_step_up          EQUS "jump_step UP"
jump_step_left        EQUS "jump_step LEFT"
jump_step_right       EQUS "jump_step RIGHT"
fast_jump_step_down   EQUS "fast_jump_step DOWN"
fast_jump_step_up     EQUS "fast_jump_step UP"
fast_jump_step_left   EQUS "fast_jump_step LEFT"
fast_jump_step_right  EQUS "fast_jump_step RIGHT"

step_sleep_1 EQUS "step_sleep 1"
step_sleep_2 EQUS "step_sleep 2"
step_sleep_3 EQUS "step_sleep 3"
step_sleep_4 EQUS "step_sleep 4"
step_sleep_5 EQUS "step_sleep 5"
step_sleep_6 EQUS "step_sleep 6"
step_sleep_7 EQUS "step_sleep 7"
step_sleep_8 EQUS "step_sleep 8"
