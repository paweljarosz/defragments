
// These are uniforms that otherwise are exposed by ShaderToy
uniform lowp vec4 iResolution;
uniform lowp vec4 iTime;
uniform sampler2D iChannel0;
uniform lowp vec4 iMouse;

//https://www.shadertoy.com/view/Xltfzj

void main()
{
    float Pi = 6.28318530718; // Pi*2

    // GAUSSIAN BLUR SETTINGS {{{
        float Directions = 16.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
        float Quality = 3.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
        float Size = 8.0; // BLUR SIZE (Radius)
        // GAUSSIAN BLUR SETTINGS }}}

        vec2 Radius = Size/iResolution.xy;

        // Normalized pixel coordinates (from 0 to 1)
        vec2 uv = gl_FragCoord.xy/iResolution.xy;
        // Pixel colour
        vec4 Color = texture(iChannel0, uv);

        // Blur calculations
        for( float d=0.0; d<Pi; d+=Pi/Directions)
        {
            for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
            {
                Color += texture( iChannel0, uv+vec2(cos(d),sin(d))*Radius*i);		
            }
        }

        // Output to screen
        Color /= Quality * Directions - 15.0;
        gl_FragColor =  Color;
}