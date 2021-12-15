extends Button


var screenshot_dir := "screenshots/"

func _on_pressed():
	get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	# Wait until the frame has finished before getting the texture.
	yield(VisualServer, "frame_post_draw")

	# Retrieve the captured image.
	var img = get_viewport().get_texture().get_data()

	# Flip it on the y-axis (because it's flipped).
	img.flip_y()

	# Create a texture for it.
#	var tex = ImageTexture.new()
#	tex.create_from_image(img)
	
	# Save it into a file
	var time = OS.get_time()
	var time_str = String(time.hour) + String(time.minute) + String(time.second)
	img.save_png("user://" + screenshot_dir + "screenshot_" + time_str + ".png")
