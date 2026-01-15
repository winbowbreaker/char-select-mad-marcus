if not _G.charSelectExists then return end

local gMarcusstates = {}
for i = 0, MAX_PLAYERS do
    gMarcusstates[i] = {}
    local c = gMarcusstates[i]
    c.grav = 0
    c.facing = 0
    c.scale = { x = 1, y = 1, z = 1 }
    c.timer = 0
    c.backlaunch = 0
    c.savedmomentum = 0
    c.brownieseaten = 0
    c.jumptimer = -5
end

function add_moveset()

--local strmspinny = audio_stream_load("crashspin.ogg")

--moveset shit
charSelect.character_hook_moveset(CT_MADMARCUS, HOOK_BEFORE_SET_MARIO_ACTION,
function (m, inc)
    local c = gMarcusstates[m.playerIndex]
    local replace = {
        [ACT_STEEP_JUMP]              = ACT_JUMP,
        [ACT_TWIRL_LAND]              = ACT_JUMP_LAND_STOP,
     -- [ACT_PUNCHING]                = ACT_SPINNYTHING,
     -- [ACT_MOVE_PUNCHING]           = ACT_SPINNYTHING_AIR,
     -- [ACT_SOFT_BACKWARD_GROUND_KB] = ACT_JUMP_KICK,
     -- [ACT_START_SLEEPING]          = ACT_IDLESECOND,
    }
    if replace[inc] then return replace[inc] end

end)

marcuslandtable = { -- saul twirl table
    [ACT_JUMP_LAND] = true,
    [ACT_DOUBLE_JUMP_LAND] = true,
    [ACT_TRIPLE_JUMP_LAND] = true,
    [ACT_BACKFLIP_LAND] = true,
    [ACT_SIDE_FLIP_LAND] = true,
    [ACT_HOLD_JUMP_LAND] = true,
    [ACT_AIR_THROW_LAND] = true,
    [ACT_LONG_JUMP_LAND] = true,
    [ACT_FREEFALL_LAND] = true,
    [ACT_HOLD_FREEFALL_LAND] = true,
    [ACT_BACKWARD_GROUND_KB] = true,
    [ACT_FORWARD_GROUND_KB] = true,
}

charSelect.character_hook_moveset(CT_MADMARCUS, HOOK_ON_SET_MARIO_ACTION,
function (m)
    if m.playerIndex == 0 then
        local c = gMarcusstates[m.playerIndex]
        if m.action == ACT_GROUND_POUND_LAND then
            cur_obj_shake_screen(SHAKE_POS_LARGE)
            cur_obj_shake_screen(SHAKE_POS_LARGE)
            cur_obj_shake_screen(SHAKE_POS_LARGE)
            spawn_sync_object(id_bhvBowserShockWave, E_MODEL_BOWSER_WAVE, m.pos.x, m.pos.y, m.pos.z, nil)
        end
        if marcuslandtable[m.action] ~= nil then
            cur_obj_shake_screen(SHAKE_POS_SMALL)
        end
        if m.action == ACT_DEATH_EXIT_LAND then
            cur_obj_shake_screen(SHAKE_POS_LARGE)
        end
    end
end)

function marcus_update(m)
    local c = gMarcusstates[m.playerIndex]
    if m.playerIndex == 0 then

        --beta groundpound
        if m.action == ACT_GROUND_POUND and m.prevAction ~= ACT_FLYING then -- is mario ground pounding
            if m.pos.y > m.floorHeight then -- making sure mario doesn't clip through the floor
                if m.actionTimer < 15 then -- checking if the "pound roll" has finished, don't ask
                    m.pos.y = m.pos.y - 5*(m.actionTimer - 1 * 5) -- lowering mario's physical height
                    m.marioObj.header.gfx.pos.y = m.pos.y
                    m.marioObj.header.gfx.angle.y = m.faceAngle.y
                    --m.marioObj.header.gfx.pos.y = m.marioObj.header.gfx.pos.y - (m.actionTimer * 2) -- lowering mario's visual height
                end
            end
        else
            --m.action = ACT_GROUND_POUND_LAND -- if mario is under the floor then set him to the ground pound land act
        end
        --beta groundpound end
        -- if m.action == ACT_GROUND_POUND_LAND and m.actionTimer == 1 then
        --     cur_obj_shake_screen(SHAKE_POS_LARGE)
        --     spawn_sync_object(id_bhvBowserShockWave, E_MODEL_BOWSER_WAVE, m.pos.x, m.pos.y, m.pos.z, nil)
        -- end
    end
end

_G.charSelect.character_hook_moveset(CT_MADMARCUS, HOOK_MARIO_UPDATE, marcus_update)
end