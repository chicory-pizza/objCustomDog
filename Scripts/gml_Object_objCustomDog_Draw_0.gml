// draw_customdogobj(x, y, facing, 1)

var sc = 1

var xx = x
var yy = y
var xs = 1
var ys = 1
xs = (image_xscale * sc)
ys = (image_yscale * sc)

var anim = attribute_get("animation")
if (scene_anim != "")
    anim = scene_anim
var anim_map = ds_map_find_value(global.animation_map, anim)
var anim_ind = floor(animation_index)
if (!ds_exists(anim_map, 1))
    return 0;
var body_frames = ds_map_find_value(anim_map, "frames_body")
var nobody = 0
if (ds_list_empty(body_frames) || (!ds_exists(body_frames, 2)))
    nobody = 1
if (!nobody)
{
    var body_frame = ds_list_find_value(body_frames, (anim_ind % ds_list_size(body_frames)))
    var body_x = ds_map_find_value(body_frame, "x")
    var body_y = ds_map_find_value(body_frame, "y")
    var b_x = (xx + (lengthdir_x((body_x * xs), image_angle) - lengthdir_y((body_y * ys), image_angle)))
    var b_y = (yy + (lengthdir_x((body_y * ys), image_angle) - lengthdir_y((body_x * xs), image_angle)))
    var b_a = ds_map_find_value(body_frame, "ang")
}
var head_frames = ds_map_find_value(anim_map, "frames_head")
var head_frame = ds_list_find_value(head_frames, (anim_ind % ds_list_size(head_frames)))
var head_x = ds_map_find_value(head_frame, "x")
var head_y = ds_map_find_value(head_frame, "y")
var h_x = (xx + (lengthdir_x((head_x * xs), image_angle) - lengthdir_y((head_y * ys), image_angle)))
var h_y = (yy + (lengthdir_x((head_y * ys), image_angle) - lengthdir_y((head_x * xs), image_angle)))
var h_a = ds_map_find_value(head_frame, "ang")
var color_head = attribute_get("color_head")
var color_skin = attribute_get("color_skin")
var color_body = attribute_get("color_body")
var alpha = image_alpha
var cmap = ds_map_find_value(global.the_gameobj.clothes, attribute_get("clothes"))
var body_spri = ds_map_find_value(cmap, "index")
var hat_map = ds_map_find_value(global.the_gameobj.hats, attribute_get("hat"))
var hat_spr = sprDog_hat
var hat_spri = ds_map_find_value(hat_map, "index")
var layer2 = ds_map_find_value(hat_map, "layer2")
var showhair = ds_map_find_value(hat_map, "showhair")
var collar = 0
if (layer2 == -1)
{
    layer2 = ds_map_find_value(cmap, "layer2")
    if (layer2 != -1)
        collar = ds_map_find_value(cmap, "collar")
}
else
    collar = ds_map_find_value(hat_map, "collar")
wearing_layer2 = (layer2 != -1 + collar)
var body_spr = sprDog_body
if (body_spri < 0)
{
    body_spr = abs(body_spri)
    body_spri = 0
}
if (custom_clothes_sprite != noone)
{
    body_spr = custom_clothes_sprite
    body_spri = 0
}

if (hat_spri < -1)
{
    hat_spr = abs(hat_spri)
    hat_spri = 0
}
if (custom_hat_sprite != noone)
{
    hat_spr = custom_hat_sprite
    hat_spri = 0
}

if (!nobody)
{
    if (body_a != 0)
        b_a *= (body_a * sign(xs))
    b_a += image_angle
}
if (head_a != 0)
    h_a *= (head_a * sign(xs))
h_a += image_angle
if (anim == "brushride" || anim == "brushride_still")
    h_a *= 0.1
if (hit_anim > 0)
{
    if (sin(((sqr(hit_anim) * pi) * 14)) < 0)
        alpha = 0
}

// Create brush
if (attribute_get("brush") == 1 && brush == noone)
{
    brush = instance_create_depth(x, y, depth, objBrush)
    brush.brush_size = 2.0
    brush.brush_color %= global.the_levelobj.paint.brush_colors
}

