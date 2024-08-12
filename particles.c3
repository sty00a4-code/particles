import std::io;
import std::math;
import raylib;

const TYPES = 3;
struct Particle {
    Vector2 pos;
    Vector2 vel;
    char type;
    bool freeze;
}

const int WIDTH = 1920 / 2;
const int HEIGHT = 1080 / 2;
const float[<2>] MIN_VEC = {0.0, 0.0};
const float[<2>] MAX_VEC = {(float) WIDTH, (float) HEIGHT};
const uint PARTICLES = 500;
const float PARTICLE_RADIUS = 2.0;
const Color[TYPES] COLORS = {
    raylib::RED,
    raylib::GREEN,
    raylib::BLUE,
};
const float MAX_DISTANCE = 100.0;
const float FORCE_FACTOR = 20.0;
const float FRICTION_FACTOR = 0.89;
const float[TYPES][TYPES] FORCES_MOLECULES = {
    { 1.0, 0.0, 0.5 },
    { 1.0, 0.0, -0.5 },
    { -0.5, 1.0, 0.0 },
};
const float[TYPES][TYPES] FORCES_SPIRAL = {
    { 1.0, 0.5, 0.0 },
    { 0.0, 1.0, 0.5 },
    { 0.5, 0.0, 1.0 },
};
const float[TYPES][TYPES] FORCES_SHIFTER = {
    //R         G           B
    { 0.5,      -0.5,       1.0 },  // R
    { 0.5,      0.0,        0.5 },  // G
    { -1.0,     1.0,        -1.0 }, // B
};
const float[TYPES][TYPES] FORCES = FORCES_SHIFTER;
fn float af(float r, float f) {
    const float BETA = 0.3;
    if (r <= BETA) {
        return r / BETA - 1;
    }
    if (BETA < r && r < 1) {
        return f * (1 - math::abs(2 * r - 1 - BETA) / (1 - BETA));
    }
    return 0.0;
}
fn float float.loop(float x, float min, float max) {
    if (x < min) {
        return max + (x % (max - min) - min);
    }
    if (x > max) {
        return min + (x % (max - min));
    }
    return x;
}
fn float[<2>] float[<2>].loop(float[<2>] vec, float[<2>] min, float[<2>] max) {
    float[<2>] new;
    foreach (i, v : vec) {
        new[i] = v.loop(min[i], max[i]);
    }
    return new;
}

struct Cursor {
    Vector2 pos;
    bool left;
    bool right;
    float radius;
}
fn void main()
{
    raylib::set_random_seed(69);
    Particle[PARTICLES] particles;
    Cursor cursor = {
        .pos = {0, 0},
        .left = false,
        .right = false,
        .radius = 20.0,
    };
    foreach (i, particle : particles) {
        particles[i].pos = { (float) raylib::get_random_value(0, WIDTH), (float) raylib::get_random_value(0, HEIGHT) };
        particles[i].type = (char) raylib::get_random_value(0, 2);
    }

    raylib::init_window(WIDTH, HEIGHT, "PARTICLES");
    defer raylib::close_window();
    while (!raylib::window_should_close()) {
        cursor.pos = raylib::get_mouse_position();
        cursor.left = raylib::is_mouse_button_down(0);
        cursor.right = raylib::is_mouse_button_down(1);
        cursor.radius += raylib::get_mouse_wheel_move() * 2.0;
        if (cursor.radius < 1.0) {
            cursor.radius = 1.0;
        }
        double dt = (double) raylib::get_frame_time();
        foreach (i, self : particles) {
            Vector2 acc;
            foreach (j, other : particles) {
                if (i == j) {
                    continue;
                }
                Vector2 dist_vec = other.pos - self.pos;
                float dist = self.pos.distance(other.pos);
                if (dist > 0 && dist <= MAX_DISTANCE) {
                    float force = af(dist / MAX_DISTANCE, FORCES[self.type][other.type]);
                    if (force != 0.0) {
                        acc.x += dist_vec.x / dist * force;
                        acc.y += dist_vec.y / dist * force;
                    }
                }
            }
            if (cursor.left && self.pos.distance(cursor.pos) <= cursor.radius) {
                Vector2 dist_vec = cursor.pos - self.pos;
                float dist = self.pos.distance(cursor.pos);
                if (dist > 0) {
                    acc.x += ((double) dist_vec.x / dist) * 5.0;
                    acc.y += ((double) dist_vec.y / dist) * 5.0;
                }
            }
            if (cursor.right && self.pos.distance(cursor.pos) <= cursor.radius) {
                Vector2 dist_vec = cursor.pos - self.pos;
                float dist = self.pos.distance(cursor.pos);
                if (dist > 0) {
                    acc.x -= ((double) dist_vec.x / dist) * 5.0;
                    acc.y -= ((double) dist_vec.y / dist) * 5.0;
                }
            }
            acc *= MAX_DISTANCE * FORCE_FACTOR;
            particles[i].vel *= FRICTION_FACTOR;
            particles[i].vel += acc * (float) dt;
            particles[i].pos += self.vel * (float) dt;
            if (self.pos.x < MIN_VEC.x) {
                particles[i].pos.x = MAX_VEC.x;
            }
            if (self.pos.x > MAX_VEC.x) {
                particles[i].pos.x = MIN_VEC.x;
            }
            if (self.pos.y < MIN_VEC.y) {
                particles[i].pos.y = MAX_VEC.y;
            }
            if (self.pos.y > MAX_VEC.y) {
                particles[i].pos.y = MIN_VEC.y;
            }
        }

        raylib::begin_drawing();
        defer raylib::end_drawing();
        raylib::clear_background({0x00, 0x00, 0x00, 0xff});
        foreach (particle : particles) {
            raylib::draw_circle(
                ((CInt) (int) particle.pos.x.loop(0, WIDTH)),
                ((CInt) (int) particle.pos.y.loop(0, WIDTH)),
                PARTICLE_RADIUS,
                COLORS[particle.type]
            );
        }
        if (cursor.left || cursor.right) {
            raylib::draw_circle(
                ((CInt) (int) cursor.pos.x),
                ((CInt) (int) cursor.pos.y),
                cursor.radius,
                { 0xff, 0xff, 0xff, 0x50 }
            );
        }
    }
}