prologues:=2;

%Constantes
u:=1cm;
pi:=3.141592654;
c:=57.29578; % conversion d'un radian en degrés
color rouge,vert,bleu,jaune,noir,blanc,orange,rose,violet,ciel,cielfonce,orangevif,gris,marron;
rouge=(1,0,0);
bleu=(0,0,1);
noir=(0,0,0);
blanc=(1,1,1);
orange=(1,0.5,0);
violet=blanc-vert;
rose=(1,0.7,0.7);
cielfonce=0.9*(0.25,1,1);
ciel=bleu+vert;
orangevif=(1,0.25,0.1);
vert=(0,1,0);
jaune=blanc-bleu;
gris=0.8*white;

color CouleurTraits;
CouleurTraits=black;

input marith;
input sarith;
input PfCObjets;

color Sommet[];

%Anthony Phan
vardef Norm primary z =
  abs (abs(Xpart z, Ypart z), Zpart z)
enddef;

let Xpart = redpart;
let Ypart = greenpart;
let Zpart = bluepart;
%

string typerepre,pointilles;
typerepre:="persp";

vardef Initialisation(expr r,t,p,d)=
  Rho:=r;
  Theta:=t;
  Phi:=p;
  DE:=d;
  Aux1:=sind(Theta);
  Aux2:=sind(Phi);
  Aux3:=cosd(Theta);
  Aux4:=cosd(Phi);
  Aux5:=Aux3*Aux2;
  Aux6:=Aux1*Aux2;
  Aux7:=Aux3*Aux4;
  Aux8:=Aux1*Aux4;
  color Oeil;
%  if typerepre="cabinet":
%    Oeil=(Rho,0,0);
%  else:
    Oeil=(Aux7,Aux8,Aux2)*Rho;
%  fi;
  pointilles:="oui";
  Lumiere:=Oeil;
enddef;

%vardef Oeil=(Rho*Aux7,Rho*Aux8,Rho*Aux2)
%enddef;

vardef sin(expr t) = sind(c*t) enddef;

vardef cos(expr t) = cosd(c*t) enddef;

vardef tan(expr t) = sin(t)/cos(t) enddef;

vardef exp(expr x) = mexp(256)**x enddef;

vardef Exp primary x = mexp(256)**x enddef;

vardef ln(expr t) = mlog(t)/256 enddef;

vardef log(expr t) = ln(t)/ln(10) enddef;

vardef ch(expr x)=(exp(x)+exp (-x))/2 enddef;

vardef sh(expr x)=(exp(x)-exp(-x))/2 enddef;

vardef th(expr x)=sh(x)/ch(x) enddef;

vardef arcsin(expr x)=%Définition mathématique en radian
  pi*angle((sqrt(1-x**2),x))/180
enddef;

vardef arccos(expr x)=%Définition mathématique en radian
  pi*angle((x,sqrt(1-x**2)))/180
enddef;

vardef arctan(expr x)=arcsin(x/(1++x))
enddef;

numeric satu,lum;
satu:=0.45;
lum:=1;

%Coordonnées dans le repère Oeil
vardef GCoord(expr N)=
  (-Xpart(N)*Aux1+Ypart(N)*Aux3,-Xpart(N)*Aux5-Ypart(N)*Aux6+Zpart(N)*Aux4,-Xpart(N)*Aux7-Ypart(N)*Aux8-Zpart(N)*Aux2+Rho)
enddef;

vardef GCoordcabinet(expr N)=
  (-(Xpart(N)*sind(30)*0.5)*Aux1+Ypart(N)*cosd(30)*Aux3,-(Xpart(N)*cosd(30)*0.5)*Aux5-Ypart(N)*Aux6+Zpart(N)*Aux4,-Xpart(N)*Aux7-Ypart(N)*Aux8-Zpart(N)*Aux2+Rho)
enddef;

unit:=1;%pour les mises à l'échelle :) Merci pst-solides3d

vardef Projette(expr M)=
  if typerepre="proj":
    ((Xpart(GCoord(M)),Ypart(GCoord(M)))/Zpart(GCoord(M)))*DE*10%
  elseif typerepre="persp":
    (Xpart(GCoord(M)),Ypart(GCoord(M)))*unit*DE
  elseif typerepre="cabinet":
%    (0.5*cosd(30)*Xpart(GCoord(M)),0.75*sind(30)*Ypart(GCoord(M)))*unit*DE
%    (Xpart(M)+0.5*cosd(30)*Zpart(M),Ypart(M)+0.5*sind(30)*Zpart(M))*20
%    (Xpart(M)+0.5*cosd(30)*Ypart(M),Zpart(M)+0.5*sind(30)*Ypart(M))*20
%    (Ypart(M)+0.5*cosd(30)*Xpart(M),Zpart(M)+0.5*sind(30)*Xpart(M))*20%Good avec Theta=-20/Phi=-10
    %(Ypart(GCoord(M))+0.5*cosd(-30)*Xpart(GCoord(M)),Zpart(GCoord(M))+0.5*sind(-30)*Xpart(GCoord(M)))*20%Good avec Theta=-20/Phi=-10
%    (Xpart(GCoord(M))*cosd(90-30),Ypart(GCoord(M))*sind(90-30)*0.5)*DE%à garder peut-être ?
%    (Xpart(GCoordcabinet(M)),Ypart(GCoordcabinet(M)))*DE%<-last good :)
    ((Xpart(GCoordcabinet(M)),Ypart(GCoordcabinet(M)))/Zpart(GCoordcabinet(M)))*DE
    %(Zpart(GCoord(M))+0.5*cosd(-30)*Ypart(GCoord(M)),Xpart(GCoord(M))+0.5*sind(-30)*Ypart(GCoord(M)))*20
