
// These are uniforms that otherwise are exposed by ShaderToy
uniform lowp vec4 iResolution;
uniform lowp vec4 iTime;
uniform sampler2D iChannel0;
uniform lowp vec4 iMouse;

//https://www.shadertoy.com/view/4lVSRm

#define PIXEL_SIZE 20.0

void main()
{
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    gl_FragColor = vec4(0);

    float dx = 1.0 / iResolution.x;
    float dy = 1.0 / iResolution.y;
    uv.x = (dx * PIXEL_SIZE) * floor(uv.x / (dx * PIXEL_SIZE));
    uv.y = (dy * PIXEL_SIZE) * floor(uv.y / (dy * PIXEL_SIZE));

    for (int i = 0; i < int(PIXEL_SIZE); i++)
    for (int j = 0; j < int(PIXEL_SIZE); j++)
    gl_FragColor += texture(iChannel0, vec2(uv.x + dx * float(i), uv.y + dy * float(j)));

    gl_FragColor /= pow(PIXEL_SIZE, 2.0);
}