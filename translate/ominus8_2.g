#  File converted from Magma code -- requires editing and checking
#  Magma -> GAP converter, version 0.43, 4/04/16 by AH

#  Global Variables used: Append, Centraliser, FPGroupStrong, FindGoodGens,
#  Generators, GetGroups, Id, IsConjugate, IsEven, Ngens, Order, Random, Socle,
#  Sym, homom

#  Defines: FindGoodGens, GetGroups, OMinus8_2Identify

DeclareGlobalFunction("OMinus8_2Identify@");

#  function names
#  FindGoodGens(group)
#  OMinus8_2Maximals(group)
GetGroups@:=function()
local 
   invol,isotrop_line,isotrop_plane,isotrop_point,l2_7,nonisotrop_four,
   nonisotrop_line,nonisotrop_point,omega,superfield;
  omega:=SubPermutationGroup(119,[(1,78)(2,89)(3,55)(4,24)(5,39)(6,34)(7,38)
   (8,100)(9,99)(10,77)(11,62)(12,74)(13,69)(14,111)(15,48)(16,54)(17,57)(18,70)
   (19,67)(20,63)(21,46)(22,81)(23,75)(25,61)(26,64)(27,117)(28,29)(30,44)
   (31,104)(32,85)(33,41)(35,93)(36,50)(37,86)(40,98)(42,110)(43,105)(45,96)
   (47,109)(49,91)(51,92)(56,95)(58,68)(59,80)(65,73)(66,114)(71,76)(72,113)
   (83,118)(84,103)(87,107)(90,112)(94,106)(97,101)(102,108)(115,119),(1,105,28)
   (2,67,57)(3,43,102)(4,16,61)(5,21,96)(6,59,45)(7,87,100)(8,35,109)(9,106,58)
   (10,24,119)(11,25,38)(12,73,13)(14,32,27)(15,118,22)(17,104,56)(18,111,49)
   (19,40,51)(20,26,76)(23,42,54)(29,79,47)(30,80,41)(31,68,48)(33,99,84)
   (37,52,55)(39,72,71)(44,50,83)(46,81,88)(53,89,90)(60,69,75)(62,65,108)
   (63,77,112)(64,98,82)(66,97,94)(70,101,107)(74,92,85)(78,110,117)(86,93,91)
   (95,116,115)(103,113,114)]);
  invol:=(2,27)(7,35)(9,102)(13,68)(14,88)(15,78)(16,119)(17,116)(20,58)(23,52)
   (24,83)(28,48)(31,70)(32,60)(36,112)(39,66)(41,117)(42,49)(45,54)(50,97)
   (56,108)(61,93)(71,91)(74,104)(80,103)(84,106)(100,118)(109,114) #CAST 
   SymmetricGroup(119)
    ;
  isotrop_point:=SubPermutationGroup(119,[(2,22,86,8,9,5,20,72,87,94,42,47)
   (3,78,71,41,16,63,92,119,100,61,15,101)
   (4,113,32,13,106,52,110,10,23,112,56,60)
   (6,118,99,75,81,117,46,91,59,85,43,93)(7,57,24,55,62,33,97,111,80,26,67,69)
   (11,79,19)(12,18,115)(14,51,25,88,27,49,17,40,90,116,58,102)
   (21,74,48,34,45,104)(28,54,82,70,31,53)(29,64,108,44,36,38,96,98,84,30,68,89)
   (35,39,77,95,66,103,50,109,105,76,114,83)(37,65,107)
   ,(2,25,117,6,78,5,61,91,71)(3,18,42,100,22,94,16,72,119)
   (4,68,77,48,23,52,66,37,74)(7,105,29,45,108,84,107,83,32)
   (8,115,51,41,86,12,15,85,101)(9,47,116,46,49,20,58,118,92)
   (10,13,64,30,67,113,57,104,69)(11,93,27,99,43,14,59,88,90)
   (17,87,40,81,79,63,102,75,19)(21,96,103,82,80,73,95,28,39)
   (24,109,33,112,106,34,26,62,111)(31,53,54,35,98,70,65,44,89)
   (36,97,60,56,50,114,110,38,55)]);
  #   order = 1658880 = 2^12 * 3^4 * 5 
  nonisotrop_point:=SubPermutationGroup(119,[(1,25,47,34,97,86,54,49,114,74,22,
   17)(2,15,92,40,96,61,24,60,113,77,75,106)(3,56,10,41)
   (4,42,87,111,21,98,36,26,14,116,70,100)(5,109,115,91,13,50,66,67,48,63,43,95)
   (6,89,103,44,99,58)(7,28,112,102,18,68,72,53,81,90,31,110)(8,11,23)
   (9,45,55,82)(12,76,104,35)(16,20,52,80)(19,37,32,117,84,69)(27,30)
   (29,51,85,105)(33,65,119)(38,59)(39,88,62,57)(46,83)(64,118,71,101)
   (73,79,78,108,93,94),(1,34,31,27,94,7,102,22,30,32)(2,35,33,58,82)
   (3,50,59,21,106,6,66,75,98,23)(4,99,87,5,100)(8,15,103,26,12)(9,24,48,70,95)
   (10,104,14,119,11,44,36,42,61,40)(13,115,38,55,111,45,63,96,67,76)
   (16,39,54,84,74,37,18,86,51,47)(17,118,117,71,19,110,62,73,57,108)
   (20,78,25,83,85,29,69,28,46,80)(41,113,116,89,43)(49,64)
   (52,112,105,101,72,79,90,93,97,68)(53,88)(56,107,92,91,109)(65,77)(81,114)])
   ;
  #   order = 1451520 = 2^9 * 3^4 * 5 * 7 
  isotrop_plane:=SubPermutationGroup(119,[(1,90,3)(2,119,88)
   (4,93,60,107,41,106,111,42,112,10,102,31)(5,75,18,51,8,11)
   (6,95,52,85,67,28,47,37,83,87,69,97)(7,115,98,109,59,76,74,79,29,13,72,73)
   (9,84,33,61,36,82,117,70,96,49,32,55)(12,38,104,22,57,68,19,34,35,99,77,114)
   (15,56,65,91,103,30,17,54,113,20,39,105)(16,27,100)
   (21,71,66,62,116,108,26,58,80,64,78,45)
   (23,101,44,48,94,53,24,40,110,50,43,89)(25,63,86,92,46,81),(1,3,88,2)(4,58)
   (5,30,66,9,25,55,60,17,75,113,108,61)(6,46,105,73,87,92,82,53,22,86,65,98)
   (7,94,21,116,23,101,64,93,109,115,107,102)
   (8,68,29,49,63,104,76,117,18,83,89,15)(10,40,62,43,26,79)
   (11,52,112,99,81,114,45,47,51,35,80,85)(12,16,96,31)(13,78,24,41,74,42)
   (14,33,44,91)(19,27,28,110)(20,100,97,106)
   (32,57,34,36,56,38,37,54,39,95,77,103)(48,71,111,72)(50,59)(69,84)(90,118)])
   ;
  #   order = 258048 = 2^12 * 3^2 * 7 
  isotrop_line:=SubPermutationGroup(119,[(1,2)(3,20,87,99,47,88,12,117,17,61)
   (4,75,13,72,60,101,29,71,26,16)(5,80,94,111,93,106,18,74,41,62)
   (6,90,19,85,15)(7,46,73,43,50,42,44,11,64,102)(8,53,51,24,92,45,27,31,115,66)
   (9,22,49,119,91)(10,116)(14,48,86,21,59,89,40,108,58,109)(23,78)
   (25,98,100,110,79,76,81,112,63,107)(28,39,103,83,56,33,38,34,82,57)
   (30,95,65,96,52)(32,68,97,55,35)(54,69,105,114,67,77,70,104,113,84),(1,118,2)
   (3,47,20,87,17,119,6,12,9,15,90,61,19,85,99)
   (4,115,38,62,81,57,45,63,69,107,27,97,13,25,95,48,79,39,7,8,56,98,51,70,24,
   100,96,21,92,32)
   (5,55,80,102,77,26,101,113,89,16,103,53,94,83,111,46,52,73,41,54,109,40,114,
   60,14,34,112,43,82,50)
   (10,42,67,106,58,36,66,18,105,110,86,65,64,59,35,23,93,84,44,71,37,76,11,104,
   31,75,68,74,72,30)(22,88,49,91,117)(28,108,116,33,29,78)]);
  #   order = 184320 = 2^12 * 3^2 * 5 
  nonisotrop_line:=SubPermutationGroup(119,[(1,21,75,5,39,35,38,45,110,116,2,95)
   (3,33,71,34,103,23,28,88,44,61,47,81)(4,60,12,11,42,77)
   (6,105,8,26,10,117,119,87,58,79,106,104)(7,73,17,16,101,84)(9,109,115)
   (13,98,46,78)(14,69,80,83)(15,114,22,112,40,102,68,57,65,64,62,25)
   (18,56,89,113)(19,82,91,76,93,43,55,70,52,50,48,100)(20,99)
   (24,118,59,86,96,31)(27,53,111,41)(29,90,63,49)(30,107,32,72)(36,85)
   (37,51,108)(54,67)(66,74,94,92),(1,91,20)
   (2,93,116,41,14,12,75,78,5,72,19,42,92,46,16)
   (3,62,31,88,65,56,40,89,57,22,34,24,18,103,97)
   (4,119,36,30,101,109,35,99,83,73,11,82,67,90,108)
   (6,69,45,17,50,95,49,76,84,8,70,32,58,37,21)
   (7,55,79,106,98,63,77,48,94,10,80,117,60,13,27)
   (9,26,53,100,29,39,115,111,74,51,104,110,43,66,107)
   (15,44,114,61,23,96,81,33,113,71,68,112,47,28,64)(25,102,59,118,86)
   (38,85,105)(52,87,54)]);
  #   order = 120960 = 2^7 * 3^3 * 5 * 7 
  superfield:=SubPermutationGroup(119,[(1,62,83)(2,67,88,46,112,63)(3,6,78)
   (4,106,68,30,54,23)(5,61,74,118,79,55)(7,49,119,82,115,51)
   (8,35,48,100,113,107)(9,16,72,99,86,93)(10,59,110,50,42,80)(11,38,34)
   (12,29,41,102,103,19)(13,40,108)(14,77,32,75,36,57)(15,73,43,71,95,85)
   (17,87,31,58,94,56)(18,101,91)(20,96,45)(21,26,98,97,28,39)
   (22,65,44,117,104,66)(24,76,105,114,37,111)(27,81)(33,109,92)(47,70,52)
   (53,89,90)(60,69)(64,84,116)
   ,(1,37,31,111,94,96,51,91,81,79,49,25,97,5,50,62,28)
   (2,95,88,63,68,103,57,14,64,109,41,52,67,38,92,9,32)
   (3,46,102,15,16,43,85,36,106,12,29,116,78,23,47,73,33)
   (4,99,112,93,72,19,75,30,54,84,34,77,70,86,6,11,71)
   (7,117,119,110,40,42,26,48,82,89,17,60,83,53,74,58,101)
   (8,107,10,105,66,21,114,108,24,115,35,56,27,22,100,55,69)
   (13,20,98,104,80,87,118,90,44,113,45,61,76,59,65,39,18)]);
  #   order = 8160 = 2^5 * 3 * 5 * 17 
  nonisotrop_four:=SubPermutationGroup(119,[(2,81)(3,9,6,12)(4,39,109,97)
   (5,40,100,11)(7,113)(8,118)(10,83,44,30)(13,37,76,52)(14,42,115,63)
   (16,93,79,51)(18,46,101,27)(19,90,117,47)(20,75,85,59)(21,98,66,50)(22,41)
   (23,48,106,26)(24,89)(25,71)(28,60)(29,64,80,53)(32,68,69,54)(33,56)
   (35,96,82,38)(36,67,55,104)(43,88,116,49)(45,84,111,105)(57,107)(58,92)
   (61,94,119,78)(65,73,77,108)(70,112,95,74)(72,91,86,87)(99,102)(103,110)
   ,(1,62,118,81,2,113)(3,9,6,15,12)
   (4,42,79,55,97,48,45,115,51,96,83,98,76,63,18,82,37,66,111,11,46,36,84,50,10,
   5,93,67,52,23)(7,114,8)
   (13,40,25,56,30,21,44,92,71,35,105,106,107,58,27,104,39,24,60,100,16,38,28,
   89,109,14,101,33,57,26)
   (17,29,88,78,61,103,19,64,85,72,99,95,90,80,49,102,91,65,117,53,22,94,119,70,
   47,31,20,86,87,77)(32,75,73,54,41,108,68,116,112,34,43,74,69,59,110)]);
  #   order = 4320 = 2^5 * 3^3 * 5 
  l2_7:=SubPermutationGroup(119,[(1,8)(2,34)(3,86)(4,87)(5,45)(6,41)(7,61)(9,94)
   (10,22)(11,112)(12,78)(13,93)(14,69)(15,47)(16,73)(17,72)(18,54)(19,117)
   (20,35)(21,50)(23,113)(24,64)(25,60)(26,83)(27,67)(28,65)(29,98)(30,48)
   (31,103)(32,63)(33,101)(36,46)(37,95)(38,88)(39,106)(40,107)(42,104)(43,116)
   (44,119)(49,114)(51,108)(52,105)(55,115)(56,92)(58,68)(59,102)(62,97)(66,80)
   (70,84)(71,74)(76,100)(79,111)(82,85)(91,109)(96,99)(110,118)
   ,(1,57,41,90,61,100,76)(2,47,13,8,75,7,80)(3,68,87,73,49,108,104)
   (4,42,28,17,89,97,38)(5,18,45,95,14,78,85)(6,93,15,81,53,34,66)
   (9,111,29,32,109,74,115)(10,40,54,107,31,52,19)(11,16,48,27,51,102,77)
   (12,101,119,56,106,69,71)(20,110,70,112,96,99,59)(21,72,35,114,84,62,50)
   (22,64,46,44,55,37,43)(23,25,94,33,39,63,24)(26,60,103,116,82,91,92)
   (30,88,118,65,67,86,58)(36,98,105,113,117,79,83)]);
  #   order = 168 = 2^3 * 3 * 7 
  return rec(val1:=omega,
    val2:=invol,
    val3:=isotrop_point,
    val4:=nonisotrop_point,
    val5:=nonisotrop_four,
    val6:=isotrop_plane,
    val7:=isotrop_line,
    val8:=nonisotrop_line,
    val9:=superfield,
    val10:=l2_7);
