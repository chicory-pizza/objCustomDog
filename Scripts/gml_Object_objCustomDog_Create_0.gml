event_inherited()

attribute_add("clothes", "Overalls", "")
attribute_add("hat", "Bandana", "")
attribute_add("hair", "Simple", "")

attribute_add("expression", "", "")
attribute_add("animation", "idle", "")

attribute_add("color_head", 16777215, "")
attribute_add("color_skin", 16777215, "")
attribute_add("color_body", 16777215, "")

// animation = "idle"
scene_anim = ""
animation_index = 0
color_part[0] = 16777215
color_part[1] = 16777215
color_part[2] = 16777215
body_a = -1
head_a = 1
hit_anim = 0
mask_surf = -1
singing = -1
ears_blow = 0

animation_speed = 1

// brush
global.brush_obj[10] = instance_create_depth(x, y, depth, objBrush)
with (global.brush_obj[10])
{
    brush_color %= global.the_levelobj.paint.brush_colors
}
global.brush_obj[10].brush_size = 2.0
brush = global.brush_obj[10]

brush_default_angle = 40
brush_angle = brush_default_angle