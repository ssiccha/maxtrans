freeze;

/*
 * This file MUST be rechecked when constructive recognition is put in
 for higher values of q, it currently only runs for q = 4,5,7
 */


/*
This file contains the functions for computing maximal subgroups of
any almost simple group with socle PSU(4, p^e), p^e>2 and either $e$
is even or $e = 1$ or $p = 2$. This covers all groups whose minimal
degree representation is of degree less than 10^7.
In the prime case we distinguish between the following extensions:

(p+1, 4) = 2: Here out = 2^2, we have "psu", "pgu", "psigmau" and
"aut" only: the group PSU.2_3 has the same subgroup conjugacy as PGU,
so we do not bother distinguishing between them.

(p+1, 4) = 4: Here Out = D_8. We have
"psu", 
"psu.2_1" (this is half of PGU), "psigmau", "psu.2_3" (the
outer element here is a product of .2_2 with the element that extends from
psu to pgu) : all of these extensions have order 2.
"pgu", "psu.2_12", "psu.2_13": these are extensions of order 4. the
second two both have a 2^2 on the outside. In the first case it is
generated by <.2_1, .2_2> and in the second by <.2_1, 2_3>. 
"aut";

If (q neq p) and q is even then we simply have type "psu".

If (q \neq p) and (4, q+1) = 2 then we have types "psu" and "aut": 
if $PSU \leq G \leq PSigmaU$ then type is "psu"; otherwise it's "aut".

If (q \neq p) and (4, q+1) = 4 then there are four types: "psu",
"twoorth+", "twoorth-" and "aut". "twoorth+" groups are $G$ st $PSU.2_1
< G \leq PSU.<2_1, 2_2>$. "twoorth-" group are $G$ st $PSU.2_1 < G \leq
PSU.<2_1, 2_2*4^{-1}>.  

/*******************************************************************/

//function names:
//A7(p)
//Getsl27d4
//U4_2(p)
//L3_4()
//SigmaGrp(extension, p, e)
//WhichGroup(group, p, e)
//U4pMaximals(group, p)
//U4qMaximals(group, q)

/********************************************************************/

import "unitreds.m": IsotropKStab, NonisotropKStab;
import "unitimps.m": StandardUnitImps, UnitImpHalfDim;
import "subfield.m": SpInSU, OrthsInSU, SubfieldSU; 
import "superfield.m": ConjIntoSU;
import "normes.m": NormaliserOfSymplecticGroup;
import "select_conj.m": SelectGroupGeneral;
import "psu3q.m": OuterInvol;
import "construct.m": ReduceOverFiniteField;

/*******************************************************************
* 2.Alt(7) is a maximal C_9 group of SU(4, p) for p gt 7 and       *
* -7 a nonsquare in GF(p)                                          *
*******************************************************************/

function A7(p)

  assert IsPrime(p);

  if p eq 3 then
    grp:= MatrixGroup<4, GF(3, 2) |
    [ W^2, W^7, 2, W^7, W^7, W, W^2, W^6, W^2, W, 2, W^5, W^5, W^3, W^2, 
    W^6 ] where W := GF(3, 2).1,
    [ W^5, 0, W^3, W^7, W^7, W^3, W, W^5, W^7, W^5, W^2, 1, 1, 2, W^3, 2 ]
    where W := GF(3, 2).1
        /* order = 10080 = 2^5 * 3^2 * 5 * 7 */ >;
    return grp;
  end if;

  if p eq 5 then
    grp:=  MatrixGroup<4, GF(5, 2) |
    [ 0, W^4, 0, W^15, W^14, 0, W^9, 0, W^17, W^15, 4, W^8, W^9, W, W^10, 
    4 ] where W := GF(5, 2).1,
    [ W^3, 1, W^2, W^21, W^13, 1, 0, 0, W^22, W^20, W^15, W^17, 4, 2, 
    W^23, 3 ] where W := GF(5, 2).1
        /* order = 5040 = 2^4 * 3^2 * 5 * 7 */ >;
    return grp;
  end if;

  assert not IsSquare(GF(p)!-7);
  assert p gt 7;
  
  sl:= SL(4, p^2);
  i7:= SquareRoot(GF(p^2)!(-7));
  b7 := GF(p^2)!((-1+i7)/2);
  x := GF(p^2)!((i7+3)/4);
  y := GF(p^2)!(b7/2);

  C := sl![0,0,1,0, 0,0,0,1, -1,0,-1,0, 0,-1,0,-1];
  D := sl![0,-x,x,-y, -y,y,-y,0, -y,0,(-i7-1)/2,-x, 0,-y,y,y];
  G := sub<sl|C,D>;

  is_unitary, f:= UnitaryForm(G);
  assert is_unitary;
  mat1:= CorrectForm(f, 4, p^2, "unitary");
  mat2:= CorrectForm(Matrix( GF(p^2),4,4,[0,0,0,1, 0,0,1,0, 0,1,0,0, 1,0,0,0] ),
                       4, p^2, "unitary");
  
  return G^(mat1*mat2^-1);
