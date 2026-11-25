// =========================================================
// JOYRATECH MINI PRO V1 - FULL DUAL-STICK KID CONTROLLER
// Sized for a 10-year-old (136mm x 74mm x 29mm)
// Includes: Dual Sticks, D-Pad, ABXY, Start/Select/Home, L1/R1/L2/R2
// =========================================================

$fn = 60;

body_l = 136.0;
body_w = 74.0;
wall = 2.4;
top_h = 14.0;
bot_h = 15.0;
corner_r = 18.0;

// Render Bottom Shell & Top Faceplate side-by-side at Z = 0
bottom_shell();

translate([0, body_w + 14, 0])
    top_shell();

module rounded_box(l, w, h, r) {
    hull() {
        translate([r, r, 0]) cylinder(h = h, r = r);
        translate([l - r, r, 0]) cylinder(h = h, r = r);
        translate([r, w - r, 0]) cylinder(h = h, r = r);
        translate([l - r, w - r, 0]) cylinder(h = h, r = r);
    }
}

// =========================================================
// PART 1: BOTTOM SHELL
// =========================================================
module bottom_shell() {
    difference() {
        rounded_box(body_l, body_w, bot_h, corner_r);

        // Hollow interior cavity
        translate([wall, wall, wall])
            rounded_box(body_l - wall * 2, body_w - wall * 2, bot_h + 1, corner_r - wall);

        // Top Edge: L1 & L2 tactile button holes (left shoulder)
        translate([22, body_w - wall - 1, wall + 4])
            cube([11, wall + 2, 7]);
        translate([38, body_w - wall - 1, wall + 4])
            cube([11, wall + 2, 7]);

        // Top Edge: R1 & R2 tactile button holes (right shoulder)
        translate([body_l - 33, body_w - wall - 1, wall + 4])
            cube([11, wall + 2, 7]);
        translate([body_l - 49, body_w - wall - 1, wall + 4])
            cube([11, wall + 2, 7]);

        // Center Top USB port cutout
        translate([body_l / 2 - 6, body_w - wall - 1, wall + 3])
            cube([12, wall + 2, 7]);

        // Bottom Edge power slide-switch cutout
        translate([body_l / 2 - 5, -1, wall + 3])
            cube([10, wall + 2, 6]);
    }

    // 4 Corner M3 screw posts
    bosses = [,
        [body_l - 11, 11],
        [11, body_w - 11],
        [body_l - 11, body_w - 11]
    ];
    for (p = bosses) {
        translate([p[0], p[1], wall])
            difference() {
                cylinder(h = bot_h - wall - 2.0, d = 6.8);
                cylinder(h = bot_h, d = 2.7);
            }
    }
}

// =========================================================
// PART 2: TOP FACEPLATE
// =========================================================
module top_shell() {
    difference() {
        union() {
            rounded_box(body_l, body_w, top_h, corner_r);
            // Inner alignment lip
            translate([wall + 0.35, wall + 0.35, top_h])
                rounded_box(body_l - (wall + 0.35) * 2, body_w - (wall + 0.35) * 2, 2.0, corner_r - wall);
        }

        // Hollow interior cavity
        translate([wall, wall, wall])
            rounded_box(body_l - wall * 2, body_w - wall * 2, top_h + 3, corner_r - wall);

        // 1. Left Analog Thumbstick Hole (Upper-Left)
        translate([26, body_w - 24, -1])
            cylinder(h = wall + 2, d = 22.0);

        // 2. Left 4-Way D-Pad Holes (Lower-Left)
        dpad_x = 42;
        dpad_y = 22;
        dpad_sp = 8.5;
        dpad_pts = [
            [dpad_x, dpad_y + dpad_sp],
            [dpad_x, dpad_y - dpad_sp],
            [dpad_x - dpad_sp, dpad_y],
            [dpad_x + dpad_sp, dpad_y]
        ];
        for (d = dpad_pts) {
            translate([d[0], d[1], -1])
                cylinder(h = wall + 2, d = 7.2);
        }

        // 3. Right 4-Button Diamond ABXY (Upper-Right)
        abxy_x = body_l - 26;
        abxy_y = body_w - 24;
        abxy_sp = 9.0;
        abxy_pts = [
            [abxy_x, abxy_y - abxy_sp],
            [abxy_x + abxy_sp, abxy_y],
            [abxy_x - abxy_sp, abxy_y],
            [abxy_x, abxy_y + abxy_sp]
        ];
        for (b = abxy_pts) {
            translate([b[0], b[1], -1])
                cylinder(h = wall + 2, d = 7.5);
        }

        // 4. Right Analog Thumbstick Hole (Lower-Right)
        translate([body_l - 44, 22, -1])
            cylinder(h = wall + 2, d = 22.0);

        // 5. Center Select, Home & Start Buttons
        menu_pts = [
            [body_l / 2 - 10, body_w / 2 + 6],
            [body_l / 2 + 10, body_w / 2 + 6],
            [body_l / 2, body_w / 2 - 6]
        ];
        for (m = menu_pts) {
            translate([m[0], m[1], -1])
                cylinder(h = wall + 2, d = 5.8);
        }

        // 6. 4 Countersunk Corner Screw Holes
        bosses = [,
            [body_l - 11, 11],
            [11, body_w - 11],
            [body_l - 11, body_w - 11]
        ];
        for (p = bosses) {
            translate([p[0], p[1], -1])
                cylinder(h = wall + 2, d = 3.3);
            translate([p[0], p[1], -0.1])
                cylinder(h = 1.6, d1 = 6.2, d2 = 3.3);
        }
    }
}
