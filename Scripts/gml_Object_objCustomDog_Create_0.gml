event_inherited()

attribute_add("clothes", "Overalls", "")
attribute_add("hat", "Bandana", "")
attribute_add("hair", "Simple", "")

attribute_add("expression", "", "")
attribute_add("animation", "idle", "")

attribute_add("color_head", 16777215, "Hat color")
attribute_add("color_skin", 16777215, "Dog body color")
attribute_add("color_body", 16777215, "Clothes color")
attribute_add("custom_clothes", "", "Used to show custom clothes")
attribute_add("custom_hat", "", "Used to show custom hat")

attribute_add("brush", 0, "Set to 1 to show a brush")
attribute_add("dialogue", "", "Dialogue text when you speak to this character, only available if interactable. Use ~ to split to a new dialogue box.")
attribute_add("interactable", 0, "Set to 1 to enable talking")
attribute_add("npc_name", "", "This character's name that appears when you walk up to them, only seen if interactable")

attribute_add("xscale", 1, "Horizontal scale, set to negative (such as -1) to flip horizontally (face to the left)")
attribute_add("yscale", 1, "Vertical scale, set to negative (such as -1) to flip vertically")
attribute_add("angle", 0, "0 for default")

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

brush = noone
brush_default_angle = 40
brush_angle = brush_default_angle

custom_clothes_sprite = noone
custom_hat_sprite = noone
