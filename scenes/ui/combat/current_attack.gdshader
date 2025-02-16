shader_type canvas_item;

uniform bool is_visible = false;
const vec4 border_color = vec4(1.0, 1.0, 1.0, 1.0);
const float border_thickness = 1.5;

void fragment() {
    // Преобразуем желаемую толщину рамки в UV-координаты
    // TEXTURE_PIXEL_SIZE = (1.0 / ширина, 1.0 / высота)
    float uv_thickness_x = border_thickness * TEXTURE_PIXEL_SIZE.x;
    float uv_thickness_y = border_thickness * TEXTURE_PIXEL_SIZE.y;
    
    // Проверяем, попали ли мы в область "рамки" по каждой из сторон
    bool is_border = false;
    if (UV.x < uv_thickness_x || (1.0 - UV.x) < uv_thickness_x ||
        UV.y < uv_thickness_y || (1.0 - UV.y) < uv_thickness_y) {
        is_border = true;
    }
    
    // Если текущий пиксель находится в зоне рамки — рисуем цвет рамки,
    // иначе берём исходный цвет текстуры
    if (is_visible && is_border) {
        COLOR = border_color;
    }
}
