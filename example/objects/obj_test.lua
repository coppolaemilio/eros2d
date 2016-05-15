obj_test = create_object()

function obj_test:create() -- Initialize your object here
  self.speed = 3
end

function obj_test:step() -- Step gets called every frame
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
    instance_create(10,10, obj_test)
  end
end

function obj_test:draw() -- Draw on the screen
  draw_rectangle(self.x,self.y,32,32,1)
  draw_text(10,10, instance_number)
end

