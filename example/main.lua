require 'eros'

window_set_size(500,500)

obj_player = create_object()
obj_player.speed = 3

function obj_player:step()
  if keyboard_check(vk_left) then
    self.x = self.x - self.speed
  end
  if keyboard_check(vk_right) then
    self.x = self.x + self.speed
  end
  if keyboard_check(vk_up) then
    self.y = self.y - self.speed
  end
  if keyboard_check(vk_down) then
    self.y = self.y + self.speed
  end
  if keyboard_check_pressed("w") and instance_number < 10 then
    instance_create(10,10, obj_player)
  end
  if keyboard_check_pressed("n") then
    room_goto(room_1)
  end
end

function obj_player:draw()
  draw_rectangle(self.x,self.y,32,32,1)
  draw_text(10,10, instance_number)
end

load_rooms()

room_goto(room_2)