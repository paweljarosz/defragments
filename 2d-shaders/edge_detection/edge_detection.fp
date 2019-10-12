
// These are uniforms that otherwise are exposed by ShaderToy
uniform lowp vec4 iResolution;
uniform lowp vec4 iTime;
uniform sampler2D iChannel0;
uniform lowp vec4 iMouse;

//Sobel filter https://www.shadertoy.com/view/MlBSWW

void main()
{
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    vec3 col;

    /*** Sobel kernels ***/
    // Note: GLSL's mat3 is COLUMN-major ->  mat3[col][row]
    mat3 sobelX = mat3(-1.0, -2.0, -1.0,
        0.0,  0.0, 0.0,
        1.0,  2.0,  1.0);
        mat3 sobelY = mat3(-1.0,  0.0,  1.0,
            -2.0,  0.0, 2.0,
            -1.0,  0.0,  1.0);  

            float sumX = 0.0;	// x-axis change
            float sumY = 0.0;	// y-axis change

            for(int i = -1; i <= 1; i++)
            {
                for(int j = -1; j <= 1; j++)
                {
                    // texture coordinates should be between 0.0 and 1.0
                    float x = (gl_FragCoord.x + float(i))/iResolution.x;	
                    float y =  (gl_FragCoord.y + float(j))/iResolution.y;

                    // Convolve kernels with image
                    sumX += length(texture( iChannel0, vec2(x, y) ).xyz) * float(sobelX[1+i][1+j]);
                    sumY += length(texture( iChannel0, vec2(x, y) ).xyz) * float(sobelY[1+i][1+j]);
                }
            }

            float g = abs(sumX) + abs(sumY);
            //g = sqrt((sumX*sumX) + (sumY*sumY));

            if(g > 1.0)
            col = vec3(1.0,1.0,1.0);
            else
            col = col * 0.0;

            gl_FragColor.xyz = col;
}