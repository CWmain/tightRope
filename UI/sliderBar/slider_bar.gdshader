shader_type canvas_item;

uniform float percent = 1.0;

void fragment() {
	if (UV.x > percent){
		COLOR.a = 0.0;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
