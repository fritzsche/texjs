%Pile des cases du chemin
pair PileChemin[];
numeric indiceChemin;
indiceChemin=0;

vardef RAZPileChemin=
  pair PileChemin[];
  indiceChemin:=0;
enddef;

def PushChemin(expr tt)=
  if indiceChemin<1:
    PileChemin[1]:=tt;
    indiceChemin:=1;
  else:
    PileChemin[indiceChemin+1]:=tt;
    indiceChemin:=indiceChemin+1;
  fi;
enddef;

def PopChemin=
  if indiceChemin<1:
    RAZPileChemin;
    for k=-1 upto LargeurLaby:
      for l=-1 upto LongueurLaby:
	if (k=-1) or (k=LargeurLaby) or (l=-1) or (l=LongueurLaby):
	  CaseExploree[k][l]:=true;
	else:
	  CaseExploree[k][l]:=false;
	fi;
      endfor;
    endfor;
    Mobile:=Depart;
    PushChemin((choixligneD,choixcolonneD));
    CaseExploree[choixligneD][choixcolonneD]:=true;
    VoisinDispo(choixligneD,choixcolonneD);
  else:
    if indiceChemin>0:
      CaseExploree[xpart(PileChemin[indiceChemin])][ypart(PileChemin[indiceChemin])]:=true;
    fi;
    indiceChemin:=indiceChemin-1;
  fi;
enddef;

def PopCheminMathAlea=
  if indiceChemin<1:
    RAZPileChemin;
    for k=-1 upto LargeurLaby:
      for l=-1 upto LongueurLaby:
	if (k=-1) or (k=LargeurLaby) or (l=-1) or (l=LongueurLaby):
	  CaseExploree[k][l]:=true;
	else:
	  CaseExploree[k][l]:=false;
	fi;
      endfor;
    endfor;
    Mobile:=Depart;
          if Entree="Nord":
        CaseExploree[choixligneD-1][choixcolonneD]:=true;
      elseif Entree="Sud":
        CaseExploree[choixligneD+1][choixcolonneD]:=true;
      elseif Entree="Est":
        CaseExploree[choixligneD][choixcolonneD+1]:=true;
      elseif Entree="Ouest":
        CaseExploree[choixligneD][choixcolonneD-1]:=true;
      fi;
      if SortieUnique:
        if (Sortie="Est") or (Sortie="Ouest"):
          for k=0 upto LargeurLaby-1:
          if k<>choixligneA:
            CaseExploree[k][choixcolonneA]:=true;
          fi;
          endfor;
        elseif (Sortie="Nord") or (Sortie="Sud"):
          for k=0 upto LongueurLaby-1:
          if k<>choixcolonneA:
            CaseExploree[choixligneA][k]:=true;
          fi;
          endfor;    
        fi;
      fi;
    PushChemin((choixligneD,choixcolonneD));
    CaseExploree[choixligneD][choixcolonneD]:=true;
    VoisinDispo(choixligneD,choixcolonneD);
  else:
    if indiceChemin>0:
      CaseExploree[xpart(PileChemin[indiceChemin])][ypart(PileChemin[indiceChemin])]:=true;
    fi;
    indiceChemin:=indiceChemin-1;
  fi;
enddef;

%Pile des cases voisines de la case parcourue
pair PileVoisin[];
numeric indiceVoisin;
indiceVoisin=0;

vardef RAZPileVoisin=
  indiceVoisin:=0;
enddef;

def PushVoisin(expr tt)=
  if indiceVoisin<1:
    PileVoisin[1]:=tt;
    indiceVoisin:=1;
  else:
    PileVoisin[indiceVoisin+1]:=tt;
    indiceVoisin:=indiceVoisin+1;
  fi;
enddef;

def PopVoisin=
  if indiceVoisin<0:
    %message("La pile n'existe pas");
  else:
    indiceVoisin:=indiceVoisin-1;
  fi;
enddef;

vardef VoisinDispo(expr la,lo)=
  RAZPileVoisin;
  numeric nbvoisin;
  nbvoisin=0;
  if (la>-1) and (la<LargeurLaby) and (lo>-1) and (lo<LongueurLaby):
    if CaseExploree[la+1][lo]=false:
      nbvoisin:=nbvoisin+1;
      PushVoisin((la+1,lo));
    fi;
    if CaseExploree[la-1][lo]=false:
      nbvoisin:=nbvoisin+1;
      PushVoisin((la-1,lo));
    fi;
    if CaseExploree[la][lo+1]=false:
      nbvoisin:=nbvoisin+1;
      PushVoisin((la,lo+1));
    fi;
    if CaseExploree[la][lo-1]=false:
      nbvoisin:=nbvoisin+1;
      PushVoisin((la,lo-1));
    fi;
  fi;
enddef;

vardef InitialisationLabyrinthe(expr long,larg)=
  LargeurLaby:=larg;
  LongueurLaby:=long;
  pair M[][],N[][];%centre de la case, coinbg de la case
  boolean CaseExploree[][];%Case Exploree ou pas
  %on initialise les cases comme non explorées pour celles qui sont à l'intérieur du labyrinthe
  %n=0;
  for k=-1 upto larg:
    for l=-1 upto long:
      M[k][l]:=u*(0.5,-0.5)+u*(l,-k);
      N[k][l]:=u*(l,-k-1);
      if (k=-1) or (k=larg) or (l=-1) or (l=long):
	CaseExploree[k][l]:=true;
      else:
	CaseExploree[k][l]:=false;
      fi;
    endfor;
  endfor;