end function;

/**********************************************************************/

Getsl27d4:= function(p)

_LR := rec < recformat< F: GrpFP, AI: SeqEnum, G: GrpMat > |
      F := FreeGroup(2) >;
_LR`AI := [ [a^-1, b^-1] ] where a is (_LR`F).1 where b is (_LR`F).2;
//two constituents interchanged by _LR`AI[1][1]

_LR`G := sub<GL(8,Integers()) |
    \[ 0, 1, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 
    0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 
    0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0 ],
    \[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
    0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 
    0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0 ] >;

L:=  ReduceOverFiniteField(_LR, p^2);
c9:=L[1];
//just testing this for now, delete later.
assert IsAbsolutelyIrreducible(c9) and (not IsSemiLinear(c9)) and
      IsPrimitive(c9) and (not IsTensor(c9));
bool, f1:= UnitaryForm(c9);
assert bool;
mat:= TransformForm(c9);
return c9^mat;
end function;
/************************************************************************/
/* 
 * We find a maximal C_9 subgroup isomorphic to U_(4, 2) = Sp(4, 3)
 * whenever the p+1 mod 3 eq 0.
 */

function U4_2(p)

  assert IsPrime(p);
  //assert p gt 3;
  assert (p+1) mod 3 eq 0;

  gamma:= PrimitiveElement(GF(p^2));
  omega:= gamma^((p^2-1) div 3);
  g1:= GF(p^2)!((2 + omega)/3);
  g2:= GF(p^2)!((1 - omega)/3);
  f1:= GF(p^2)!((1 + 2*omega^2)/3);
  f2:= GF(p^2)!((1 - omega^2)/3);
  a:= GL(4, p^2)!DiagonalMatrix([1, 1, omega, 1]);
  b:= GL(4, p^2)!
  [ 1,  0,  0,  0, 0, f1, f2, f2, 0, f2, f1, f2, 0, f2, f2, f1];
  c:= GL(4, p^2)!
  [ g1, 0, -g2, g2,0, 1,   0,  0, -g2, 0,  g1, g2, g2, 0,  g2, g1];

  grp:= sub<GL(4,p^2)|a, b, c>;
  newgrp:=  DerivedSubgroup(grp);
  assert #newgrp eq 51840;
  is_unitary, f:= UnitaryForm(newgrp);
  assert is_unitary;
  m1:= CorrectForm(f, 4, p^2,"unitary");
  m2:= CorrectForm(Matrix(GF(p^2),4,4,[0,0,0,1, 0,0,1,0, 0,1,0,0, 1,0,0,0] ),
                   4, p^2, "unitary");
  return newgrp^(m1*m2^-1);
end function;

/************************************************************************/

//Maximal C_9 of U_4(3).

function L3_4()
  g:=  MatrixGroup<4, GF(3, 2) |
    [ 0, 2, 0, W^6, 0, W^3, 0, 1, W^2, W^7, 2, W^7, W^3, 1, W^6, W ] where 
    W := GF(3, 2).1,
    [ W^7, 2, W^3, W^6, W^2, 2, W^6, 0, W^2, 0, 2, 0, W^7, W^2, W, 2 ] 
    where W := GF(3, 2).1
        /* order = 80640 = 2^8 * 3^2 * 5 * 7 */ >;
  return g;
end function;



/************************************************************************/

function SigmaGrp(extension, p, e)
  biggrp:= PSigmaU(4, p^e);
  norms:= NormalSubgroups(biggrp: OrderEqual:= #PSU(4,
    p^e)*extension);
  assert #norms eq 1;
  return norms[1]`subgroup;
end function;

/*********************************************************************/

function WhichGroup(group, p, e)
  assert e eq 1 or IsEven(e) or IsEven(p); 
  q:= p^e;
  soc:= Socle(group);
  if group eq soc then
    return group, "psu";
  end if;

  d:= Gcd(q+1, 4);
  if d eq 1 then
    assert IsEven(p) and e gt 1;
    return soc, "psu";
  end if;

  out, f:= quo<group|soc>;
  if #out eq d*e*2 then
    return soc, "aut";
  end if;

  if e eq 1 and d eq 2 then
    assert #out eq 2; //owise have psu or aut(psu)  
    s2:= SylowSubgroup(group, 2);
    s2_sigma:= SylowSubgroup(PSigmaU(4, q), 2);    
    if #Center(s2) eq #Centre(s2_sigma) then //I think this is the
                                       //cheapest reliable test.
      return soc, "psigmau";
    else
      s2_pgu:= SylowSubgroup(PGU(4, q), 2);
      pcs2:= PCGroup(s2);
      pc_s2_pgu:= PCGroup(s2_pgu);
      a, b:= IsIsomorphic(pcs2, pc_s2_pgu);
      if a then 
        return soc, "pgu"; 
      else
        return soc, "psu.2_3";
      end if;
    end if;
  end if;

  if e eq 1 and d eq 4 then
    if #out eq 2 then
      s2:= SylowSubgroup(group, 2);
      s2sig:= SylowSubgroup(PSigmaU(4, q), 2);
      cl_grp:= Classes(s2);
      cl_sig:= Classes(s2sig);       
      data:= [<cl_grp[i][1], cl_grp[i][2]>:i in[1..#cl_grp]];
      if data eq [<cl_sig[i][1], cl_sig[i][2]>: i in [1..#cl_sig]] then
        return soc, "psigmau";
      end if;
      p, psu2_1:= OrbitAction(sub<GL(4, q^2)|SU(4, q), (GU(4,
                   q).1)^2>, sub<RSpace(GL(4, q^2))|[1, 0, 0, 0]>);
      s2_2_1:= SylowSubgroup(psu2_1, 2);
      cl_2_1:= Classes(s2_2_1);
      if data eq [<cl_2_1[i][1], cl_2_1[i][2]>: i in [1..#cl_2_1]] then 
        return soc, "psu.2_1";
      else
        return soc, "psu.2_3";
      end if;
    end if;
    assert #out eq 4;
    if IsCyclic(out) then
      return soc, "pgu"; 
    end if;
    subs:= Subgroups(out : OrderEqual:= 2);
    assert #subs eq 3;
    for i in [1..3] do
      soc, type:= WhichGroup(subs[i]`subgroup@@f, p, e);
      if "psigmau" eq type then
        return soc, "psu.2_12";
      elif "psu.2_3" eq type then
        return soc, "psu.2_13";
      end if;
    end for;
  end if;

  assert e gt 1 and IsOdd(p);

  if d eq 2 then
    if IsOdd(e) then
      if IsOdd(#out) then
        return soc, "psu"; //has same fusion as psu;
      else
        return soc, "aut"; //has same fusion as aut;  
      end if;
    end if;
    if not IsCyclic(out) then
      return soc, "aut";
    end if;
    sigmagrp:= SigmaGrp(#out, p, e);
    s2:= SylowSubgroup(group, 2);
    s2sigma:= SylowSubgroup(sigmagrp, 2);
    assert #s2 eq #s2sigma;
    cl_grp:= Classes(s2);
    cl_sig:= Classes(s2sigma);
    data_grp:= [<cl_grp[i][1], cl_grp[i][2]> : i in [1..#cl_grp]];
    data_sig:= [<cl_sig[i][1], cl_sig[i][2]>: i in [1..#cl_sig]];
    if data_grp eq data_sig then
      return soc, "psu";
    else
      return soc, "aut";
    end if;
  end if;
  "error: we should have PSU(4, p) or PSU(4, 2^e) or PSU(4, p^e)";
  "where e is even";
  return 0, _;

end function;

//Homomorphism function - currently only works for q=4,5,7.
//can hopefully use Brooksbank's method for other  q  later.
MakeHomom:= function(group, q, psu, apsu : Print:=0)
  local GtoPSU, homom, ims, a, b, a1, b1, imconj,
    g, newgens, subsoc, subgp, psugens, imgens, CG, ce, isc, h, socle, found;

  soc := Socle(group);

  /* find standard generators in soc and in psu if the different cases.*/
  if q eq 4 then
    o:=1; while o ne 20 and o ne 30 do a:=Random(soc); o:=Order(a); end while;
    a:= a^(o div 2);
    found := false;
    while not found do
      o:=1; while o ne 4 do b:=Random(soc); o:=Order(b); end while;
      for i in [1..50] do
         if Order(a*b) eq 20 then found:=true;  break; end if;
         b:=b^Random(soc);
      end for;
    end while;
    o:=1;
    while o ne 20 and o ne 30 do a1:=Random(psu); o:=Order(a1); end while;
    a1:= a1^(o div 2);
    found := false;
    while not found do
      o:=1; while o ne 4 do b1:=Random(psu); o:=Order(b1); end while;
      for i in [1..50] do
         if Order(a1*b1) eq 20 then found:=true;  break; end if;
         b1:=b1^Random(psu);
      end for;
    end while;
  elif q eq 5 then
    o:=1;
    while o ne 8 and o ne 24 and o ne 60 do
      a:=Random(soc); o:=Order(a);
    end while;
    b:= a^(o div 4);
    a:= a^(o div 2);
    while Order(a*b) ne 9 do b:=b^Random(soc); end while;
    o:=1; while o ne 8 and o ne 24 and o ne 60 do
      a1:=Random(psu); o:=Order(a1);
    end while;
    b1 := a1^(o div 4);
    a1:= a1^(o div 2);
    while Order(a1*b1) ne 9 do b1:=b1^Random(psu); end while;
  elif q eq 7 then
    o:=1;
    while o ne 56 and o ne 48 do
      a:=Random(soc); o:=Order(a);
    end while;
    b:= a^(o div 4);
    a:= a^(o div 2);
    while Order(a*b) ne 15 or Order((a,b)) ne 24 do b:=b^Random(soc);
    end while;
    o:=1;
    while o ne 56 and o ne 48 do
      a1:=Random(psu); o:=Order(a1);
    end while;
    b1:= a1^(o div 4);
    a1:= a1^(o div 2);
    while Order(a1*b1) ne 15 or Order((a1,b1)) ne 24 do b1:=b1^Random(psu);
    end while;
  end if;

  newgens:=[group|a,b];
  soc := sub<soc | newgens>;
  subgp := soc;
  for g in Generators(group) do
   if not g in subgp then Append(~newgens,g);
     subgp := sub< group | newgens >; RandomSchreier(subgp);
   end if;
  end for;
  group := subgp;
  GtoSU := hom<soc->psu | a1,b1>;

  psugens := [apsu|a1,b1];
  //Now identify images of all generators of group in apsu.
  ims := psugens;
  for i in [Ngens(soc)+1..Ngens(group)] do
      g := group.i;
      CG := apsu; ce := Id(apsu);
      for j in [1.. #psugens] do
        imconj := GtoSU(soc.j^g);
        isc, h := IsConjugate(CG,psugens[j]^ce,imconj);
        if not isc then error "Conjugation error in Aut(PSU(d,q))"; end if;
        CG := Centraliser(CG,imconj);
        ce := ce*h;
      end for;
      Append(~ims,ce);
  end for;
  return hom< group -> apsu | ims >, soc, group;
end function;

/************************************************************************/

forward MakeSU4HomomGeneral;

function U4pIdentify(group, p: max:= true, Print:=0)
  assert IsPrime(p);
  assert p gt 2;

  if Print gt 1 then "making standard group"; end if;
  gu := GU(4,p);
  su := SU(4,p);
  apsu := PGammaU(4,p);
  factor := hom< gu->apsu | [apsu.i :  i in [1..Ngens(gu)]] >;
  psu := su @ factor;

  if Print gt 1 then "setting up isomorphism"; end if;
  homom, soc, group :=
         MakeSU4HomomGeneral(group, p, 1, psu, apsu, factor : Print:=Print);

  if Print gt 1 then print "Calling FPGroupStrong"; end if;
  F, phi := FPGroupStrong(sub< psu | [ soc.i @ homom : i in [1..Ngens(soc)] ]>);

  if (p+1) mod 2 eq 0 then
    gens := [apsu|homom(group.1), homom(group.2), apsu.1, apsu.3];
  else gens := [apsu|homom(group.1), homom(group.2), apsu.3];
  end if;
  apsu := sub<apsu|gens>;

  maximals:= [];
  if not max then
    return homom, apsu, maximals, F, phi;
  end if;

  d:= Gcd(p+1, 4);
  soc, type:= WhichGroup(group, p, 1);
  if Print gt 1 then "type =", type; end if;

  z:= PrimitiveElement(GF(p^2));
  
  if not type in {"aut", "pgu"} then
    d_cyc:= (GL(4, p^2)!DiagonalMatrix([z, 1, 1, z^-p])) @ factor;
    if type eq "psigmau" and d eq 4 then
      out_invol:= OuterInvol(group, soc) @ homom;
    end if;
  end if;
 
  if Print gt 1 then "getting reducibles"; end if;
  //Append(~maximals, Stabiliser(psu, 1));
  Append(~maximals, IsotropKStab(4, p, 1)@factor);
  Append(~maximals, IsotropKStab(4, p, 2)@factor);
  Append(~maximals, NonisotropKStab(4, p, 1)@factor);

  if Print gt 1 then "getting imprimitives"; end if;
  Append(~maximals, StandardUnitImps(4, p, 2)@factor);
  if p gt 3 or type in  {"pgu", "psu.2_3", "psu.2_13", "aut"} then//NOVELTY!!
    Append(~maximals, StandardUnitImps(4, p, 1)@factor);
    Append(~maximals, UnitImpHalfDim(4, p)@factor);
  end if;

  if d eq 2 then //p = 1 mod 4.
    //no possibility for subgrp_copies to be greater than d.
    if Print gt 1 then "getting subfields"; end if;
    if type in {"psu", "psigmau"} then
      symp:= SpInSU(4, p);
      Append(~maximals, symp@factor);
      Append(~maximals, (symp@factor)^d_cyc);
    end if;
    oplus, ominus:= OrthsInSU(4, p);
    Append(~maximals, oplus@factor);
    Append(~maximals, ominus@factor);
  else //(p+1, 4) = 4.
    if Print gt 1 then "getting subfields"; end if;
    subfields:= [];
    oplus, ominus:= OrthsInSU(4, p);
    sp:= SpInSU(4, p);
    if type in {"psu", "psu.2_1"} then
      if p gt 3 then subfields:= [sp, oplus, ominus];
      else subfields:= [sp, ominus];
      end if;
    elif type in {"psigmau", "psu.2_12"}  then
      if p gt 3 then subfields:= [sp, oplus];
      else subfields:= [sp];
      end if;
    elif type in {"psu.2_3", "psu.2_13"} then
      subfields:= [ominus];
    end if;
    if #subfields gt 0 then
      for x in subfields do
        Append(~maximals, x@factor);
        Append(~maximals, (x@factor)^d_cyc);
      end for;
    end if;
  end if;

  if d eq 4 then
    if p mod 8 eq 7 and type in {"psu", "psigmau"} then
      if Print gt 1 then "getting extraspecials"; end if;
      extra:= NormaliserOfSymplecticGroup(4, p^2);
      mat:= ConjIntoSU(extra, 4, p);
      extra:= extra^mat;
      if type eq "psu" then
        for i in [0..3] do
          Append(~maximals,(extra@factor)^(d_cyc^i));
        end for;
      else
        //we should get 2 copies selected out of the 4 possibles.
        grps:= SelectGroupGeneral(psu,extra@factor,d_cyc,out_invol);
        maximals:= maximals cat [grps,grps^(d_cyc^2)];
      end if;
    elif p mod 8 eq 3 and type in {"psu", "psu.2_1", "psigmau", 
                                                       "psu.2_12"} then
      if Print gt 1 then "getting extraspecials"; end if;
      extra1:= NormaliserOfSymplecticGroup(4, p^2);
      extra2:= DerivedSubgroup(extra1);
      mat:= ConjIntoSU(extra2, 4, p);
      extra:= extra2^mat; 
      Append(~maximals, extra@factor);
      Append(~maximals, (extra@factor)^d_cyc);
    end if;
  end if;

  if d eq 2 and type in {"psu", "psigmau", "psu.2_3"} then
    if (p mod 7) in {3, 5, 6} and type in {"psu", "psigmau"} then
      if Print gt 1 then "getting A_7"; end if;
      A_7:= A7(p);
      Append(~maximals, A_7@factor);
      Append(~maximals, (A_7@factor)^d_cyc);
    end if;
    if ((p mod 7) in {3,5,6}) and ((p mod 8) eq 1) and (type eq "psigmau") then
      if Print gt 1 then "getting 2L_2(7) novelty"; end if;
      sl27:= Getsl27d4(p);  
      Append(~maximals, sl27@factor);
      Append(~maximals, (sl27@factor)^d_cyc);
    elif ((p mod 7) in {3,5,6}) and ((p mod 8) eq 5) and 
         (type eq "psu.2_3") then        
      if Print gt 1 then "getting 2L_2(7) novelty"; end if;
      sl27:= Getsl27d4(p);  
      Append(~maximals, sl27@factor);
      Append(~maximals, (sl27@factor)^d_cyc);
    end if;
    if (p mod 6) eq 5 and not (type eq "psu.2_3") then
      if Print gt 1 then "getting U4_2"; end if;
      u4_2:= U4_2(p);
      Append(~maximals, u4_2@factor);
      Append(~maximals, (u4_2@factor)^d_cyc);
    end if;
  elif d eq 4 then
    if type in {"psu", "psigmau"} then
      c9:= [];
      if (p mod 7) in {3, 5, 6} then
        if Print gt 1 then "getting a7"; end if;
        c9:= [A7(p)];
      end if;
      if (p mod 6) eq 5 then
        if Print gt 1 then "getting u4_2"; end if;
        Append(~c9, U4_2(p));
      end if;
      if #c9 gt 0 then
        for x in c9 do
          if type eq "psu" then
            for i in [0..3] do
              Append(~maximals, (x@factor)^(d_cyc^i));
            end for;
          else //type eq "psigmau";
            grps:= SelectGroupGeneral(psu, x@factor, d_cyc, out_invol);
            maximals:= maximals cat [grps,grps^(d_cyc^2)];
          end if;
        end for;
      end if;
    end if;
    if (p mod 7) in {3,5,6} and (p gt 3) and type in {"psigmau",
         "psu.2_3"} then
      if ((p mod 8) eq 3 and type eq "psigmau") or ((p mod 8) eq 7 and
          type eq "psu.2_3") then
        if Print gt 1 then "getting novelty SL_2(7)"; end if;
        c9:= Getsl27d4(p);
        grps:= SelectGroupGeneral(psu, c9@factor, d_cyc, out_invol);
        maximals:= maximals cat [grps, grps^(d_cyc^2)];
      end if;
    end if;
    if p eq 3 and type in {"psu", "psu.2_1", "psu.2_3", "psu.2_13"}
       then
      if Print gt 1 then "getting L_3(4)"; end if;
      l3_4:= L3_4();
      Append(~maximals, l3_4@factor);
      Append(~maximals, (l3_4@factor)^d_cyc);
    end if;
  end if;
        
  return homom, apsu, maximals, F, phi;

end function;

/*********************************************************************/     

function U4qIdentify(group, q: max:= true, Print:=0)
  fac:= Factorisation(q);
  assert #fac eq 1;
  p:= fac[1][1];
  e:= fac[1][2];
  assert IsEven(e) or e eq 1 or IsEven(p);

  if e eq 1 then 
    return U4pIdentify(group, q: max:= max, Print:=Print);
  end if;

  if Print gt 1 then "making standard group"; end if;
  gu := GU(4,q);
  su := SU(4,q);
  apsu := PGammaU(4,q);
  factor := hom< gu->apsu | [apsu.i :  i in [1..Ngens(gu)]] >;
  psu := su @ factor;

  if Print gt 1 then "setting up isomorphism"; end if;
  homom, soc, group :=
         MakeSU4HomomGeneral(group, p, e, psu, apsu, factor : Print:=Print);

  if Print gt 1 then print "Calling FPGroupStrong"; end if;
  F, phi := FPGroupStrong(sub< psu | [ soc.i @ homom : i in [1..Ngens(soc)] ]>);

  if (q+1) mod 2 eq 0 then
    gens := [apsu|homom(group.1), homom(group.2), apsu.1, apsu.3];
  else gens := [apsu|homom(group.1), homom(group.2), apsu.3];
  end if;
  apsu := sub<apsu|gens>;

  maximals:= [];
  if not max then
    return homom, apsu, maximals, F, phi;
  end if;

  d:= Gcd(q+1, 4);
  soc, type:= WhichGroup(group, p, e);
  if Print gt 1 then "type =", type; end if;

  z:= PrimitiveElement(GF(q^2));
  
  if not type in {"aut", "pgu"} and IsOdd(q) then
    d_cyc:= (GL(4, q^2)!DiagonalMatrix([z, 1, 1, z^-q])) @ factor;
  end if;
 
  if Print gt 1 then "getting reducibles"; end if;
  Append(~maximals, Stabiliser(psu, 1));
  Append(~maximals, IsotropKStab(4, q, 2)@factor);
  Append(~maximals, NonisotropKStab(4, q, 1)@factor);

  if Print gt 1 then "getting imprimitives"; end if;
  Append(~maximals, StandardUnitImps(4, q, 1)@factor);
  Append(~maximals, StandardUnitImps(4, q, 2)@factor);
  Append(~maximals, UnitImpHalfDim(4, q)@factor);

  if Print gt 1 then "getting subfields"; end if;
  if e gt 2 then
    fac_e:= Factorisation(e);
    if fac_e[1][1] eq 2 then
      fac_e:= [x: x in fac_e | not x eq fac_e[1]];
    end if;
    for x in fac_e do
      f:= e div x[1];
      grp:= SubfieldSU(4, p, e, f);
      Append(~maximals, grp@factor);
    end for;
  end if;

  if d eq 1 then
    sp:= SpInSU(4, q);
    Append(~maximals, sp@factor);
  elif d eq 2 then
    if type in {"psu", "psigmau"} then
      sp:= SpInSU(4, q);
      Append(~maximals, sp@factor);
      Append(~maximals, (sp@factor)^d_cyc);
    end if;
    oplus, ominus:= OrthsInSU(4, q);
    Append(~maximals, oplus@factor);
    Append(~maximals, ominus@factor);
  else
    subfields:= [];
    if type in {"psu", "twoorth+", "twoorth-"} then
      Append(~subfields, SpInSU(4, q));
      oplus, ominus:= OrthsInSU(4, q);
      if type in {"psu", "two_orth+"} then
        Append(~subfields, oplus);
      end if;
      if type in {"psu", "two_orth-"} then
        Append(~subfields, ominus);
      end if;
      for x in subfields do
        Append(~maximals, x@factor);
        Append(~maximals, (x@factor)^d_cyc);
      end for;
    end if;
  end if;

 return homom, apsu, maximals, F, phi;

end function;

MakeSU4HomomGeneral :=
                  function(group, p, e, psu, apsu, factor : Print:=0)
  local works, GtoSU, SUtoG, mat, homom, ims,
    g, newgens, subsoc, subgp, psugens, imgens, CG, ce, isc, h, socle;

  soc := Socle(group);
  /* Reduce number of generators of soc, and
   * rearrange generators of group to get those of soc coming first
   */
  d:=4;
  repeat
    newgens := [ group | Random(soc), Random(soc) ];
    subsoc := sub<soc|newgens>; RandomSchreier(subsoc);
  until subsoc eq soc;
/*
  while subsoc ne soc do
    x:=Random(soc);
    while x in subsoc do x:=Random(soc); end while;
    Append(~newgens,x); subsoc := sub<soc|newgens>; RandomSchreier(subsoc);
  end while;
*/
  soc := subsoc;
  subgp := subsoc;
  for g in Generators(group) do
   if not g in subgp then Append(~newgens,g);
    subgp := sub< group | newgens >; RandomSchreier(subgp);
   end if;
  end for;
  group := subgp;

  works := false;
  while not works do works, GtoSU := RecogniseSU4(soc,p^e); end while;
  psugens := [];
  for  i in [1..Ngens(soc)] do
      mat := GtoSU(soc.i);
      Append(~psugens,mat@factor);
  end for;
  //Now identify images of all generators of group in apsu.
  ims := psugens;
  for i in [Ngens(soc)+1..Ngens(group)] do
      g := group.i;
      CG := apsu; ce := Id(apsu);
      for j in [1.. #psugens] do
        mat := GtoSU(soc.j^g);
        isc, h := IsConjugate(CG,psugens[j]^ce,mat@factor);
        if not isc then error "Conjugation error in Aut(PSU(d,q))"; end if;
        CG := Centraliser(CG,mat@factor);
        ce := ce*h;
      end for;
      Append(~ims,ce);
  end for;
  return hom< group -> apsu | ims >, soc, group;
end function;