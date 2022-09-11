interactable = attribute_get("interactable")
npc_name = attribute_get("npc_name")

image_xscale = attribute_get("xscale")
image_yscale = attribute_get("yscale")
image_angle = attribute_get("angle")

// Start of custom hat/clothes
var path_prefix = "" // temp_directory doesn't work on Mac
if (os_type != os_macosx)
{
    path_prefix = temp_directory + "/"
}

var custom_clothes = attribute_get("custom_clothes")
if (custom_clothes != "")
{
    // Write to temp file, then read it as sprite, there doesn't seem to be a way to load buffer (that is a PNG) as a surface/sprite
    // I do my best, ok :(
    var buffer = buffer_decompress(buffer_base64_decode(custom_clothes))
    var path = path_prefix + "objCustomDog_temp/" + buffer_md5(buffer, 0, buffer_get_size(buffer)) + ".png"
    if (!file_exists(path))
    {
        buffer_save(buffer, path)
    }

    var sprite = sprite_add_midpoint(path, 1, false, false, (global.art_save_res / 2), (global.art_save_res / 2))
    sprite_set_offset(sprite, sprite_get_xoffset(sprDog_blankshirt), sprite_get_yoffset(sprDog_blankshirt))

    custom_clothes_sprite = sprite
}

// Yes, duplicated code because importing new global scripts is a bit unreliable
var custom_hat = attribute_get("custom_hat")
if (custom_hat != "")
{
    var buffer = buffer_decompress(buffer_base64_decode(custom_hat))
    var path = path_prefix + "objCustomDog_temp/" + buffer_md5(buffer, 0, buffer_get_size(buffer)) + ".png"
    if (!file_exists(path))
    {
        buffer_save(buffer, path)
    }

    var sprite = sprite_add_midpoint(path, 1, false, false, (global.art_save_res / 2), (global.art_save_res / 2))
    sprite_set_offset(sprite, sprite_get_xoffset(sprDog_head), sprite_get_yoffset(sprDog_head))

    custom_hat_sprite = sprite
}
