-- Displaying messages on the terminal
io.stdout:setvbuf("no")

-- Including all the eros packages
require 'eros.functions'
require "eros.class"
require 'eros.keys'
require 'eros.camera'

VERSION = "0.0.2"

game = {}
objects = {}

-- Game functions
function game.start() end
function game.step() end
function game.draw() end

-- Constants
cr_none = "cr_none"


print("[+] Eros v" .. VERSION)


-- Wrapping the love default functions with the needed ones for eros
-- Instead of using love.x() you can use the new game.start, game.step game.draw.
function love.load()
    game.start()
    -- Create event of objects
    for i = 1, #objects do
      objects[i].create()
    end
end

function love.update( dt )
    mouse_x, mouse_y = love.mouse.getPosition( )
    game.step()
    if keyboard_check(vk_escape) then
        game_end()
    end
    --ACTIVATING TRANSITION
    perform_transition()
end


function love.draw()
  camera:set()
  room_draw()
  -- Drawing all instances created in the room
  if room.instances then
    for j = 1, #room.instances do
      room.instances[j]:draw()
    end
  end
  -- if there is a background active, draw it
  if room.background_image then
    draw_background(room.background_image, 0, 0)
  end

  game.draw()

  -- for use when you change room
  draw_transition()
  camera:unset()
end

-- This is required for the camera functions
function math.clamp(x, min, max)
  return x < min and min or (x > max and max or x)
end
