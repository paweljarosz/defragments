uniform lowp vec4 iResolution;
uniform lowp vec4 iTime;
uniform sampler2D iChannel0;
uniform lowp vec4 iMouse;

#define F vec3(.2126, .7152, .0722)

void main()
{
    gl_FragColor = vec4(vec3(dot(texture(iChannel0, gl_FragCoord.xy / iResolution.xy).xyz, F)), 1);
}