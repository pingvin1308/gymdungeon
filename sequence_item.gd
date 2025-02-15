extends TextureRect


func enable() -> void:
	if material is ShaderMaterial:
		material.set_shader_parameter("is_visible", true)


func disable() -> void:
	if material is ShaderMaterial:
		material.set_shader_parameter("is_visible", false)
