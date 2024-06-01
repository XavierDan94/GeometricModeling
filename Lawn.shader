Shader "Examples/Lawn"
{
    Properties
    {
        _BaseColor("Base Color", Color) = (0.8, 0.7, 0.5, 1)
    }

    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque"
            "Queue" = "Geometry"
            "RenderPipeline" = "UniversalPipeline"
        }

        Pass
        {
            Tags
            {
                "LightMode" = "UniversalForward"
            }

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct v2f
            {
                float4 positionCS : SV_Position;
                float2 uv : TEXCOORD0;
            };

            CBUFFER_START(UnityPerMaterial)
                float4 _BaseColor;
            CBUFFER_END

            float2 _MainTex_ST;

            v2f vert (float4 vertex : POSITION) 
            {
                v2f o;
                o.positionCS = mul(UNITY_MATRIX_MVP, vertex);
                o.uv = vertex.xy * 0.5 + 0.5;
                return o;
            }

            float hash(float2 p)
            {
                return frac(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
            }

            float noise(float2 p)
            {
                float2 i = floor(p);
                float2 f = frac(p);
                f = f * f * (3.0 - 2.0 * f);
                float a = hash(i);
                float b = hash(i + float2(1.0, 0.0));
                float c = hash(i + float2(0.0, 1.0));
                float d = hash(i + float2(1.0, 1.0));
                return lerp(lerp(a, b, f.x), lerp(c, d, f.x), f.y);
            }

            float fractalNoise(float2 p)
            {
                float f = 0.0;
                f += 0.5000 * noise(p); p *= 2.02;
                f += 0.2500 * noise(p); p *= 2.03;
                f += 0.1250 * noise(p); p *= 2.01;
                f += 0.0625 * noise(p); p *= 2.04;
                f /= 0.9375; // Normalize to 0-1
                return f;
            }

            float4 frag (v2f i) : SV_Target
            {
                float cloudiness = fractalNoise(i.uv);
                return float4(_BaseColor.rgb * cloudiness, 1.0);
            }
            ENDHLSL
        }
    }
    Fallback Off
}
