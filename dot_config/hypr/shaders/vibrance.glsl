precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main(){
    vec4 color = texture2D(tex, v_texcoord);

    float VIBRANCE_AMOUNT = 1.0;

    float average = (color.r + color.g + color.b) / 3.0;
    float mx = max(color.r, max(color.g, color.b));
    float amt = (mx - average) * (-VIBRANCE_AMOUNT * 3.0);

    color.rgb = mix(color.rgb, vec3(mx), amt);

    gl_FragColor = color; 
}
