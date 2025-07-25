#   
  Ç                GLSL.std.450                     main    Z  ¾               D:\Flutter\flutter_3.3.2\flutter\packages\flutter\lib\src\material\shaders\ink_sparkle.frag  >   Ì     // OpModuleProcessed entry-point ink_sparkle_fragment_main
// OpModuleProcessed auto-map-bindings
// OpModuleProcessed auto-map-locations
// OpModuleProcessed client opengl100
// OpModuleProcessed target-env opengl
// OpModuleProcessed entry-point main
#line 1
#version 320 es

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

precision highp float;

// TODO(antrob): Put these in a more logical order (e.g. separate consts vs varying, etc)

layout(location = 0) uniform vec4 u_color;
layout(location = 1) uniform float u_alpha;
layout(location = 2) uniform vec4 u_sparkle_color;
layout(location = 3) uniform float u_sparkle_alpha;
layout(location = 4) uniform float u_blur;
layout(location = 5) uniform vec2 u_center;
layout(location = 6) uniform float u_radius_scale;
layout(location = 7) uniform float u_max_radius;
layout(location = 8) uniform vec2 u_resolution_scale;
layout(location = 9) uniform vec2 u_noise_scale;
layout(location = 10) uniform float u_noise_phase;
layout(location = 11) uniform vec2 u_circle1;
layout(location = 12) uniform vec2 u_circle2;
layout(location = 13) uniform vec2 u_circle3;
layout(location = 14) uniform vec2 u_rotation1;
layout(location = 15) uniform vec2 u_rotation2;
layout(location = 16) uniform vec2 u_rotation3;

layout(location = 0) out vec4 fragColor;

const float PI = 3.1415926535897932384626;
const float PI_ROTATE_RIGHT = PI * 0.0078125;
const float PI_ROTATE_LEFT = PI * -0.0078125;
const float ONE_THIRD = 1./3.;
const vec2 TURBULENCE_SCALE = vec2(0.8);

float saturate(float x) {
  return clamp(x, 0.0, 1.0);
}

float triangle_noise(highp vec2 n) {
  n = fract(n * vec2(5.3987, 5.4421));
  n += dot(n.yx, n.xy + vec2(21.5351, 14.3137));
  float xy = n.x * n.y;
  return fract(xy * 95.4307) + fract(xy * 75.04961) - 1.0;
}

float threshold(float v, float l, float h) {
  return step(l, v) * (1.0 - step(h, v));
}

mat2 rotate2d(vec2 rad){
  return mat2(rad.x, -rad.y, rad.y, rad.x);
}

float soft_circle(vec2 uv, vec2 xy, float radius, float blur) {
  float blur_half = blur * 0.5;
  float d = distance(uv, xy);
  return 1.0 - smoothstep(1.0 - blur_half, 1.0 + blur_half, d / radius);
}

float soft_ring(vec2 uv, vec2 xy, float radius, float thickness, float blur) {
  float circle_outer = soft_circle(uv, xy, radius + thickness, blur);
  float circle_inner = soft_circle(uv, xy, max(radius - thickness, 0.0), blur);
  return saturate(circle_outer - circle_inner);
}

float circle_grid(vec2 resolution, vec2 p, vec2 xy, vec2 rotation, float cell_diameter) {
  p = rotate2d(rotation) * (xy - p) + xy;
  p = mod(p, cell_diameter) / resolution;
  float cell_uv = cell_diameter / resolution.y * 0.5;
  float r = 0.65 * cell_uv;
  return soft_circle(p, vec2(cell_uv), r, r * 50.0);
}

float sparkle(vec2 uv, float t) {
  float n = triangle_noise(uv);
  float s = threshold(n, 0.0, 0.05);
  s += threshold(n + sin(PI * (t + 0.35)), 0.1, 0.15);
  s += threshold(n + sin(PI * (t + 0.7)), 0.2, 0.25);
  s += threshold(n + sin(PI * (t + 1.05)), 0.3, 0.35);
  return saturate(s) * 0.55;
}

