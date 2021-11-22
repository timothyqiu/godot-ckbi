tool
extends EditorImportPlugin


func get_importer_name():
	return "com.timothyqiu.godot-color-keyed-bmp-importer"


func get_visible_name():
	return "Color-Keyed BMP"


func get_recognized_extensions():
	return ["bmp"]


func get_save_extension():
	return "stex"


func get_resource_type():
	return "StreamTexture"


func get_preset_count():
	return 1


func get_preset_name(preset):
	return "Default"


func get_import_options(preset):
	return [
		{
			name="color_key",
			default_value=Color.magenta,
			property_hint=PROPERTY_HINT_COLOR_NO_ALPHA,
		},
	]


func get_option_visibility(option, options):
	return true


func import(source_file, save_path, options, platform_variants, gen_files):
	var file := File.new()
	var err := file.open(source_file, File.READ)
	if err != OK:
		printerr("Failed to open file: ", err)
		return err
	
	var image := Image.new()
	err = image.load_bmp_from_buffer(file.get_buffer(file.get_len()))
	if err != OK:
		printerr("Failed to load BMP: ", err)
		return err
	
	file.close()
	image.convert(Image.FORMAT_RGBA8)
	
	var key: Color = options.color_key
	
	image.lock()
	for y in image.get_height():
		for x in image.get_width():
			if image.get_pixel(x, y).is_equal_approx(key):
				image.set_pixel(x, y, Color.transparent)
	image.unlock()
	
	var filename = save_path + "." + get_save_extension()
	return save_stex_png(image, filename)


func save_stex_png(image: Image, path: String) -> int:
	var file := File.new()
	var err := file.open(path, File.WRITE)
	if err != OK:
		printerr("Failed to open file: ", err)
		return err
	
	file.store_8(ord("G"))
	file.store_8(ord("D"))
	file.store_8(ord("S"))
	file.store_8(ord("T"))
	
	file.store_16(image.get_width())
	file.store_16(0)
	file.store_16(image.get_height())
	file.store_16(0)
	
	file.store_32(0)  # Texture flags
	
	var format := 1 << 20  # StreamTexture::FORMAT_BIT_PNG
	var data := image.save_png_to_buffer()
	image.clear_mipmaps()
	var mmc := 1
	
	file.store_32(format)
	file.store_32(mmc)
	file.store_32(data.size() + 4)
	file.store_8(ord("P"))
	file.store_8(ord("N"))
	file.store_8(ord("G"))
	file.store_8(ord(" "))
	file.store_buffer(data)
	
	return OK
