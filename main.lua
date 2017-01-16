local cherryBomb = RegisterMod("CherryBomb", 1)
local cherryBomb_item = Isaac.GetItemIdByName( "Cherry Bomb" )

function cherryBomb:use_cherryBomb()
    local player = Isaac.GetPlayer(0)
    local entities = Isaac.GetRoomEntities()
    local enemies = {}

    --Create a table containing enemies and the player
    for i=1, #entities do
        if entities[i]:IsVulnerableEnemy() then
            table.insert(enemies, 1, entities[i])
        end
    end
    table.insert(enemies, 1, player)

    --Spawn Bomb on a random entity (enemy or player)
    local explo_enemy = enemies[ math.random( #enemies ) ]
    local spawned_bomb = Isaac.Spawn(4, 0, 0, explo_enemy.Position, explo_enemy.Velocity, player) 

    --Create sound for bomb spawn
    local sound_entity = Isaac.Spawn(EntityType.ENTITY_FLY, 0, 0, Vector(320,300), Vector(0,0), nil):ToNPC()
    sound_entity:PlaySound(SoundEffect.SOUND_VAMP_GULP, 30, 0, false, 1.5)
    sound_entity:Remove()


    --Spawn visual effects for bomb spawn
    Game():SpawnParticles(explo_enemy.Position, EffectVariant.TEAR_POOF_A, 1, 1, Color(0.4,0.4,0.1,1,0,0,0), math.random());
    Game():SpawnParticles(explo_enemy.Position, EffectVariant.TEAR_POOF_SMALL, 1, 1, Color(0.4,0.4,0.1,50,0,0,0), math.random());
    Game():SpawnParticles(explo_enemy.Position, EffectVariant.BLOOD_SPLAT, 1, 1, Color(0.4,0.4,0.1,1,0,0,0), math.random());
end

cherryBomb:AddCallback( ModCallbacks.MC_USE_ITEM, cherryBomb.use_cherryBomb, cherryBomb_item);
