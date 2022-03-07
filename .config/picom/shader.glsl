uniform float opacity;
uniform bool invert_color;
uniform sampler2D tex;
uniform vec2 u_resolution;
uniform float u_time;
in vec2 texCoord;




// Generate white noise
float random2d(vec2 coord){
	return fract(sin(dot(coord.xy, vec2(12.9898, 78.233))) * 43758.5453);
}



void main() {
	vec2 coord = gl_TexCoord[0].xy;

	vec4 pixel = texture2D(tex, coord);
	pixel *= opacity;

	if(pixel.a != 1.0) {
		float grain = random2d(vec2(sin(coord)));
		
		// noise
		vec3 color = vec3(grain);

		// luminosity
		color = mix(color, vec3(0.0), 0.1);

		// blend original with new
		color = mix(pixel, color, 0.03);
	
			
		gl_FragColor = vec4(color, pixel.a);
	} else {
		gl_FragColor = pixel;
	}
}

