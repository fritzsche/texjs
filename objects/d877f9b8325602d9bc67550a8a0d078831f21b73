boolean Poser,Etapes,STOP;
Poser=true;
STOP=false;

color CouleurRemplis;

vardef Stop=
  if Etapes:
    if k>Total-1:
      STOP:=true;
    fi;
  fi;
enddef;

vardef Av(expr pas)=
  Stop;
  if STOP=false:
    A[k+1]-A[k]=ut*pas*VecteurDpt;
    B[tt+1]:=A[k+1];
    RetiensAngle[k+1]:=RetiensAngle[k];
    if Poser:
      draw A[k]--A[k+1] withpen pencircle scaled Epaisseur;
    %drawarrow A[k]--(A[k]+10*VecteurDpt) withcolor blue;
    fi;
  fi;
  k:=k+1;
  tt:=tt+1;
enddef;

vardef Re(expr pas)=
  Stop;
  if STOP=false:
    A[k+1]-A[k]=-ut*pas*VecteurDpt;
    B[tt+1]:=A[k+1];
    RetiensAngle[k+1]:=RetiensAngle[k];
    if Poser:
      draw A[k]--A[k+1] withpen pencircle scaled Epaisseur;
    %drawarrow A[k]--(A[k]+10*VecteurDpt) withcolor blue;
    fi;
  fi;
  k:=k+1;
  tt:=tt+1;
enddef;

vardef Tg(expr pas)=
  Stop;
  if STOP=false:
    VecteurDpt:=rotation(VecteurDpt,(0,0),pas);
    A[k+1]:=A[k];
    B[tt+1]:=A[k+1];
  %drawarrow A[k]--(A[k]+10*VecteurDpt) withcolor blue;
    RetiensAngle[k+1]:=RetiensAngle[k]+pas;
    Angle:=Angle+pas;
  fi;
  k:=k+1;
  tt:=tt+1;
enddef;

vardef Td(expr pas)=
  Stop;
  if STOP=false:
    VecteurDpt:=rotation(VecteurDpt,(0,0),-pas);
    A[k+1]:=A[k];
    B[tt+1]:=A[k+1];
  %drawarrow A[k]--(A[k]+10*VecteurDpt) withcolor blue;
    RetiensAngle[k+1]:=RetiensAngle[k]-pas;
    Angle:=Angle-pas;
  fi;
  k:=k+1;
  tt:=tt+1;
enddef;

vardef Bc=
  Stop;
  if STOP=false:
    Poser:=true;
  fi;
enddef;

vardef Lc=
  Stop;
  if STOP=false:
    Poser:=false;
  fi;
enddef;

vardef Teleporter(expr xpas,ypas)=
  Stop;
  if STOP=false:
    A[k+1]:=A[k]+ut*(xpas,ypas);
    B[tt+1]:=A[k+1];
  fi;
  k:=k+1;
  tt:=tt+1;
enddef;

k=0;
tt=0;