%    (0.5*cosd(45)*Xpart(GCoord(M)),0.5*sind(45)*Ypart(GCoord(M)))*unit*DE
%    (Xpart(GCoord(M)),Ypart(GCoord(M)))*unit*DE
    %(Xpart(GCoord(M)),Ypart(GCoord(M)))*10
  fi
enddef;

vardef TraceAxes=
  color Origine,Unitex,Unitey,Unitez;
  Origine=(0,0,0);
  Unitex=(5,0,0);
  Unitey=(0,5,0);
  Unitez=(0,0,5);
  drawoptions(dashed dashpattern(on 12bp off 6bp on 3bp off 6bp));
  drawarrow Projette(Origine)--Projette(Unitex) withcolor blue;
  drawarrow Projette(Origine)--Projette(Unitey) withcolor vert;
  drawarrow Projette(Origine)--Projette(Unitez);
  drawoptions();
enddef;

vardef TraceAxesD(expr xd,yd,zd)=
  drawoptions(dashed dashpattern(on12bp off6bp on3bp off6bp));;
  drawarrow Projette((0,0,0))--Projette((xd,0,0));
  drawarrow Projette((0,0,0))--Projette((0,yd,0));
  drawarrow Projette((0,0,0))--Projette((0,0,zd));
  drawoptions();
  label(btex $x$ etex,Projette((xd+0.3,0,0)));
  label(btex $y$ etex,Projette((0,yd+0.3,0)));
  label(btex $z$ etex,Projette((0,0,zd+0.3)));
enddef;

vardef TraceAxesDD(expr xd,yd,zd,xf,yf,zf)=
  drawoptions(dashed evenly);
  draw Projette((0,0,0))--Projette((xd,0,0));
  draw Projette((0,0,0))--Projette((0,yd,0));
  draw Projette((0,0,0))--Projette((0,0,zd));
  drawoptions();
  drawarrow Projette((xd,0,0))--Projette((xf,0,0));
  drawarrow Projette((0,yd,0))--Projette((0,yf,0));
  drawarrow Projette((0,0,zd))--Projette((0,0,zf));
  label(btex $x$ etex,Projette((xf+0.3,0,0)));
  label(btex $y$ etex,Projette((0,yf+0.3,0)));
  label(btex $z$ etex,Projette((0,0,zf+0.3)));
enddef;

vardef TraceGrille(expr NB)=
  color ppt[];
  for k=0 upto NB:
    ppt[k]:=(k,0,0);
    draw Projette(ppt[k]+(0,0,NB))--Projette(ppt[k])--Projette(ppt[k]+(0,NB,0));
    ppt[k]:=(0,k,0);
    draw Projette(ppt[k]+(NB,0,0))--Projette(ppt[k])--Projette(ppt[k]+(0,0,NB));
    ppt[k]:=(0,0,k);
    draw Projette(ppt[k]+(NB,0,0))--Projette(ppt[k])--Projette(ppt[k]+(0,NB,0));
  endfor;
enddef;

primarydef u Vectprod v =
  (Ypart u * Zpart v - Zpart u * Ypart v,
    Zpart u * Xpart v - Xpart u * Zpart v,
    Xpart u * Ypart v - Ypart u * Xpart v)
enddef;

vardef Normal(expr vecun,vecde,vectr)=
  save aa;
  color aa;
  P1:=redpart(vecde-vecun);
  P2:=greenpart(vecde-vecun);
  P3:=bluepart(vecde-vecun);
  Q1:=redpart(vectr-vecun);
  Q2:=greenpart(vectr-vecun);
  Q3:=bluepart(vectr-vecun);
  aa=(P2*Q3-Q2*P3,P3*Q1-Q3*P1,P1*Q2-Q1*P2);
  aa
enddef;

vardef ProduitScalaire(expr wec,mor)=
  Xpart(wec)*Xpart(mor)+Ypart(wec)*Ypart(mor)+Zpart(wec)*Zpart(mor)
enddef;
%pour les rotations et translations

vardef RotX(expr ptx)=
  (Xpart(ptx),Ypart(ptx)*cosd(angx)-Zpart(ptx)*sind(angx),Ypart(ptx)*sind(angx)+Zpart(ptx)*cosd(angx))
enddef;

vardef RotY(expr ptx)=
  (Xpart(ptx)*cosd(angy)+Zpart(ptx)*sind(angy),Ypart(ptx),-Xpart(ptx)*sind(angy)+Zpart(ptx)*cosd(angy))
enddef;

vardef RotZ(expr ptx)=
  (Xpart(ptx)*cosd(angz)-Ypart(ptx)*sind(angz),Xpart(ptx)*sind(angz)+Ypart(ptx)*cosd(angz),Zpart(ptx))
enddef;

vardef RotXYZ(expr ptx)=
  RotZ(RotY(RotX(ptx)))
enddef;

angx:=0;
angy:=0;
angz:=0;
color TR;
TR:=(0,0,0);
%pour les tubes
vardef VT(expr t)=Fp(t)/Norm(Fp(t))
enddef;

vardef VN(expr t)=Fd(t)/Norm(Fd(t))
enddef;

vardef VBN(expr t)=VT(t) Vectprod VN(t)
enddef;

path feuillet;
numeric _tfig,_nfig;
pair coinbg,coinbd,coinhd,coinhg;
_nfig:=0;