if (brush != noone && brush.visible && (!nobody))
{
    if (xs < 0)
        brush_angle += (angle_difference(brush_default_angle, brush_angle) * 0.4)
    else
        brush_angle += (angle_difference((180 - brush_default_angle), brush_angle) * 0.4)
    var brush_a = b_a
    if (anim == "lay")
        brush_a /= 2
    var brush_x = (lengthdir_x((body_x * xs), image_angle) - lengthdir_y(((body_y - 13) * ys), image_angle))
    var brush_y = (lengthdir_x(((body_y - 13) * ys), image_angle) - lengthdir_y((body_x * xs), image_angle))
    var brush_len = (55 * brush.scale)
    var brush_spr = sprBrush
    var brush_col = brush.paint_target.paint_color[(brush.brush_color % brush.paint_target.paint_colors)]
    if (brush.broom == 1)
    {
        brush_spr = sprBroom
        brush_col = c_white
    }
    else if brush.mybrush
    {
    }
    draw_sprite_ext(brush_spr, 2, ((xx + brush_x) + lengthdir_x(brush_len, ((brush_angle + image_angle) + brush_a))), ((yy + brush_y) + lengthdir_y(brush_len, ((brush_angle + image_angle) + brush_a))), (brush.scale * (-image_xscale)), (brush.scale * image_yscale), (((brush_angle + 90) + image_angle) + brush_a), brush_col, 1)
    if brush.mybrush
        brush_spr = 10
    draw_sprite_ext(brush_spr, 0, ((xx + brush_x) + lengthdir_x(brush_len, ((brush_angle + image_angle) + brush_a))), ((yy + brush_y) + lengthdir_y(brush_len, ((brush_angle + image_angle) + brush_a))), (brush.scale * image_yscale), (brush.scale * image_yscale), (((brush_angle + 90) + image_angle) + brush_a), c_white, 1)
}
var oxs = xs
var oys = ys
var axs = xs
var ays = ys
var head_spr = sprDog_head
var head_img = 0
var hxs = xs
var hys = ys
xs /= global.dog_res_scale
ys /= global.dog_res_scale
if (anim == "idle")
{
    axs = xs
    ays = ys
}
var expr = attribute_get("expression")
var depressed = 0
if dog_sad()
{
    if (data_get(global.progress) >= 31)
        depressed = 1
}
switch anim
{
    case "snooze":
    case "breathe":
        expr = "closed"
        if depressed
            expr = "closed_sad"
        else if (anim == "breathe" && animation_index > 16)
            expr = "small"
        break
    case "shake":
        expr = "ow"
        break
    case "doze":
        switch floor(anim_ind)
        {
            case 0:
            case 5:
            case 6:
                break
            case 4:
                expr = "closed"
                if depressed
                    expr = "closed_sad"
                break
            default:
                expr = "small"
                if depressed
                    expr = "depressed"
                break
        }

        break
}

if (expr != "" && expr != "neutral" && (ds_map_exists(global.the_dog.expressions, expr) || expr == "evil"))
{
    head_spr = sprDog_expression
    if (expr == "evil")
        head_img = 18
    else
        head_img = ds_map_find_value(global.the_dog.expressions, expr)
}
else if (dog_sad() && expr == "")
{
    head_spr = sprDog_expression
    if (!depressed)
        head_img = 17
    else
        head_img = 19
}
else
{
    hxs = xs
    hys = ys
}
draw_sprite_ext(ds_map_find_value(anim_map, "spr_B"), anim_ind, xx, yy, axs, ays, image_angle, color_skin, alpha)
if (!nobody)
{
    draw_sprite_ext(body_spr, body_spri, b_x, b_y, xs, ys, b_a, color_body, alpha)
    if (collar == 2 && layer2 != -1)
    {
        draw_sprite_ext(sprDog_body2, layer2, b_x, b_y, xs, ys, b_a, color_head, alpha)
        layer2 = -1
    }
}
draw_sprite_ext(ds_map_find_value(anim_map, "spr_A"), anim_ind, xx, yy, axs, ays, image_angle, color_skin, alpha)
if (layer2 != -1 && (!collar) && (!nobody))
    draw_sprite_ext(sprDog_body2, layer2, b_x, b_y, xs, ys, b_a, choice(color_head, color_body, collar), alpha)
switch anim
{
    case "transit":
        draw_sprite_ext(sprDog_transit_card, anim_ind, xx, yy, axs, ays, image_angle, c_white, alpha)
        break
    case "hug_clementine":
        with (objClementine)
            draw_sprite_ext(sprClementine_hugarm, anim_ind, x, y, image_xscale, image_yscale, image_angle, painted_layer[1], image_alpha)
        if global.TRAILER
        {
            with (objTranslatormeet)
                draw_sprite_ext(sprClementine_hugarm, anim_ind, x, y, image_xscale, image_yscale, image_angle, painted_layer[1], image_alpha)
        }
        break
    case "hug_chicory":
    case "hug_chicory_fast":
        with (objChicory)
            draw_sprite_ext(sprDog_hug_chicory_extra, anim_ind, other.x, other.y, image_xscale, image_yscale, image_angle, painted_layer[painted_layer_cols[1]], image_alpha)
        break
}

