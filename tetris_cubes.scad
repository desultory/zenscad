

block_size = 5;
b = [block_size, block_size, block_size];
face_size = block_size * 3 / 4;
face_offset = (block_size - face_size) / 2;



module hollow_cube(){
    difference() {
        cube(b);
        translate([0, face_offset, face_offset]) cube([block_size, face_size, face_size]);
        translate([face_offset, 0, face_offset]) cube([face_size, block_size, face_size]);
        translate([face_offset, face_offset, 0]) cube([face_size, face_size, block_size]);
    }
}

module tetris_cube() {
    hollow_cube();
    translate([face_offset, face_offset, face_offset]) cube([face_size, face_size, face_size]);
}


module tetris_I(){
    tetris_cube();
    translate([0, block_size, 0]) tetris_cube();
    translate([0, block_size * 2, 0]) tetris_cube();
    translate([0, block_size * 3, 0]) tetris_cube();
}

module tetris_L(){
    tetris_cube();
    translate([0, block_size, 0])tetris_cube();
    translate([0, block_size * 2, 0]) tetris_cube();
    translate([block_size, block_size * 2, 0]) tetris_cube();
}
module tetris_block(){
    tetris_cube();
    translate([0, block_size, 0]) tetris_cube();
    translate([block_size, block_size, 0]) tetris_cube();
    translate([block_size, 0, 0]) tetris_cube();
}

module tetris_Z(){
    tetris_cube();
    translate([0, block_size, 0]) tetris_cube();
    translate([block_size, block_size, 0]) tetris_cube();
    translate([block_size, block_size * 2, 0]) tetris_cube();
}



translate([-block_size * 1.5, 0]) tetris_I();

tetris_Z();

translate([ -block_size * .25, block_size * 2.25, 0]) tetris_L();

translate([ block_size * 1.25, -block_size * 1.5, 0]) tetris_block();    