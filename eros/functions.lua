-- TRANSITION VARIABLES
local _transition = 0
local _transition_alpha = 0
local _transition_target = 0

-- KEYPRESSED VARIABLES
last_key = ""

function room_transition(room_name)
    _transition_target = room_name
    _transition = 1
end

function perform_transition()
    if _transition ~= 0 then
        local transition_speed = 0.025
        if _transition == 1 then
            _transition_alpha = _transition_alpha + transition_speed
        end
        if _transition_alpha > 1 and _transition == 1 then
            _transition = 2
        end
        if _transition == 2 then
            _transition_alpha = 1
            _transition = 3
            room_index = _transition_target
        end
        if _transition == 3 then
            _transition_alpha = _transition_alpha - transition_speed
            if _transition_alpha < 0 then
                _transition = 0
            end
        end
    end
end

function draw_transition()
    if _transition ~= 0 then
        draw_set_color(black)
        draw_set_alpha(_transition_alpha)
        love.graphics.rectangle("fill", 0,0,love.graphics.getWidth(),love.graphics.getHeight() )
    end
end
--------
function create_font (fontname, size)
  return love.graphics.newFont(fontname, size)
end

function create_sprite(path, image_number, xoffset, yoffset)
  sprite = {
    love_sprite = love.graphics.newImage( path ),
    image_number = image_number
  }
  sprite.width = sprite.love_sprite:getWidth()
  sprite.height = sprite.love_sprite:getHeight()
  sprite.image_width = sprite.width/sprite.image_number
  sprite.image_height = sprite.height
  if xoffset == nil then xoffset = 0 end
  if yoffset == nil then yoffset = 0 end
  sprite.xoffset = xoffset
  sprite.yoffset = yoffset
  sprite.love_sprite:setFilter('nearest','nearest')
  return sprite
end

function create_tileset(path, image_number, width, height, xoffset, yoffset)
  sprite = {
    love_sprite = love.graphics.newImage( path ),
    image_number = image_number
  }
  sprite.width = sprite.love_sprite:getWidth()
  sprite.height = sprite.love_sprite:getHeight()
  sprite.image_width = width
  sprite.image_height = height
  if xoffset == nil then xoffset = 0 end
  if yoffset == nil then yoffset = 0 end
  sprite.xoffset = xoffset
  sprite.yoffset = yoffset
  sprite.love_sprite:setFilter('nearest','nearest')
  return sprite
end

function create_room(room_name)
  local rm = '../rooms/' .. room_name
  print(rm)
  if love.filesystem.exists(rm) then
    return love.filesystem.load(rm)()
  end
end

function game_end()
    love.event.push('quit')
end

function keyboard_check(key)
    return love.keyboard.isDown(key)
end

function keyboard_check_pressed(key)
    if love.keyboard.isDown(key) then
        local out = false
        if last_key ~= key then
            out = love.keyboard.isDown(key)
        end
        last_key = key
        return out
    end
end

function love.keyreleased(key)
    if key == last_key then
        last_key = ""
    end
end

function draw_sprite_old(sprite_index, image_index, x, y)
    love.graphics.draw(sprite_index, x, y)
end


function draw_sprite(sprite_index, image_index, x, y)
    -- Sprites are tables with different properties
    local _image_index = math.floor(image_index)

    local quad = love.graphics.newQuad(
        sprite_index.image_width * (_image_index), 0,
        sprite_index.image_width, sprite_index.height,
        sprite_index.width, sprite_index.height
    )
    love.graphics.draw(sprite_index.love_sprite,quad,x,y,0,1,1,sprite_index.xoffset,sprite_index.yoffset)
end

function draw_rectangle(x, y, width, height, fill)
  local f = "fill"
  if fill ~= 1 then
    f = "none"
  end
  love.graphics.rectangle(f, x, y, width, height )
end

function draw_reset()
  love.graphics.setColor(255,255,255,255)
end

function create_background(path)
  back = love.graphics.newImage(path)
  back:setFilter('nearest','nearest')
  return back
end

function draw_background(b_index, x, y)
  love.graphics.draw(b_index,x,y)
end

function draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, color, image_alpha)
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(color,alpha)
    local _image_index = math.floor(image_index)
    local quad = love.graphics.newQuad(
        sprite_index.image_width * _image_index, 0,
        sprite_index.image_width, sprite_index.height,
        sprite_index.width, sprite_index.height
    )
    love.graphics.draw(
        sprite_index.love_sprite,
        quad,
        x, y,
        math.rad(image_angle),
        image_xscale, image_yscale,
        sprite_index.xoffset, sprite_index.yoffset
    )
    love.graphics.setColor(r,g,b,a)
end

function draw_tile(sprite_index, image_index, row_index, x, y, size)
    -- Sprites are tables with different properties
    local _image_index = math.floor(image_index)
    local _row_index = math.floor(row_index)

    local quad = love.graphics.newQuad(
        sprite_index.image_width * (_image_index),
        sprite_index.image_width * (_row_index),
        sprite_index.image_width, sprite_index.image_width,
        sprite_index.width, sprite_index.height
    )
    love.graphics.draw(sprite_index.love_sprite,quad,x,y,0,size,size,sprite_index.xoffset,sprite_index.yoffset)
end

function draw_text(x,y,text)
    love.graphics.print(text, x, y)
end

function draw_set_color(r,g,b)
    love.graphics.setColor(r,g,b,255)
end

function draw_set_font(fontname)
    love.graphics.setFont(fontname)
end

function draw_set_alpha(alpha)
    r, g, b, a = love.graphics.getColor()
    a = 255 * alpha
    love.graphics.setColor(r,g,b,a)
end

function create_object()
  local t = class:new()
  t.x = 0
  t.y = 0
  t.z = 0
  t.visible = true
  t.sprite_index = 0
  t.image_index = 0
  t.image_speed = 1
  function t:create() end
  function t:step() end
  function t:draw()
    self.image_index = self.image_index + self.image_speed
    if self.sprite_index ~= 0 then
      if self.image_index > self.sprite_index.image_number then
        self.image_index = 0
      end
      draw_sprite(self.sprite_index,self.image_index,self.x,self.y)
    end
  end
  return t
end

instance_number = 0
function room_instance_create(x, y, object)
    local i = class:new()
    i:addparent(object)
    i.x = x
    i.y = y
    instance_number = instance_number + 1
    i.id = instance_number
    return i
end
function instance_create(x, y, object)
    local i = class:new()
    i:addparent(object)
    i.x = x
    i.y = y
    instance_number = instance_number + 1
    i.id = instance_number
    room.instances[i.id] = i
    return i
end

function window_set_fullscreen(bool)
    love.window.setFullscreen(bool, "normal")
end

function window_set_cursor(cursor)
    --This function needs more love.
    if cursor == "cr_none" then
        love.mouse.setVisible(false)
    elseif cursor == nil then
        love.mouse.setVisible(true)
    else
        love.mouse.setCursor(cursor)
    end
end

function window_set_size(width, height)
  return love.window.setMode( width, height)
end


function room_draw()
  if room.background_color then
    r, g, b, a = love.graphics.getColor()
    draw_set_color(room.background_color)
    width, height = love.graphics.getDimensions()
    love.graphics.rectangle("fill", 0, 0, width, height )
    love.graphics.setColor(r,g,b,a)
  end
end

function random(value)
  return math.random(value)
end

function window_set_size( w, h )
  love.window.setMode( w, h)
end

----------------------------------------
-- ENGINE RELATED
-- This functions are not ment to be used by the end user.

-- Sorting function
function drawSort(a,b)
    return a.z < b.z
end
