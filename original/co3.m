freeze;
 
/* Code for maximal subgroups of co3 */

function CO3Identify(group: max:= true, Print:=0)
// group should be already knwon to be isomorphic to co3

  if Print gt 1 then print "Making standard group"; end if;
  co3 :=  sub<Sym(276) |
    \[  1, 24, 2, 5, 7, 6, 4, 189, 184, 190, 183, 192, 191, 181, 
    182, 196, 194, 195, 193, 188, 186, 185, 187, 3, 26, 27, 25, 28, 49, 50, 51, 
    52, 57, 58, 59, 60, 55, 56, 53, 54, 47, 48, 45, 46, 208, 207, 206, 205, 200,
    199, 198, 197, 202, 201, 204, 203, 226, 225, 228, 227, 121, 122, 123, 124, 
    127, 128, 125, 126, 138, 137, 139, 140, 118, 117, 120, 119, 131, 132, 130, 
    129, 134, 133, 136, 135, 91, 90, 87, 88, 100, 98, 97, 99, 93, 94, 89, 92, 
    85, 86, 96, 95, 107, 108, 105, 106, 115, 116, 113, 114, 109, 110, 111, 112, 
    101, 102, 103, 104, 173, 174, 175, 176, 172, 171, 169, 170, 160, 159, 158, 
    157, 179, 180, 177, 178, 167, 168, 165, 166, 161, 162, 164, 163, 22, 23, 11,
    9, 19, 16, 18, 17, 10, 8, 20, 21, 13, 14, 15, 12, 66, 65, 68, 67, 70, 69, 
    72, 71, 84, 83, 82, 81, 63, 64, 62, 61, 74, 73, 76, 75, 77, 78, 80, 79, 154,
    155, 143, 144, 141, 152, 142, 151, 150, 149, 153, 156, 145, 148, 147, 146, 
    32, 31, 30, 29, 40, 39, 38, 37, 42, 41, 44, 43, 232, 236, 239, 233, 231, 
    241, 244, 237, 242, 235, 229, 234, 240, 243, 230, 238, 34, 33, 36, 35, 264, 
    270, 271, 266, 263, 273, 274, 268, 267, 276, 272, 261, 265, 269, 262, 275, 
    255, 258, 250, 245, 249, 257, 252, 259, 246, 254, 248, 256, 247, 253, 251, 
    260, 221, 222, 212, 219, 214, 209, 216, 210, 217, 223, 213, 211, 220, 218, 
    215, 224 ],
    \[ 117, 78, 3, 167, 148, 12, 33, 181, 136, 20, 31, 56, 35, 
    193, 240, 152, 137, 134, 231, 132, 130, 199, 118, 86, 71, 112, 263, 198, 17,
    224, 155, 140, 250, 40, 187, 244, 153, 176, 165, 47, 150, 256, 49, 259, 114,
    55, 248, 175, 52, 154, 210, 220, 223, 205, 18, 214, 188, 232, 212, 29, 19, 
    228, 80, 72, 236, 186, 44, 271, 273, 267, 8, 206, 164, 102, 75, 183, 226, 
    113, 82, 275, 251, 45, 109, 157, 85, 92, 38, 238, 4, 262, 95, 159, 74, 253, 
    104, 161, 84, 94, 42, 100, 101, 103, 93, 108, 105, 268, 269, 91, 83, 270, 2,
    70, 111, 79, 81, 98, 120, 197, 9, 125, 143, 54, 123, 119, 1, 122, 127, 221, 
    129, 58, 190, 178, 211, 46, 200, 124, 60, 57, 151, 50, 7, 121, 146, 144, 
    234, 142, 179, 174, 247, 145, 131, 59, 37, 32, 213, 156, 173, 252, 24, 160, 
    107, 99, 260, 246, 158, 89, 166, 115, 276, 5, 217, 254, 97, 170, 149, 249, 
    68, 10, 265, 90, 25, 184, 258, 208, 169, 106, 264, 274, 222, 139, 216, 67, 
    51, 27, 255, 242, 201, 62, 189, 135, 23, 207, 203, 204, 126, 219, 53, 227, 
    209, 14, 133, 16, 11, 6, 241, 15, 69, 30, 64, 43, 128, 22, 202, 266, 239, 
    196, 182, 28, 73, 230, 233, 21, 61, 41, 194, 65, 63, 88, 36, 191, 110, 77, 
    76, 225, 180, 229, 48, 34, 87, 141, 168, 39, 116, 172, 195, 162, 177, 243, 
    192, 163, 147, 245, 235, 13, 261, 218, 26, 66, 96, 215, 257, 185, 171, 138, 
    237, 272 ] >;

  //find standard generators
  x:=Random(co3);
  while not Order(x) in {9,18,24,30} do x:=Random(co3); end while;
  a := x^(Order(x) div 3);
  x:=Random(co3); while Order(x) ne 20 do x:=Random(co3); end while;
  b := x^5; while Order(a*b) ne 14 do b:=b^Random(co3); end while;

  co3:=sub<co3|a,b>;

  if Print gt 1 then print "Calling FPGroupStrong"; end if;
  F, phi := FPGroupStrong(co3);

  if Print gt 1 then print "Setting up isomorphism"; end if;

  //Find standard generators of soc
  soc := group;
  x:=Random(soc);
  while not Order(x) in {9,18,24,30} do x:=Random(soc); end while;
  ag := x^(Order(x) div 3);
  x:=Random(soc); while Order(x) ne 20 do x:=Random(soc); end while;
  bg := x^5; while Order(ag*bg) ne 14 do bg:=bg^Random(soc); end while;
  group := sub< group | ag,bg >;

  homom := hom< group -> co3 | [a,b] >;

  maximals:= [];
  if not max then
    return homom, co3, maximals, F, phi;
  end if;

  if Print gt 1 then print "getting maximals"; end if;
  Append(~maximals,Stabilizer(co3,1)); //McL:2
  Append(~maximals,Stabilizer(co3,{1..100})); //HS
  Append(~maximals,Stabilizer(co3,{1..2})); //U_4(3):2^2
  Append(~maximals,Stabilizer(co3,{1..23})); //M23
  S2:=Sylow(co3,2); S3:=Sylow(co3,3);
  Append(~maximals,Normaliser(co3,Centraliser(S3,DerivedSubgroup(S3))));
       //3^5:(2xM11)
  Append(~maximals,Normaliser(co3,Centre(S2)));//2.S_6(2)
  Append(~maximals,Stabiliser(co3,
   { 101, 102, 103, 104, 105, 106, 109, 110, 111, 112, 113, 114, 117, 118, 
    119, 120, 125, 126, 127, 128, 129, 130, 131, 132, 135, 136, 137, 138, 139, 
    140, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 154, 155, 159, 160, 
    161, 162, 163, 164, 165, 168, 169, 171, 179, 180, 181, 182, 184, 185, 186, 
    187, 188, 189, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 205, 206, 
    207, 208, 209, 210, 211, 214, 215, 217, 219, 220, 221, 222, 223, 224, 225, 
    226, 229, 230, 232, 233, 234, 236, 237, 238, 239, 240, 243, 244, 245, 246, 
    247, 249, 251, 254, 255, 256, 257, 258, 259, 260, 261, 262, 264, 265, 266, 
    268, 269, 270, 271, 272, 274, 275 }));//U_3(5):S_3
  Append(~maximals,Normaliser(co3,Centre(S3)));//3^(1+4):4S_6
  Append(~maximals,Stabiliser(co3,
            { 19, 71, 92, 209, 250, 253, 255, 265 }));//2^4.A8
  Append(~maximals,Stabiliser(co3,{1,2,3}));//L_3(4):D_12
  Append(~maximals,Stabiliser(co3,
    { 24, 98, 105, 118, 121, 137, 154, 187, 196, 197, 270, 274 }));//2xM_12
  Append(~maximals,Normaliser(co3,DerivedSubgroup(DerivedSubgroup(S2))));
                      //2^{2+6}.3^3.2^2
  Append(~maximals,Stabiliser(co3,
   { 2, 6, 10, 11, 13, 14, 18, 19, 20, 25, 33, 38, 41, 42, 45, 51, 53, 57, 
    59, 61, 62, 63, 64, 66, 74, 75, 76, 81, 82, 85, 92, 96, 97, 98, 99, 100, 
    104, 106, 109, 112, 114, 115, 116, 122, 123, 126, 128, 129, 130, 134, 141, 
    142, 143, 148, 149, 151, 152, 155, 157, 162, 165, 168, 172, 175, 176, 181, 
    184, 187, 188, 190, 191, 194, 197, 199, 200, 204, 205, 211, 212, 214, 215, 
    220, 223, 224, 226, 228, 229, 230, 233, 234, 236, 238, 240, 241, 243, 244, 
    247, 248, 253, 256, 260, 261, 262, 263, 266, 269, 271, 276 }));
                      //S_3xL_2(8):3
  Append(~maximals,Stabiliser(co3,
   { 2, 6, 19, 53, 61, 63, 75, 97, 99, 100, 104, 106, 116, 129, 143, 149, 
    152, 157, 162, 172, 175, 184, 187, 194, 204, 224, 226, 234, 238, 240, 241, 
    243, 260, 262, 263, 269 })); //A_4 x S_5

  return homom, co3, maximals, F, phi;
end function;

