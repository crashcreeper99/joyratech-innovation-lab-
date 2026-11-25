// =========================================================
// JOYRATECH MINI PAD V1 - KID-SIZED WIRELESS CONTROLLER SHELL
// Sized for a 10-year-old (116mm x 58mm x 26mm)
// Prints completely flat at Z = 0 with zero supports
// =========================================================

$fn = 60;

body_l = 116.0;
body_w = 58.0;
wall = 2.4;
top_h = 13.0;
bot_h = 14.0;
corner_r = 16.0;

// Render Bottom Case & Top Faceplate side-by-side at Z = 0
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
// PART 1: BOTTOM SHELL (Holds ESP32 + 3xAAA Battery Pack)
// =========================================================
module bottom_shell() {
    difference() {
        rounded_box(body_l, body_w, bot_h, corner_r);

        // Hollow interior cavity
        translate([wall, wall, wall])
            rounded_box(body_l - wall * 2, body_w - wall * 2, bot_h, corner_r - wall);

        // Front USB-C / Micro-USB reprogramming & charging port cutout
        translate([body_l / 2 - 6, body_w - wall - 1, wall + 3])
            cube([12, wall + 2, 7]);

        // Rear power slide-switch cutout
        translate([body_l / 2 - 5, -1, wall + 3])
            cube([10, wall + 2, 6]);
    }

    // 4 Corner M3 screw bosses
    boss_offsets = [,
        [body_l - 10, 10],
        [10, body_w - 10],
        [body_l - 10, body_w - 10]
    ];
    for (pos = boss_offsets) {
        translate([pos[0], pos[1], wall])
            difference() {
                cylinder(h = bot_h - wall - 2.0, d = 6.5);
                cylinder(h = bot_h, d = 2.7); // Self-tapping M3 hole
            }
    }
}

// =========================================================
// PART 2: TOP FACEPLATE (Printed Upside-Down Flat at Z = 0)
// =========================================================
module top_shell() {
    difference() {
        union() {
            rounded_box(body_l, body_w, top_h, corner_r);
            // Inner alignment lip that snaps into bottom shell
            translate([wall + 0.3, wall + 0.3, top_h])
                rounded_box(body_l - (wall + 0.3) * 2, body_w - (wall + 0.3) * 2, 2.0, corner_r - wall);
        }

        // Hollow interior cavity
        translate([wall, wall, wall])
            rounded_box(body_l - wall * 2, body_w - wall * 2, top_h + 3, corner_r - wall);

        // Left Analog Thumbstick Dome Opening (22mm dia)
        translate([28, body_w / 2, -1])
            cylinder(h = wall + 2, d = 22.0);

        // Right 4-Button Diamond Cluster (A, B, X, Y - 7.5mm holes for 6x6mm tactile caps)
        btn_cx = body_l - 28;
        btn_cy = body_w / 2;
        btn_spread = 9.5;
        btn_holes = [
            [btn_cx, btn_cy - btn_spread], // Bottom (A)
            [btn_cx + btn_spread, btn_cy], // Right (B)
            [btn_cx - btn_spread, btn_cy], // Left (X)
            [btn_cx, btn_cy + btn_spread]  // Top (Y)
        ];
        for (b = btn_holes) {
            translate([b[0], b[1], -1])
                cylinder(h = wall + 2, d = 7.5);
        }

        // Center Start/Menu Button Hole
        translate([body_l / 2, body_w / 2, -1])
            cylinder(h = wall + 2, d = 6.0);

        // 4 Countersunk Screw Holes matching bottom bosses
        boss_offsets = [,
            [body_l - 10, 10],
            [10, body_w - 10],
            [body_l - 10, body_w - 10]
        ];
        for (pos = boss_offsets) {
            translate([pos[0], pos[1], -1])
                cylinder(h = wall + 2, d = 3.3);
            translate([pos[0], pos[1], -0.1])
                cylinder(h = 1.6, d1 = 6.2, d2 = 3.3);
        }
    }
}
