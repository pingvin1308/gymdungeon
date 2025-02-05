shader_type canvas_item;

// Степень подкрашивания: 0.0 – нет эффекта, 1.0 – полностью подкрашено.
uniform float damage: hint_range(0.0, 1.0) = 0.0;
// Цвет подкрашивания (по умолчанию красный).
uniform vec4 damage_color = vec4(1.0, 0.0, 0.0, 0.0);

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
   	COLOR = mix(tex_color, damage_color, damage);    
}
