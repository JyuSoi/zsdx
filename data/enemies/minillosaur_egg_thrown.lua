-- Minillosaur egg: a small papillosaur that comes from an egg.
-- This enemy is usually be generated by a bigger one.

in_egg = nil

-- The enemy appears: create its movement
function event_appear()

  sol.enemy.set_life(2)
  sol.enemy.set_damage(2)
  sol.enemy.create_sprite("enemies/minillosaur_egg_thrown")
  sol.enemy.set_size(24, 32)
  sol.enemy.set_origin(12, 20)
  sol.enemy.set_invincible()
  sol.enemy.set_attack_consequence("sword", "custom")
  sol.enemy.set_obstacle_behavior("flying")

  local sprite = sol.enemy.get_sprite()
  sol.main.sprite_set_animation(sprite, "egg")
  in_egg = true
  local x, y = sol.enemy.get_position()
  local hero_x, hero_y = sol.map.hero_get_position()
  local angle = sol.main.get_angle(x, y, hero_x, hero_y)
end

-- The enemy was stopped for some reason and should restart
function event_restart()

  if in_egg then
    local sprite = sol.enemy.get_sprite()
    sol.main.sprite_set_animation(sprite, "egg")
    local m = sol.main.straight_movement_create(120, angle)
    sol.main.movement_set_property(m, "max_distance", 180)
    sol.main.movement_set_property(m, "smooth", false)
    sol.enemy.start_movement(m)
  end
end

-- An obstacle is reached: in the egg state, break the egg
function event_obstacle_reached()

  local sprite = sol.enemy.get_sprite()
  if sol.main.sprite_get_animation(sprite) == "egg" then
    break_egg()
  end
end

-- The movement is finished: in the egg state, break the egg
function event_movement_finished(movement)
  -- same thing as when an obstacle is reached
  event_obstacle_reached()
end

-- The enemy receives an attack whose consequence is "custom"
function event_custom_attack_received(attack, sprite)

  if attack == "sword" and sol.main.sprite_get_animation(sprite) == "egg" then
    -- the egg is hit by the sword
    break_egg()
    sol.main.play_sound("monster_hurt")
  end
end

-- Starts breaking the egg
function break_egg()

  local sprite = sol.enemy.get_sprite()
  sol.enemy.stop_movement()
  sol.main.sprite_set_animation(sprite, "egg_breaking")
end

--  The animation of a sprite is finished
function event_sprite_animation_finished(sprite, animation)

  -- if the egg was breaking, make the minillosaur go
  if animation == "egg_breaking" then
    sol.main.sprite_set_animation(sprite, "walking")
    sol.enemy.set_size(16, 16)
    sol.enemy.set_origin(8, 12)
    sol.enemy.snap_to_grid()
    local m = sol.main.path_finding_movement_create(40)
    sol.enemy.start_movement(m)
    sol.enemy.set_default_attack_consequences()
    in_egg = false
  end
end

