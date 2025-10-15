% Fichier regroupant les macros pour les schémas des nombres premiers

numeric retenirnb[];

vardef Estcepremier(expr NBa)=
  boolean $;
  c:=2;
  departa:=NBa;
  test:=1;
  $=true;
  if departa=1:
    $:=false;
  else:
    forever:
      if (departa mod c)=0:
	departa:=departa div c;
	test:=test+1;
      else:
	c:=c+1;
      fi;
      exitif departa=1;
    endfor;
  fi;
  if test=2:
    $:=true
  else:
    $:=false;
  fi;
  $
enddef;

vardef PremierSimple(expr NB)=
  b:=2;
  depart:=NB;
  if Estcepremier(depart)=false:
    forever:
      if (depart mod b)=0:
	Ancre[k+1]-Ancre[k]=(-decalage*0.5,-decalage);
	Ancre[k+2]-Ancre[k+1]=(decalage,0);
	depart:=depart div b;
	retenirnb[k+1]=b;
        retenirnb[k+2]=depart;
	label(LATEX("\num{"&decimal(b)&"}"),Ancre[k+1]);
	label(LATEX("\num{"&decimal(depart)&"}"),Ancre[k+2]);
	draw 1/5[Ancre[k],Ancre[k+1]]--4/5[Ancre[k],Ancre[k+1]];
	draw 1/5[Ancre[k],Ancre[k+2]]--4/5[Ancre[k],Ancre[k+2]];
	k:=k+2;
	racine:=depart;
	depart:=1;
      else:
	b:=b+1;
      fi;
      exitif depart=1;
    endfor;
  else:
    racine:=1;
  fi;
enddef;

vardef PremierSimplePdf(expr NB)=
  b:=2;
  depart:=NB;
  if Estcepremier(depart)=false:
    forever:
      if (depart mod b)=0:
	Ancre[k+1]-Ancre[k]=(-decalage*0.5,-decalage);
	Ancre[k+2]-Ancre[k+1]=(decalage,0);
	depart:=depart div b;
	retenirnb[k+1]=b;
        retenirnb[k+2]=depart;
	label(LATEX("\num{"&decimal(b)&"}"),Ancre[k+1]);
	label(LATEX("\num{"&decimal(depart)&"}"),Ancre[k+2]);
	draw 1/5[Ancre[k],Ancre[k+1]]--4/5[Ancre[k],Ancre[k+1]];
	draw 1/5[Ancre[k],Ancre[k+2]]--4/5[Ancre[k],Ancre[k+2]];
	k:=k+2;
	racine:=depart;
	depart:=1;
      else:
	b:=b+1;
      fi;
      exitif depart=1;
    endfor;
  else:
    racine:=1;
  fi;
enddef;

vardef PremierSimpleArbre(expr NB)=
  b:=2;
  depart:=NB;
  if Estcepremier(depart)=false:
    forever:
      if (depart mod b)=0:
	Ancre[k+1]-Ancre[k]=(-decalage*0.5,-decalage);
	Ancre[k+2]-Ancre[k+1]=(decalage,0);
	depart:=depart div b;
        retenirnb[k+1]=b;
        retenirnb[k+2]=depart;
	draw Branche(Ancre[k],Ancre[k+1]);
	draw Branche(Ancre[k],Ancre[k+2]);
	k:=k+2;
	racine:=depart;
	depart:=1;
      else:
	b:=b+1;
      fi;
      exitif depart=1;
    endfor;
  else:
    racine:=1;
  fi;
enddef;

vardef NbEtape(expr nb)=
  b:=2;
  depart:=nb;
  etape:=0;
  Stock[0][0]=depart;
  forever:
    if (depart mod b)=0:
      etape:=etape+1;
      if etape=1:
	Stock[etape][0]=b;
	Stock[etape][etape]:=depart div b;
      else:
	for k=0 upto etape-2:
	  Stock[etape][k]:=Stock[etape-1][k];
	endfor;
	Stock[etape][etape-1]:=b;
	Stock[etape][etape]:=depart div b;
      fi;
      depart:=depart div b;
    else:
      b:=b+1;
    fi;
    exitif depart=1;
  endfor;
  etape
