shader_type canvas_item;

void fragment() {
    float alpha = 1.0 - UV.y;  // Градиент прозрачности сверху вниз
    vec3 color = vec3(1.0, 0.5, 0.0);  // Оранжевый цвет удара
    COLOR = vec4(color, alpha * texture(TEXTURE, UV).a);
}
