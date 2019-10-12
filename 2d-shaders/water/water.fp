
// These are uniforms that otherwise are exposed by ShaderToy
uniform lowp vec4 iResolution;
uniform lowp vec4 iTime;
uniform sampler2D iChannel0;
uniform lowp vec4 iMouse;

//https://www.shadertoy.com/view/XdcXDn

#define amp 0.02
#define tint_color vec4(0.45, 0.89,0.99, 1)

void main()
{
    vec2 uv = gl_FragCoord.xy / iResolution.xy;

    vec2 p = uv +
    (vec2(.5)-texture(iChannel0, uv*0.3+vec2(iTime.x*0.05, iTime.x*0.025)).xy)*amp +
    (vec2(.5)-texture(iChannel0, uv*0.3-vec2(-iTime.x*0.005, iTime.x*0.0125)).xy)*amp;

    gl_FragColor = texture(iChannel0, p)*tint_color;
}