float turbulence(vec2 uv) {
  vec2 uv_scale = uv * TURBULENCE_SCALE;
  float g1 = circle_grid(TURBULENCE_SCALE, uv_scale, u_circle1, u_rotation1, 0.17);
  float g2 = circle_grid(TURBULENCE_SCALE, uv_scale, u_circle2, u_rotation2, 0.2);
  float g3 = circle_grid(TURBULENCE_SCALE, uv_scale, u_circle3, u_rotation3, 0.275);
  float v = (g1 * g1 + g2 - g3) * 0.5;
  return saturate(0.45 + 0.8 * v);
}

void main() {
  vec2 p = gl_FragCoord.xy;
  vec2 uv = p * u_resolution_scale;
  vec2 density_uv = uv - mod(p, u_noise_scale);
  float radius = u_max_radius * u_radius_scale;
  float turbulence = turbulence(uv);
  float ring = soft_ring(p, u_center, radius, 0.05 * u_max_radius, u_blur);
  float sparkle = sparkle(density_uv, u_noise_phase) * ring * turbulence * u_sparkle_alpha;
  float wave_alpha = soft_circle(p, u_center, radius, u_blur) * u_alpha * u_color.a;
  vec4 wave_color = vec4(u_color.rgb * wave_alpha, wave_alpha);
  vec4 sparkle_color = vec4(u_sparkle_color.rgb * u_sparkle_color.a, u_sparkle_color.a);
  fragColor = mix(wave_color, sparkle_color, sparkle);
}
     
 GL_GOOGLE_cpp_style_line_directive    GL_GOOGLE_include_directive      main         saturate(f1;      
   x        triangle_noise(vf2;      n        threshold(f1;f1;f1;      v        l        h        rotate2d(vf2;        rad  	 #   soft_circle(vf2;vf2;f1;f1;       uv        xy    !   radius    "   blur     	 +   soft_ring(vf2;vf2;f1;f1;f1;   &   uv    '   xy    (   radius    )   thickness     *   blur     
 3   circle_grid(vf2;vf2;vf2;vf2;f1;   .   resolution    /   p     0   xy    1   rotation      2   cell_diameter     8   sparkle(vf2;f1;   6   uv    7   t     ;   turbulence(vf2;   :   uv    T   xy       blur_half        d        circle_outer         param        param        param        param         circle_inner      ¥   param     §   param     ©   param     ª   param     °   param     ´   param     Ã   cell_uv   É   r     Ò   param     Ô   param     Õ   param     ×   param     Û   n     Ü   param     ß   s     á   param     ã   param     ä   param     ð   param     ñ   param     ò   param     ÿ   param        param       param       param       param       param       param       uv_scale        g1    !  u_circle1     "  u_rotation1   $  param     %  param     '  param     )  param     +  param     -  g2    .  u_circle2     /  u_rotation2   0  param     1  param     3  param     5  param     7  param     9  g3    :  u_circle3     ;  u_rotation3   =  param     >  param     @  param     B  param     D  param     F  v     S  param     W  p     Z  gl_FragCoord      ]  uv    _  u_resolution_scale    b  density_uv    e  u_noise_scale     i  radius    k  u_max_radius      m  u_radius_scale    p  turbulence    q  param     t  ring      u  u_center      x  u_blur    y  param     {  param     }  param       param       param       sparkle     u_noise_phase       param       param       u_sparkle_alpha     wave_alpha      param       param       param       param       u_alpha     u_color   ¥  wave_color    °  sparkle_color     ±  u_sparkle_color   ¾  fragColor   G  !        G  !  "       G  !  !      G  "        G  "  "       G  "  !      G  .        G  .  "       G  .  !      G  /        G  /  "       G  /  !      G  :        G  :  "       G  :  !      G  ;        G  ;  "       G  ;  !      G  Z        G  _        G  _  "       G  _  !      G  e     	   G  e  "       G  e  !   	   G  k        G  k  "       G  k  !      G  m        G  m  "       G  m  !      G  u        G  u  "       G  u  !      G  x        G  x  "       G  x  !      G       
   G    "       G    !   
   G          G    "       G    !      G          G    "       G    !      G           G    "       G    !       G  ±        G  ±  "       G  ±  !      G  ¾              !                             !  	                                !           !                            !           !                    !  %                     !  -                     !  5            +     >       +     ?     ?+     D   'Â¬@+     E   ¯%®@,     F   D   E   +     L   ãG¬A+     M   êeA,     N   L   M     U           +  U   V       +  U   Y      +     ^   Ü¾B+     b   fB+           ?+     Ê   ff&?+     Ð     HB+     à   ÍÌL=+     ç   ÛI@+     é   33³>+     î   ÍÌÌ=+     ï   >+     ø   333?+     ý   ÍÌL>+     þ     >+       ff?+       >+       ÍÌ?+       ÍÌL?,                        ;     !      ;     "      +     #  {.>;     .      ;     /      ;     :      ;     ;      +     <  ÍÌ>+     O  ffæ>  X           Y     X  ;  Y  Z     ;     _      ;     e         j         ;  j  k      ;  j  m      ;     u      ;  j  x      ;  j        ;  j        ;  j                 X  ;          +  U            ¤     X    ¦        ;    ±         ½     X  ;  ½  ¾     +     Ä  ÛÉ<+     Å  ÛÉ¼+     Æ  «ªª>     ^      6               ø     ;     W     ;     ]     ;     b     ;     i     ;     p     ;     q     ;     t     ;     y     ;     {     ;     }     ;          ;          ;          ;          ;          ;          ;          ;          ;          ;          ;  ¤  ¥     ;  ¤  °          _       =  X  [  Z  O     \  [  [         >  W  \       `       =     ^  W  =     `  _       a  ^  `  >  ]  a       a       =     c  ]  =     d  W  =     f  e       g  d  f       h  c  g  >  b  h       b       =     l  k  =     n  m       o  l  n  >  i  o       c       =     r  ]  >  q  r  9     s  ;   q  >  p  s       d       =     v  k       w  à   v  =     z  W  >  y  z  =     |  u  >  {  |  =     ~  i  >  }  ~  >    w  =       x  >      9 	      +   y  {  }      >  t         e       =       b  >      =         >      9       8       =       t             =       p             =                    >           f       =       W  >      =       u  >      =       i  >      =       x  >      9       #           =                    A  j  ¡       =     ¢  ¡       £    ¢  >    £       g       =  X  §    O  ¦  ¨  §  §            =     ©      ¦  ª  ¨  ©  =     «    Q     ¬  ª      Q     ­  ª     Q     ®  ª     P  X  ¯  ¬  ­  ®  «  >  ¥  ¯       h       =  X  ²  ±  O  ¦  ³  ²  ²            A  j  ´  ±     =     µ  ´    ¦  ¶  ³  µ  A  j  ·  ±     =     ¸  ·  Q     ¹  ¶      Q     º  ¶     Q     »  ¶     P  X  ¼  ¹  º  »  ¸  >  °  ¼       i       =  X  ¿  ¥  =  X  À  °  =     Á    P  X  Â  Á  Á  Á  Á    X  Ã     .   ¿  À  Â  >  ¾  Ã  ý  8       %      6            	   7     
   ø          &       =     =   
        @      +   =   >   ?   þ  @   8       )   "   6               7        ø     ;     T           *       =     C           G   C   F        H      
   G   >     H        +       =     I      O     J   I   I          =     K           O   K   N        P   J   O   =     Q      P     R   P   P        S   Q   R   >     S        ,       A     W      V   =     X   W   A     Z      Y   =     [   Z        \   X   [   >  T   \        -       =     ]   T        _   ]   ^        `      
   _   =     a   T        c   a   b        d      
   c        e   `   d        f   e   ?   þ  f   8       0   *   6               7        7        7        ø          1       =     i      =     j           k      0   i   j   =     l      =     m           n      0   l   m        o   ?   n        p   k   o   þ  p   8       4      6               7        ø          5       A     s      V   =     t   s   A     u      Y   =     v   u        w   v   A     x      Y   =     y   x   A     z      V   =     {   z   P     |   t   w   P     }   y   {   P     ~   |   }   þ  ~   8       8   =   6     #          7        7         7     !   7     "   ø  $   ;           ;                9       =        "                 >             :       =           =                       C         >             ;       =                   ?      =                   ?      =           =        !                            1                    ?      þ     8       >   L   6     +       %   7     &   7     '   7     (   7     )   7     *   ø  ,   ;           ;           ;           ;           ;           ;            ;     ¥      ;     §      ;     ©      ;     ª      ;     °           ?       =        (   =        )                 =        &   >        =        '   >        >        =        *   >        9        #               >             @       =     ¡   (   =     ¢   )        £   ¡   ¢        ¤      (   £   >   =     ¦   &   >  ¥   ¦   =     ¨   '   >  §   ¨   >  ©   ¤   =     «   *   >  ª   «   9     ¬   #   ¥   §   ©   ª   >      ¬        A       =     ­      =     ®            ¯   ­   ®   >  °   ¯   9     ±      °   þ  ±   8       D   W   6     3       -   7     .   7     /   7     0   7     1   7     2   ø  4   ;     ´      ;     Ã      ;     É      ;     Ò      ;     Ô      ;     Õ      ;     ×           E       =     µ   1   >  ´   µ   9     ¶      ´   =     ·   0   =     ¸   /        ¹   ·   ¸        º   ¶   ¹   =     »   0        ¼   º   »   >  /   ¼        F       =     ½   /   =     ¾   2   P     ¿   ¾   ¾        À   ½   ¿   =     Á   .        Â   À   Á   >  /   Â        G       =     Ä   2   A     Å   .   Y   =     Æ   Å        Ç   Ä   Æ        È   Ç      >  Ã   È        H       =     Ë   Ã        Ì   Ê   Ë   >  É   Ì        I       =     Í   Ã   P     Î   Í   Í   =     Ï   É        Ñ   Ï   Ð   =     Ó   /   >  Ò   Ó   >  Ô   Î   =     Ö   É   >  Õ   Ö   >  ×   Ñ   9     Ø   #   Ò   Ô   Õ   ×   þ  Ø   8       L      6     8       5   7     6   7     7   ø  9   ;     Û      ;     Ü      ;     ß      ;     á      ;     ã      ;     ä      ;     ð      ;     ñ      ;     ò      ;     ÿ      ;           ;          ;          ;          ;          ;               M       =     Ý   6   >  Ü   Ý   9     Þ      Ü   >  Û   Þ        N       =     â   Û   >  á   â   >  ã   >   >  ä   à   9     å      á   ã   ä   >  ß   å        O       =     æ   Û   =     è   7        ê   è   é        ë   ç   ê        ì         ë        í   æ   ì   >  ð   í   >  ñ   î   >  ò   ï   9     ó      ð   ñ   ò   =     ô   ß        õ   ô   ó   >  ß   õ        P       =     ö   Û   =     ÷   7        ù   ÷   ø        ú   ç   ù        û         ú        ü   ö   û   >  ÿ   ü   >     ý   >    þ   9          ÿ        =       ß              >  ß          Q       =       Û   =       7                   	  ç          
        	           
  >      >      >    é   9                =       ß              >  ß          R       =       ß   >      9                       þ    8       U      6     ;          7     :   ø  <   ;          ;          ;     $     ;     %     ;     '     ;     )     ;     +     ;     -     ;     0     ;     1     ;     3     ;     5     ;     7     ;     9     ;     =     ;     >     ;     @     ;     B     ;     D     ;     F     ;     S          V       =       :              >           W       >  $    =     &    >  %  &  =     (  !  >  '  (  =     *  "  >  )  *  >  +  #  9 	    ,  3   $  %  '  )  +  >    ,       X       >  0    =     2    >  1  2  =     4  .  >  3  4  =     6  /  >  5  6  >  7  ý   9 	    8  3   0  1  3  5  7  >  -  8       Y       >  =    =     ?    >  >  ?  =     A  :  >  @  A  =     C  ;  >  B  C  >  D  <  9 	    E  3   =  >  @  B  D  >  9  E       Z       =     G    =     H         I  G  H  =     J  -       K  I  J  =     L  9       M  K  L       N  M     >  F  N       [       =     P  F       Q    P       R  O  Q  >  S  R  9     T     S  þ  T  8  