# Eros
Eros is a [löve](https://www.love2d.org/) framework to make game development easy.

## How to use
Copy the eros directory to the root of your project and then add this to the first line of your main.lua file:
```lua
require 'eros'
```
This will add everything you need to start working with Eros.

## Game elements
All the naming conventions is straight out of GM:S. I didn't wanted to create a new standard since many people (like me) already memorized all the names and workflow.
A GML to Lua translation tool can be made at some point for easy porting of pre-existing projects.

### Sprites
You can include sprites in your game by using the "create_sprite" function.
```lua
create_sprite(path, image_number, xoffset, yoffset)
```
### Backgrounds
Backgrounds are sprites with less properties and closely related with the rooms.
To add a background:
```lua
background_test = create_sprite(path)
```
If you want to set a background on a room:
```lua
example_room = {
  background_image = background_test
}
```
### Objects
Objects are based on [SECL](https://github.com/bartbes/love-misc-libs/tree/master/SECL) class system. To create one is as simple as:
```lua
-- Declaring an object
obj_test = create_object()
-- Now that the object is declared you can set a sprite or other properties to it.
obj_test.sprite_index = spr_vs
obj_test.image_speed = 0.1
```
### Fonts
TTF fonts can be imported as easy as:
```lua
create_font (fontname, size)
```
### Rooms
```lua
room_a = {
  background_color = {100, 100, 100},
  background_image = background_test,
  instances = {
    instance_create(120, 20, obj_test)
  }
}
```
### Camera
The camera needs to be adapted for a easier use and document.

## Roadmap
- Sounds and music
- Optimize newQuad on sprite create instead of draw event
- Tile sets
- Create executable from project

### Anything else
Anything else that is not included here can be complemented with the default functions and libraries made for [löve](https://www.love2d.org/).

## Dependencies
🎶 All you need is [löve](https://www.love2d.org/) ~

## Workflow
I'm using Atom editor to work on löve games with the following packages:
- [Build](https://atom.io/packages/build)
- [language-lua](https://atom.io/packages/language-lua)


## License
```
Copyright (C) 2015 Emilio Coppola <emilio@evelend.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```