enddef;

vardef TraceLabyrinthe=
  save $;
  picture $;
  $=image(
      if Murs:
      for k=1 upto LargeurLaby:
	trace murgauche shifted(u*(0,-k));
      endfor;
      for k=0 upto LongueurLaby-1:
	trace murhaut shifted(u*(k,-1));
      endfor;
      for k=1 upto LargeurLaby:
	trace murdroit shifted(u*(LongueurLaby-1,-k));
      endfor;
      for k=0 upto LongueurLaby-1:
	trace murbas shifted(u*(k,-LargeurLaby));
      endfor;
      for k=1 upto LargeurLaby-1:
	for l=1 upto LongueurLaby-1:
	  trace Separation shifted(u*(l,-k));
	endfor;
      endfor;
    else:
      for k=0 upto LargeurLaby:
	trace u*(0,0-k)--u*(LongueurLaby,0-k);
      endfor;
      for k=0 upto LongueurLaby:
	trace u*(0+k,0)--u*(0+k,-LargeurLaby);
      endfor;
    fi;
    );
  $
enddef;

vardef InitialisationLabyrintheMul(expr long,larg)=
  LargeurLaby:=larg;
  LongueurLaby:=long;
  uh=2u;
  uv=2u;
  pair M[][],N[][];%centre de la case, coinbg de la case
  boolean CaseExploree[][];%Case Exploree ou pas
  %on initialise les cases comme non explorées pour celles qui sont à l'intérieur du labyrinthe
  for k=-1 upto larg:
    for l=-1 upto long:
      M[k][l]:=(5mm,-uv+5mm)+(l*uh,-k*uv);
      N[k][l]:=(l*uh,(-k-1)*uv);
      if (k=-1) or (k=larg) or (l=-1) or (l=long):
	CaseExploree[k][l]:=true;
      else:
	CaseExploree[k][l]:=false;
      fi;
    endfor;
  endfor;
enddef;

vardef TraceLabyrintheMul=
  save $;
  picture $;
  $=image(
      n:=0;
      for k=0 upto LargeurLaby-1:
	for l=0 upto LongueurLaby-1:
	  n:=n+1;
	if (n mod 2)=1:
	  draw (Fullcircle scaled 10mm) shifted N[k][l];
	else:
	  draw (unitsquare scaled 10mm) shifted N[k][l];
	fi;
      endfor;
    endfor;
    );
  $
enddef;

vardef murgauche=
  save $;
  picture $;
  path pl[];
  $=image(
      pl1=(0,0)--u*(0.1,0)..u*(0.02+uniformdeviate(0.05),0.25)..u*(0.1-uniformdeviate(0.03),0.5)..u*(0.02+uniformdeviate(0.05),0.75)..u*(0.1,1)--u*(0,1)--cycle;
    remplis pl[1];
    trace pl[1];
    );
  $
enddef;%ok

vardef murhaut=
  save $;
  picture $;
  path pl[];
  $=image(
      pl1=u*(0,0.8)--u*(0,1)--u*(1,1)--u*(1,0.8)..u*(0.8+uniformdeviate(0.1),0.8+uniformdeviate(0.1))..u*(0.4+uniformdeviate(0.2),0.8-uniformdeviate(0.1))..u*(0.2+uniformdeviate(0.2),0.8+uniformdeviate(0.1))--cycle;
    remplis pl[1];
    trace pl[1];
    );
  $
enddef;

vardef murdroit=
  save $;
  picture $;
  path pl[];
  $=image(
    pl1=u*(1,0)--u*(1-0.15,0)--u*(1-0.15,0.2){dir180}..u*(1-0.08+uniformdeviate(0.05),0.2+uniformdeviate(0.1))..u*(1-0.09+uniformdeviate(0.015),0.3+uniformdeviate(0.2))..u*(1-0.08+uniformdeviate(0.04),0.5+uniformdeviate(0.2))..{dir0}u*(1-0.15,0.8)--u*(1-0.15,1)--u*(1-0,1)--cycle;
    remplis pl[1];
    trace pl[1];
    );
  $
enddef;%ok

vardef murbas=
  save $;
  picture $;
  path pl[];
  $=image(
      pl1=u*(0,0.2)--u*(0,0)--u*(1,0)--u*(1,0.2)..u*(0.8+uniformdeviate(0.1),0.2+uniformdeviate(0.1))..u*(0.4+uniformdeviate(0.2),0.2-uniformdeviate(0.1))..u*(0.2+uniformdeviate(0.2),0.2+uniformdeviate(0.1))--cycle;
    remplis pl[1];
    trace pl[1];
    );
  $
enddef;

vardef Separation=
  save $;
  picture $;
  path pl[];
  $=image(
      pl1=u*(0.2,0)..u*(0.05+uniformdeviate(0.05),0.05+uniformdeviate(0.05))..u*(0,0.2)..u*(-0.1+uniformdeviate(0.05),0.05+uniformdeviate(0.05))..u*(-0.2,0)..u*(-0.1+uniformdeviate(0.05),-0.05-uniformdeviate(0.05))..u*(0,-0.2)..u*(0.05+uniformdeviate(0.05),-0.05-uniformdeviate(0.05))..cycle;
    remplis pl[1];
    trace pl[1];
    );
  $
enddef;

endinput