var mask_spr = -1
var surf_x = h_x
var surf_y = h_y
switch anim
{
    case "floatstart":
        mask_spr = sprDog_floatstart_mask
        break
    case "float":
        mask_spr = sprDog_float_mask
        break
    case "floatstop":
        mask_spr = sprDog_floatstop_mask
        break
}

if (mask_spr != -1)
{
    var mask_yoff = sprite_get_yoffset(mask_spr)
    surf_y = (h_y - mask_yoff)
    var mask_xoff = sprite_get_xoffset(mask_spr)
    surf_x = (h_x - choice(mask_xoff, (sprite_get_width(mask_spr) - mask_xoff), xs < 0))
    h_y -= surf_y
    h_x -= surf_x
    if (!surface_exists(mask_surf))
        mask_surf = surface_create(sprite_get_width(mask_spr), sprite_get_height(mask_spr))
    surface_set_target(mask_surf)
    draw_clear_alpha(c_black, 0)
}
else if (mask_surf != -1)
{
    surface_free(mask_surf)
    mask_surf = -1
}
if (showhair > 2)
    draw_sprite_ext(hat_spr, showhair, h_x, h_y, xs, ys, h_a, color_head, alpha)
draw_sprite_ext(head_spr, head_img, h_x, h_y, hxs, hys, h_a, color_skin, alpha)
if (singing != -1)
{
    if (head_spr != 2)
    {
        hxs *= global.dog_res_scale
        hys *= global.dog_res_scale
    }
    draw_sprite_ext(sprDog_sing, singing, h_x, h_y, hxs, hys, h_a, color_skin, alpha)
}
if (hat_spri == -1 || showhair == 1 || showhair > 2)
    draw_sprite_ext(sprDog_hat, ds_map_find_value(global.the_gameobj.hairs, attribute_get("hair")), h_x, h_y, xs, ys, h_a, color_skin, alpha)
if (hat_spri != -1 && (showhair != 2 || mask_spr != -1))
    draw_sprite_ext(hat_spr, hat_spri, h_x, h_y, xs, ys, h_a, color_head, alpha)
if (layer2 != -1 && collar && (!nobody))
    draw_sprite_ext(sprDog_body2, layer2, b_x, b_y, xs, ys, b_a, choice(color_head, color_body, collar), alpha)
if (mask_spr != -1)
{
    gpu_set_blendmode(bm_subtract)
    draw_sprite_ext(mask_spr, anim_ind, choice(mask_xoff, (sprite_get_width(mask_spr) - mask_xoff), xs < 0), mask_yoff, axs, ays, 0, c_white, 1)
    gpu_set_blendmode(bm_normal)
    surface_reset_target()
    shader_reset()
    draw_surface(mask_surf, surf_x, surf_y)
    shader_resadjust()
    h_y += surf_y
    h_x += surf_x
}
if (ears_blow == 0 || anim == "sit")
    draw_sprite_ext(ds_map_find_value(anim_map, "spr_ear"), anim_ind, xx, yy, axs, ays, image_angle, color_skin, alpha)
else
    draw_sprite_ext(sprDog_ear_wind, (((current_time / 83) % 8) + (8 * sign(ears_blow) == sign(oxs))), ((xx + head_x) + (2.5 * oxs)), ((yy + head_y) + 45.5), oxs, oys, image_angle, color_skin, alpha)
if (hat_spri != -1 && showhair == 2 && mask_spr == -1)
    draw_sprite_ext(hat_spr, hat_spri, h_x, h_y, xs, ys, h_a, color_head, alpha)
if (anim == "letter")
    draw_sprite_ext(sprDog_letter_letter, anim_ind, xx, yy, axs, ays, image_angle, c_white, alpha)
if (anim == "shake")
{
    if (anim_ind < sprite_get_number(sprDog_shake_drops))
        draw_sprite_ext(sprDog_shake_drops, anim_ind, xx, yy, oxs, oys, image_angle, c_gray, alpha)
}
if (object_index == objCustomDog)
{
    head_x = h_x
    head_y = h_y
    head_ha = h_a
    hat_spr = hat_spri
    if (!nobody)
    {
        body_x = b_x
        body_y = b_y
        body_ha = b_a
    }
}
