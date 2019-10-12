uniform lowp vec4 iResolution;
uniform lowp vec4 iTime;
uniform sampler2D iChannel0;
uniform lowp vec4 iMouse;

//Soft treshold: https://www.shadertoy.com/view/4ssGR8

const float Soft = 0.001;
const float Threshold = 0.3;

void main()
{
    float f = Soft/2.0;
    float edge0 = Threshold - f;
    float edge1 = Threshold + f;

    vec4 tx = texture(iChannel0, gl_FragCoord.xy/iResolution.xy);

    //Calculate average color of current pixel
    float average = (tx.x + tx.y + tx.z) / 3.0;

    //Smooth Hermite interpolation between 0 and 1 (black and white)
    float v = smoothstep(edge0, edge1, average);
    gl_FragColor = vec4(v);
}