-- name: [CS] Mad Marcus
-- description: so beytah \n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!
-- category: cs

--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/wiki/API-Documentation

    Use this if you're curious on how anything here works >v<
    (This is an edited version of the Template File by Squishy)
]]

local TEXT_MOD_NAME = "[CS] Mad Marcus"

-- Stops mod from loading if Character Select isn't on
if not _G.charSelectExists then
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nis gonna get very mad if you don't turn on character select right now.", 6)
    return 0
end

local E_MODEL_CUSTOM_MODEL = smlua_model_util_get_id("marcusmad_geo") -- main costume

--icons
local TEX_CUSTOM_LIFE_ICON = get_texture_info("mad-micon")

-- All Located in "sound" Name them whatever you want. Remember to include the .ogg extension
local VOICETABLE_MADMAN = {
    [CHAR_SOUND_OKEY_DOKEY] = 'Silent.ogg', -- Starting game
    [CHAR_SOUND_LETS_A_GO] = 'madalive.ogg', -- Starting level
    [CHAR_SOUND_PUNCH_YAH] = 'madyah2.ogg', -- Punch 1
    [CHAR_SOUND_PUNCH_WAH] = 'madwah2.ogg', -- Punch 2
    [CHAR_SOUND_PUNCH_HOO] = 'madhoo2.ogg', -- Punch 3
    [CHAR_SOUND_YAH_WAH_HOO] = {'madyah.ogg', 'madyah2.ogg', 'madwah.ogg'}, -- First/Second jump sounds
    [CHAR_SOUND_HOOHOO] = {'madhoo.ogg', 'madhoohoo.ogg'}, -- Third jump sound
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'madyippee.ogg', 'madyahoo.ogg'}, -- Triple jump sounds
    [CHAR_SOUND_UH] = 'Silent.ogg', -- Wall bonk
    [CHAR_SOUND_UH2] = 'madagh.ogg', -- Landing after long jump
    [CHAR_SOUND_UH2_2] = 'madagh.ogg', -- Same sound as UH2; jumping onto ledge
    [CHAR_SOUND_HAHA] = 'madhaha.ogg', -- Landing triple jump
    [CHAR_SOUND_YAHOO] = {'madyahoo.ogg', 'madyaha.ogg', 'madlaugh.ogg'}, -- Long jump
    [CHAR_SOUND_DOH] = 'Silent.ogg', -- Long jump wall bonk
    [CHAR_SOUND_WHOA] = 'madagh.ogg', -- Grabbing ledge
    [CHAR_SOUND_EEUH] = 'Silent.ogg', -- Climbing over ledge
    [CHAR_SOUND_WAAAOOOW] = 'madscreaming.ogg', -- Falling a long distance
    [CHAR_SOUND_TWIRL_BOUNCE] = 'madyippee.ogg', -- Bouncing off of a flower spring
    [CHAR_SOUND_GROUND_POUND_WAH] = 'madwah.ogg',
    [CHAR_SOUND_HRMM] = 'Silent.ogg', -- Lifting something
    [CHAR_SOUND_HERE_WE_GO] = {'madbro.ogg', 'madalive.ogg', 'madlikemad.ogg'}, -- Star get
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'madlaugh.ogg', -- Throwing Bowser
--DAMAGE
    [CHAR_SOUND_ATTACKED] = 'madagh.ogg', -- Damaged
    [CHAR_SOUND_PANTING] = 'Silent.ogg', -- Low health
    [CHAR_SOUND_ON_FIRE] = 'madscreaming.ogg', -- Burned
--SLEEP SOUNDS
    [CHAR_SOUND_IMA_TIRED] = 'Silent.ogg', -- Mario feeling tired
    [CHAR_SOUND_YAWNING] = 'Silent.ogg', -- Mario yawning before he sits down to sleep
    [CHAR_SOUND_SNORING1] = 'Silent.ogg', -- Snore Inhale
    [CHAR_SOUND_SNORING2] = 'Silent.ogg', -- Exhale
    [CHAR_SOUND_SNORING3] = 'Silent.ogg', -- Sleep talking / mumbling
--COUGHING (USED IN THE GAS MAZE)
    [CHAR_SOUND_COUGHING1] = 'Silent.ogg', -- Cough take 1
    [CHAR_SOUND_COUGHING2] = 'Silent.ogg', -- Cough take 2
    [CHAR_SOUND_COUGHING3] = 'Silent.ogg', -- Cough take 3