enddef;

vardef Positions(expr Step)=
  for k=0 upto (Step-1):
    for l=0 upto k:
      N[k][l]=(-k*dx+(l+k*.5)*dx,-k*dy);
      label(LATEX("\num{"&decimal(Stock[k][l])&"}"),N[k][l]);
    endfor;
    for l=0 upto k-1:
      label(LATEX("$\times$"),1/2[N[k][l],N[k][l+1]]);
    endfor;
  endfor;
  for k=0 upto (Step-1):
    for l=0 upto (k-1):
      draw 1/5[N[k][l],N[k-1][l]]--4/5[N[k][l],N[k-1][l]];
    endfor;
    if k>0:
      draw 1/5[N[k][k],N[k-1][k-1]]--4/5[N[k][k],N[k-1][k-1]];
    fi;
  endfor;
enddef;

vardef PositionsPdf(expr Step)=
  for k=0 upto (Step-1):
    for l=0 upto k:
      N[k][l]=(-k*dx+(l+k*.5)*dx,-k*dy);
      label(LATEX("\num{"&decimal(Stock[k][l])&"}"),N[k][l]);
    endfor;
    for l=0 upto k-1:
      label(LATEX("$\times$"),1/2[N[k][l],N[k][l+1]]);
    endfor;
  endfor;
  for k=0 upto (Step-1):
    for l=0 upto (k-1):
      draw 1/5[N[k][l],N[k-1][l]]--4/5[N[k][l],N[k-1][l]];
    endfor;
    if k>0:
      draw 1/5[N[k][k],N[k-1][k-1]]--4/5[N[k][k],N[k-1][k-1]];
    fi;
  endfor;
enddef;

vardef PositionsVide(expr Step)=
  for k=0 upto (Step-1):
    for l=0 upto k:
      N[k][l]=(-k*dx+(l+k*.5)*dx,-k*dy);
    endfor;
    for l=0 upto k-1:
      label(LATEX("$\times$"),1/2[N[k][l],N[k][l+1]]);
    endfor;
  endfor;
  for k=0 upto (Step-1):
    for l=0 upto (k-1):
      draw 1/5[N[k][l],N[k-1][l]]--4/5[N[k][l],N[k-1][l]];
    endfor;
    if k>0:
      draw 1/5[N[k][k],N[k-1][k-1]]--4/5[N[k][k],N[k-1][k-1]];
    fi;
  endfor;
  label(LATEX("\num{"&decimal(Stock[0][0])&"}"),N[0][0]);
enddef;

vardef PositionsVidePdf(expr Step)=
  for k=0 upto (Step-1):
    for l=0 upto k:
      N[k][l]=(-k*dx+(l+k*.5)*dx,-k*dy);
    endfor;
    for l=0 upto k-1:
      label(LATEX("$\times$"),1/2[N[k][l],N[k][l+1]]);
    endfor;
  endfor;
  for k=0 upto (Step-1):
    for l=0 upto (k-1):
      draw 1/5[N[k][l],N[k-1][l]]--4/5[N[k][l],N[k-1][l]];
    endfor;
    if k>0:
      draw 1/5[N[k][k],N[k-1][k-1]]--4/5[N[k][k],N[k-1][k-1]];
    fi;
  endfor;
  label(LATEX("\num{"&decimal(Stock[0][0])&"}"),N[0][0]);
enddef;

vardef Branche(expr nbd,nba)=
  save $;
  picture $;
  pair UnitVector;
  numeric AngleVector;
  UnitVector=unitvector(nba-nbd) rotated 90;
  AngleVector=angle(nba-nbd)+(-10+uniformdeviate(20));
  path branche;
  branche=(nbd+UnitVector){dir AngleVector}..(nba+UnitVector)--reverse((nbd-UnitVector){dir AngleVector}..(nba-UnitVector))--cycle;
  $=image(
  fill branche withcolor gris;
  draw branche;
  );
  $
enddef;

endinput;
