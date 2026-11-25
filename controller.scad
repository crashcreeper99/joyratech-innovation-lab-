$fn = 48;

// =========================================================
// JOYRATECH PRO (HANDLED EDITION) - ZERO-OVERLAP PRINT BED
// Flat at Z = 0 | Clean 12mm Spacing Between All Parts
// =========================================================

body_l = 136;
body_w = 74;
total_h = 29;
wall = 2.4;
split_z = 19;
corner_r = 12;

// Tactile switch actuator stem hole size (typical 6x6mm switch: 3.25mm)
stem_hole_d = 3.25;

// 1. Handled Bottom Shell (Shifted Y = +26 so handle tips start at Y = 0)
translate([8, 26, 0])
    bottom_shell_handled();

// 2. Handled Top Faceplate (Shifted Y = +138 -> 12mm clear gap above bottom shell)
translate([8, 138, 0])
    top_shell();

// 3. All 15 Button Caps + 1 Spare (Placed cleanly to the right at X = 160)
translate([160, 10, 0])
    layout_caps_grid();

// ---------------- MODULES ----------------

module rounded_box(l, w, h, r) {
    hull() {
        translate([r, r, 0]) cylinder(h = h, r = r);
        translate([l - r, r, 0]) cylinder(h = h, r = r);
        translate([r, w - r, 0]) cylinder(h = h, r = r);
        translate([l - r, w - r, 0]) cylinder(h = h, r = r);
    }
}

// Swept ergonomic left & right palm handles (extends down to Y = -26)
module ergohandles(h, offset_wall = 0) {
    // Left Handle
    hull() {
        translate([18, 22, 0]) cylinder(h = h, r = 16 - offset_wall);
        translate([11, 2, 0])  cylinder(h = h, r = 13.5 - offset_wall);
        translate([4, -15, 0]) cylinder(h = h, r = 11 - offset_wall);
    }
    // Right Handle
    hull() {
        translate([body_l - 18, 22, 0]) cylinder(h = h, r = 16 - offset_wall);
        translate([body_l - 11, 2, 0])  cylinder(h = h, r = 13.5 - offset_wall);
        translate([body_l - 4, -15, 0]) cylinder(h = h, r = 11 - offset_wall);
    }
}

module bottom_shell_handled() {
    difference() {
        union() {
            rounded_box(body_l, body_w, split_z, corner_r);
            ergohandles(split_z, offset_wall = 0);
        }

        // Hollow main center cavity
        translate([wall, wall, wall])
            rounded_box(body_l - 2*wall, body_w - 2*wall, split_z + 1, corner_r - wall);

        // Hollow handle pockets
        translate([0, 0, wall])
            ergohandles(split_z + 1, offset_wall = wall);

        // Top Wall (Y = body_w): USB-C port & L1/L2/R1/R2 shoulder cutouts
        translate([body_l/2 - 4.7, body_w - wall - 1, 7.5])
            cube([9.4, wall + 2, 3.8]);
        for (sx = [22, 38, body_l - 33, body_l - 49]) {
            translate([sx - 3.75, body_w - wall - 1, 11])
                cube([7.5, wall + 2, 9]);
        }

        // Bottom Center Wall (Y = 0): Power slide switch cutout
        translate([body_l/2 - 4.25, -1, 7.5])
            cube([8.5, wall + 2, 4.4]);
    }

    // 4 Corner Screw Bosses (for M3 x 10mm/12mm screws)
    bosses = [[6, 6], [body_l - 6, 6], [6, body_w - 6], [body_l - 6, body_w - 6]];
    for (b = bosses) {
        translate([b[0], b[1], wall])
            difference() {
                cylinder(h = split_z - wall - 0.4, d = 6.2);
                cylinder(h = split_z, d = 2.7);
            }
    }