def feuille(expr xa,ya,xb,yb) =
  feuillet := (xa,ya)--(xa,yb)--(xb,yb)--(xb,ya)--cycle;
  coinbg := (xa,ya);
  coinbd := (xb,ya);
  coinhd := (xb,yb);
  coinhg := (xa,yb);
  %modifié le 29.09.04
  z.so=(xpart(coinbg/1cm),ypart(coinbg/1cm));
  z.ne=(xpart(coinhd/1cm),ypart(coinhd/1cm));
  %fin modification
  extra_endfig := "clip currentpicture to feuillet;" & extra_endfig;
enddef;

def figureespace(expr xa,ya,xb,yb) =
  _nfig:=_nfig+1;
  beginfig(_nfig);
    feuille(xa,ya,xb,yb);
    _tfig:= if (xb-xa)>(yb-ya): xb-xa else: yb-ya fi;
        _tfig:=2*_tfig;
enddef; 

def finespace=
endfig;
enddef;

def QS(expr ndeb,nfin)=
  begingroup
    save v,m,x;
    if ndeb<nfin:
      v:=ALT[cpt[ndeb]];
      m:=ndeb;
      for i=(ndeb+1) upto nfin:
	if ALT[cpt[i]]<v:
	  m:=m+1;
	  x:=cpt[m];cpt[m]:=cpt[i];cpt[i]:=x;
	fi
      endfor;
      x:=cpt[m];cpt[m]:=cpt[ndeb];cpt[ndeb]:=x;
      QS(ndeb,m-1);
      QS(m+1,nfin);
    fi
  endgroup
enddef;

boolean Pointilles;
Pointilles:=false;

boolean Vue[];
color Fc[].iso;
boolean Creux;
Creux:=false;

vardef DessineObjetNew=
  numeric ALT[];
  %on détermine les zmax dans le repère spatial de l'écran
  for k=1 upto apj:
    Fc[k].iso:=(0,0,0) for l=1 upto ns[k][0]:
      +Fc[k][l]
    endfor;
    Fc[k].iso:=Fc[k].iso/ns[k][0];
  endfor;
  for k=1 upto apj:
    %ALT[k]=-Zpart(GCoord(Fc[k].iso));
    zmax:=infinity;
    for l=1 upto ns[k][0]:
      t:=-Zpart(GCoord(Fc[k][l]));
      if t<zmax:
	zmax:=t;
      fi;
    endfor;
    ALT[k]=zmax;
    cpt[k]:=k;
  endfor;
  %On trie suivant les zmax
  QS(1,apj);
  %On dessine
  if Pointilles:
    for k=1 upto apj:
      draw for l=1 upto ns[cpt[k]][0]:
	Projette(Fc[cpt[k]][l])--
      endfor
      cycle if Vue[cpt[k]]=false: dashed evenly fi;
    endfor;
  else:
    for k=1 upto apj:
      if Creux=false:
	if Vue[cpt[k]]:
	  fill for l=1 upto ns[cpt[k]][0]:
	    Projette(Fc[cpt[k]][l])--
	  endfor
	  cycle withcolor
	  if arcenciel:
	    lumin(cpt[k])*Hsvtorgb(((cpt[k]/apj)*360,satu,lum))
	  else:
	    lumin(cpt[k])*outcolor
	  fi;
	  if traits:
	    draw for l=1 upto ns[cpt[k]][0]:
	      Projette(Fc[cpt[k]][l])--
	    endfor
	    cycle;
	  fi;
	fi;
      else:
	fill for l=1 upto ns[cpt[k]][0]:
	  Projette(Fc[cpt[k]][l])--
	endfor
	cycle withcolor
	if Vue[cpt[k]]:
	  if arcenciel:
	    lumin(cpt[k])*Hsvtorgb(((cpt[k]/apj)*360,satu,lum))
	  else:
	    lumin(cpt[k])*outcolor
	  fi
	else:
	  lumin(cpt[k])*incolor
	fi;
	if traits:
	  draw for l=1 upto ns[cpt[k]][0]:
	    Projette(Fc[cpt[k]][l])--
	  endfor
	  cycle;
	fi;
      fi;
    endfor;
  fi;
enddef;

color Fc[][];%représente les sommets des différentes faces;

invnormale:=1;%Parfois dans la lecture des fichiers OFF, il est nécessaire d'opposer la normale pour obtenir un bon intérieur-extérieur
boolean OFF,OBJ;%pour utiliser la lumière "correctement"
OFF:=false;
OBJ:=false;

