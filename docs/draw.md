# Draw functions
This functions will be executed during the draw events.
If you are inside an object you should use *object_name*:draw() and if you want do draw it on the game itself you have game.draw().

### draw_sprite(sprite_index, image_index, x, y)
This function draws a sprite on the screen

### draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, color, image_alpha)

### draw_text(x,y,text)

### draw_set_font(fontname)

### draw_set_alpha(alpha)

### draw_set_color(r,g,b)

### draw_reset()

### draw_tile(sprite_index, image_index, row_index, x, y, size)

### draw_rectangle(x, y, width, height, fill)

### draw_background(b_index, x, y)