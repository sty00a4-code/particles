def Vector2 = float[<2>];
def Vector3 = float[<3>];
def Vector4 = float[<4>];
def Color = char[<4>];
struct Rectangle {
    float x;
    float y;
    float w;
    float h;
}

extern fn void init_window(int width, int height, char *title) @extern("InitWindow");
extern fn void close_window() @extern("CloseWindow");
extern fn void toggle_fullscreen() @extern("ToggleFullscreen");
extern fn bool window_should_close() @extern("WindowShouldClose");
extern fn void begin_drawing() @extern("BeginDrawing");
extern fn void end_drawing() @extern("EndDrawing");
extern fn float get_frame_time() @extern("GetFrameTime");

extern fn bool is_key_pressed(int key) @extern("IsKeyPressed");
extern fn bool is_key_pressed_repeat(int key) @extern("IsKeyPressedRepeat");
extern fn bool is_key_down(int key) @extern("IsKeyDown");
extern fn bool is_key_released(int key) @extern("IsKeyReleased");
extern fn bool is_key_up(int key) @extern("IsKeyUp");
extern fn int get_key_pressed() @extern("GetKeyPressed");
extern fn int get_char_pressed() @extern("GetCharPressed");
extern fn void set_exit_key(int key) @extern("SetExitKey");

extern fn Vector2 get_mouse_position() @extern("GetMousePosition");
extern fn bool is_mouse_button_pressed(int button) @extern("IsMouseButtonPressed");
extern fn bool is_mouse_button_down(int button) @extern("IsMouseButtonDown");
extern fn bool is_mouse_button_released(int button) @extern("IsMouseButtonReleased");
extern fn bool is_mouse_button_up(int button) @extern("IsMouseButtonUp");
extern fn float get_mouse_wheel_move() @extern("GetMouseWheelMove");

extern fn void clear_background(Color color) @extern("ClearBackground");
extern fn void draw_circle(int centerX, int centerY, float radius, Color color) @extern("DrawCircle");

extern fn void set_random_seed(CUInt seed) @extern("SetRandomSeed");
extern fn int get_random_value(int min, int max) @extern("GetRandomValue");

const Color LIGHTGRAY = { 200, 200, 200, 255 };
const Color GRAY = { 130, 130, 130, 255 };
const Color DARKGRAY = { 80, 80, 80, 255 };
const Color YELLOW = { 253, 249, 0, 255 };
const Color GOLD = { 255, 203, 0, 255 };
const Color ORANGE = { 255, 161, 0, 255 };
const Color PINK = { 255, 109, 194, 255 };
const Color RED = { 230, 41, 55, 255 };
const Color MAROON = { 190, 33, 55, 255 };
const Color GREEN = { 0, 228, 48, 255 };
const Color LIME = { 0, 158, 47, 255 };
const Color DARKGREEN = { 0, 117, 44, 255 };
const Color SKYBLUE = { 102, 191, 255, 255 };
const Color BLUE = { 0, 121, 241, 255 };
const Color DARKBLUE = { 0, 82, 172, 255 };
const Color PURPLE = { 200, 122, 255, 255 };
const Color VIOLET = { 135, 60, 190, 255 };
const Color DARKPURPLE = { 112, 31, 126, 255 };
const Color BEIGE = { 211, 176, 131, 255 };
const Color BROWN = { 127, 106, 79, 255 };
const Color DARKBROWN = { 76, 63, 47, 255 };
const Color WHITE = { 255, 255, 255, 255 };
const Color BLACK = { 0, 0, 0, 255 };
const Color BLANK = { 0, 0, 0, 0 };
const Color MAGENTA = { 255, 0, 255, 255 };
const Color RAYWHITE = { 245, 245, 245, 255 };

const int KEY_SPACE = 32;