vardef LectureOFF(expr nomsolide)=
  OFF:=true;
  %Détermination du nombre de sommets et de faces.
  string s_;
  s_=readfrom nomsolide;
  string ss[];
  if s_<>EOF:
    ss1 := loptok s_;
    t_ := if ss1="%": 0 else: 1 fi;
    forever:
      ss[incr t_] := loptok s_;
      exitif ss[t_]="";
    endfor
  else: false
  fi;
  NbS:=round(Mexp Mlog_str ss1);
  NF:=round(Mexp Mlog_str ss2);
  message("Il y a "&decimal(NbS)&" sommets.");
  message("Il y a "&decimal(NF)&" faces au total.");
  %Détermination des coordonnées des sommets
  message("Création des sommets.");
  s_:=readfrom nomsolide;
  if debut=0:
    for k=0 upto NbS-1:
      s_:=readfrom nomsolide;
      if s_<>EOF:
	ss1 := loptok s_;
	n_ := if ss1="%": 0 else: 1 fi;
	forever:
	  ss[incr n_] := loptok s_;
	  exitif ss[n_]="";
	endfor
      else: false
      fi;
      Sommet[k]:=(Mexp ((Mlog_str ss1) Mdiv (Mlog echelle)),Mexp ((Mlog_str ss3) Mdiv (Mlog echelle)),Mexp ((Mlog_str ss2) Mdiv (Mlog echelle)));
      %Sommet[k]:=(Mexp (Mlog_str ss1),Mexp (Mlog_str ss3),Mexp (Mlog_str ss2))/echelle;
      %Sommet[k]:=(Mexp (Mlog_str ss1)/echelle,Mexp (Mlog_str ss3)/echelle,Mexp (Mlog_str ss2)/echelle);
    endfor;
  else:
    for k=1 upto NbS:
      s_:=readfrom nomsolide;
      if s_<>EOF:
	ss1 := loptok s_;
	n_ := if ss1="%": 0 else: 1 fi;
	forever:
	  ss[incr n_] := loptok s_;
	  exitif ss[n_]="";
	endfor
      else: false
      fi;
      Sommet[k]:=(Mexp ((Mlog_str ss1) Mdiv (Mlog echelle)),Mexp ((Mlog_str ss3) Mdiv (Mlog echelle)),Mexp ((Mlog_str ss2) Mdiv (Mlog echelle)));
      %Sommet[k]:=(Mexp (Mlog_str ss1),Mexp (Mlog_str ss3),Mexp (Mlog_str ss2))/echelle;
      %Sommet[k]:=(Mexp (Mlog_str ss1)/echelle,Mexp (Mlog_str ss3)/echelle,Mexp (Mlog_str ss2)/echelle);
    endfor;
  fi;
  message("Création des faces.");
  %Détermination des faces
  apj:=0;color cc,dd;
  nbfvues:=0;
  for nf=-4000 upto (-4000+NF)-1:
    s_:=readfrom nomsolide;
     if s_<>EOF:
      ss1 := loptok s_;
      n_ := if ss1="%": 0 else: 1 fi;
      forever:
	ss[incr n_] := loptok s_;
	exitif ss[n_]="";
      endfor
    else: false
    fi;
    apj:=apj+1;
    ns[apj][0]:=Mexp Mlog_str ss1;%pour savoir le nb de sommets par face
    for nl=1 upto ns[apj][0]:
      Fc[apj][nl]:=Sommet[round(Mexp Mlog_str ss[nl+1])];
    endfor;
    dd:=Oeil-Fc[apj][1];
    cc:=invnormale*Normal(Fc[apj][1],Fc[apj][2],Fc[apj][3]);
    if (ProduitScalaire(dd,cc)>=0):
      Vue[apj]:=true;
      nbfvues:=nbfvues+1;
    else:
      if Creux=true:
	Vue[apj]:=false;
      else:
	apj:=apj-1;
      fi;
    fi;
  endfor;
  message("Faces vues déterminees : il y en a "&decimal(nbfvues)&".");
  closefrom nomsolide;
  DessineObjetNew;
enddef;

vardef LectureOBJ(expr nomfichier)=
  OBJ:=true;
  string s_;
  string ss[];
  nbss:=1;
  apj:=0;
  forever:
    s_:=readfrom nomfichier;
    if s_<>EOF:
      ss0 := loptok s_;
      if ss0="v":
	n_:=0;
	forever:
	  ss[incr n_] := loptok s_;
	  exitif ss[n_]="";
	endfor
	Sommet[nbss]:=(Mexp((Mlog_str ss1) Mdiv (Mlog echelle)),Mexp ((Mlog_str ss3) Mdiv (Mlog echelle)),Mexp ((Mlog_str ss2) Mdiv (Mlog echelle)));
	nbss:=incr nbss;
      elseif ss0="f":
	n_:=0;
	forever:
	  ss[incr n_] := loptok s_;
	  exitif ss[n_]="";
	endfor;
	ns[apj][0]:=n_-1;
	for k=1 upto ns[apj][0]:
	  if invnormale=1:
	    Fc[apj][ns[apj][0]-k+1] := Sommet[round(Mexp(Mlog_str ss[k]))]
	    %if unknown OTFc.@[apj][OTFc.@[apj].nb-k+1]:
	  %  show OTFc.@[apj][OTFc.@[apj].nb-k+1];
	  %fi;
	  else:
	    Fc[apj][k] := Sommet[round(Mexp(Mlog_str ss[k]))]
	    %if unknown OTFc.@[apj][k]:
	  %  show OTFc.@[apj][k];
	  %fi;
	  fi;
	endfor;
	if ProduitScalaire(Oeil-Fc[apj][1],Normal(Fc[apj][1],Fc[apj][2],Fc[apj][3]))>=0:
	  Vue[apj]:=true;
	  apj:=apj+1;
	else:
	  if Creux=true:
	    Vue[apj]:=false;
	    apj:=apj+1;
	  fi;
	fi;
      fi;
    fi;
    exitif s_=EOF;
  endfor;
  apj:=apj-1;
  closefrom nomfichier;
  DessineObjetNew
enddef;

nb:=8;

%tube
vardef Tube(expr Fn,dp,ds,rayon,tmin,nbp,pas)=%f,f',f'',rayon du tube,paramètre départ,nb points, pas
  save _tube;
  picture _tube;
  scantokens("vardef F(expr t)="&Fn&" enddef;");
  scantokens("vardef Fp(expr t)="&dp&" enddef;");
  scantokens("vardef Fd(expr t)="&ds&" enddef;");
  color G[][];
