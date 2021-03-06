
// These are uniforms that otherwise are exposed by ShaderToy
uniform lowp vec4 iResolution;
uniform lowp vec4 iTime;
uniform sampler2D iChannel0;
uniform lowp vec4 iMouse;

//https://www.shadertoy.com/view/wljGWR

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main()
{
    // Sawtooth calc of time
    float offset = (iTime.x - floor(iTime.x)) / iTime.x;
    float time = iTime.x * offset;
    // Wave design params
    vec3 waveParams = vec3(10.0, 0.8, 0.1 );


    // Find coordinate, flexible to different resolutions
    float maxSize = max(iResolution.x, iResolution.y);
    vec2 uv = gl_FragCoord.xy / maxSize;


    // Find center, flexible to different resolutions
    vec2 center = iResolution.xy / maxSize / 2.;

    // Distance to the center
    float dist = distance(uv, center);

    // Original color
    vec4 c = texture(iChannel0, uv);

    // Limit to waves
    if (time > 0. && dist <= time + waveParams.z && dist >= time - waveParams.z) {

        // The pixel offset distance based on the input parameters
        float diff = (dist - time);
        float diffPow = (1.0 - pow(abs(diff * waveParams.x), waveParams.y));
        float diffTime = (diff  * diffPow);

        // The direction of the distortion
        vec2 dir = normalize(uv - center);


        // Perform the distortion and reduce the effect over time
        uv += ((dir * diffTime) / (time * dist * 80.0)) * dist;

        // Grab color for the new coord
        c = texture(iChannel0, uv);

        // Optionally: Blow out the color for brighter-energy origin
        //c += (c * diffPow) / (time * dist * 2000.0);

        vec4 red = texture(iChannel0, vec2(uv.x - (0.2 / (time* dist * 1000.0)), uv.y)) * vec4(1.0, 0.0, 0.0,1.0);
        vec4 green = texture(iChannel0, vec2(uv.x + (0.2 / (time* dist * 1000.0)) , uv.y))
        * vec4(0.0, 1.00, 0.0,1.0);
        vec4 blue  = texture(iChannel0, vec2(uv.x, uv.y)) * vec4(0.0, 0.0, 1.0,1.0);
        c += red + green + blue;
        c /= 2.;
    }

    gl_FragColor = c;
}