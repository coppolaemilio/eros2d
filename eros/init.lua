-- Displaying messages on the terminal
io.stdout:setvbuf("no")

-- Including all the eros packages
require 'eros.functions'
require 'eros.assets'
require "eros.class"
require 'eros.keys'
require 'eros.camera'

VERSION = "0.1.2"
DEV = true

game = {}
objects = {}
room = {}

-- Game functions
function game.start() end
function game.step() end
function game.draw() end

-- Constants
cr_none = "cr_none"

function printd(string)
  if DEV then
    print(string)
  end
end

printd("[+] Eros v" .. VERSION)


-- Wrapping the love default functions with the needed ones for eros
-- Instead of using love.x() you can use the new game.start, game.step game.draw.
function love.load()
    game.start()
end

function love.update( dt )
    mouse_x, mouse_y = love.mouse.getPosition( )
    game.step()

    -- Instance step events
    if room.instances then
      if unexpected_condition then
        print("error!")
      else
        for j = 1, #room.instances do
          room.instances[j]:step()
        end
      end
    end

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