%nb point sur le cercle
  NB:=nbp;%nb de pas
  for l=0 upto NB:
    for k=0 upto nb:
      G[l][k]=F(tmin+l*pas)+rayon*(cosd(k*(360/nb))*VN(tmin+l*pas)+sind(k*(360/nb))*VBN(tmin+l*pas));
    endfor;
  endfor;
  apj:=0;
  for l=0 upto (NB-1):
    for k=0 upto nb-1:
      apj:=apj+1;
      cpt[apj]:=apj;
      Fc[apj][1]:=G[l][k];
      Fc[apj][2]:=G[l][k+1];
      Fc[apj][3]:=G[l+1][k+1];
      Fc[apj][4]:=G[l+1][k];
      Fc[apj].iso:=(Fc[apj][1]+Fc[apj][2]+Fc[apj][3]+Fc[apj][4])/4;
      ALT[apj]:=-Zpart(GCoord(Fc[apj][1]));
    endfor;
  endfor;
  QS(1,apj);
  _tube=image(
    for k=1 upto apj:
      fill for l=1 upto 4:
	Projette(Fc[cpt[k]][l])--
      endfor
      cycle withcolor if arcenciel: lumin(cpt[k])*Hsvtorgb((floor((cpt[k]/apj)*360),satu,lum))
	else: lumin(cpt[k])*outcolor fi;
      draw for l=1 upto 4:
	Projette(Fc[cpt[k]][l])--
      endfor
      cycle withpen pencircle scaled0.25bp;
    endfor;
    );
  _tube
enddef;

%Tube new :)
%pour les tubes new :)
vardef T(expr t)=Fp(t)
enddef;

vardef VTn(expr t)=if Norm(T(t))=0:
    T(t)
  else:
    T(t)/Norm(T(t))
  fi
enddef;

vardef VNn(expr t)=
  save _VNBis,__VN;
  color _VNBis,__VN;
  __VN=T(t) Vectprod ((T(t+nn)-T(t-nn))/2);
  if __VN=(0,0,0):
    _VNBis=(0,0,1);
  else:
    __VN:=__VN/Norm(__VN);
    if ProduitScalaire(VNbisprec[t-nn],__VN)>0:
      _VNBis=__VN/Norm(__VN)
    else:
      _VNBis=-(__VN/Norm(__VN))
    fi;
  fi;
  VNbisprec[t]=_VNBis;
  _VNBis
enddef;

vardef VBNn(expr t)=VTn(t) Vectprod VNn(t)
enddef;

vardef Tuben(expr Fn,dp,rayon,tmin,nbp,pas)=%f,f',f'',rayon du tube,paramètre départ,nb points, pas
  save _tuben;
  picture _tuben;
  scantokens("vardef F(expr t)="&Fn&" enddef;");
  scantokens("vardef Fp(expr t)="&dp&" enddef;");
  color G[][];
%nb point sur le cercle
  NB:=nbp;%nb de pas
  nn:=pas;
  %pour gérer le "flip" aux points d'inflexion
  color VNbisprec[];
  VNbisprec[tmin-nn]=T(tmin-nn) Vectprod ((T(tmin)-T(tmin-2*nn))/2);
  %
  ang:=360/nb;
  for l=0 upto NB:
    for k=0 upto nb:
      G[l][k]=F(tmin+l*pas)+rayon*(cosd(k*ang)*VNn(tmin+l*pas)+sind(k*ang)*VBNn(tmin+l*pas));
    endfor;
  endfor;
  apj:=0;
  for l=0 upto (NB-1):
    for k=0 upto nb-1:
      apj:=apj+1;
      cpt[apj]:=apj;
      Fc[apj][1]:=G[l][k];
      Fc[apj][2]:=G[l][k+1];
      Fc[apj][3]:=G[l+1][k+1];
      Fc[apj][4]:=G[l+1][k];
      Fc[apj].iso:=(Fc[apj][1]+Fc[apj][2]+Fc[apj][3]+Fc[apj][4])/4;
      ALT[apj]:=-Zpart(GCoord(Fc[apj].iso));
    endfor;
  endfor;
  QS(1,apj);
  _tuben=image(
    for k=1 upto apj:
      fill for l=1 upto 4:
	Projette(Fc[cpt[k]][l])--
      endfor
      cycle withcolor if arcenciel: lumin(cpt[k])*Hsvtorgb((floor((cpt[k]/apj)*360),satu,lum))
	else: lumin(cpt[k])*outcolor fi;
      draw for l=1 upto 4:
	Projette(Fc[cpt[k]][l])--
      endfor
      cycle withpen pencircle scaled0.25bp;
    endfor;
    );
  _tuben
enddef;


vardef Fonction(expr fn,tmin,tmax,pas)=%fonction
  scantokens("vardef F(expr t)="&fn&" enddef;");
  save _f;
  path _f;
  _f=Projette(F(tmin))
  for k=tmin+pas step pas until tmax:
    --Projette(F(k))
  endfor;
  _f
enddef;

color outcolor,incolor,outcolorbis;

boolean Spar;
Spar:=false;