--DEATH
    [CHAR_SOUND_DYING] = 'Silent.ogg', -- Dying from damage
    [CHAR_SOUND_DROWNING] = 'Silent.ogg', -- Running out of air underwater
    [CHAR_SOUND_MAMA_MIA] = 'madlikemad.ogg' -- Booted out of level
}

local ANIMTABLE_MADMANIMATION = {
    [CHAR_ANIM_IDLE_HEAD_CENTER] = 'newsoupstare',
    [CHAR_ANIM_IDLE_HEAD_LEFT] = 'newsoupstare',
    [CHAR_ANIM_IDLE_HEAD_RIGHT] = 'newsoupstare',
    [_G.charSelect.CS_ANIM_MENU] = "newsoupstare",
}

animTables = {
    ANIMTABLE_MADMANIMATION
}

local PALETTE_MARCUS = {
    name = "marcus",
    [PANTS]  = "264A34",
    [SHIRT]  = "E13A00",
    [GLOVES] = "FFFFFF",
    [SHOES]  = "0A1419",
    [HAIR]   = "3E0F0C",
    [SKIN]   = "FFB184" ,
    [CAP]    = "E13A00",
    [EMBLEM] = "000000"
}

--tanner skin E59D5D

local CSloaded = false
local function on_character_select_load()
    CT_MADMARCUS = _G.charSelect.character_add("Mad Marcus", {"he was in my copy of mario wii -", "and now he's here, to jumpscare me!"}, "WinbowBreaker Charlotte", "E13A00", E_MODEL_CUSTOM_MODEL, CT_MARIO, TEX_CUSTOM_LIFE_ICON, 1.15, nil)

    _G.charSelect.character_set_category(CT_MADMARCUS, "DXA")
    _G.charSelect.character_set_category(CT_MADMARCUS, "Squishy Workshop")

    local CSMARCFITTI = get_texture_info("marcfitti")
    _G.charSelect.character_add_graffiti(CT_MADMARCUS, CSMARCFITTI)

    _G.charSelect.character_add_voice(E_MODEL_CUSTOM_MODEL, VOICETABLE_MADMAN)
    _G.charSelect.character_add_animations(E_MODEL_CUSTOM_MODEL, ANIMTABLE_MADMANIMATION)
    _G.charSelect.character_add_palette_preset(E_MODEL_CUSTOM_MODEL, PALETTE_MARCUS, "malus malus italicus")

    alts = {}
    add_moveset()
    CSloaded = true
end

function marcusupdate(m)
    if _G.charSelect.character_get_current_number(0) == CT_MADMARCUS then
        if m.playerIndex == 0 then
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, marcusupdate)

local voices = {
    [VOICETABLE_MADMAN] = 1
}

local MARC_COIN = audio_sample_load("madcoins.mp3")
local MARCREDCOIN = audio_sample_load("madredcoins.mp3")

local function marcusmadness(id)
    if _G.charSelect.character_get_current_number(0) ~= CT_MADMARCUS then return end

    local m = gMarioStates[0]
    local soundPos = m.pos --m.marioObj.header.gfx.cameraToObject
    local vol = 1
    
    if id == SOUND_GENERAL_COIN or id == SOUND_GENERAL_COIN_WATER then
        audio_sample_play(MARC_COIN, soundPos, vol)
        return NO_SOUND
    end
    if id == SOUND_MENU_COLLECT_RED_COIN
    or id == SOUND_MENU_COLLECT_RED_COIN + 0x10000
    or id == SOUND_MENU_COLLECT_RED_COIN + 0x20000
    or id == SOUND_MENU_COLLECT_RED_COIN + 0x30000
    or id == SOUND_MENU_COLLECT_RED_COIN + 0x40000
    or id == SOUND_MENU_COLLECT_RED_COIN + 0x50000
    or id == SOUND_MENU_COLLECT_RED_COIN + 0x60000
    or id == SOUND_MENU_COLLECT_RED_COIN + 0x70000 then
        audio_sample_play(MARCREDCOIN, soundPos, vol)
        return NO_SOUND
    end
end


local function on_character_sound(m, sound)
    if not CSloaded then return end
    if voices[_G.charSelect.character_get_voice(m)] then return _G.charSelect.voice.sound(m, sound) end
end

local function on_character_snore(m)
    if not CSloaded then return end
    if voices[_G.charSelect.character_get_voice(m)] then return _G.charSelect.voice.snore(m) end
end

hook_event(HOOK_ON_PLAY_SOUND, marcusmadness)
hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)
hook_event(HOOK_CHARACTER_SOUND, on_character_sound)
hook_event(HOOK_MARIO_UPDATE, on_character_snore)