freeze;
 
get_standard_gens_g24 := function(G)
/* standard gens and algorithm from Birmingham web page */
/* assumes G is isomorphic to G2(4) */
    P := RandomProcess(G);
    repeat x := Random(P); ord := Order(x); until ord in {4,8,12};
    a := x ^ (ord div 2);
    repeat
	repeat x := Random(P); ord := Order(x); until ord in {5,10,15};
	x := x ^ (ord div 5);
	repeat 
	    b := x^Random(P); ab := a*b;
	until Order(ab) eq 13 and Order(ab*b) eq 13;
	ord := Order(ab*ab*b);
	assert ord in {10,15};
    until ord eq 15;
    return a,b;
end function;

G24Identify := function(group:max:=true,Print:=0)
S := Sym(416);
a :=S!
\[39, 254, 61, 65, 243, 26, 50, 343, 143, 114, 56, 76, 289, 53, 15, 62, 325, 67,
46, 216, 308, 252, 335, 24, 25, 6, 27, 305, 275, 121, 351, 81, 259, 109, 390, 
128, 383, 186, 1, 241, 414, 402, 274, 359, 45, 19, 365, 110, 363, 7, 292, 101, 
14, 228, 93, 11, 66, 168, 122, 358, 3, 16, 130, 326, 4, 57, 18, 372, 209, 313, 
336, 398, 385, 182, 163, 12, 257, 276, 105, 80, 32, 231, 159, 407, 181, 188, 
340, 160, 323, 346, 394, 369, 55, 183, 416, 96, 226, 187, 401, 202, 52, 320, 
176, 157, 79, 223, 352, 294, 34, 48, 137, 251, 253, 10, 240, 116, 269, 317, 341,
380, 30, 59, 342, 131, 411, 126, 238, 36, 129, 63, 124, 132, 370, 134, 172, 156,
111, 138, 368, 300, 349, 366, 9, 395, 145, 162, 212, 195, 406, 242, 250, 222, 
355, 167, 166, 136, 104, 210, 83, 88, 399, 146, 75, 268, 281, 155, 154, 58, 400,
197, 235, 135, 174, 173, 249, 103, 177, 258, 237, 203, 85, 74, 94, 184, 264, 38,
98, 86, 260, 318, 304, 344, 298, 337, 148, 290, 170, 256, 376, 246, 347, 100, 
180, 329, 384, 373, 272, 338, 69, 158, 405, 147, 367, 332, 302, 20, 230, 357, 
219, 393, 288, 152, 106, 354, 280, 97, 371, 54, 283, 217, 82, 330, 248, 389, 
171, 236, 179, 127, 387, 115, 40, 150, 5, 273, 315, 200, 247, 233, 175, 151, 
112, 22, 113, 2, 334, 198, 77, 178, 33, 189, 301, 379, 361, 185, 265, 348, 328, 
164, 117, 296, 327, 207, 244, 43, 29, 78, 278, 277, 311, 225, 165, 291, 229, 
375, 285, 286, 392, 221, 13, 196, 282, 51, 412, 108, 410, 270, 321, 193, 299, 
140, 261, 215, 396, 191, 28, 404, 386, 21, 374, 356, 279, 312, 70, 314, 245, 
316, 118, 190, 319, 102, 297, 415, 89, 388, 17, 64, 271, 267, 204, 232, 350, 
214, 409, 255, 23, 71, 194, 208, 339, 87, 119, 123, 8, 192, 382, 90, 201, 266, 
141, 331, 31, 107, 403, 224, 153, 310, 218, 60, 44, 377, 263, 362, 49, 364, 47, 
142, 213, 139, 92, 133, 227, 68, 206, 309, 284, 199, 360, 397, 262, 120, 381, 
345, 37, 205, 73, 307, 239, 324, 234, 35, 413, 287, 220, 91, 144, 303, 378, 72, 
161, 169, 99, 42, 353, 306, 211, 149, 84, 408, 333, 295, 125, 293, 391, 41, 322,
95 ];
b:= S!
\[361, 333, 343, 18, 299, 349, 47, 399, 116, 277, 266, 117, 214, 337, 321, 315, 
240, 391, 190, 174, 71, 334, 104, 357, 272, 170, 139, 46, 305, 146, 189, 252, 
314, 124, 159, 121, 303, 91, 112, 346, 222, 271, 79, 255, 77, 395, 166, 7, 398, 
64, 213, 78, 43, 70, 40, 326, 147, 179, 115, 199, 105, 229, 168, 324, 162, 345, 
165, 328, 384, 404, 381, 325, 221, 302, 348, 374, 291, 265, 282, 155, 385, 82, 
403, 31, 25, 359, 62, 167, 356, 30, 387, 416, 293, 365, 188, 208, 287, 19, 297, 
369, 11, 313, 164, 212, 320, 66, 152, 223, 230, 53, 378, 414, 279, 114, 21, 148,
218, 169, 88, 153, 55, 65, 2, 402, 262, 106, 275, 366, 232, 20, 286, 273, 322, 
143, 183, 75, 129, 127, 397, 400, 182, 69, 13, 373, 239, 100, 219, 307, 289, 
197, 362, 203, 367, 290, 74, 245, 17, 172, 209, 194, 341, 415, 259, 338, 38, 
312, 251, 198, 351, 339, 5, 50, 392, 16, 61, 176, 281, 178, 201, 86, 149, 160, 
85, 119, 28, 353, 310, 330, 128, 145, 347, 396, 407, 331, 10, 371, 241, 51, 144,
238, 372, 196, 376, 191, 175, 57, 185, 87, 94, 202, 370, 390, 63, 225, 154, 131,
9, 237, 243, 220, 33, 97, 319, 180, 134, 256, 227, 14, 96, 171, 298, 377, 173, 
137, 41, 296, 368, 401, 98, 270, 1, 318, 206, 408, 360, 323, 304, 23, 80, 269, 
184, 294, 231, 216, 274, 329, 200, 210, 44, 340, 151, 250, 27, 93, 236, 292, 
226, 411, 280, 316, 45, 135, 123, 163, 187, 254, 308, 126, 327, 125, 335, 110, 
354, 101, 412, 276, 235, 181, 306, 133, 42, 284, 99, 161, 263, 52, 264, 393, 
109, 204, 389, 249, 350, 364, 39, 288, 217, 342, 332, 138, 382, 48, 120, 336, 
130, 157, 192, 413, 76, 205, 383, 215, 95, 158, 156, 92, 89, 136, 379, 246, 141,
247, 132, 261, 3, 73, 260, 111, 49, 228, 32, 195, 177, 300, 278, 36, 344, 68, 
34, 211, 193, 83, 140, 4, 81, 113, 54, 58, 380, 72, 150, 22, 60, 309, 35, 84, 
102, 12, 90, 37, 258, 358, 363, 108, 122, 405, 234, 103, 267, 224, 59, 317, 268,
301, 244, 186, 67, 352, 142, 248, 283, 285, 394, 253, 207, 311, 295, 26, 242, 
386, 406, 6, 410, 24, 107, 257, 118, 355, 56, 388, 15, 233, 8, 29, 375, 409 ];
c := S!
\[2, 1, 5, 4, 3, 8, 10, 6, 13, 7, 15, 17, 9, 20, 11, 23, 12, 25, 27, 14, 30, 32,
16, 35, 18, 37, 19, 39, 41, 21, 31, 22, 45, 47, 24, 50, 26, 53, 28, 56, 29, 58, 
60, 62, 33, 55, 34, 65, 67, 36, 70, 71, 38, 74, 46, 40, 57, 42, 80, 43, 82, 44, 
84, 64, 48, 88, 49, 90, 92, 51, 52, 96, 98, 54, 101, 85, 77, 78, 104, 59, 107, 
61, 110, 63, 76, 113, 115, 66, 118, 68, 97, 69, 122, 94, 106, 72, 91, 73, 127, 
129, 75, 132, 134, 79, 105, 95, 81, 139, 140, 83, 143, 144, 86, 146, 87, 141, 
148, 89, 151, 120, 154, 93, 156, 157, 159, 161, 99, 163, 100, 164, 166, 102, 
169, 103, 170, 172, 137, 174, 108, 109, 116, 177, 111, 112, 180, 114, 182, 117, 
184, 186, 119, 152, 188, 121, 155, 123, 124, 191, 125, 160, 126, 193, 128, 130, 
196, 131, 198, 178, 133, 135, 203, 136, 206, 138, 208, 210, 142, 168, 213, 145, 
181, 147, 217, 149, 220, 150, 222, 153, 224, 225, 158, 228, 162, 215, 231, 165, 
197, 167, 199, 232, 227, 235, 171, 204, 238, 173, 241, 175, 244, 176, 246, 212, 
179, 248, 194, 250, 183, 218, 253, 185, 255, 187, 249, 189, 190, 259, 201, 192, 
263, 230, 195, 200, 233, 269, 202, 271, 273, 205, 276, 278, 207, 280, 264, 209, 
277, 211, 284, 214, 223, 216, 286, 288, 219, 291, 221, 293, 295, 258, 226, 299, 
300, 302, 229, 243, 304, 306, 307, 308, 234, 310, 236, 312, 237, 314, 316, 239, 
245, 240, 279, 242, 319, 315, 321, 247, 323, 251, 324, 252, 326, 327, 254, 330, 
256, 331, 257, 296, 334, 336, 260, 261, 301, 262, 328, 265, 340, 266, 267, 268, 
343, 270, 325, 272, 348, 274, 282, 275, 349, 341, 281, 354, 283, 350, 285, 287, 
311, 289, 290, 303, 360, 292, 294, 332, 364, 297, 347, 298, 367, 368, 370, 305, 
318, 342, 309, 344, 345, 346, 335, 313, 317, 322, 378, 361, 377, 320, 381, 356, 
384, 366, 386, 329, 352, 388, 390, 333, 365, 358, 337, 338, 379, 339, 396, 397, 
398, 383, 395, 385, 353, 351, 369, 402, 355, 403, 374, 357, 376, 359, 387, 362, 
393, 363, 405, 406, 389, 408, 375, 371, 372, 373, 400, 399, 401, 380, 382, 413, 
391, 392, 412, 394, 414, 410, 411, 407, 404, 409, 416, 415 ];

    simp := sub<S|a,b>;
    simp`Order := 251596800;
    F, phi := FPGroupStrong(simp);
    soc := Socle(group);
    aut := Index(group, soc);
    if Print gt 1 then printf "group is G(2,4):[%o]\n", aut; end if;
    ga, gb:= get_standard_gens_g24(soc);
    soc := sub< soc | ga,gb >;
    soc`Order := 251596800;
    newgens := [ group | ga, gb];
    for g in Generators(group) do
       if not g in sub<group|newgens> then Append(~newgens,g); end if;
    end for;
    group := sub<group|newgens>;
    ag24 := sub< S | a, b, c >;
    ims := [ ag24 | a, b];
    homom :=  hom< soc -> simp | ims >;
    for i in [Ngens(soc)+1..Ngens(group)] do
        g := group.i;
        CG := ag24; ce := Id(ag24);
        for j in [1..2] do
            isc, h := IsConjugate(CG,simp.j^ce,homom(soc.j^g));
            if not isc then error "Conjugation error in Aut(G(2,4))"; end if;
            CG := Centraliser(CG,homom(soc.j^g));
            ce := ce*h;
        end for;
        Append(~ims,ce);
    end for;
    newgens := ims;
    for g in Generators(ag24) do
        if not g in sub<ag24|ims> then Append(~ims,g); end if;
    end for;
    ag24 := sub< S | ims >;
    homom :=  hom< group -> ag24 | newgens >;

    maximals:= [];
    if not max then 
        return homom, ag24, maximals, F, phi;
    end if;
    
    /* 
       Maximal subgroups from Birmingham web page.
       If their list is complete then all is well.
       The below have all been tested for maximality using IsMaximal,
       and each M is simp-conjugate to M^c.
       The two with the same order (184320) have different chief factors.
       Generators as words in a,b by Bill Unger. They have no particular 
       merit, apart from giving the right groups.
    */ 

    // J2 [point stabilizer]
    M := sub<simp|a, b^(a*b*a*b^2)>;
    M`Order := 604800;
    Append(~maximals, M); 

    // 2^(4+6):(A5 x 3) [2^(4+6) normal in 2-Sylow]
    M := sub<simp|
	a ^ (b^2 * a * b^-1), 
	a * b^2 * a * b^-2 * a * b * a * b * a * b^2 >;
    M`Order := 184320;
    Append(~maximals, M); 

    // 2^(2+8):(A5 x 3) [2^(2+8) normal in 2-Sylow]
    M := sub<simp|
	b * a * b^-2 * a * b * a * b^-2 * a * b,
	a * b * a * b * a * b * a * b * a * b^-1 >;
    M`Order := 184320;
    Append(~maximals, M); 
    
    // U(3,4):2 
    M := sub<simp|
	b^-1 * a * b^2 * a * b^-1, 
	a * b * a * b * a * b * a * b^-1 * a * b^2 * a * b^2 * a >;
    M`Order := 124800;
    Append(~maximals, M); 

    // 3.L(3,4):2 [Normalizer of subgrp of order 3]
    M := sub<simp | a, b * a * b^-1 * a * b^2 * a * b^2 * a * b^2 >;
    M`Order := 120960;
    Append(~maximals, M); 

    // U3(3):2 [Centralizer of an outer involution]
    M := sub<simp|
	a * b * a * b^2 * a * b^-1 * a * b^2 * a * b^-1 * a * b * a * 
	    b * a * b,
	a * b^-1 * a * b * a * b * a * b^-2 * a * b * a * b * a * b^-1>;
    M`Order := 12096;
    Append(~maximals, M); 

    // A5 x A5  
    M := sub<simp|
	b^2 * a * b^2 * a * b^-2 * a * b^-1 * a * b * a * b^2 * a * b * a,
	b^-1 * a * b^2 * a * b^-1 * a * b * a * b * a * b * a * b^-2 * a * 
	    b * a >;
    M`Order := 3600;
    Append(~maximals, M);

    // L(2,13) 
    M := sub<simp|
	a * b^-1 * a * b * a * b * a * b^-2 * a * b^-1 * a * b^-1 * a * b * 
	    a * b * a * b^-2,
	b^-2 * a * b^-2 * a * b^-1 * a * b^2 * a * b * a * b^2 
	    * a * b^2 * a * b * a * b^-1 >;
    M`Order := 1092;
    Append(~maximals, M);

    return homom, ag24, maximals, F, phi;
end function;