vardef Sparam(expr fn,umin,umax,upas,vmin,vmax,vpas)=%fonction
  Spar:=true;
  save _Sparam;
  scantokens("vardef Famille(expr u,v)="&fn&" enddef;");
  apj:=0;
  picture _Sparam;
  %On crée les facettes et on calcule la profondeur en Z.
  for k=umin step upas until umax:
    for l=vmin step vpas until vmax:
      apj:=apj+1;
      cpt[apj]:=apj;
      Fc[apj][1]:=Image(Famille(k+upas,l));
      Fc[apj][2]:=Image(Famille(k,l));
      Fc[apj][3]:=Image(Famille(k,l+vpas));
      Fc[apj][4]:=Image(Famille(k+upas,l+vpas));
      Fc[apj].iso:=(Fc[apj][1]+Fc[apj][3])/2;%(Fc[apj][1]+Fc[apj][2]+Fc[apj][3]+Fc[apj][4])/4;
      ALT[apj]:=-Zpart(GCoord(Fc[apj].iso));
      if ProduitScalaire(Oeil-Fc[apj].iso,invnormale*Normal(Fc[apj].iso,Fc[apj][1],Fc[apj][2]))>=0:
	Vue[apj]:=true
      else:
	Vue[apj]:=false
      fi;
    endfor;
  endfor;
  %On range les faces par un QS en fonction de leur profondeur
  QS(1,apj);
  %On affiche toutes les faces par ordre décroissant de profondeur.
  _Sparam=image(
    for k=1 upto apj:
      fill for l=1 upto 4:
	Projette(Fc[cpt[k]][l])--
      endfor
      cycle withcolor if Vue[cpt[k]]:
	if arcenciel: lumin(cpt[k])*Hsvtorgb((floor((cpt[k]/apj)*360),satu,lum))
	else: lumin(cpt[k])*outcolor fi
      else:lumin(cpt[k])*incolor fi;
      if traits=true:
	draw for l=1 upto 4:
	    Projette(Fc[cpt[k]][l])--
	endfor
	cycle withcolor CouleurTraits;
      else:
	draw for l=1 upto 4:
	    Projette(Fc[cpt[k]][l])--
	endfor
	cycle withcolor if Vue[cpt[k]]:
	    if arcenciel: lumin(cpt[k])*Hsvtorgb((floor((cpt[k]/apj)*360),satu,lum))
	  else: lumin(cpt[k])*outcolor fi
	else:lumin(cpt[k])*incolor fi;
      fi;
    endfor;
    );
  Spar:=false;
  _Sparam
enddef;

vardef Revolution(expr fn,umin,umax,upas,vmin,vmax,vpas)=
  Sparam("(xpart(point(u) of "&fn&")*cos(v),xpart(point(u) of "&fn&")*sin(v),ypart(point(u) of "&fn&"))",umin,umax,upas,vmin,vmax,vpas)
enddef;

boolean traits;%sur une idée d'Herbert Voss à propos de pst-solides :)
%sert à désactiver le tracer des traits
%15/07/08:pour l'instant implanter uniquement pour les surfaces en z
traits=true;

boolean arcenciel;%pour essayer d'obtenir des dégradés tels que pst-solides :)
arcenciel=false;