    // 4 NodeMCU-32S Mounting Standoffs (25.5mm x 51.5mm centered)
    mcu_pins = [[56.5, 13.5], [79.5, 13.5], [56.5, 62.5], [79.5, 62.5]];
    for (p = mcu_pins) {
        translate([p[0], p[1], wall])
            difference() {
                cylinder(h = 7.5, d = 4.8);
                cylinder(h = 8, d = 2.0);
            }
    }
}

module top_shell() {
    top_h = total_h - split_z;
    difference() {
        union() {
            rounded_box(body_l, body_w, top_h, corner_r);
            ergohandles(top_h, offset_wall = 0);
        }

        // Hollow underside
        translate([wall, wall, wall])
            rounded_box(body_l - 2*wall, body_w - 2*wall, top_h + 1, corner_r - wall);
        translate([0, 0, wall])
            ergohandles(top_h + 1, offset_wall = wall);

        // Left & Right Thumbstick Holes (24mm diameter)
        translate([30, 22, -1]) cylinder(h = wall + 2, d = 24);
        translate([body_l - 30, 22, -1]) cylinder(h = wall + 2, d = 24);

        // D-Pad Button Holes (X=28, Y=50, 10mm offset)
        for (dx = [-10, 10]) translate([28 + dx, 50, -1]) cylinder(h = wall + 2, d = 7.2);
        for (dy = [-10, 10]) translate([28, 50 + dy, -1]) cylinder(h = wall + 2, d = 7.2);

        // ABXY Button Holes (X=108, Y=50, 10.5mm offset)
        for (dx = [-10.5, 10.5]) translate([body_l - 28 + dx, 50, -1]) cylinder(h = wall + 2, d = 7.5);
        for (dy = [-10.5, 10.5]) translate([body_l - 28, 50 + dy, -1]) cylinder(h = wall + 2, d = 7.5);

        // Menu Buttons: Select, Home, Start
        for (mx = [body_l/2 - 14, body_l/2, body_l/2 + 14])
            translate([mx, 58, -1]) cylinder(h = wall + 2, d = 6.2);

        // 4 Countersunk Corner Screw Holes
        bosses = [[6, 6], [body_l - 6, 6], [6, body_w - 6], [body_l - 6, body_w - 6]];
        for (b = bosses) {
            translate([b[0], b[1], -1]) cylinder(h = top_h + 2, d = 3.3);
            translate([b[0], b[1], -0.1]) cylinder(h = 1.6, d1 = 6.0, d2 = 3.3);
        }
    }
}

module tactile_cap(cap_d, flange_d, total_h, is_shoulder = false) {
    flange_h = 1.2;
    difference() {
        union() {
            cylinder(h = flange_h, d = flange_d);
            if (is_shoulder) {
                translate([-cap_d/2, -2.8, 0])
                    cube([cap_d, 5.6, total_h]);
            } else {
                cylinder(h = total_h - 0.6, d = cap_d);
                translate([0, 0, total_h - 0.6])
                    cylinder(h = 0.6, d1 = cap_d, d2 = cap_d - 1.0);
            }
        }
        translate([0, 0, -0.1])
            cylinder(h = 2.6, d = stem_hole_d);
        translate([0, 0, -0.1])
            cylinder(h = 0.5, d1 = stem_hole_d + 0.5, d2 = stem_hole_d);
    }
}

// Arranged in a compact 4x4 grid on the right side (fits inside 215x215mm total bed)
module layout_caps_grid() {
    for (i = [0:3])
        translate([0, i * 14, 0])
            tactile_cap(cap_d = 6.6, flange_d = 8.8, total_h = 4.6);
    for (i = [0:3])
        translate([14, i * 14, 0])
            tactile_cap(cap_d = 6.9, flange_d = 9.1, total_h = 4.6);
    for (i = [0:3])
        translate([28, i * 14, 0])
            tactile_cap(cap_d = 5.6, flange_d = 7.8, total_h = 4.2);
    for (i = [0:3])
        translate([42, i * 14, 0])
            tactile_cap(cap_d = 6.8, flange_d = 9.0, total_h = 5.2, is_shoulder = true);
}
