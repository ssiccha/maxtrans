#  File converted from Magma code -- requires editing and checking
#  Magma -> GAP converter, version 0.38, 1/12/16 by AH

#  Global Variables used: Append, CorrectForm, Determinant, DiagonalJoin,
#  DiagonalMatrix, Eltseq, Factorisation, GF, GL, GU, IsEven, IsOdd,
#  ListMatToQ, Matrix, Ngens, PrimitiveElement, SL, SU, ScalarMatrix, Sym,
#  TransformForm, Transpose, UnitaryForm, WreathProduct

#  Defines: ListMatToQ, StandardUnitImps, UnitImpHalfDim

DeclareGlobalFunction("StandardUnitImps@");

DeclareGlobalFunction("UnitImpHalfDim@");

#  This makes SU(k, q).(q+1)^(d/k-1).Sym(d/k).
#  We create a wreath product which acts on an orthogonal
#  sum of k-dimensional unitary spaces, then correct for determinant -1
#  in the permutation matrices, then add a single diagonal element
#  which has order (q-1) on the first space, and corrects for
#  determinant on the second. there's a couple of points where the case
#  k=1 is different, as we cannot create a hyperbolic line in a 1-d
#  space.
InstallGlobalFunction(StandardUnitImps@,
function(d,q,k)
local bool,diag,form,form2,g,general,grp,i,mat1,mat2,newgens,normaliser,
      t,temp,z;
  general:=ValueOption("general");
  if general=fail then
    general:=false;
  fi;
  normaliser:=ValueOption("normaliser");
  if normaliser=fail then
    normaliser:=false;
  fi;
  if k > 1 then
    Assert(1,d mod k=0);
  fi;
  Assert(1,IsPrimePowerInt(q));
  t:=QuoInt(d,k);
  z:=PrimitiveElement(GF(q^2));
  if normaliser then
    general:=true;
  fi;
  if general then
    g:=MatWreathProduct(GU(k,q),SymmetricGroup(t));
    # =v= MULTIASSIGN =v=
    form:=UnitaryForm@(g);
    bool:=form.val1;
    form:=form.val2;
    # =^= MULTIASSIGN =^=
    mat1:=TransformForm@(form,"unitary");
    if normaliser then
      g:=SubgroupContaining(GL(d,q^2),g,z*IdentityMat(GF(q^2),d));
    fi;
    return g^mat1;
  fi;
  #  we make the standard wreath product
  g:=MatWreathProduct(SU(k,q),SymmetricGroup(t));
  #  have to fix determinants, which might be -1 at this point.
  newgens:=[];
  for i in GeneratorsOfGroup(g) do
    if not IsOne(DeterminantMat(i)) then
      #  must be -1, do this for	q even
      if k > 1 then
        temp:=g.i*DiagonalMat(Concatenation([z^(QuoInt((q+1),2))]
         ,List([1..k-2],i->z^0),[-z^(QuoInt(-(q+1),2))],List([1..d-k],i->z^0)));
	Assert(1,IsOne(DeterminantMat(temp)));
        Add(newgens,temp);
      else
        Add(newgens,i*DiagonalMat(Concatenation([-z^0],List([2..d]
	,i->z^0))));
      fi;
    else
      Add(newgens,i);
    fi;
  od;
  if k > 1 then
    diag:=DiagonalMat(Concatenation([z],List([1..k-2],i->z^0),[z^-q,z^-1]
     ,List([1..k-2],i->z^0),[z^q],List([1..d-2*k],i->z^0)));
  else
    diag:=DiagonalMat(Concatenation([z^(q-1),z^(1-q)],List([3..d],i->z^0)));
  fi;
  grp:=SubgroupContaining(GL(d,q^2),newgens,diag);
  # =v= MULTIASSIGN =v=
  form:=UnitaryForm@(grp);
  bool:=form.val1;
  form:=form.val2;
  # =^= MULTIASSIGN =^=
  if not bool then
    Info(InfoWarning,1,"error: grp not unitary");
    return grp;
  fi;
  # =v= MULTIASSIGN =v=
  form2:=UnitaryForm@(SU(d,q));
  bool:=form2.val1;
  form2:=form2.val2;
  # =^= MULTIASSIGN =^=
  mat1:=CorrectForm@(form,d,q^2,"unitary");
  mat2:=CorrectForm@(form2,d,q^2,"unitary");
  #return grp^(mat1*(mat2^-1));
  return grp^(mat1/mat2);
  
end);

#  idea with this second sort is to act as SL(d/2, q^2) on
#  <e_1..e_{d/2}> and correct on <f_{d/2}..f_1>.
InstallGlobalFunction(UnitImpHalfDim@,
function(d,q)
local diag,gen1,gen2,general,gens,k,normaliser,p1,p1img,p2,p2img,swap1,swapmat,
   z;
  general:=ValueOption("general");
  if general=fail then
    general:=false;
  fi;
  normaliser:=ValueOption("normaliser");
  if normaliser=fail then
    normaliser:=false;
  fi;
  Assert(1,IsEvenInt(d));
  k:=QuoInt(d,2);
  Assert(1,IsPrimePowerInt(q));
  if normaliser then
    general:=true;
  fi;
  swap1:=MatrixByEntries(GF(q^2),k,k,List([1..k],i->[i,k-i+1,1]));
  p2:=SL(k,q^2);
  p1:=p2.1;
  p2:=p2.2;
  p1img:=TransposedMat(ListMatToQ@(Flat(p1^-1),q));
  p2img:=TransposedMat(ListMatToQ@(Flat(p2^-1),q));
  gen1:=DirectSumMat(p1,swap1*p1img*swap1);
  gen2:=DirectSumMat(p2,swap1*p2img*swap1);
  z:=PrimitiveElement(GF(q^2));
  diag:=DiagonalMat(Concatenation([z,z^q],List([1..d-4],i->z^0),[z^-1,z^-q]));
  swapmat:=MatrixByEntries(GF(q^2),d,d,Concatenation(List([1..k]
   ,i->[i,i+k,1]),List([k+1..d],i->[i,i-k,1])));
  if d mod 4=2 and IsOddInt(q) then
    swapmat:=swapmat*(GU(d,q).1)^(QuoInt((q+1),2));
  fi;
  gens:=[gen1,gen2,diag,swapmat];
  if general then
    Add(gens,GUMinusSU@(d,q));
  fi;
  if normaliser then
    Add(gens,z*IdentityMat(GF(q),d));
  fi;
  return SubgroupContaining(GL(d,q^2),gens);
  
end);