boolean surfz;
surfz:=false;
boolean couleurz;
couleurz=false;
color cz[];
boolean Mcir;
Mcir:=false;
rayd:=0;%sauf si division par 0 :(
%ajout de angtotal et angd pour les cas dans les différents cadrans
angtotal:=360;
angd:=0;

vardef SurfZ(text t_)=
  surfz:=true;
  save _SurfZ;
  picture _SurfZ;
  color alt[];
  nbargument:=0;
  for p_=t_ :
    if string p_:
      scantokens("vardef Fz(expr X,Y)="&p_&" enddef;");
    else:
      nbargument:=nbargument+1;
      NN[nbargument]:=p_;
    fi;
  endfor;
  apj:=0;sign:=0;
  Zmax:=-infinity;
  Zmin:=infinity;
  if nbargument=6:
    xmin:=NN1;
    xmax:=NN2;
    ymin:=NN3;
    ymax:=NN4;
    nblignes:=NN5;
    nbpoints:=NN6;
    IncX:=(xmax-xmin)/nbpoints;
    IncY:=(ymax-ymin)/nblignes;
    color Yc[][],Xc[][],Fc[][];
    for ligne=0 upto nblignes:
      y:=ymax-ligne*IncY;
      x:=xmin;
      Yc[ligne][0]=(x,y,Fz(x,y));
      for k=1 upto nbpoints:
	Yc[ligne][k]=((xmin+k*IncX,y,Fz(xmin+k*IncX,y)));
      endfor;
    endfor;
    for k=0 upto (nblignes-1):
      for l=0 step 3 until (nbpoints-3):
	apj:=apj+1;
	cpt[apj]:=apj;
	Fc[apj][1]:=Yc[k][l];
	Fc[apj][2]:=Yc[k][l+3];
	Fc[apj][3]:=Yc[k+1][l+3];
	Fc[apj][4]:=Yc[k+1][l];
	Fc[apj].iso:=(Fc[apj][1]+Fc[apj][2]+Fc[apj][3]+Fc[apj][4])/4;
	ALT[apj]:=-Zpart(GCoord(Fc[apj].iso));
	if Zpart(Fc[apj].iso)>Zmax:
	  Zmax:=Zpart(Fc[apj].iso);
	fi;
	if Zpart(Fc[apj].iso)<Zmin:
	  Zmin:=Zpart(Fc[apj].iso);
	fi;
	if ProduitScalaire(Oeil-Fc[apj].iso,Normal(Fc[apj].iso,Fc[apj][2],Fc[apj][1]))>=0:
	  Vue[apj]:=true;
	else:
	  Vue[apj]:=false
	fi;
      endfor;
    endfor;
  else:
    raymax:=NN1;
    pray:=NN2;
    nblignes:=NN3;
      for r=rayd step pray until (raymax-pray):
      for y=0 step 1 until (nblignes-1):
	apj:=apj+1;
	cpt[apj]:=apj;
	Fc[apj][1]:=(r*cosd(angd+y*(angtotal/nblignes)),r*sind(angd+y*(angtotal/nblignes)),Fz(r*cosd(angd+y*(angtotal/nblignes)),r*sind(angd+y*(angtotal/nblignes))));
	Fc[apj][2]:=(r*cosd(angd+(y+1)*(angtotal/nblignes)),r*sind(angd+(y+1)*(angtotal/nblignes)),Fz(r*cosd(angd+(y+1)*(angtotal/nblignes)),r*sind(angd+(y+1)*(angtotal/nblignes))));
	Fc[apj][3]:=((r+pray)*cosd(angd+(y+1)*(angtotal/nblignes)),(r+pray)*sind(angd+(y+1)*(angtotal/nblignes)),Fz((r+pray)*cosd(angd+(y+1)*(angtotal/nblignes)),(r+pray)*sind(angd+(y+1)*(angtotal/nblignes))));
	Fc[apj][4]:=((r+pray)*cosd(angd+y*(angtotal/nblignes)),(r+pray)*sind(angd+y*(angtotal/nblignes)),Fz((r+pray)*cosd(angd+y*(angtotal/nblignes)),(r+pray)*sind(angd+y*(angtotal/nblignes))));
	Fc[apj].iso:=(Fc[apj][1]+Fc[apj][2]+Fc[apj][3]+Fc[apj][4])/4;
	if Zpart(Fc[apj].iso)>Zmax:
	  Zmax:=Zpart(Fc[apj].iso);
	fi;
	if Zpart(Fc[apj].iso)<Zmin:
	  Zmin:=Zpart(Fc[apj].iso);
	fi;
	ALT[apj]:=-Zpart(GCoord(Fc[apj].iso));
	if ProduitScalaire(Oeil-Fc[apj].iso,Normal(Fc[apj].iso,Fc[apj][2],Fc[apj][1]))>=0:
	  Vue[apj]:=true;
	else:
	  Vue[apj]:=false
	fi;
      endfor;
    endfor;
  fi;
  %On range les faces par un QS en fonction de leur profondeur
  QS(1,apj);
  %On affiche toutes les faces par ordre décroissant de profondeur.
  _SurfZ=image(
    pickup pencircle scaled 0.25bp;
    for k=1 upto apj:
      fill for l=1 upto 4:
	Projette(Fc[cpt[k]][l])--
      endfor
      cycle withcolor if couleurz:
	  if unknown cz1:Hsvtorgb((floor(((Zpart(Fc[cpt[k]].iso)-Zmin)/(Zmax-Zmin))*360),satu,lum))
	else:
	  ((Zpart(Fc[cpt[k]].iso)-Zmin)/(Zmax-Zmin))[cz2,cz1]
	fi;
      else:
	if Vue[cpt[k]]:
	  if arcenciel: lumin(cpt[k])*Hsvtorgb((floor((cpt[k]/apj)*360),satu,lum))
	  else:lumin(cpt[k])*outcolor fi
	else: lumin(cpt[k])*incolor fi;
	if traits=true:
	  draw for l=1 upto 4:
	      Projette(Fc[cpt[k]][l])--
	  endfor
	  cycle;
	fi;
      fi;
      if traits=true:
	draw for l=1 upto 4:
	    Projette(Fc[cpt[k]][l])--
	endfor
	cycle;
      fi;
    endfor;
    );
  surfz:=false;
  _SurfZ
enddef;

%Objet prédéfinis
vardef ObjetCube(expr ar)=
  NbS:=8;
  Sommet1:=(ar,0,0);
  Sommet2:=(ar,ar,0);
  Sommet3:=(0,ar,0);
  Sommet4:=(0,0,0);
  Sommet5:=(0,0,ar);
  Sommet6:=(ar,0,ar);
  Sommet7:=(ar,ar,ar);
  Sommet8:=(0,ar,ar);
%%Faces
  NF:=6;
  ns[1][0]:=4;Fc[1][1]:=Sommet1;Fc[1][2]:=Sommet2;Fc[1][3]:=Sommet3;Fc[1][4]:=Sommet4;
  ns[2][0]:=4;Fc[2][1]:=Sommet4;Fc[2][2]:=Sommet3;Fc[2][3]:=Sommet8;Fc[2][4]:=Sommet5;
  ns[3][0]:=4;Fc[3][1]:=Sommet1;Fc[3][2]:=Sommet4;Fc[3][3]:=Sommet5;Fc[3][4]:=Sommet6;
  ns[4][0]:=4;Fc[4][1]:=Sommet5;Fc[4][2]:=Sommet8;Fc[4][3]:=Sommet7;Fc[4][4]:=Sommet6;
  ns[5][0]:=4;Fc[5][1]:=Sommet2;Fc[5][2]:=Sommet7;Fc[5][3]:=Sommet8;Fc[5][4]:=Sommet3;
  ns[6][0]:=4;Fc[6][1]:=Sommet1;Fc[6][2]:=Sommet6;Fc[6][3]:=Sommet7;Fc[6][4]:=Sommet2;
  %
  %Détermination des faces
  apj:=0;color cc,dd;
  for nf=1 upto NF:
    apj:=apj+1;
    dd:=Oeil-Fc[nf][1];
    cc:=invnormale*Normal(Fc[nf][1],Fc[nf][2],Fc[nf][3]);
    if (ProduitScalaire(dd,cc)>=0):
      Vue[apj]=true
    else:
      Vue[apj]=false;
    fi;
  endfor;
enddef;

%coloriage et lumière
vardef Hsvtorgb(expr CC)=%CC couleur donnée en hsv d'après http://en.wikipedia.org/wiki/HSL_color_space
  save $;
  color $;
  SSw:=floor(Xpart(CC)/60);
  SSh:=SSw mod 6;
  SSf:=(Xpart(CC)/60)-floor(SSw);
  SSs:=Ypart((CC));
  SSv:=Zpart((CC));
  SSp:=SSv*(1-SSs);
  SSq:=SSv*(1-SSf*SSs);
  SSt:=SSv*(1-(1-SSf)*SSs);
  if SSh=0: $=(SSv,SSt,SSp) elseif SSh=1:$=(SSq,SSv,SSp) elseif SSh=2:$=(SSp,SSv,SSt) elseif SSh=3:$=(SSp,SSq,SSv) elseif SSh=4:$=(SSt,SSp,SSv) elseif SSh=5:$=(SSv,SSp,SSq) fi;
  $
enddef;

marron=Hsvtorgb((60,1,0.3));

intensite:=2;
boolean eclairage;
eclairage:=true;

color Lumiere;

invnormalelum:=1;

vardef lumin(expr nbt)=
  save $;
  numeric $;
  if eclairage=false:
    $=1;
  else:
    color uu,vv;
    uu=Lumiere-Fc[nbt].iso;
    uu:=uu/Norm(uu);
    vv=invnormalelum*Normal(Fc[nbt].iso,Fc[nbt][1],Fc[nbt][2]);
    if Norm(vv)<>0:
      vv:=vv/Norm(vv)
    fi;
    if (surfz) or (Spar) or (OFF) or (OBJ):
      $=intensite*abs(ProduitScalaire(vv,uu))
    else:
      $=intensite*(ProduitScalaire(vv,uu));
    fi;
    if $>1:
      $:=1;
    fi;
  fi;
  $
enddef;


%%sucre

%%Transparence fait par Anthony Phan
picture alphapict_; alphapict_=nullpicture;
color fillcolor; fillcolor=gris;
fgalpha := 0.5; % usual alpha parameter
bgalpha:= 1; % alpha parameter with respect to the background

vardef transparence expr c =
  alphapict_ := nullpicture;
  alphafill_(currentpicture, c);
  addto currentpicture also alphapict_;
enddef;

def alphafill_(expr p, c) =
  begingroup
    save p_, xmax_, xmin_, ymax_, ymin_; picture p_;
    p_ = nullpicture;
    (xmin_, ymin_) = llcorner c; (xmax_, ymax_) = urcorner c;
    addto p_ contour c withcolor bgalpha[background, fillcolor];
    for p__ within p:
      numeric xmin__, xmax__, ymin__, ymax__;
      (xmin__, ymin__) = llcorner p__; (xmax__, ymax__) = urcorner p__;
      if (xmax__<= xmin_) or (xmin__ >= xmax_):
      else:
        if (ymax__<= ymin_) or (ymin__ >= ymax_):
        else:
          if (not clipped p__) and (not bounded p__):
            addto p_ also p__ withcolor
            fgalpha[(redpart p__, greenpart p__, bluepart p__),
            fillcolor];
          else:
            begingroup save alphapict_;
              picture alphapict_; alphapict_ = nullpicture;
              alphafill_(p__, pathpart p__);
              addto p_ also alphapict_;
            endgroup;
          fi
        fi
      fi
    endfor
    clip p_ to c;
    addto alphapict_ also p_;
  endgroup;
enddef;

vardef Cercles(text t)=
  save Cer;
  save n;
  n:=0;
  for p_=t:
    if color p_:
      n:=n+1;
      _T[n]:=p_;
    fi;
  endfor;
  path Cer;
  color ptcer[];
  for k=0 step 5 until 360 :
    ptcer[k div 5]-_T[1]=Distance(_T[1],_T[2])*((_T[4]-_T[3])*cosd(k)/Distance(_T[3],_T[4])+(_T[5]-_T[3])*sind(k)/Distance(_T[3],_T[5]));
  endfor;
  Cer=Projette(ptcer0)
    for k=0 step 5 until 360 :
    ..Projette(ptcer[k div 5])
  endfor
  ..cycle;
  Cer
enddef;

vardef Label@#(expr s,z)=
  save p; picture p;
  label@#(s,Projette(z));
enddef;
vardef DotLabel@#(expr s,z)=
  save p; picture p;
  dotlabel@#(s,Projette(z));
enddef;

vardef DefinirSommets(text t)=
  color t;
  nbauto:=0;
  for p_=t:
    nbauto:=nbauto+1;
    if unknown p_: p_=Sommet[nbauto]; else: p_:=Sommet[nbauto]; fi;
  endfor;
enddef;

vardef DefinirSommetsSection(text t)=
  color t;
  nbauto:=0;
  for p_=t:
    nbauto:=nbauto+1;
    if unknown p_: p_=MSection[nbauto]; else: p_:=MSection[nbauto]; fi;
  endfor;
enddef;

vardef EcrireSommetsPave(text t)=
  if AutoLabel:
    nb:=0;
    for p_=t:
      nb:=nb+1;
      if nb=1:
	label.llft(TEX(""&p_&""),Projette(Sommet1));
      fi;
      if nb=2:
	label.lrt(TEX(""&p_&""),Projette(Sommet2));
      fi;
      if nb=3:
	label.rt(TEX(""&p_&""),Projette(Sommet3));
      fi;
      if nb=4:
	if Pointilles:
	  label.ulft(TEX(""&p_&""),Projette(Sommet4));
	fi;
      fi;
      if nb=5:
	label.ulft(TEX(""&p_&""),Projette(Sommet5));
      fi;
      if nb=6:
	label.lft(TEX(""&p_&""),Projette(Sommet6));
      fi;
      if nb=7:
	label.lrt(TEX(""&p_&""),Projette(Sommet7));
      fi;
      if nb=8:
	label.urt(TEX(""&p_&""),Projette(Sommet8));
      fi;
    endfor;
  fi;
enddef;

endinput;