end;
;
#  ****************************************************************
#  these are the good generators as described in Rob Wilson's Online
#  ATLAS.
FindGoodGens@:=function(g)
local a,b,found,o,x;
  found:=false;
  while not found do
    x:=Random(g);
    o:=Order(x);
    if IsEvenInt(o) and Size(Centraliser(g,x^(QuoInt(o,2))))=3072 then
      a:=x^(QuoInt(o,2));
      found:=true;
    fi;
  od;
  found:=false;
  while not found do
    x:=Random(g);
    o:=Order(x);
    if o mod 3=0 and Size(Centraliser(g,x^(QuoInt(o,3))))=648 then
      b:=x^(QuoInt(o,3));
      found:=true;
    fi;
  od;
  found:=false;
  while not found do
    x:=Random(g);
    a:=a^x;
    if Order(a*b)=17 and Order(a*b*a*b^2)=17 and Order((a*b)^3*b)=30 then
      return rec(val1:=a,
        val2:=b);
    fi;
  od;
end;
;
#  ****************************************************************
InstallGlobalFunction(OMinus8_2Identify@,
function(group)
local 
   CG,F,Print,a,aom82,b,ce,g,group,h,homom,i,ims,invol,isc,isotrop_line,
   isotrop_plane,isotrop_point,j,l2_7,max,maximals,newgens,nonisotrop_four,
   nonisotrop_line,nonisotrop_point,omega,phi,soc,superfield;
  max:=ValueOption("max");
  if max=fail then
    max:=true;
  fi;
  Print:=ValueOption("Print");
  if Print=fail then
    Print:=0;
  fi;
  # =v= MULTIASSIGN =v=
  l2_7:=GetGroups@();
  omega:=l2_7.val1;
  invol:=l2_7.val2;
  isotrop_point:=l2_7.val3;
  nonisotrop_point:=l2_7.val4;
  nonisotrop_four:=l2_7.val5;
  isotrop_plane:=l2_7.val6;
  isotrop_line:=l2_7.val7;
  nonisotrop_line:=l2_7.val8;
  superfield:=l2_7.val9;
  l2_7:=l2_7.val10;
  # =^= MULTIASSIGN =^=
  # =v= MULTIASSIGN =v=
  phi:=FPGroupStrong(omega);
  F:=phi.val1;
  phi:=phi.val2;
  # =^= MULTIASSIGN =^=
  soc:=Socle(group);
  # =v= MULTIASSIGN =v=
  b:=FindGoodGens@(soc);
  a:=b.val1;
  b:=b.val2;
  # =^= MULTIASSIGN =^=
  soc:=SubStructure(soc,a,#TODO CLOSURE
    b);
  newgens:=[a,b];
  for g in Generators(group) do
    if not g in SubStructure(group,newgens) then
      Add(newgens,g);
    fi;
  od;
  group:=SubStructure(group,newgens);
  aom82:=SubStructure(SymmetricGroup(119),omega.1,#TODO CLOSURE
    omega.2,invol);
  ims:=[omega.1,omega.2];
  homom:=GroupHomomorphismByImages(soc,omega,
    GeneratorsOfGroup(soc),ims);
  for i in [Ngens(soc)+1..Ngens(group)] do
    g:=group.i;
    CG:=aom82;
    ce:=One(aom82);
    for j in [1..2] do
      # =v= MULTIASSIGN =v=
      h:=IsConjugate(CG,omega.j^ce,homom(soc.j^g));
      isc:=h.val1;
      h:=h.val2;
      # =^= MULTIASSIGN =^=
      if not isc then
        Error("Conjugation error in Aut(O^-(8,2))");
      fi;
      CG:=Centraliser(CG,homom(soc.j^g));
      ce:=ce*h;
    od;
    Add(ims,ce);
  od;
  newgens:=ims;
  for g in Generators(aom82) do
    if not g in SubStructure(aom82,ims) then
      Add(ims,g);
    fi;
  od;
  aom82:=SubStructure(SymmetricGroup(119),ims);
  homom:=GroupHomomorphismByImages(group,aom82,
    GeneratorsOfGroup(group),newgens);
  if not max then
    return rec(val1:=homom,
      val2:=aom82,
      val3:=[],
      val4:=F,
      val5:=phi);
  fi;
  #  nothing fiddly here: extension is a .2 and all groups extend.
  maximals:=List([isotrop_point,nonisotrop_point,isotrop_plane,isotrop_line,
   nonisotrop_line,superfield,nonisotrop_four,l2_7],x->x);
  return rec(val1:=homom,
    val2:=aom82,
    val3:=maximals,
    val4:=F,
    val5:=phi);
end);


