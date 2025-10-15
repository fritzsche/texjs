%%%%% epaisseur de tracés %%%%%%%%
numeric eppen;
eppen=0.25;

pickup pencircle scaled eppen;
defaultpen := savepen;

%points pour placer les différents éléments
pair _coinprec;%coinbasgauche de la boite précédente
pair _coincom;%coinbasdroite de la boite afin d'y mettre des commentaires
pair _coinnum;%milieu côté gauche pour placer la numérotation des lignes

%paramètres
numeric Nblignes; Nblignes:=1;
pair DebutListe; DebutListe=(0,0);
boolean NumeroteLignes; NumeroteLignes=false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% couleurs
color CoulLignes; CoulLignes:=black;
color ColBloc; % alias des couleurs de bloc

vardef LATEXSCRATCH primary s =
  write "verbatimtex" to "mptextmp.mp";
  write "%&latex" to "mptextmp.mp";
  write "\documentclass[12pt]{article}" to "mptextmp.mp";
  write "\usepackage{ProfCollege}" to "mptextmp.mp";
  write "\usepackage[utf8]{inputenc}" to "mptextmp.mp";
  write "\usepackage[T1]{fontenc}" to "mptextmp.mp";
  write "\usepackage[sfdefault,lf]{carlito}" to "mptextmp.mp";
  write "\usepackage{pifont}" to "mptextmp.mp";
%  write "\usepackage[french]{babel}" to "mptextmp.mp";
%  write "\usepackage[autolanguage]{numprint}" to "mptextmp.mp";
%  write "\usepackage{amssymb}" to "mptextmp.mp";
%  write "\usepackage{amsmath}" to "mptextmp.mp";
%  write "\usepackage{mathrsfs}" to "mptextmp.mp";
%  write "\usepackage{xcolor}" to "mptextmp.mp";
%  write "\usepackage{calc}" to "mptextmp.mp";
%  write "\newlength{\longbarreheight}" to "mptextmp.mp";
%  write "\setlength{\longbarreheight}{2.1ex+3pt}" to "mptextmp.mp";
%  write "\newlength{\longbarredepth}" to "mptextmp.mp";
%  write "\setlength{\longbarredepth}{0.9ex+3pt}" to "mptextmp.mp";
%  write "\def\longbarre{\vrule height\longbarreheight depth\longbarredepth width0pt}" to "mptextmp.mp";
%  write "\usepackage{graphicx}" to "mptextmp.mp";
%  write "\def\barre{\vrule height2.1ex depth.9ex width0pt}" to "mptextmp.mp";
%  write "\def\demibarre{\vrule height1.4ex depth.6ex width0pt}" to "mptextmp.mp";
  write "\begin{document}" to "mptextmp.mp";
  write "etex" to "mptextmp.mp";
  write "btex "&s&" etex" to "mptextmp.mp";
  write EOF to "mptextmp.mp";
  scantokens "input mptextmp"
enddef;


%Version3
color BleuMouvTrois,dBleuMouvTrois,VioletAppTrois,dVioletAppTrois,OrangeConTrois,OrangeTrois,OrangeListTrois,SonTrois,DSonTrois,EvenementTrois,CapteurTrois,StyloTrois,BlocTrois,BlocDefTrois,BlocDefLigneTrois,MessageTrois,ControleTrois,CapFonceTrois,CloneTrois,FondSonTrois,OvalStyloTrois,FondOvalOp;
BleuMouvTrois=(76/255,151/255,255/255);
dBleuMouvTrois=(66/255,128/255,215/255);
VioletAppTrois=(153/255,102/255,255/255);
dVioletAppTrois=(133/255,92/255,214/255);
OrangeConTrois=(255/255,171/255,25/255);
OrangeTrois=(255/255,140/255,26/255);
OrangeListTrois=(255/255,102/255,26/255);
SonTrois=(207/255,99/255,207/255);
DSonTrois=(201/255,79/255,201/255);
FondSonTrois=(15/255,189/255,140/255);
EvenementTrois=(255/255,191/255,0);
MessageTrois=(230/255,172/255,0);
CapteurTrois=(92/255,177/255,214/255);
CapFonceTrois=(71/255,168/255,209/255);
StyloTrois=(15/255,189/255,140/255);
OvalStyloTrois=(13/255,165/255,122/255);
BlocTrois=(255/255,102/255,128/255);
BlocDefTrois=(255/255,77/255,106/255);
BlocDefLigneTrois=(255/255,51/255,85/255);
ControleTrois=(255/255,171/255,25/255);
CloneTrois=(236/255,156/255,19/255);
FondOvalOp=(89/255,192/255,89/255);

vardef FondOvalAppMenu=
  save $; color $;
  $=dVioletAppTrois;
  $
enddef;

%%%%Alias
def Place expr o =
    if path o: draw o else: draw o fi
enddef;

%impression
boolean print;
print=false;

numeric coefprint;
coefprint:=0.95;

%texte ou symbole droite gauche
boolean symbole;
symbole=true;

%divers
numeric eb;%ecart boite-texte
eb:=3pt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Création des boites
ecrt:=eb/2;%largeur de la bordure de départ des boites Box, OValBox...

vardef Box(text t)=
  save $; path $;
  picture ox;
  ox=image(
      if string t:
      string demitt;
      demitt=t&"\barre";
      label(LATEXSCRATCH(demitt),(0,0));
    else:
      draw t;
    fi;
    );
  $=(llcorner ox+(0,-ecrt))--(lrcorner ox+(0,-ecrt))--(urcorner ox+(0,ecrt))--(ulcorner ox+(0,ecrt))--cycle;
  $
enddef;

vardef RecBox(text t)=
  save $; path $; path xo;
  if string t:
    string demit;
    demit=t&"\demibarre";
    xo=Box(demit);%on crée la boite contenant le texte
  else:
    xo=Box(t);
  fi;
    $=(llcorner xo+(-eb,eb)){dir-90}..{dir0}(llcorner xo)--(lrcorner xo){dir0}..{dir90}(lrcorner xo+(eb,eb))--(urcorner xo+(eb,-eb)){dir90}..{dir180}(urcorner xo)--(ulcorner xo){dir180}..{dir-90}(ulcorner xo+(-eb,-eb))--cycle;
  $
enddef;

%%%%%%%%%%%%%%

%%%%%%% Boites Ovales %%%%%%%%
vardef OvalBox(text t)=
  save $; path $; path xo;
  if string t:
    string demit;
    demit=t&"\barre";
    xo=Box(demit);%on crée la boite contenant le texte
  else:
    xo=Box(t);
  fi;
  $=(llcorner xo+(eb,0))--(lrcorner xo-(eb,0)){dir0}..{dir180}(urcorner xo+(-eb,0))--(ulcorner xo+(eb,0)){dir180}..{dir0}cycle;%on "arrondit" la boite
  $
enddef;

vardef OvalVar(expr ar)=
  save Ovar; picture Ovar;
  save TAvar; path TAvar;
  string TTv;
  TTv=ar&"\barre";
  TAvar=OvalBox(TTv);
  Ovar=image(
      fill TAvar if print=false : withcolor OrangeTrois else : withcolor white fi;
    draw TAvar if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH("\barre\bfseries "&ar),(0,0)) if print=false : withcolor white fi;
    );
  Ovar:=Ovar shifted(-center Ovar);
  Ovar
enddef;

vardef OvalList(text listelist)=
  save CList;  picture CList;
  path TAlist; picture LOCMt;
  LOCMt=ColleBoxNew(listelist);
  TAlist=OvalBox(LOCMt);
  CList=image(
    fill TAlist if print=false : withcolor OrangeListTrois else : withcolor white fi;
    draw LOCMt;
    draw TAlist if print=false : withcolor coefprint*white fi;
    );
  CList:=CList shifted(-center CList);
  CList
enddef;

vardef OvalBloc(expr ar)=
  save $;  picture $;
  path tabloc;
  tabloc=OvalBox(ar);
  $=image(
    fill tabloc if print=false : withcolor BlocTrois else: withcolor white fi;
    draw tabloc if print=true : withcolor black else: withcolor BlocDefLigneTrois fi;
    label(LATEXSCRATCH("\bfseries\barre "&ar),(0,0)) if print=false : withcolor blanc fi;
    );
  $
enddef;

vardef OvalMiniBox(text t)=
  save $; path $; path xo;
  if string t:
    string demit;
    demit=t&"\demibarre";
    xo=Box(demit);%on crée la boite contenant le texte
  else:
    xo=Box(t);
  fi;
  $=(llcorner xo+(eb/2,0))--(lrcorner xo-(eb/2,0)){dir0}..{dir180}(urcorner xo+(-eb/2,0))--(ulcorner xo+(eb/2,0)){dir180}..{dir0}cycle;%on "arrondit" la boite
  $
enddef;

vardef DiamondBox(text t)=
  save $; path $; path xo;
  xo=Box(t);%on crée la boite contenant le texte
  $=(llcorner xo-(eb,0))--(lrcorner xo+(eb,0))--(1/2[lrcorner xo,urcorner xo]+(4eb,0))--(urcorner xo+(eb,0))--(ulcorner xo-(eb,0))--(1/2[llcorner xo,ulcorner xo]+(-4eb,0))--cycle;
  $
enddef;

vardef OvalNb(expr ar)=
  save Onb;  picture Onb;
  path tanb;
  tanb=OvalBox(ar);
  Onb=image(
    fill tanb withcolor white;
    draw tanb if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH("\barre "&ar),(0,0));
    );
  Onb
enddef;

vardef OvalText(expr ar)=
  save $; save TA;
  picture $;
  path TA;
  TA=OvalBox(ar);
  $=image(%
    fill TA withcolor white;
    draw TA if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH("\barre "&ar),(0,0));
    );
    $:=$ shifted(-center $);
  $
enddef;

vardef OvalOp(text listeop)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew(listeop);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OvalApp(text listop)=
  save $;  picture $;
  save ta; path ta;
  save TTap; picture TTap;
  TTap=ColleBoxNew(listop);
  ta=OvalBox(TTap);
  $=image(
      fill ta if print=false : withcolor VioletAppTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    draw TTap;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef OvalSon(text listop)=
  save $;  picture $;
  save ta; path ta;
  save TTap; picture TTap;
  TTap=ColleBoxNew(listop);
  ta=OvalBox(TTap);
  $=image(
      fill ta if print=false : withcolor SonTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    draw TTap;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef OvalMusique(expr ar)=
  save $; save TA;
  picture $;
  if string ar:
    picture TT;
    TT=ColleBoxNew(DoubleNote,"tempo");
    path TA;
    TA=OvalBox(TT);
    $=image(
	fill TA if print : withcolor white else : withcolor StyloTrois fi;
      draw TT if print=true : withcolor coefprint*white fi;
      );
  else:
    message("La commande --OvalStylo-- n'accepte qu'un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef OvalMouv(expr ar)=
  save $;  picture $;
  path ta; string TTm;
  TTm=ar&"\longbarre";
  ta=OvalBox(TTm);
  $=image(
    fill ta if print=false : withcolor BleuMouvTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH("\longbarre "&ar),center ta) if print=false : withcolor blanc fi;
    );
  $
enddef;

vardef OvalMenuCap(expr art)=OvalCapMenu(art) enddef;

vardef OvalCapMenu(expr ar)=
  save $; picture $;
  string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$";
  fi;
  path TAMC;
  TAMC=OvalBox(TTm);
  $=image(
      fill TAMC if print : withcolor white else : withcolor CapFonceTrois fi;
    draw TAMC if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm),center TAMC);
    );
  $
enddef;

vardef OvalCap(text listecap)=
  save Cap;  picture Cap;
  save TAcap; path TAcap;
  save LOCMcap; picture LOCMcap;
  LOCMcap=ColleBoxNew(listecap);
  TAcap=OvalBox(LOCMcap);
  Cap=image(
    fill TAcap if print=false : withcolor CapteurTrois else : withcolor white fi;
    draw LOCMcap;
    draw TAcap if print=false : withcolor coefprint*white fi;
    );
  Cap:=Cap shifted(-center Cap);
  Cap
enddef;

vardef OvalMouvMenu(expr ar)=
  save $;  picture $;
  path ta; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else:
      "\color{white}"&ar&"\hbox to1em{\barre}\color{black}$\blacktriangledown$"
  fi;
  ta=OvalBox(TTm);
  $=image(
      fill ta if print=false : withcolor dBleuMouvTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm),center ta);
    );
  $
enddef;

vardef OvalAppMenu(expr ar)=
  save $;  picture $;
  path ta; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$";
  fi;
  ta=OvalBox(TTm);
  $=image(
      fill ta if print=false : withcolor FondOvalAppMenu else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm),center ta);
    );
  $
enddef;

vardef OvalSonMenu(expr art)=OvalMenuSon(art) enddef;

vardef OvalMenuSon(expr ar)=
  save $; save TA;
  picture $;
  string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$";
  fi;
  path TA;
  TA=OvalBox(TTm);
  $=image(%
    fill TA if print : withcolor white else : withcolor DSonTrois fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm),center TA);
    );
  $
enddef;

vardef OvalMenuControle(expr ar)=
  save $; save TA;
  picture $;
  string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$";
  fi;
  path TA;
  TA=OvalBox(TTm);
  $=image(
      fill TA if print : withcolor white else : withcolor CloneTrois fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm), center TA);
    );
  $
enddef;

vardef OvalStylo(expr ar)=
  save $; save TA;
  picture $;
  string TT,TTI;
  if string ar:
    if print:
      TT=ar&"\hbox to1em{\barre}$\blacktriangledown$"
    else:
      TT=ar&"\hbox to1em{\barre}\color{white}$\blacktriangledown$"
    fi;
    TTI=ar&"\hbox to1em{\barre}\phantom{$\blacktriangledown$}";
    path TA;
    TA=OvalBox(TT);
    $=image(
	fill TA if print : withcolor white else : withcolor OvalStyloTrois fi;
      draw TA if print=false : withcolor coefprint*white fi;
      label(LATEXSCRATCH(TT),(0,0)) if print=false : withcolor white fi;
      );
  else:
    message("La commande --OvalStylo-- n'accepte qu'un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef OvalCouleur(expr redcc,greencc,bluecc)=
  save $; picture $;
  string TTv;
  path tacol;
  TTv="\phantom{10}\barre";
  tacol=OvalBox(TTv);
  $=image(
      fill tacol withcolor (redcc,greencc,bluecc);
    draw tacol;
    );
  $:=$ shifted(-center tacol);
  $
enddef;

vardef OvalMenuEvenement(expr ar)=
  save $; save TA;
  picture $;
  string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$";
  fi;
  path TA;
  TA=OvalBox(TTm);
  $=image(
      fill TA if print : withcolor white else : withcolor MessageTrois fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm), center TA);
    );
  $
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rectangles
vardef RecMouvMenu(expr ar)=
  save $;  picture $;
  path ta; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$"
  fi;
  ta=RecBox(TTm);
  $=image(
      fill ta if print=false : withcolor BleuMouvTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm),center ta);
    );
  $
enddef;

vardef RecMenuApp(expr ar)=
  save $;  picture $;
  save ta; path ta; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$";
  fi;
  ta=RecBox(TTm);
  $=image(
      fill ta if print=false : withcolor VioletAppTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm),center ta);
    );
  $
enddef;

vardef RecMenuOp(expr ar)=
  save $; save TA;
  picture $; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$";
  fi;
  path TA;
  TA=RecBox(TTm);
  $=image(
      fill TA if print : withcolor white else : withcolor FondOvalOp fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm), center TA);
    );
  $
enddef;

vardef RecMenuSon(expr ar)=
  save $; save TA;
  picture $; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$" fi;
  path TA;
  TA=RecBox(TTm);
  $=image(
      fill TA if print : withcolor white else : withcolor SonTrois fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm), center TA);
    );
  $
enddef;

vardef RecEvenementMenu(expr ar)=
  save $;  picture $;
  path ta; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$";
  fi;
  ta=RecBox(TTm);
  $=image(
      fill ta if print=false : withcolor EvenementTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm),center ta);
    );
  $
enddef;

vardef RecMenuCap(expr ar)=
    save $;  picture $;
  path ta; string TTm;
    TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$";
    fi;
  ta=RecBox(TTm);
  $=image(
      fill ta if print=false : withcolor CapteurTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm),center ta);
    );
  $
enddef;

vardef RecMenuVar(expr ar)=
  save $; save TA;
  picture $; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$";
  fi;
  path TA;
  TA=RecBox(TTm);
  $=image(
      fill TA if print : withcolor white else : withcolor OrangeTrois fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm), center TA);
    );
  $
enddef;

vardef RecMenuList(expr ar)=
  save $; save TA;
  picture $; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}$\blacktriangledown$" else: "\color{white}"&ar&"\hbox to1em{\barre}$\blacktriangledown$";
  fi;
  path TA;
  TA=RecBox(TTm);
  $=image(
      fill TA if print : withcolor white else : withcolor OrangeListTrois fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(LATEXSCRATCH(TTm), center TA);
    );
  $
enddef;

%%%%%%% Affichage Complet %%%%%%%%%%%%%
vardef PuzzleBox(text t)=
  save $; path $; path xo;
  xo=Box(t);%on crée la boite contenant le texte
  $=(llcorner xo+(-eb,0)){dir-90}..{dir0}(llcorner xo+(0,-eb))--
    (llcorner xo+(0.375cm,0)+(-eb,-eb)){dir0}..
    {dir0}(llcorner xo+(0.375cm,0)+(0,-2eb))--
    (llcorner xo+(0.625cm,0)+(0,-2eb)){dir0}..
    {dir0}(llcorner xo+(0.625cm,0)+(eb,-eb))--
    (lrcorner xo+(0,-eb)){dir0}..{dir90}(lrcorner xo+(eb,0))--(urcorner xo+(eb,0)){dir90}..{dir-180}(urcorner xo+(0,eb))--
    (ulcorner xo+(0.625cm,0)+(eb,eb)){dir180}..
    {dir180}(ulcorner xo+(0.625cm,0))--
    (ulcorner xo+(0.375cm,0)){dir180}..
    {dir180}(ulcorner xo+(0.375cm,0)+(-eb,eb))--
    (ulcorner xo+(0,eb)){dir-180}..{dir-90}(ulcorner xo+(-eb,0))--cycle;
  $
enddef;

vardef BlocPuzzle(text nombloc)=
  save Bpuzzle; picture Bpuzzle;
  path TABp;   picture LOCMp;
  LOCMp=ColleBoxNew(nombloc);
  TABp=PuzzleBox(LOCMp);
  Bpuzzle=image(
    fill TABp if print=false : withcolor BlocDefTrois else : withcolor white fi;
    draw LOCMp;
    draw TABp  if print=true : withcolor black else: withcolor BlocDefLigneTrois fi;
    );
  Bpuzzle:=Bpuzzle shifted(-center Bpuzzle+(0,-eb/2));
  Bpuzzle
enddef;

vardef ColleBoxNew(text t)=%Pour coller plusieurs boites
  save Colle; picture Colle;
  Colle=nullpicture;
  numeric nbcolle;  nbcolle:=0;
  save NBCOLLE; path NBCOLLE;
  for p_ = t:
    nbcolle:=nbcolle+1;
  endfor;
  picture HOLD;  HOLD:=nullpicture;
  if unknown LONG: LONG:=0 fi;
  if nbcolle=1:%On dessine
    for p_ = t:
      if string p_:
	NBCOLLE:=Box(p_);
	HOLD:=image(
	    label(LATEXSCRATCH("\sffamily\bfseries\longbarre "&p_),(0,0)) if print=false : withcolor white fi;%->ok
	  );
	HOLD:=(HOLD shifted ((xpart((center HOLD)-(llcorner HOLD))+LONG,0)));
      else:
	HOLD:=(p_ shifted ((xpart((center p_)-(llcorner p_))+LONG,0)));
      fi;
    endfor;
    addto Colle also HOLD;
    LONG:=LONG+abs(lrcorner Colle - llcorner Colle)+eb;
  else:%il faut coller les boites une à une
    for p_ = t:
      addto Colle also (ColleBoxNew(p_));
    endfor;
  fi;
  Colle
enddef;

vardef CADRE(expr texti)=
  save $;  path $;
  $=(llcorner texti+(-eb,0)){dir-90}..{dir0}(llcorner texti+(0,-eb))--
    (llcorner texti+(0.375cm,0)+(-eb,-eb)){dir0}..
    {dir0}(llcorner texti+(0.375cm,0)+(0,-2eb))--
    (llcorner texti+(0.625cm,0)+(0,-2eb)){dir0}..
    {dir0}(llcorner texti+(0.625cm,0)+(eb,-eb))--
    (lrcorner texti+(0,-eb)){dir0}..{dir90}(lrcorner texti+(eb,0))--(urcorner texti+(eb,0)){dir90}..{dir-180}(urcorner texti+(0,eb))--
    (ulcorner texti+(0.625cm,0)+(eb,eb)){dir180}..
    {dir180}(ulcorner texti+(0.625cm,0))--
    (ulcorner texti+(0.375cm,0)){dir180}..
    {dir180}(ulcorner texti+(0.375cm,0)+(-eb,eb))--
    (ulcorner texti+(0,eb)){dir-180}..{dir-90}(ulcorner texti+(-eb,0))--cycle;
  $
enddef;

vardef AFFI(expr texta)=
  path cadre;
  cadre=CADRE(texta);
  picture TEXT;
  TEXT=image(%
      fill cadre withcolor if print=true :coefprint*white else: if unknown ColBloc : white else : ColBloc fi; fi;
    draw texta;
    draw cadre withcolor CoulLignes;
    );
  TEXT
enddef;

vardef Affichage(expr textu)=
  save $;
  picture $;
  $=AFFI(textu);
  $:=$ shifted (if unknown _coinprec:(0,0) else :_coinprec fi - (ulcorner $));
_coinprec:=(llcorner $)+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(LATEXSCRATCH("\footnotesize"&decimal(Nblignes)&""),_coinnum);
  Nblignes:=Nblignes+1;
fi;
$
enddef;

%Pour les blocs de type contrôle
vardef CADRECONTROLE(expr texti)=
  save $;  path $;
  path tracecadre;
  $=(llcorner texti+(-eb,-eb))--%(llcorner texti+(0,-eb))--
    (llcorner texti+(0.875cm,0)+(-eb,-eb)){dir0}..
    {dir0}(llcorner texti+(0.875cm,0)+(0,-2eb))--
    (llcorner texti+(1.125cm,0)+(0,-2eb)){dir0}..
    {dir0}(llcorner texti+(1.125cm,0)+(eb,-eb))--
    (lrcorner texti+(0,-eb)){dir0}..{dir90}(lrcorner texti+(eb,0))--(urcorner texti+(eb,0)){dir90}..{dir180}(urcorner texti+(0,eb))--
    (ulcorner texti+(0.625cm,0)+(eb,eb)){dir180}..
    {dir180}(ulcorner texti+(0.625cm,0))--
    (ulcorner texti+(0.375cm,0)){dir180}..
    {dir180}(ulcorner texti+(0.375cm,0)+(-eb,eb))--
    (ulcorner texti+(0,eb)){dir180}..{dir-90}(ulcorner texti+(-eb,0))--cycle;
  tracecadre=(llcorner texti+(0.5cm,0)+(0,-eb))--(llcorner texti+(0.875cm,0)+(-eb,-eb)){dir0}..
    {dir0}(llcorner texti+(0.875cm,0)+(0,-2eb))--
    (llcorner texti+(1.125cm,0)+(0,-2eb)){dir0}..
    {dir0}(llcorner texti+(1.125cm,0)+(eb,-eb))--
    (lrcorner texti+(0,-eb)){dir0}..{dir90}(lrcorner texti+(eb,0))--(urcorner texti+(eb,0)){dir90}..{dir180}(urcorner texti+(0,eb))--
    (ulcorner texti+(0.625cm,0)+(eb,eb)){dir180}..
    {dir180}(ulcorner texti+(0.625cm,0))--
    (ulcorner texti+(0.375cm,0)){dir180}..
    {dir180}(ulcorner texti+(0.375cm,0)+(-eb,eb))--
    (ulcorner texti+(0,eb)){dir180}..{dir-90}(ulcorner texti+(-eb,0))--
    (llcorner texti+(-eb,-eb));
  $
enddef;

vardef AFFICONTROLE(expr texta)=
  path cadre;
  cadre=CADRECONTROLE(texta);
  picture TEXT;
  TEXT=image(
      fill cadre withcolor if print=true :coefprint*white else: if unknown ColBloc : white else : ColBloc fi; fi;
    draw texta;
    draw tracecadre withcolor CoulLignes;
    );
  TEXT
enddef;

vardef AffichageControle(expr textu)=
  save $;
  picture $;
  $=AFFICONTROLE(textu);
  $:=$ shifted (if unknown _coinprec:(0,0) else :_coinprec fi - (ulcorner $));
_coinprec:=llcorner $+(0.5cm,0);
_coinprec:=_coinprec+(0,eb);
coindebutbloc[numblocrep]:=(llcorner $)+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(LATEXSCRATCH("\footnotesize"&decimal(Nblignes)&""),_coinnum);
  Nblignes:=Nblignes+1;
fi;
$
enddef;

vardef CADREED(expr texti)=
  save $; path $;
  $=(llcorner texti+(-eb,0)){dir-90}..{dir0}(llcorner texti+(0,-eb))--
    (llcorner texti+(0.375cm,0)+(-eb,-eb)){dir0}..
    {dir0}(llcorner texti+(0.375cm,0)+(0,-2eb))--
    (llcorner texti+(0.625cm,0)+(0,-2eb)){dir0}..
    {dir0}(llcorner texti+(0.625cm,0)+(eb,-eb))--
    (lrcorner texti+(0,-eb)){dir0}..{dir90}(lrcorner texti+(eb,0))--(urcorner texti+(eb,0)){dir90}..{dir-180}(urcorner texti+(0,eb))--
    1/2[ulcorner texti+(-eb,eb),urcorner texti+(eb,eb)]{dir150}..{dir-150}(ulcorner texti+(-eb,eb))--cycle;
  $
enddef;

vardef AFFIED(expr texta)=
  path cadre;
  cadre=CADREED(texta);
  picture TEXT;
  TEXT=image(
      fill cadre withcolor if print=true :coefprint*white else: if unknown ColBloc : white else : ColBloc fi; fi;
    draw texta;
    draw cadre withcolor CoulLignes;
    );
  TEXT
enddef;

vardef AffichageED(expr textu)=
  save $;
  picture $;
  $=AFFIED(textu);
  $:=$ shifted (if unknown _coinprec:(0,0) else :_coinprec fi - (ulcorner $));
_coinprec:=llcorner $;
_coinprec:=_coinprec+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(LATEXSCRATCH("\footnotesize"&decimal(Nblignes)&""),_coinnum);
  Nblignes:=Nblignes+1;
fi;
$
enddef;

%%% section Mouvement %%%%%%%%%%
vardef Avancer(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  if string nbpas:
    texto=ColleBoxNew("avancer de",OvalNb(nbpas),"pas");
  else:
    texto=ColleBoxNew("avancer de",nbpas,"pas");
  fi;
  ColBloc:=BleuMouvTrois;
  $=Affichage(texto);
  $
enddef;

vardef Arcdroite=
  save $;
  picture $;
  $=image(
      path cc;
    cc=fullcircle scaled 10pt;
    drawarrow reverse(subpath(0,0.75*length cc) of cc) withpen pencircle scaled 2bp if print=false: withcolor white fi;
    );
  $
enddef;

vardef Arcgauche=
  save $;
  picture $;
  $=image(
      path cc;
    cc=fullcircle scaled 10pt;
    drawarrow (subpath(0.75*length cc,1.5*length cc) of cc) withpen pencircle scaled 2bp if print=false: withcolor white fi;
    );
  $
enddef;

vardef Tournerd(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  if string nbpas:
    if symbole=true:
      texto=ColleBoxNew("tourner",Arcdroite,"de",OvalNb(nbpas),"degré(s)");
    else:
      texto=ColleBoxNew("tourner à droite de",OvalNb(nbpas),"degré(s)");
    fi;
  else:
    if symbole=true:
      texto=ColleBoxNew("tourner",Arcdroite,"de",nbpas,"degré(s)");
    else:
      texto=ColleBoxNew("tourner à droite de",nbpas,"degré(s)");
    fi;
  fi;
  ColBloc:=BleuMouvTrois;
  $=Affichage(texto);
  $
enddef;

vardef Tournerg(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  if string nbpas:
    if symbole=true:
      texto=ColleBoxNew("tourner",Arcgauche,"de",OvalNb(nbpas),"degré(s)");
    else:
      texto=ColleBoxNew("tourner à gauche de",OvalNb(nbpas),"degré(s)");
    fi;
  else:
    if symbole=true:
      texto=ColleBoxNew("tourner",Arcgauche,"de",nbpas,"degré(s)");
    else:
      texto=ColleBoxNew("tourner à gauche de",nbpas,"degré(s)");
    fi;
  fi;
  ColBloc:=BleuMouvTrois;
  $=Affichage(texto);
  $
enddef;

vardef Orienter(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  if string nbpas:
    texto=ColleBoxNew("s'orienter à",OvalNb(nbpas));
  else:
    texto=ColleBoxNew("s'orienter à",nbpas);
  fi;
  ColBloc:=BleuMouvTrois;
  $=Affichage(texto);
  $
enddef;

vardef Orienterdirection(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  if string nbpas:
    texto=ColleBoxNew("s'orienter vers",OvalMouvMenu(nbpas));
  else:
    texto=ColleBoxNew("s'orienter vers",nbpas);
  fi;
  ColBloc:=BleuMouvTrois;
  $=Affichage(texto);
  $
enddef;

vardef OrienterVers(expr nbpass)=Orienterdirection(nbpass) enddef;

vardef Aller(expr xa,ya)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("aller à x:",if string xa:OvalNb(xa) else: xa fi,"y:",if string ya:OvalNb(ya) else: ya fi);
  ColBloc:=BleuMouvTrois;
  $=Affichage(texto);
  $
enddef;

vardef Glisser(expr na,xa,ya)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("glisser en",if string na:OvalNb(na) else: na fi,"seconde(s) à x :",if string xa:OvalNb(xa) else: xa fi,"y:",if string ya:OvalNb(ya) else: ya fi);
  ColBloc:=BleuMouvTrois;
  $=Affichage(texto);
  $
enddef;

vardef Allera(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  if string nbpas:
    texto=ColleBoxNew("aller à",OvalMouvMenu(nbpas));
    ColBloc:=BleuMouvTrois;
    $=Affichage(texto);
  else:
    message("");
    message("La commande -- Allera -- n'accepte qu'un type string comme argument.");
    message("");  
    $=nullpicture;
  fi;
  $
enddef;

vardef Glissera(expr na,xa)=
  LONG:=0;
  save $;
  picture $, texto;
  if string xa:
    texto=ColleBoxNew("glisser en",if string na:OvalNb(na) else: na fi,"seconde(s) à",OvalMouvMenu(xa));
  ColBloc:=BleuMouvTrois;
  $=Affichage(texto);
else:
  message("");
  message("La commande -- Glissera -- n'accepte qu'un type string comme deuxième argument.");
    message("");  
  $=nullpicture;
fi;
  $
enddef;

vardef Ajouter(expr nba,xa)=
  LONG:=0;
  save $;
  picture $, texto;
  if string xa:
    texto=ColleBoxNew("ajouter",if string nba:OvalNb(nba) else: nba fi,"à",xa);
  ColBloc:=BleuMouvTrois;
  $=Affichage(texto);
else:
  message("");
  message("La commande -- Ajouter -- n'accepte qu'un type string comme deuxième argument.");
  message("");  
  $=nullpicture;
fi;
$
enddef;

vardef Mettre(expr xa,nba)=
  LONG:=0;
  save $;
  picture $, texto;
  if string xa:
    texto=ColleBoxNew("mettre",xa,"à",if string nba:OvalNb(nba) else: nba fi);
    ColBloc:=BleuMouvTrois;
    $=Affichage(texto);
  else:
    message("");
    message("La commande -- Mettre -- n'accepte qu'un type string comme premier argument.");
    message("");  
    $=nullpicture;
  fi;
  $
enddef;

vardef Rebondir=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("rebondir si le bord est atteint");
  ColBloc:=BleuMouvTrois;
  $=Affichage(texto);
  $
enddef;

vardef FixerSensRotation(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  if string nbpas:
    texto=ColleBoxNew("fixer le sens de rotation",RecMouvMenu(nbpas));%RecMouvMenu(nbpas));
    ColBloc:=BleuMouvTrois;
    $=Affichage(texto);
  else:
    message("La commande --FixerSensRotation-- admet un seul argument de type string");
    $=nullpicture;
  fi;
  $
enddef;  

%%%% fin section Mouvement %%%%%%

%%%%% Section Apparence %%%%%%%%%
vardef DireT(expr na,xa)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("dire",if string na:OvalText(na) else: na fi,"pendant",if string xa : OvalNb(xa) else: xa fi,"seconde(s)");
ColBloc:=VioletAppTrois;
$=Affichage(texto);
$
enddef;

vardef Dire(expr na)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("dire",if string na:OvalText(na) else: na fi);
ColBloc:=VioletAppTrois;
$=Affichage(texto);
$
enddef;

vardef PenserT(expr na,xa)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("penser à",if string na:OvalText(na) else: na fi,"pendant",if string xa : OvalNb(xa) else: xa fi,"seconde(s)");
ColBloc:=VioletAppTrois;
$=Affichage(texto);
$
enddef;

vardef Penser(expr na)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("penser à",if string na:OvalText(na) else: na fi);
ColBloc:=VioletAppTrois;
$=Affichage(texto);
$
enddef;

vardef Montrer=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("montrer");
  ColBloc:=VioletAppTrois;
  $=Affichage(texto);
  $
enddef;

vardef Cacher=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("cacher");
  ColBloc:=VioletAppTrois;
  $=Affichage(texto);
  $
enddef;

vardef Basculer(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("basculer sur le costume",OvalAppMenu(nbpas));
    ColBloc:=VioletAppTrois;
    $=Affichage(texto);
  else:
    message("La commande --Basculer-- n'accepte qu'un argument string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef BasculerCostume(expr nbpass)=Basculer(nbpass) enddef;

vardef CostumeSuivant=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("costume suivant");
  ColBloc:=VioletAppTrois;
  $=Affichage(texto);
$
enddef;

vardef ARSuivant=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("arrière-plan suivant");
  ColBloc:=VioletAppTrois;
  $=Affichage(texto);
$
enddef;

vardef BasculerAR(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("basculer sur l'arrière-plan",OvalAppMenu(nbpas));
    ColBloc:=VioletAppTrois;
    $=Affichage(texto);
  else:
    message("La commande --BasculerAR-- n'accepte qu'un argument string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef BasculerARA(expr nbpas)=%quand la scène est sélectionnée...
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("basculer sur l'arrière-plan",OvalAppMenu(nbpas)," et attendre");
    ColBloc:=VioletAppTrois;
    $=Affichage(texto);
  else:
    message("La commande --BasculerARA-- n'accepte qu'un argument string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef AjouterEffet(expr nbpas,xa)=
  LONG:=0;
  save $;
  picture $,texto;
  if string xa:
    texto=ColleBoxNew("ajouter",if string nbpas: OvalNb(nbpas) else: nbpas fi," à l'effet",RecMenuApp(xa));
  ColBloc:=VioletAppTrois;
  $=Affichage(texto);
else:
  message("La commande --AjouterEffet-- n'accepte qu'un deuxième argument de type string.");
  $=nullpicture;
fi;
$
enddef;

vardef MettreEffet(expr xa,nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string xa:
    texto=ColleBoxNew("mettre l'effet",RecMenuApp(xa),"à",if string nbpas:OvalNb(nbpas) else: nbpas fi);
  ColBloc:=VioletAppTrois;
  $=Affichage(texto);
else:
  message("La commande --MettreEffet-- n'accepte qu'un premier argument de type string.");
  $=nullpicture;
fi;
$
enddef;

vardef AnnulerEffet=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("annuler les effets graphiques");
  ColBloc:=VioletAppTrois;
  $=Affichage(texto);
$
enddef;

vardef AnnulerEffets=AnnulerEffet enddef;

vardef AjouterTaille(expr na)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("ajouter",if string na:OvalNb(na) else: na fi,"à la taille");
ColBloc:=VioletAppTrois;
$=Affichage(texto);
$
enddef;

vardef MettreA(expr na)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("mettre la taille à",if string na:OvalNb(na) else: na fi,"\% de la taille initiale");
ColBloc:=VioletAppTrois;
$=Affichage(texto);
$
enddef;

vardef MettreTaille(expr art)=MettreA(art) enddef;

vardef AllerPlan(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("aller à l'",RecMenuApp(nbpas),"plan");
    ColBloc:=VioletAppTrois;
    $=Affichage(texto);
  else:
    message("La commande --AllerPlan-- n'accepte qu'un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef DeplacerPlan(expr nbpas,xa)=
  LONG:=0;
  save $;
  picture $,texto;
  if string xa:
    texto=ColleBoxNew("déplacer de",if string nbpas:OvalNb(nbpas) else: nbpas fi,"plan(s) vers l'",RecMenuApp(xa));
  ColBloc:=VioletAppTrois;
  $=Affichage(texto);
else:
  message("La commande --DeplacerPlan-- n'accepte qu'un deuxième argument de type string.");
  $=nullpicture;
fi;
$
enddef;
%%%%fin Section Apparance%%%%%%%%%%%%

%%%%%% Section Son%%%%%%%%%%%%
vardef Jouer(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  if string nbpas :
    texto=ColleBoxNew("jouer le son",OvalMenuSon(nbpas));
    ColBloc:=SonTrois;
    $=Affichage(texto);
  else:
    message("La commande --Jouer-- n'accepte qu'un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef JouerT(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  if string nbpas:
    texto=ColleBoxNew("jouer le son",OvalMenuSon(nbpas)," jusqu'au bout");
    ColBloc:=SonTrois;
    $=Affichage(texto);
  else:
    message("La commande --Jouer-- n'accepte qu'un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef ArreterSon=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("arrêter tous les sons");
  ColBloc:=SonTrois;;
  $=Affichage(texto);
  $
enddef;

vardef ArreterSons=ArreterSon enddef;

vardef AjouterVol(expr xa)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("ajouter",if string xa:OvalNb(xa) else: xa fi," au volume");
  ColBloc:=SonTrois;
  $=Affichage(texto);
  $
enddef;

vardef MettreVol(expr xa)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("mettre le volume à",if string xa: OvalNb(xa) else: xa fi,"~\%");
  ColBloc:=SonTrois;
  $=Affichage(texto);
  $
enddef;

vardef AjouterEffetSon(expr nombre, effet)=
  LONG:=0;
  save $;
  picture $, texto;
  if string effet:
    texto=ColleBoxNew("ajouter",if string nombre : OvalNb(nombre) else: nombre fi," à l'effet",RecMenuSon(effet));
  ColBloc:=SonTrois;
  $=Affichage(texto);
else:
  message("La commande -- AjouterEffet -- n'accepte qu'un deuxième argument de type string.");
  $=nullpicture;
fi;
$
enddef;

vardef MettreEffetSon(expr effet,nombre)=
  LONG:=0;
  save $;
  picture $, texto;
  if string effet:
    texto=ColleBoxNew("mettre l'effet",RecMenuSon(effet),"à",if string nombre:OvalNb(nombre) else: nombre fi);
  ColBloc:=SonTrois;
  $=Affichage(texto);
else:
  message("La commande -- MettreEffet -- n'accepte qu'un argument de type string.");
  $=nullpicture;
fi;
$
enddef;

vardef AnnulerEffetSon=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("annuler tous les effets sonores");
  ColBloc:=SonTrois;
  $=Affichage(texto);
  $
enddef;

%Musique
vardef Tambour(expr na,xa)=
  LONG:=0;
  save $;
  picture $, texto;
  if string na:
    texto=ColleBoxNew(DoubleNote,"jouer du tambour",OvalStylo(na),"pendant",if string xa:OvalNb(xa) else: xa fi,"temps");
  ColBloc:=StyloTrois;
  $=Affichage(texto);
else:
  message("La commande --Tambour-- n'accepte qu'un premier argument de type string.");
  $=nullpicture;
fi;
$
enddef;

vardef Pause(expr na)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew(DoubleNote,"faire une pause pendant",if string na: OvalNb(na) else: na fi," temps");
  ColBloc:=StyloTrois;
  $=Affichage(texto);
  $
enddef;

vardef JouerNote(expr na,xa)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew(DoubleNote,"jouer la note",if string na:OvalNb(na) else: na fi," pendant",if string xa:OvalNb(xa) else: xa fi," temps");
ColBloc:=StyloTrois;
$=Affichage(texto);
$
enddef;

vardef ChoisirInstrument(expr na)=
  LONG:=0;
  save $;
  picture $, texto;
  if string na:
    texto=ColleBoxNew(DoubleNote,"choisir l'instrument \no{}",OvalStylo(na));
    ColBloc:=StyloTrois;
    $=Affichage(texto);
  else:
    message("La commande -- ChoisirInstrument -- n'accepte qu'un argument de type string");
    $=nullpicture;
  fi;
  $
enddef;

vardef MettreTempo(expr xa)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew(DoubleNote,"mettre le tempo à",if string xa:OvalNb(xa) else: xa fi);
  ColBloc:=FondSonTrois;
  $=Affichage(texto);
  $
enddef;

vardef AjouterTempo(expr xa)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew(DoubleNote,"ajouter",if string xa:OvalNb(xa) else: xa fi," au tempo");
ColBloc:=FondSonTrois;
$=Affichage(texto);
$
enddef;

vardef DoubleNote=
  save $;
  picture $;
  $=image(
      draw (((0,0)--(0,18pt)) shifted(-12,-9pt)) withpen pencircle scaled 1bp withcolor if print: coefprint*white else: StyloTrois fi;
      draw NoteImage shifted((-5,-2));
    draw NoteImage shifted((3.5,2));
    draw (((0,0)--(0,18pt)) shifted(12,-9pt)) withpen pencircle scaled 1bp withcolor if print: 0.5*coefprint*white else: (69/255,168/255,140/255) fi;%Trop clair->(14/255,187/255,139/255);
);
  $:=$ shifted(-3,0);
  $
enddef;

vardef NoteImage=
  save $;
  picture $;
  $=image(
      linecap := butt;
    linejoin := mitered;
    fill (80.695297,716.262024)..controls (80.574203,716.257996) and (80.476601,716.171997)..(80.480499,716.062988)
      --(80.687500,704.125000)..controls (79.941399,704.570007) and (78.644501,704.637024)..(77.312500,704.223022)
      ..controls (75.503899,703.659973) and (74.339798,702.429993)..(74.710899,701.473022)
      ..controls (75.082001,700.512024) and (76.851601,700.187988)..(78.656303,700.750000)
      ..controls (80.425797,701.301025) and (81.574203,702.504028)..(81.273399,703.453003)
      --(81.125000,711.987976)..controls (82.910202,711.909973) and (86.910202,711.625000)..(84.917999,706.456970)
      ..controls (85.992203,707.906006) and (86.839798,709.598022)..(85.273399,711.629028)
      ..controls (84.378899,712.789001) and (81.617203,713.348022)..(81.062500,715.398010)
      --(81.054703,716.065979)..controls (81.050797,716.176025) and (80.953102,716.262024)..(80.832001,716.262024)
      --cycle if print=false: withcolor white fi;
    pickup pencircle scaled 0.797011bp;
    draw (80.695297,716.262024)..controls (80.574203,716.257996) and (80.476601,716.171997)..(80.480499,716.062988)
      --(80.687500,704.125000)..controls (79.941399,704.570007) and (78.644501,704.637024)..(77.312500,704.223022)
      ..controls (75.503899,703.659973) and (74.339798,702.429993)..(74.710899,701.473022)
      ..controls (75.082001,700.512024) and (76.851601,700.187988)..(78.656303,700.750000)
      ..controls (80.425797,701.301025) and (81.574203,702.504028)..(81.273399,703.453003)
      --(81.125000,711.987976)..controls (82.910202,711.909973) and (86.910202,711.625000)..(84.917999,706.456970)
      ..controls (85.992203,707.906006) and (86.839798,709.598022)..(85.273399,711.629028)
      ..controls (84.378899,712.789001) and (81.617203,713.348022)..(81.062500,715.398010)
      --(81.054703,716.065979)..controls (81.050797,716.176025) and (80.953102,716.262024)..(80.832001,716.262024)
      --cycle if print=false: withcolor white fi;
    pickup pencircle scaled eppen;
    );
  $:=($ rotatedabout((72.000000,699),15)) scaled 0.8;
  $:=$ shifted(-center $);
  $
enddef;

%%%%%% fin Section Son %%%%%%%%%

%%%%%% Section Stylo %%%%%%%%%
vardef ImageCrayon=
  save titi;
  picture titi;
  titi=image(%
      draw CrayonImage shifted(-12,0);
    draw (((0,0)--(0,18pt)) shifted(9,-9)) withpen pencircle scaled 1bp  withcolor if print: 0.5*coefprint*white else: (69/255,168/255,140/255) fi;%Trop clair->(14/255,187/255,139/255);
     );
  titi
enddef;

vardef Effacer=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew(ImageCrayon,"effacer tout");
  ColBloc:=StyloTrois;
  $=Affichage(texto);
  $
enddef;

vardef Estampiller=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew(ImageCrayon,"estampiller");
  ColBloc:=StyloTrois;
  $=Affichage(texto);
  $
enddef;

vardef PoserStylo=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew(ImageCrayon," stylo en position d'écriture");
  ColBloc:=StyloTrois;
  $=Affichage(texto);
$
enddef;

vardef ReleverStylo=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew(ImageCrayon,"relever le stylo");
  ColBloc:=StyloTrois;
  $=Affichage(texto);
$
enddef;

vardef MettreCouleur(expr redc,greenc,bluec)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew(ImageCrayon," mettre la couleur du stylo à",OvalCouleur(redc,greenc,bluec));
  ColBloc:=StyloTrois;
  $=Affichage(texto);
  $
enddef;

vardef AjouterCS(text t)=
  LONG:=0;
  save $;
  picture $,texto;
  numeric k; k=0;
  for p_=t:
    if k=1:string effet; effet=p_ fi;
    if k=0: if string p_:string nombre; nombre=p_ else: if picture p_: picture nombre; nombre=p_; fi fi fi;
    k:=k+1;
  endfor;
  texto=ColleBoxNew(ImageCrayon,"ajouter",if string nombre:OvalNb(nombre) else: nombre fi,"à la",OvalStylo(effet),"du stylo");
ColBloc:=StyloTrois;
$=Affichage(texto);
$
enddef;

vardef MettreCS(text t)=
  LONG:=0;
  save $;
  picture $,texto;
  numeric k; k=0;
  for p_=t:
    if k=0:string effet; effet=p_ fi;
    if k=1: if string p_:string nombre; nombre=p_ else: if picture p_: picture nombre; nombre=p_; fi fi fi;
    k:=k+1;
  endfor;
  texto=ColleBoxNew(ImageCrayon,"mettre la",OvalStylo(effet),"du stylo à",if string nombre:OvalNb(nombre) else: nombre fi);
ColBloc:=StyloTrois;
$=Affichage(texto);
$
enddef;

%taille du stylo
vardef AjouterTS(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew(ImageCrayon,"ajouter",if string nbpas:OvalNb(nbpas) else: nbpas fi,"à la taille du stylo");
ColBloc:=StyloTrois;
$=Affichage(texto);
$
enddef;

vardef MettreTS(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew(ImageCrayon,"mettre la taille du stylo à",if string nbpas:OvalNb(nbpas) else: nbpas fi);
ColBloc:=StyloTrois;
$=Affichage(texto);
$
enddef;

vardef CrayonImage=
  picture cray;
  cray=image(%
      drawoptions (if print=false:withcolor (0.298050,0.556850,0.917650) fi);
    linecap := butt;
    linejoin := mitered;
    fill (0.960938,1.390630)--(1.644530,2.996090)..controls (1.730470,3.199220) and (1.917970,3.500000)..(2.062500,3.664060)..controls (2.324220,3.968750) and (3.539060,2.753910)..(3.234380,2.488280)..controls (3.070310,2.343750) and (2.769530,2.160160)..(2.566410,2.074220)--cycle;
    drawoptions (withcolor (0.349030,0.368640,0.450970));
    pickup pencircle scaled 0.498140bp;
    draw (0.960938,1.390630)--(1.644530,2.996090)..controls (1.730470,3.199220) and (1.917970,3.500000)..(2.062500,3.664060)..controls (2.324220,3.968750) and (3.539060,2.753910)..(3.234380,2.488280)..controls (3.070310,2.343750) and (2.769530,2.160160)..(2.566410,2.074220)--cycle;
    drawoptions (withcolor (1.000000,1.000000,1.000000));
    %pickup pencircle scaled 0.000000bp;
    fill (1.800780,3.363280)--(2.558590,5.156250)..controls (2.601560,5.257810) and (2.699220,5.402340)..(2.777340,5.480470)--(8.281250,10.984400)..controls (8.300780,11.003900) and (8.339840,11.023400)..(8.367190,11.031300)..controls (9.757810,11.398400) and (10.968800,10.187500)..(10.601600,8.792970)..controls (10.593800,8.769530) and (10.574200,8.730470)..(10.554700,8.710940)--(6.316410,4.476560)..controls (5.539060,3.695310) and (4.089840,2.718750)..(3.074220,2.289060)--(2.980470,2.246090)..controls (2.957030,2.238280) and (2.953130,2.242190)..(2.972660,2.261720)..controls (3.539060,2.753910) and (2.324220,3.968750)..(1.800780,3.363280)--cycle;
    drawoptions (if print=false:withcolor (0.349030,0.368640,0.450970) fi);
    pickup pencircle scaled 0.498140bp;
    draw (1.800780,3.363280)--(2.558590,5.156250)..controls (2.601560,5.257810) and (2.699220,5.402340)..(2.777340,5.480470)--(8.281250,10.984400)..controls (8.300780,11.003900) and (8.339840,11.023400)..(8.367190,11.031300)..controls (9.757810,11.398400) and (10.968800,10.187500)..(10.601600,8.792970)..controls (10.593800,8.769530) and (10.574200,8.730470)..(10.554700,8.710940)--(6.316410,4.476560)..controls (5.539060,3.695310) and (4.089840,2.718750)..(3.074220,2.289060)--(2.980470,2.246090)..controls (2.957030,2.238280) and (2.953130,2.242190)..(2.972660,2.261720)..controls (3.539060,2.753910) and (2.324220,3.968750)..(1.800780,3.363280);
    drawoptions (if print=false:withcolor (0.298050,0.556850,0.917650) fi);
    %pickup pencircle scaled 0.000000bp;
    fill (8.316410,11.019500)--(13.031300,15.730500)..controls (13.109400,15.808600) and (13.257800,15.878900)..(13.371100,15.886700)..controls (14.308600,15.949200) and (15.519500,14.734400)..(15.457000,13.796900)..controls (15.449200,13.687500) and (15.378900,13.535200)..(15.300800,13.457000)--(10.589800,8.746090)..controls (10.968800,10.187500) and (9.757810,11.398400)..(8.316410,11.019500)--cycle;
    drawoptions (if print=false:withcolor (0.349030,0.368640,0.450970) fi);
    pickup pencircle scaled 0.498140bp;
    draw (8.316410,11.019500)--(13.031300,15.730500)..controls (13.109400,15.808600) and (13.257800,15.878900)..(13.371100,15.886700)..controls (14.308600,15.949200) and (15.519500,14.734400)..(15.457000,13.796900)..controls (15.449200,13.687500) and (15.378900,13.535200)..(15.300800,13.457000)--(10.589800,8.746090)..controls (10.968800,10.187500) and (9.757810,11.398400)..(8.316410,11.019500)--cycle;
    draw (12.562500,15.265600)..controls (7.937500,15.644500) and (9.453130,10.488300)..(6.117190,11.398400);
    %pickup pencircle scaled 0.000000bp;
    fill (7.199220,12.785200)..controls (6.812500,13.175800) and (6.179690,13.175800)..(5.792970,12.785200)..controls (5.402340,12.398400) and (5.402340,11.765600)..(5.792970,11.378900)..controls (6.179690,10.988300) and (6.812500,10.988300)..(7.199220,11.378900)..controls (7.589840,11.765600) and (7.589840,12.398400)..(7.199220,12.785200)--cycle;
    fill (6.496090,12.082000)--cycle;
    pickup pencircle scaled 0.498140bp;
    draw (7.199220,12.785200)..controls (6.812500,13.175800) and (6.179690,13.175800)..(5.792970,12.785200)..controls (5.402340,12.398400) and (5.402340,11.765600)..(5.792970,11.378900)..controls (6.179690,10.988300) and (6.812500,10.988300)..(7.199220,11.378900)..controls (7.589840,11.765600) and (7.589840,12.398400)..(7.199220,12.785200)--cycle;
    draw (6.496090,12.082000);
    drawoptions();
    pickup pencircle scaled 0bp;
    draw (-3,0)--(-3,18) withcolor if print : coefprint*white else: StyloTrois fi;
    pickup pencircle scaled eppen;
    );
  cray:=cray shifted((0,-9pt));
  cray
enddef;

%%%%%% Fin Section Stylo %%%%%%%%

%%%%%% Section Contrôle %%%%%%%%%
color colControle;
colControle:=OrangeConTrois;

vardef AffichageStop=
  path cadre;
  cadre=(llcorner texto+(-eb,0)){dir-90}..{dir0}(llcorner texto+(0,-eb))--
    (lrcorner texto+(0,-eb)){dir0}..{dir90}(lrcorner texto+(eb,0))--(urcorner texto+(eb,0)){dir90}..{dir180}(urcorner texto+(0,eb))--
    (ulcorner texto+(0.625cm,0)+(eb,eb)){dir180}..
    {dir180}(ulcorner texto+(0.625cm,0))--
    (ulcorner texto+(0.375cm,0)){dir180}..
    {dir180}(ulcorner texto+(0.375cm,0)+(-eb,eb))--
    (ulcorner texto+(0,eb)){dir180}..{dir-90}(ulcorner texto+(-eb,0))--cycle;
  picture TEXT;
  TEXT=image(
      fill cadre withcolor if print : coefprint*white else : if unknown colControle : LightOrange else : colControle fi fi;
    draw texto;
    draw cadre withcolor CoulLignes;
    );
  TEXT
enddef;

pair coindebutbloc[];
numeric numblocrep;
numblocrep:=0;

vardef Repeter(expr xa)=
  LONG:=0;
  save $;
  numblocrep:=numblocrep+1;
  picture $,texto;
  texto=ColleBoxNew("répéter", if string xa : OvalNb(xa) else: xa fi,"fois");
LongRep[numblocrep]:=abs(llcorner texto-lrcorner texto);%afin de conserver la longueur du"répéter..."
ColBloc:=OrangeConTrois;
$=AffichageControle(texto);
$
enddef;

vardef RepeterI=
  LONG:=0;
  save $;
  numblocrep:=numblocrep+1;
  picture $,texto;
  texto=ColleBoxNew("répéter indéfiniment");
  LongRep[numblocrep]:=abs(llcorner texto-lrcorner texto);%afin de conserver la longueur du"répéter..."
  ColBloc:=OrangeConTrois;
  $=AffichageControle(texto);
  $
enddef;

vardef RepeterJ(expr xa)=
  LONG:=0;
  save $;
  numblocrep:=numblocrep+1;
  picture $,texto;
  if picture xa:
    texto=ColleBoxNew("répéter jusqu'à ce que",xa);
    LongRep[numblocrep]:=abs(llcorner texto-lrcorner texto);%afin de conserver la longueur du"répéter..."
    ColBloc:=OrangeConTrois;
    $=AffichageControle(texto);
  else:
    message("La commande -- RepeterJ -- n'admet qu'un argument de type picture.");
    $=nullpicture;
  fi;
  $
enddef;

vardef FinBlocRepeter=
  LONG:=0;
  save $;
  picture $,texto;
  _coinprec:=_coinprec-(0.5cm,0);
  drawoptions();
  texto=image(
      labeloffset:=0;
    label.lrt(LATEXSCRATCH("\hbox to"&decimal(LongRep[numblocrep])&"pt{\phantom{\barre fin du bloc}}"),if unknown _coinprec: (0,0) else:_coinprec fi);
  labeloffset:=3;
  );
path cadre;
cadre=(coindebutbloc[numblocrep]+(0.125,0.125))--
  (coindebutbloc[numblocrep]+(0.0625+0.5cm+eb,0.125)){dir180}..
  {dir-90}(coindebutbloc[numblocrep]+(0.5cm,-eb))--
  (ulcorner texto+(0.5cm,eb)){dir-90}..
  {dir0}(ulcorner texto+(0.5cm+eb,0))--
  (ulcorner texto+(0.5cm+0.375cm,0)){dir0}..%
  {dir0}(ulcorner texto+(0.5cm+0.375cm,0)+(eb,-eb))--%
  (ulcorner texto+(0.5cm+0.625cm,0)+(eb,-eb)){dir0}..%
  {dir0}(ulcorner texto+(0.5cm+0.625cm,0)+(2eb,0))--%  
  (urcorner texto+(-eb,0)){dir0}..
  {dir-90}(urcorner texto+(0,-eb))--
  (lrcorner texto+(0,eb)){dir-90}..
  {dir180}(lrcorner texto+(-eb,0))--
  (llcorner texto+(0.125+0.625cm,0)+(2eb,0)){dir180}..
  {dir180}(llcorner texto+(0.125+0.625cm,0)+(eb,-eb))--
  (llcorner texto+(0.125+0.375cm,0)+(eb,-eb)){dir180}..
  {dir180}(llcorner texto+(0.125+0.375cm,0))--
  (llcorner texto+(0.125,0)+(eb,0)){dir180}..
  {dir90}(llcorner texto+(0.125,0)+(0,eb))--  
  cycle;
$=image(
    fill cadre withcolor if print : coefprint*white else : if unknown colControle : LightOrange else : colControle fi fi;
  draw cadre withcolor if print : coefprint*white else : if unknown colControle : LightOrange else : colControle fi fi;
  AA:=ahangle;
  ahangle:=90;
  drawarrow (lrcorner texto+(-0.625cm,0.15cm)){dir-15}..{dir90}(urcorner texto+(-0.25cm,-0.1cm)) withpen pencircle scaled2bp if print=false : withcolor white fi;
  ahangle:=AA;
  draw (coindebutbloc[numblocrep]+(0.0625+0.5cm+eb,0.125)){dir180}..
    {dir-90}(coindebutbloc[numblocrep]+(0.5cm,-eb))--
    (ulcorner texto+(0.5cm,eb)){dir-90}..
    {dir0}(ulcorner texto+(0.5cm+eb,0))--
    (ulcorner texto+(0.5cm+0.375cm,0)){dir0}..%
    {dir0}(ulcorner texto+(0.5cm+0.375cm,0)+(eb,-eb))--%
    (ulcorner texto+(0.5cm+0.625cm,0)+(eb,-eb)){dir0}..%
    {dir0}(ulcorner texto+(0.5cm+0.625cm,0)+(2eb,0))--%  
    (urcorner texto+(-eb,0)){dir0}..
    {dir-90}(urcorner texto+(0,-eb))--
    (lrcorner texto+(0,eb)){dir-90}..
    {dir180}(lrcorner texto+(-eb,0))--
    (llcorner texto+(0.125+0.625cm,0)+(2eb,0)){dir180}..
    {dir180}(llcorner texto+(0.125+0.625cm,0)+(eb,-eb))--
    (llcorner texto+(0.125+0.375cm,0)+(eb,-eb)){dir180}..
    {dir180}(llcorner texto+(0.125+0.375cm,0))--
    (llcorner texto+(0.125,0)+(eb,0)){dir180}..
    {dir90}(llcorner texto+(0.125,0)+(0,eb))--(coindebutbloc[numblocrep]+(0.125,0.125)) withcolor CoulLignes;
  );
_coinprec:=(llcorner $);
_coinprec:=_coinprec+(0,eb);
numblocrep:=numblocrep-1;
$
enddef;

vardef FinBlocRepeterI=FinBlocRepeter enddef;

vardef BlocUserFinRepeter(expr col)=
  colControle:=col;
  FinBlocRepeter
enddef;

vardef Si(expr xa)=
  LONG:=0;
  save $;
  numblocrep:=numblocrep+1;
  picture $,texto;
  if picture xa:
    texto=ColleBoxNew("si\hbox to1em{}",xa,"alors");
    LongRep[numblocrep]:=abs(llcorner texto-lrcorner texto);%afin de conserver la longueur du"répéter..."
    ColBloc:=OrangeConTrois;
    $=AffichageControle(texto);
  else:
    message("La commande -- Si -- n'admet qu'un argument de type picture.");
    $=nullpicture;
  fi;
  $
enddef;

vardef FinBlocSi=
  LONG:=0;
  save $;
  picture $,texto;
  _coinprec:=_coinprec-(0.5cm,0);
  drawoptions();
  texto=image(
      labeloffset:=0;
    label.lrt(LATEXSCRATCH("\hbox to"&decimal(LongRep[numblocrep])&"pt{\phantom{\barre fin du bloc}}"),if unknown _coinprec: (0,0) else:_coinprec fi);
  labeloffset:=3;
  );
path cadre;
if BlocStopAvant=false:
  cadre=(coindebutbloc[numblocrep]+(0.125,0.125))--
    (coindebutbloc[numblocrep]+(0.0625+0.5cm+eb,0.125)){dir180}..
    {dir-90}(coindebutbloc[numblocrep]+(0.5cm,-eb))--
    (ulcorner texto+(0.5cm,eb)){dir-90}..
    {dir0}(ulcorner texto+(0.5cm+eb,0))--
    (ulcorner texto+(0.5cm+0.375cm,0)){dir0}..%
    {dir0}(ulcorner texto+(0.5cm+0.375cm,0)+(eb,-eb))--%
    (ulcorner texto+(0.5cm+0.625cm,0)+(eb,-eb)){dir0}..%
    {dir0}(ulcorner texto+(0.5cm+0.625cm,0)+(2eb,0))--%  
    (urcorner texto+(-eb,0)){dir0}..
    {dir-90}(urcorner texto+(0,-eb))--
    (lrcorner texto+(0,eb)){dir-90}..
    {dir180}(lrcorner texto+(-eb,0))--
    (llcorner texto+(0.125+0.625cm,0)+(2eb,0)){dir180}..
    {dir180}(llcorner texto+(0.125+0.625cm,0)+(eb,-eb))--
    (llcorner texto+(0.125+0.375cm,0)+(eb,-eb)){dir180}..
    {dir180}(llcorner texto+(0.125+0.375cm,0))--
    (llcorner texto+(0.125,0)+(eb,0)){dir180}..
    {dir90}(llcorner texto+(0.125,0)+(0,eb))--  
    cycle;
else:
  cadre=(coindebutbloc[numblocrep]+(0.125,0.125))--
    (coindebutbloc[numblocrep]+(0.0625+0.5cm,0)+(eb,0.125)){dir180}..
    {dir-90}(coindebutbloc[numblocrep]+(0.5cm,0)+(0,-eb))--
    (ulcorner texto+(0.5cm,0)+(0,eb)){dir-90}..
    {dir0}(ulcorner texto+(0.5cm,0)+(eb,0))--
%	(ulcorner texto+(0.125+0.875cm,0)){dir0}..
%	{dir0}(ulcorner texto+(0.125+0.875cm,0)+(eb,-eb))--
%	(ulcorner texto+(0.125+1.125cm,0)+(eb,-eb)){dir0}..
%	{dir0}(ulcorner texto+(0.125+1.125cm,0)+(2eb,0))--%--%      
    (urcorner texto+(-eb,0)){dir0}..
    {dir-90}(urcorner texto+(0,-eb))--
    (lrcorner texto+(0,eb)){dir-90}..
    {dir180}(lrcorner texto+(-eb,0))--
    (llcorner texto+(0.125+0.625cm,0)+(2eb,0)){dir180}..
    {dir180}(llcorner texto+(0.125+0.625cm,0)+(eb,-eb))--
    (llcorner texto+(0.125+0.375cm,0)+(eb,-eb)){dir180}..
    {dir180}(llcorner texto+(0.125+0.375cm,0))--
    (llcorner texto+(0.125,0)+(eb,0)){dir180}..
    {dir90}(llcorner texto+(0.125,0)+(0,eb))--
    cycle;
fi;
$=image(
    fill cadre withcolor if print : coefprint*white else : if unknown colControle : LightOrange else : colControle fi fi;
  draw cadre withcolor if print : coefprint*white else : if unknown colControle : LightOrange else : colControle fi fi;
  if BlocStopAvant=false:
    draw (coindebutbloc[numblocrep]+(0.0625+0.5cm,0)+(eb,0)){dir180}..
      {dir-90}(coindebutbloc[numblocrep]+(0.5cm,0)+(0,-eb))--
      (ulcorner texto+(0.5cm,0)+(0,eb)){dir-90}..
      {dir0}(ulcorner texto+(0.5cm,0)+(eb,0))--
      (ulcorner texto+(0.125+0.875cm,0)){dir0}..
      {dir0}(ulcorner texto+(0.125+0.875cm,0)+(eb,-eb))--
      (ulcorner texto+(0.125+1.125cm,0)+(eb,-eb)){dir0}..
      {dir0}(ulcorner texto+(0.125+1.125cm,0)+(2eb,0))--%--%      
      (urcorner texto+(-eb,0)){dir0}..
      {dir-90}(urcorner texto+(0,-eb))--
      (lrcorner texto+(0,eb)){dir-90}..
      {dir180}(lrcorner texto+(-eb,0))--
      (llcorner texto+(0.125+0.625cm,0)+(2eb,0)){dir180}..
      {dir180}(llcorner texto+(0.125+0.625cm,0)+(eb,-eb))--
      (llcorner texto+(0.125+0.375cm,0)+(eb,-eb)){dir180}..
      {dir180}(llcorner texto+(0.125+0.375cm,0))--
      (llcorner texto+(0.125,0)+(eb,0)){dir180}..
      {dir90}(llcorner texto+(0.125,0)+(0,eb))--
      (coindebutbloc[numblocrep]+(0.125,0.125))
       withcolor CoulLignes;
  else:
    draw (coindebutbloc[numblocrep]+(0.0625+0.5cm,0)+(eb,0.125)){dir180}..
      {dir-90}(coindebutbloc[numblocrep]+(0.5cm,0)+(0,-eb))--
      (ulcorner texto+(0.5cm,0)+(0,eb)){dir-90}..
      {dir0}(ulcorner texto+(0.5cm,0)+(eb,0))--
	%(ulcorner texto+(0.125+0.875cm,0)){dir0}..
	%{dir0}(ulcorner texto+(0.125+0.875cm,0)+(eb,-eb))--
	%(ulcorner texto+(0.125+1.125cm,0)+(eb,-eb)){dir0}..
	%{dir0}(ulcorner texto+(0.125+1.125cm,0)+(2eb,0))--%--%      
      (urcorner texto+(-eb,0)){dir0}..
      {dir-90}(urcorner texto+(0,-eb))--
      (lrcorner texto+(0,eb)){dir-90}..
      {dir180}(lrcorner texto+(-eb,0))--
      (llcorner texto+(0.125+0.625cm,0)+(2eb,0)){dir180}..
      {dir180}(llcorner texto+(0.125+0.625cm,0)+(eb,-eb))--
      (llcorner texto+(0.125+0.375cm,0)+(eb,-eb)){dir180}..
      {dir180}(llcorner texto+(0.125+0.375cm,0))--
      (llcorner texto+(0.125,0)+(eb,0)){dir180}..
      {dir90}(llcorner texto+(0.125,0)+(0,eb))--
      (coindebutbloc[numblocrep]+(0.125,0.125))
      withcolor CoulLignes;
  fi;
  );
_coinprec:=(llcorner $);
_coinprec:=_coinprec+(0,eb);
numblocrep:=numblocrep-1;
$
enddef;

boolean BlocStopAvant;
BlocStopAvant=false;

vardef Sinon=
  LONG:=0;
  save $;
  picture $,texto;
  _coinprec:=_coinprec-(0.5cm,0);
  drawoptions();
  texto=image(
      labeloffset:=0;
    label.lrt(LATEXSCRATCH("\, \hbox to"&decimal(LongRep[numblocrep])&"pt{\bfseries\longbarre sinon}"),if unknown _coinprec: (0,0) else:_coinprec fi) if print=false : withcolor blanc fi;
  labeloffset:=3;
  );
  path cadre;
  if BlocStopAvant=false:
      cadre=(llcorner texto+(0.125,0))--
	(coindebutbloc[numblocrep]+(0.125,0.125))--
	(coindebutbloc[numblocrep]+(0.0625+0.5cm,0)+(eb,0.125)){dir180}..
	{dir-90}(coindebutbloc[numblocrep]+(0.5cm,0)+(0,-eb))--
	(ulcorner texto+(0.5cm,0)+(0,eb)){dir-90}..
	{dir0}(ulcorner texto+(0.5cm,0)+(eb,0))--
	(ulcorner texto+(0.125+0.875cm,0)){dir0}..
	{dir0}(ulcorner texto+(0.125+0.875cm,0)+(eb,-eb))--
	(ulcorner texto+(0.125+1.125cm,0)+(eb,-eb)){dir0}..
	{dir0}(ulcorner texto+(0.125+1.125cm,0)+(2eb,0))--%--%      
	(urcorner texto+(-eb,0)){dir0}..
	{dir-90}(urcorner texto+(0,-eb))--
	(lrcorner texto+(0,eb)){dir-90}..
	{dir180}(lrcorner texto+(-eb,0))--
	(llcorner texto+(0.125+1.125cm,0)+(2eb,0)){dir180}..
	{dir180}(llcorner texto+(0.125+1.125cm,0)+(eb,-eb))--
	(llcorner texto+(0.125+0.875cm,0)+(eb,-eb)){dir180}..
	{dir180}(llcorner texto+(0.125+0.875cm,0))--  
	cycle;
    else:
      cadre=(llcorner texto+(0.125,0))--
	(coindebutbloc[numblocrep]+(0.125,0.125))--
	(coindebutbloc[numblocrep]+(0.0625+0.5cm,0)+(eb,0.125)){dir180}..
	{dir-90}(coindebutbloc[numblocrep]+(0.5cm,0)+(0,-eb))--
	(ulcorner texto+(0.5cm,0)+(0,eb)){dir-90}..
	{dir0}(ulcorner texto+(0.5cm,0)+(eb,0))--
%	(ulcorner texto+(0.125+0.875cm,0)){dir0}..
%	{dir0}(ulcorner texto+(0.125+0.875cm,0)+(eb,-eb))--
%	(ulcorner texto+(0.125+1.125cm,0)+(eb,-eb)){dir0}..
%	{dir0}(ulcorner texto+(0.125+1.125cm,0)+(2eb,0))--%--%      
	(urcorner texto+(-eb,0)){dir0}..
	{dir-90}(urcorner texto+(0,-eb))--
	(lrcorner texto+(0,eb)){dir-90}..
	{dir180}(lrcorner texto+(-eb,0))--
	(llcorner texto+(0.125+1.125cm,0)+(2eb,0)){dir180}..
	{dir180}(llcorner texto+(0.125+1.125cm,0)+(eb,-eb))--
	(llcorner texto+(0.125+0.875cm,0)+(eb,-eb)){dir180}..
	{dir180}(llcorner texto+(0.125+0.875cm,0))--  
	cycle;
    fi;
$=image(
    fill cadre withcolor if print=true : coefprint*white else : if unknown colControle : LightOrange else : colControle fi fi;
  draw cadre withcolor if print=true : coefprint*white else : if unknown colControle : LightOrange else : colControle fi fi;
  draw texto;
    if BlocStopAvant=false:
      draw (coindebutbloc[numblocrep]+(0.0625+0.5cm,0)+(eb,0.125)){dir180}..
	{dir-90}(coindebutbloc[numblocrep]+(0.5cm,0)+(0,-eb))--
	(ulcorner texto+(0.5cm,0)+(0,eb)){dir-90}..
	{dir0}(ulcorner texto+(0.5cm,0)+(eb,0))--
	(ulcorner texto+(0.125+0.875cm,0)){dir0}..
	{dir0}(ulcorner texto+(0.125+0.875cm,0)+(eb,-eb))--
	(ulcorner texto+(0.125+1.125cm,0)+(eb,-eb)){dir0}..
	{dir0}(ulcorner texto+(0.125+1.125cm,0)+(2eb,0))--%--%      
	(urcorner texto+(-eb,0)){dir0}..
	{dir-90}(urcorner texto+(0,-eb))--
	(lrcorner texto+(0,eb)){dir-90}..
	{dir180}(lrcorner texto+(-eb,0))--
	(llcorner texto+(0.125+1.125cm,0)+(2eb,0)){dir180}..
	{dir180}(llcorner texto+(0.125+1.125cm,0)+(eb,-eb))--
	(llcorner texto+(0.125+0.875cm,0)+(eb,-eb)){dir180}..
	{dir180}(llcorner texto+(0.125+0.875cm,0))--
	(llcorner texto+(0.125+0.5cm+eb,0))
	 withcolor CoulLignes;
    else:
            draw (coindebutbloc[numblocrep]+(0.0625+0.5cm,0)+(eb,0.125)){dir180}..
	{dir-90}(coindebutbloc[numblocrep]+(0.5cm,0)+(0,-eb))--
	(ulcorner texto+(0.5cm,0)+(0,eb)){dir-90}..
	{dir0}(ulcorner texto+(0.5cm,0)+(eb,0))--
	%(ulcorner texto+(0.125+0.875cm,0)){dir0}..
	%{dir0}(ulcorner texto+(0.125+0.875cm,0)+(eb,-eb))--
	%(ulcorner texto+(0.125+1.125cm,0)+(eb,-eb)){dir0}..
	%{dir0}(ulcorner texto+(0.125+1.125cm,0)+(2eb,0))--%--%      
	(urcorner texto+(-eb,0)){dir0}..
	{dir-90}(urcorner texto+(0,-eb))--
	(lrcorner texto+(0,eb)){dir-90}..
	{dir180}(lrcorner texto+(-eb,0))--
	(llcorner texto+(0.125+1.125cm,0)+(2eb,0)){dir180}..
	{dir180}(llcorner texto+(0.125+1.125cm,0)+(eb,-eb))--
	(llcorner texto+(0.125+0.875cm,0)+(eb,-eb)){dir180}..
	{dir180}(llcorner texto+(0.125+0.875cm,0))
	withcolor CoulLignes;
    fi;
    draw (llcorner texto+(0.125,0))--(coindebutbloc[numblocrep]+(0.125,0.125)) withcolor CoulLignes;
    );
  _coinprec:=(llcorner $)+(0.5cm,0);
  _coinprec:=_coinprec+(0,eb);
  coindebutbloc[numblocrep]:=(llcorner $)+(0,eb+0.125);
  $
enddef;

vardef Attendre(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("attendre",if string nbpas:OvalNb(nbpas) else: nbpas fi,"seconde(s)");
ColBloc:=OrangeConTrois;
$=Affichage(texto);
$
enddef;
  
vardef AttendreJ(expr xa)=
  LONG:=0;
  save $;
  picture $,texto;
  if picture xa:
    texto=ColleBoxNew("attendre jusqu'à ce que",xa);
    ColBloc:=OrangeConTrois;
    $=Affichage(texto);
  else:
    message("La commande -- AttendreJ -- n'admet qu'un argument de type picture.");
    $=nullpicture;
  fi;
  $
enddef;

vardef Stop(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  string TTm;%Pour sauvegarder le nbpas car en l'utilisant dans les if, il ne permet pas la concaténation...
  TTm=if print:nbpas&"\hbox to1em{\barre}$\blacktriangledown$" else:"\color{white}"&nbpas&"\hbox to1em{\barre}$\blacktriangledown$";
  fi;
  texto=image(
      path ti;
    ti=Box("stop");
    label(LATEXSCRATCH("\bfseries\barre stop"),center ti) if print=false : withcolor white fi;%_>ok
    if picture nbpas:
      picture ta;
      ta=nbpas;
      drawoptions(shifted (xpart((lrcorner ti)-(llcorner ta)+(eb,0)),ypart(center ti-center ta)));
      draw ta;
      drawoptions();
    else:
      path ta;
      ta=RecBox(TTm);%
      drawoptions(shifted (xpart((lrcorner ti)-(llcorner ta)+(eb,0)),ypart(center ti-center ta)));
      if print=false : fill ta withcolor ControleTrois fi;
      draw ta withcolor 0.95white;
      label(LATEXSCRATCH(TTm),center ta);
      drawoptions();
    fi;
  );
$=AffichageStop shifted (if unknown _coinprec:(0,0) else :_coinprec fi - ulcorner AffichageStop);
_coinprec:=llcorner $;
_coinprec:=_coinprec;%+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(LATEXSCRATCH("\footnotesize"&decimal(Nblignes)&""),_coinnum);
  Nblignes:=Nblignes+1;
fi;
$
enddef;

vardef CommencerClone=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("quand je commence comme un clone");
  ColBloc:=ControleTrois;
  $=AffichageED(texto);
  $
enddef;

vardef CreerClone(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("créer un clone de",OvalMenuControle(nbpas));
    ColBloc:=ControleTrois;
    $=Affichage(texto);
  else:
    message("La commande -- CreerClone -- accepte un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef SupprimerClone=
  LONG:=0;
  save $;
  picture $,texto;
  texto=image(
      path ti;
    ti=Box("supprimer ce clone");
    label(LATEXSCRATCH("\bfseries\barre supprimer ce clone"),center ti) if print=false : withcolor white fi;%_>ok
    );
  $=AffichageStop shifted (if unknown _coinprec:(0,0) else :_coinprec fi - ulcorner AffichageStop);
_coinprec:=llcorner $;
_coinprec:=_coinprec+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(LATEXSCRATCH("\footnotesize"&decimal(Nblignes)&""),_coinnum);
  Nblignes:=Nblignes+1;
fi;
$
enddef;
%%fin Section Contrôle%%%

%%%%%%%% Section Evenements %%%%%
vardef Drapeau=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("quand",DrapeauImage shifted(-(80,707)),"est cliqué");
  ColBloc:=EvenementTrois;
  $=AffichageED(texto);
  $
enddef;

vardef QPresse(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("quand la touche",RecEvenementMenu(nbpas),"est pressée");
    ColBloc:=EvenementTrois;
    $=AffichageED(texto);
  else:
    message("La commande -- QPresse -- accepte un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef QLutinPresse=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("quand ce sprite est cliqué");
  ColBloc:=EvenementTrois;
  $=AffichageED(texto);
  $
enddef;

vardef QSpritePresse=QLutinPresse enddef;

vardef QScenePressee=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("quand la scène est cliquée");
  ColBloc:=EvenementTrois;
  $=AffichageED(texto);
  $
enddef;

vardef QBasculeAR(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("quand l'arrière-plan bascule sur",RecEvenementMenu(nbpas));
    ColBloc:=EvenementTrois;
    $=AffichageED(texto);
  else:
    message("La commande -- QBasculeAR -- accepte un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef QVolumeSup(expr nbpas,xa)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("quand le",RecEvenementMenu(nbpas),"$>$",if string xa:OvalNb(xa) else: xa fi);
  ColBloc:=EvenementTrois;
  $=AffichageED(texto);
else:
  message("La commande -- QVolumeSup -- accepte un premier argument de type string.");
  $=nullpicture;
fi;
$
enddef;

vardef QRecevoirMessage(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("quand je reçois",RecEvenementMenu(nbpas));
    ColBloc:=EvenementTrois;
    $=AffichageED(texto);
  else:
    message("La commande -- QRecevoirMessage -- accepte un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef EnvoyerMessage(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("envoyer à tous",OvalMenuEvenement(nbpas));
    ColBloc:=EvenementTrois;
    $=Affichage(texto);
  else:
    message("La commande -- EnvoyerMessage -- accepte un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef EnvoyerMessageA(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("envoyer à tous",OvalMenuEvenement(nbpas),"et attendre");
    ColBloc:=EvenementTrois;
    $=Affichage(texto);
  else:
    message("La commande -- EnvoyerMessageA -- accepte un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef DrapeauImage=
  save $; picture $;
  $=image(
      linecap := butt;
    linejoin := rounded;
    if print = false: drawoptions(withcolor(76/255,191/255,86/255)) fi;
    fill (72.000000,713.254028)--(72.000000,718.918030)--(72.507797,718.979980)
      --(72.984398,719.026978)--(73.437500,719.054993)--(73.867203,719.070007)
      --(74.273399,719.073975)--(74.660202,719.062988)--(75.023399,719.043030)
      --(75.367203,719.012024)--(75.695297,718.968994)--(76.003899,718.918030)
      --(76.300797,718.859009)--(76.578102,718.793030)--(76.847702,718.723022)
      --(77.105499,718.648010)--(77.351601,718.570007)--(77.589798,718.484009)
      --(77.820297,718.401978)--(78.042999,718.312988)--(78.234398,718.237976)
      --(78.234398,706.906006)--(78.042999,706.979980)--(77.820297,707.065979)
      --(77.589798,707.151978)--(77.351601,707.237976)--(77.105499,707.315979)
      --(76.847702,707.390991)--(76.578102,707.460999)--(76.300797,707.526978)
      --(76.003899,707.585999)--(75.695297,707.637024)--(75.367203,707.676025)
      --(75.023399,707.710999)--(74.660202,707.729980)--(74.273399,707.742004)
      --(73.867203,707.737976)--(73.437500,707.723022)--(72.984398,707.690979)
      --(72.507797,707.648010)--(72.000000,707.585999)--cycle;
%    drawoptions (withcolor (0,0.625,0));
    fill (78.246101,712.565979)--(78.261703,718.226990)--(78.476601,718.140991)
      --(78.691399,718.059021)--(78.902298,717.976990)--(79.113297,717.895020)
      --(79.328102,717.820007)--(79.546898,717.754028)--(79.765602,717.687988)
      --(79.992203,717.632996)--(80.226601,717.585999)--(80.468803,717.543030)
      --(80.718803,717.515991)--(80.980499,717.495972)--(81.253899,717.492004)
      --(81.542999,717.495972)--(81.843803,717.515991)--(82.160202,717.546997)
      --(82.492203,717.598022)--(82.847702,717.664001)--(83.218803,717.745972)
      --(83.332001,717.773010)--(83.332001,706.440979)--(83.218803,706.414001)
      --(82.847702,706.328003)--(82.492203,706.265991)--(82.160202,706.215027)
      --(81.843803,706.179993)--(81.542999,706.164001)--(81.253899,706.156006)
      --(80.980499,706.164001)--(80.718803,706.184021)--(80.468803,706.210999)
      --(80.226601,706.250000)--(79.992203,706.301025)--(79.765602,706.354980)
      --(79.546898,706.418030)--(79.328102,706.487976)--(79.113297,706.562988)
      --(78.902298,706.645020)--(78.691399,706.723022)--(78.476601,706.809021)
      --(78.234398,706.906006)--cycle;
%    drawoptions (withcolor (0,0.625,0));
    fill (83.332001,712.109009)--(83.332001,717.773010)--(83.613297,717.843994)
      --(84.031303,717.965027)--(84.468803,718.104980)--(84.933601,718.265991)
      --(85.425797,718.448975)--(85.945297,718.651978)--(86.492203,718.882996)
      --(87.070297,719.137024)--(87.679703,719.414001)--(88.324203,719.718994)
      --(89.000000,720.054993)--(89.000000,708.718994)--(88.324203,708.387024)
      --(87.679703,708.081970)--(87.070297,707.801025)--(86.492203,707.551025)
      --(85.945297,707.320007)--(85.425797,707.117004)--(84.933601,706.934021)
      --(84.468803,706.773010)--(84.031303,706.632996)--(83.613297,706.512024)
      --(83.332001,706.440979)--cycle;
%    drawoptions (withcolor (0,0.625,0));
%pickup pencircle scaled 0.199253bp;
    draw (72.000000,713.254028)--(72.000000,718.918030)--(72.507797,718.979980)
      --(72.984398,719.026978)--(73.437500,719.054993)--(73.867203,719.070007)
      --(74.273399,719.073975)--(74.660202,719.062988)--(75.023399,719.043030)
      --(75.367203,719.012024)--(75.695297,718.968994)--(76.003899,718.918030)
      --(76.300797,718.859009)--(76.578102,718.793030)--(76.847702,718.723022)
      --(77.105499,718.648010)--(77.351601,718.570007)--(77.589798,718.484009)
      --(77.820297,718.401978)--(78.042999,718.312988)--(78.261703,718.226990)
      --(78.476601,718.140991)--(78.691399,718.059021)--(78.902298,717.976990)
      --(79.113297,717.895020)--(79.328102,717.820007)--(79.546898,717.754028)
      --(79.765602,717.687988)--(79.992203,717.632996)--(80.226601,717.585999)
      --(80.468803,717.543030)--(80.718803,717.515991)--(80.980499,717.495972)
      --(81.253899,717.492004)--(81.542999,717.495972)--(81.843803,717.515991)
      --(82.160202,717.546997)--(82.492203,717.598022)--(82.847702,717.664001)
      --(83.218803,717.745972)--(83.613297,717.843994)--(84.031303,717.965027)
      --(84.468803,718.104980)--(84.933601,718.265991)--(85.425797,718.448975)
      --(85.945297,718.651978)--(86.492203,718.882996)--(87.070297,719.137024)
      --(87.679703,719.414001)--(88.324203,719.718994)--(89.000000,720.054993)
      --(89.000000,708.718994)--(88.324203,708.387024)--(87.679703,708.081970)
      --(87.070297,707.801025)--(86.492203,707.551025)--(85.945297,707.320007)
      --(85.425797,707.117004)--(84.933601,706.934021)--(84.468803,706.773010)
      --(84.031303,706.632996)--(83.613297,706.512024)--(83.218803,706.414001)
      --(82.847702,706.328003)--(82.492203,706.265991)--(82.160202,706.215027)
      --(81.843803,706.179993)--(81.542999,706.164001)--(81.253899,706.156006)
      --(80.980499,706.164001)--(80.718803,706.184021)--(80.468803,706.210999)
      --(80.226601,706.250000)--(79.992203,706.301025)--(79.765602,706.354980)
      --(79.546898,706.418030)--(79.328102,706.487976)--(79.113297,706.562988)
      --(78.902298,706.645020)--(78.691399,706.723022)--(78.476601,706.809021)
      --(78.261703,706.895020)--(78.042999,706.979980)--(77.820297,707.065979)
      --(77.589798,707.151978)--(77.351601,707.237976)--(77.105499,707.315979)
      --(76.847702,707.390991)--(76.578102,707.460999)--(76.300797,707.526978)
      --(76.003899,707.585999)--(75.695297,707.637024)--(75.367203,707.676025)
      --(75.023399,707.710999)--(74.660202,707.729980)--(74.273399,707.742004)
      --(73.867203,707.737976)--(73.437500,707.723022)--(72.984398,707.690979)
      --(72.507797,707.648010)--(72.000000,707.585999)--cycle if print=false : withcolor (0,0.625,0) fi;
    %pickup pencircle scaled 0.8bp;
    draw (72.000000,699)--(72.000000,720);
    drawoptions();
    );
  $:=$ rotatedabout((72.000000,699),-15);
  $
enddef;
%%Fin section Evenement%%%

%%%% Section Bloc %%%%
vardef AffichageBlocDef=
  path cadre;
  cadre=(llcorner texto+(-eb,0)){dir-90}..{dir0}(llcorner texto+(0,-eb))--
      (llcorner texto+(0.375cm,0)+(-eb,-eb)){dir0}..
      {dir0}(llcorner texto+(0.375cm,0)+(0,-2eb))--
      (llcorner texto+(0.625cm,0)+(0,-2eb)){dir0}..
      {dir0}(llcorner texto+(0.625cm,0)+(eb,-eb))--
      (lrcorner texto+(0,-eb)){dir0}..{dir90}(lrcorner texto+(eb,0))--
      (urcorner texto+(eb,eb)){dir90}..{dir180}(urcorner texto+(0,2eb))--
      (ulcorner texto+(0,2eb)){dir180}..
      {dir-90}(ulcorner texto+(-eb,eb))--
      cycle;
  picture TEXT;
  TEXT=image(
    fill cadre withcolor if print : coefprint*white else : BlocTrois fi;%if unknown colBloc : DarkPurple else: colBloc fi fi;
    draw texto;
    draw cadre withcolor CoulLignes;
    );
  TEXT
enddef;

vardef Bloc(text nomblocbloc)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=image(
      picture CBbloc;
    CBbloc=ColleBoxNew(nomblocbloc);
    draw CBbloc;
    );
  ColBloc:=BlocTrois;
  $=Affichage(texto);
  $
enddef;

vardef NouveauBloc(text nbpasbloc)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=image(
      picture CB;
    CB=ColleBoxNew("définir",BlocPuzzle(nbpasbloc));
    draw CB;
    );
$=AffichageBlocDef shifted (if unknown _coinprec:(0,0) else :_coinprec fi - ulcorner AffichageBlocDef);
_coinprec:=llcorner $;
_coinprec:=_coinprec+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(LATEXSCRATCH("\footnotesize"&decimal(Nblignes)&""),_coinnum);
  Nblignes:=Nblignes+1;
fi;
$
enddef;
%%%% Fin Section Bloc%%%%

%%% Section Divers%%%
vardef CommandeVide(expr commande)=
  LONG:=0;
  save $;
  picture $,texto,TEXT;
  if string commande :
    texto=image(
	label.lrt(LATEXSCRATCH("\barre \hbox to"&commande&"cm{}"),if unknown _coinprec: (0,0) else:_coinprec fi);
    );
else:
  texto=commande;
fi;
ColBloc:=white;
$=Affichage(texto);
$
enddef;

vardef LigneVide=
  LONG:=0;
  save $;
  picture $,texto,TEXT;
  texto=image(
      label.lrt(LATEXSCRATCH("\barre \hbox to2cm{}"),if unknown _coinprec: (0,0) else:_coinprec fi);
  );
TEXT=image(
    path cadre;
  cadre=CADRE(texto);
  unfill cadre;
  %draw (urcorner texto+(0,eb))--
  %  (ulcorner texto+(0.625cm,0)+(eb,eb)){dir180}..
  %  {dir180}(ulcorner texto+(0.625cm,0))--
  %  (ulcorner texto+(0.375cm,0)){dir180}..
  %  {dir180}(ulcorner texto+(0.375cm,0)+(-eb,eb))--
  %  (ulcorner texto+(0,eb)) withpen pencircle scaled 0;
  );
$=TEXT shifted (if unknown _coinprec:(0,0) else :_coinprec fi - ulcorner TEXT);
_coinprec:=llcorner $;
_coinprec:=_coinprec+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(LATEXSCRATCH("\footnotesize"&decimal(Nblignes)&""),_coinnum);
  Nblignes:=Nblignes+1;
fi;
$
enddef;

vardef LigneVideVar(expr commande)=
  LONG:=0;
  save $;
  picture $,texto,TEXT;
  if string texto:
    texto=image(
	label.lrt(LATEXSCRATCH("\barre \hbox to2cm{}"),if unknown _coinprec: (0,0) else:_coinprec fi);
    );
else:
  texto=commande;
fi;
TEXT=image(
    path cadre;
  cadre=(llcorner texto+(-eb,0))--(llcorner texto+(0,-eb))--
    (llcorner texto+(0.375cm,0)+(-eb,-eb))--
    (llcorner texto+(0.375cm,0)+(0,-2eb))--
    (llcorner texto+(0.625cm,0)+(0,-2eb))--
    (llcorner texto+(0.625cm,0)+(eb,-eb))--
    (lrcorner texto+(0,-eb))--(lrcorner texto+(eb,0))--(urcorner texto+(eb,0))--(urcorner texto+(0,eb))--
    (ulcorner texto+(0.625cm,0)+(eb,eb))--
    (ulcorner texto+(0.625cm,0))--
    (ulcorner texto+(0.375cm,0))--
    (ulcorner texto+(0.375cm,0)+(-eb,eb))--
    (ulcorner texto+(0,eb))--(ulcorner texto+(-eb,0))--cycle;
  fill cadre withcolor white;
%  draw (urcorner texto+(0,eb))--
%    (ulcorner texto+(0.625cm,0)+(eb,eb))--
%    (ulcorner texto+(0.625cm,0))--
%    (ulcorner texto+(0.375cm,0))--
%    (ulcorner texto+(0.375cm,0)+(-eb,eb))--
%    (ulcorner texto+(0,eb)) withpen pencircle scaled 0.05bp;
  );
$=TEXT shifted (if unknown _coinprec:(0,0) else :_coinprec fi - ulcorner TEXT);
_coinprec:=llcorner $;
_coinprec:=_coinprec+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(LATEXSCRATCH("\footnotesize"&decimal(Nblignes)&""),_coinnum);
  Nblignes:=Nblignes+1;
fi;
$
enddef;

vardef LignePointilles=
  LONG:=0;
  save $;
  picture $,texto,TEXT;
  texto=image(
      label.lrt(LATEXSCRATCH("\barre\Large \strut\ldots\hbox to1em{}"),if unknown _coinprec: (0,0) else:_coinprec fi);
  );
TEXT=image(
    path cadre;
  cadre=CADRE(texto);
  fill cadre withcolor white;
  draw %(urcorner texto+(0,eb))--
    (ulcorner texto+(0.625cm,0)+(eb,eb)){dir180}..
    {dir180}(ulcorner texto+(0.625cm,0))--
    (ulcorner texto+(0.375cm,0)){dir180}..
    {dir180}(ulcorner texto+(0.375cm,0)+(-eb,eb))
    %--(ulcorner texto+(0,eb))
    withpen pencircle scaled 0.01;
  draw texto;
  );
$=TEXT shifted (if unknown _coinprec:(0,0) else :_coinprec fi - ulcorner TEXT);
_coinprec:=llcorner $;
_coinprec:=_coinprec+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(LATEXSCRATCH("\footnotesize"&decimal(Nblignes)&""),_coinnum);
  Nblignes:=Nblignes+1;
fi;
$
enddef;

vardef Commentaires(expr commande)=
  LONG:=0;
  save $;
  picture $,texto,TEXT;
  texto=image(
      label.lrt(LATEXSCRATCH("\barre "& commande &""),if unknown _coinprec: (0,0) else:_coinprec fi) withcolor 0.5*white;
  );
TEXT=image(
    path cadre;
  cadre=CADRE(texto);
  fill cadre withcolor white;
  draw texto;
  );
$=TEXT shifted (if unknown _coinprec:(0,0) else :_coinprec fi - ulcorner TEXT);
_coinprec:=llcorner $;
_coinprec:=_coinprec+(0,eb);
$
enddef;

color colcom;
colcom=0.5white;

vardef CommentairesLigne(expr commande)=
  LONG:=0;
  save $;
  picture $,texto,TEXT;
  TEXT=image(
      label.rt(LATEXSCRATCH(commande), _coincom) withcolor colcom;
  );
$=TEXT shifted (_coincom - 1/2[llcorner TEXT,ulcorner TEXT]);
$
enddef;

vardef BlocGris(expr ar)=
  LONG:=0;
  save $;  picture $;
  path ta; string TTm;
  TTm=ar&"\barre";
  ta=OvalMiniBox(TTm);
  $=image(
    fill ta withcolor 0.975white;
    draw ta withcolor 0.85white;
    label(LATEXSCRATCH(TTm),center ta) if print=false : withcolor blanc fi;
    );
$
enddef;

vardef BlocGrisMulti(text argris)=
  LONG:=0;
  save $;  picture $;
  path ta; picture TTm;
  TTm=ColleBox(argris);
  ta=OvalMiniBox(TTm);
  $=image(
    fill ta withcolor grisBloc;
    draw TTm;
%    label(LALATEXSCRATCH(TTm),center ta) if print=false : withcolor blanc fi;
    );
$
enddef;

boolean BlocE,BlocR;
BlocE:=false;
BlocR:=false;

vardef BlocUser(expr colblocuser)(text textbloc)=
  LONG:=0;
  save $;
  picture $;
  save TA;  path TA; picture BUTB; picture texto; picture TEXT;
  BUTB=ColleBoxNew(textbloc);
  TA=Box(BUTB);
  texto=image(
      draw BUTB;
    );
  ColBloc:=colblocuser;
  if BlocE:
    $=AffichageED(texto);
  elseif BlocR:
    LONG:=0;
    numblocrep:=numblocrep+1;
    LongRep[numblocrep]:=abs(llcorner texto-lrcorner texto);%afin de conserver la longueur du"répéter..."
    $=AffichageControle(texto);
  else:
    $=Affichage(texto);
  fi;
  $
enddef;

vardef BlocCouleur(expr colblocuser)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=image(
      label.lrt(LATEXSCRATCH("\barre \hbox to4cm{}"),if unknown _coinprec: (0,0) else:_coinprec fi);
  );
ColBloc:=colblocuser;
$=Affichage(texto);
$
enddef;
%% fin Section Divers %%%

%% Section Capteur %%%%
vardef Demander(expr nbpas)=
  LONG:=0;
  save Dem;
  picture Dem,texto;
  if string nbpas:
    texto=ColleBoxNew("demander",OvalNb(nbpas),"et attendre");
  else:
    texto=ColleBoxNew("demander",nbpas,"et attendre");
  fi;
  ColBloc:=CapteurTrois;
  Dem=Affichage(texto);
  Dem
enddef;

vardef ReinitChrono=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("réinitialiser le chronomètre");
  ColBloc:=CapteurTrois;
  $=Affichage(texto);
  $
enddef;

vardef MettreGlissement(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("mettre mode de glissement à",RecMenuCap(nbpas));
    ColBloc:=CapteurTrois;
    $=Affichage(texto);
  else:
    message("La commande -- MettreGlissement -- admet un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

%video

vardef CameraImage=
  LONG:=0;
  save $;
  picture $;
  $=image(
      pair A,B,C,D,E,F;
    A=(0,0);
    B-A=(10,0);
    C-B=(0,10);
    D-C=A-B;
    E-B=(4,1.5);
    F-C=(4,-1.5);
    numeric EB;
    EB=2pt;
    path camera;
    camera=(A+(EB,0))--(B+(-EB,0)){dir0}..{dir90}(B+(0,EB))--2/5[B,C]--E--F--3/5[B,C]--(C+(0,-EB)){dir90}..{dir-180}(C+(-EB,0))--(D+(EB,0)){dir180}..{dir-90}(D+(0,-EB))--(A+(0,EB)){dir-90}..{dir0}cycle;
    fill camera withcolor (77,77,77)/255;
    draw camera withcolor (77,77,77)*0.95/255;
    path cc;
    cc=fullcircle scaled 6;
    color coul[];
    if print:
      coul0:=0.9white;
      coul1:=0.933white;
      coul2:=0.966white;
      coul3:=white;
    else:
      coul0=(75,205,169)/255;
      coul1=(16,230,212)/255;
      coul2=(224,247,241)/255;
      coul3=(1,1,1);
    fi;
    for k=0 upto 3:
      fill (cc shifted(B+(10,3*k))) withcolor coul[k];
      draw (cc shifted(B+(10,3*k))) withcolor 0.95*coul[k];
    endfor;
    draw ((-3,0)--(-3,18)) withcolor if print : coefprint*white else: StyloTrois fi;
    pickup pencircle scaled eppen;
    );
  $:=$ scaled 0.8;
  $
enddef;

vardef ImageCamera=
  save titi;
  picture titi;
  titi=image(
      draw CameraImage shifted(-12,-5);
      draw (((0,0)--(0,18pt)) shifted(9,-9)) withpen pencircle scaled 1bp  withcolor if print: 0.5*coefprint*white else: (69/255,168/255,140/255) fi;
    );
  titi
enddef;

vardef ActiverVideo(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew(ImageCamera,"vidéo",OvalStylo(nbpas));
    ColBloc:=StyloTrois;
    $=Affichage(texto);
  else:
    message("La commande -- ActiverVideo -- admet un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef TransparenceVideo(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew(ImageCamera,"mettre la transparence vidéo sur",OvalNb(nbpas));
    ColBloc:=StyloTrois;
    $=Affichage(texto);
  else:
    message("La commande -- TransparenceVideo -- admet un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef QuandMV(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew(ImageCamera,"quand mouvement vidéo $>$",OvalNb(nbpas));
    ColBloc:=StyloTrois;
    $=AffichageED(texto);
  else:
    message("La commande -- QuandMV -- admet un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef VideoSur(expr nbpas,xa)=
  LONG:=0;
  save $;
  picture $,texto;
  if (string nbpas) and (string xa):
    texto=ColleBoxNew(ImageCamera,"vidéo",OvalStylo(nbpas),"sur",OvalStylo(xa));
    %ColBloc:=StyloTrois;
    path ta;
    ta=OvalBox(texto);
    $=image(
    fill ta withcolor if print: coefprint*white else: StyloTrois fi;
    draw ta withcolor CoulLignes;
    %label(LATEXSCRATCH(TTm),center ta) if print=false : withcolor blanc fi;
  draw texto;
    );
  else:
    message("La commande -- VideoSur -- admet deux arguments de type string.");
    $=nullpicture;
  fi;
  $
enddef;

%% fin Section Capteur %%%

%%% Section Variables %%%
vardef MettreVar(expr nbpas,xa)=
  LONG:=0;
  save MV;
  picture MV,texto;
  if string nbpas :
    texto=ColleBoxNew("mettre",RecMenuVar(nbpas),"à",if string xa:OvalNb(xa) else: xa fi);
    ColBloc:=OrangeTrois;
    MV=Affichage(texto);
  else:
    message("La commande -- MettreVar -- admet un premier paramètre de type string.");
    MV=nullpicture;
  fi;
  MV
enddef;

vardef AjouterVar(expr nbpas,xa)=
  LONG:=0;
  save $;
  picture $,texto;
  if string xa :
    texto=ColleBoxNew("ajouter",if string nbpas:OvalNb(nbpas) else: nbpas fi,"à",RecMenuVar(xa));
  ColBloc:=OrangeTrois;
  $=Affichage(texto);
else:
  message("La commande -- AjouterVar -- admet un deuxième paramètre de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef MontrerVar(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas :
    texto=ColleBoxNew("montrer la variable",RecMenuVar(nbpas));
    ColBloc:=OrangeTrois;
    $=Affichage(texto);
  else:
    message("La commande -- MontrerVar -- admet un premier paramètre de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef CacherVar(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas :
    texto=ColleBoxNew("cacher la variable",RecMenuVar(nbpas));
    ColBloc:=OrangeTrois;
    $=Affichage(texto);
  else:
    message("La commande -- CacherVar -- admet un premier paramètre de type string.");
    $=nullpicture;
  fi;
  $
enddef;

%Liste
vardef AjouterListe(expr nbpas,xa)=
  LONG:=0;
  save $;
  picture $,texto;
  if string xa :
    texto=ColleBoxNew("ajouter",if string nbpas:OvalNb(nbpas) else: nbpas fi,"à",RecMenuList(xa));
  ColBloc:=OrangeListTrois;
  $=Affichage(texto);
else:
  message("La commande -- AjouterListe -- admet un deuxième paramètre de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef SupprimerListe(expr nbpas,xa)=
  LONG:=0;
  save $;
  picture $,texto;
  if string xa :
    texto=ColleBoxNew("supprimer l'élément",if string nbpas:OvalNb(nbpas) else: nbpas fi,"de",RecMenuList(xa));
  ColBloc:=OrangeListTrois;
  $=Affichage(texto);
else:
  message("La commande -- SupprimerListe -- admet un deuxième paramètre de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef SupprimerListeAll(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas :
      texto=ColleBoxNew("supprimer tous les éléments de la liste",RecMenuList(nbpas));
    ColBloc:=OrangeListTrois;
    $=Affichage(texto);
else:
  message("La commande -- SupprimerListe -- admet un deuxième paramètre de type string.");
    $=nullpicture;
fi;
$
enddef;

vardef InsererListe(expr xa,nbpas,ya)=
  LONG:=0;
  save $;
  picture $,texto;
  if string ya :
      texto=ColleBoxNew("insérer",if string xa:OvalNb(xa) else: xa fi,"en position",if string nbpas:OvalNb(nbpas) else: nbpas fi,"de",RecMenuList(ya));
    ColBloc:=OrangeListTrois;
    $=Affichage(texto);
  else:
    message("La commande -- InsererListe -- admet un troisième paramètre de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef RemplacerListe(expr xa,nbpas,ya)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas :
    texto=ColleBoxNew("remplacer l'élément",if string xa:OvalNb(xa) else: xa fi,"de la liste",RecMenuList(nbpas),"par",if string ya:OvalNb(ya) else: ya fi);
  ColBloc:=OrangeListTrois;
  $=Affichage(texto);
else:
  message("La commande -- RemplacerListe -- admet un deuxième paramètre de type string.");
  $=nullpicture;
fi;
$
enddef;

vardef MontrerListe(expr xa)=
  LONG:=0;
  save $;
  picture $,texto;
  if string xa :
    texto=ColleBoxNew("montrer la liste",RecMenuList(xa));
    ColBloc:=OrangeListTrois;
    $=Affichage(texto);
  else:
    message("La commande -- MontrerListe -- admet un paramètre de type string.");
    $=nullpicture;
  fi;
  $
enddef;

vardef CacherListe(expr xa)=
  LONG:=0;
  save $;
  picture $,texto;
  if string xa :
    texto=ColleBoxNew("cacher la liste",RecMenuList(xa));
    ColBloc:=OrangeListTrois;
    $=Affichage(texto);
  else:
    message("La commande -- CacherListe -- admet un paramètre de type string.");
    $=nullpicture;
  fi;
  $
enddef;

%%% Section Operateur %%%

vardef OpAdd(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"$+$",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpSous(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"$-$",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpMul(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"$\times$",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpMulS(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"$*$",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpDiv(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"$\div$",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpDivS(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"$/$",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpModulo(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"modulo",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpAlea(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew("nombre aléatoire entre",if string pasun : OvalNb(pasun) else: pasun fi,"et",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpRegrouper(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew("regrouper",if string pasun : OvalNb(pasun) else: pasun fi,"et",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpLettre(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew("lettre",if string pasun : OvalNb(pasun) else: pasun fi,"de",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpLongueur(expr pasun)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew("longueur de",if string pasun : OvalNb(pasun) else: pasun fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpArrondi(expr pasun)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew("arrondi de",if string pasun : OvalNb(pasun) else: pasun fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpFonction(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew(RecMenuOp(pasun),"de",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
      fill TAao if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LOPop;
    draw TAao if print=false : withcolor coefprint*white fi;
    );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef TestOpSup(expr pasun, pasdeux)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"$>$",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestOpInf(expr pasun, pasdeux)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"$<$",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestOpEgal(expr pasun, pasdeux)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"$=$",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestOpEt(expr pasun, pasdeux)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"et",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestOpOu(expr pasun, pasdeux)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"ou",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi);
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestOpNon(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("non",if string pasun : OvalNb(pasun) else: pasun fi);
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestOpContient(expr pasun,pasdeux)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(if string pasun : OvalNb(pasun) else: pasun fi,"contient",if string pasdeux : OvalNb(pasdeux) else: pasdeux fi,"?");
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor FondOvalOp else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef AppCostume(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(RecMenuApp(pasun),"du costume");
  TAa=OvalBox(LTa);
  $=image(
      fill TAa if print=false : withcolor VioletAppTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef AppAP(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(RecMenuApp(pasun),"de l'arrière-plan");
  TAa=OvalBox(LTa);
  $=image(
      fill TAa if print=false : withcolor VioletAppTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef CapDistance(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("distance de",OvalCapMenu(pasun));
  TAa=OvalBox(LTa);
  $=image(
      fill TAa if print=false : withcolor CapteurTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef CapTemps(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(RecMenuCap(pasun),"actuelle");
  TAa=OvalBox(LTa);
  $=image(
      fill TAa if print=false : withcolor CapteurTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef CapNumero(expr pasun,pasdeux)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(RecMenuCap(pasun),"de",OvalCapMenu(pasdeux));
  TAa=OvalBox(LTa);
  $=image(
      fill TAa if print=false : withcolor CapteurTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestCapToucheObjet(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("touche le",OvalCapMenu(pasun),"?");
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor CapteurTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestCapCouleur(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("couleur",OvalCouleur(redpart(pasun),greenpart(pasun),bluepart(pasun)),"touchée ?");
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor CapteurTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestCapCouleurs(expr pasun,pasdeux)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("couleur",OvalCouleur(redpart(pasun),greenpart(pasun),bluepart(pasun)),"touche",OvalCouleur(redpart(pasdeux),greenpart(pasdeux),bluepart(pasdeux)),"?");
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor CapteurTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestCapTouche(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("touche",OvalMenuCap(pasun),"pressée ?");
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor CapteurTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestCapSouris=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("souris pressée ?");
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor CapteurTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestListeContient(expr nbpas,nbbas)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(RecMenuList(nbpas),"contient",if string nbbas:OvalNb(nbbas) else: nbbas fi);
  TAa=DiamondBox(LTa);
  $=image(
      fill TAa if print=false : withcolor OrangeListTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef ListeElement(expr nbpas,nbbas)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("élément",if string nbpas:OvalNb(nbpas) else: nbpas fi,"de",RecMenuList(nbbas));
  TAa=OvalBox(LTa);
  $=image(
      fill TAa if print=false : withcolor OrangeListTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef ListePosition(expr nbpas,nbbas)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("position de",if string nbpas:OvalNb(nbpas) else: nbpas fi,"de",RecMenuList(nbbas));
  TAa=OvalBox(LTa);
  $=image(
      fill TAa if print=false : withcolor OrangeListTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef ListeLongueur(expr nbpas)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("longueur de",RecMenuList(nbpas));
  TAa=OvalBox(LTa);
  $=image(
      fill TAa if print=false : withcolor OrangeListTrois else : withcolor coefprint*white fi;
    draw LTa;
    draw TAa if print=false : withcolor coefprint*white fi;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef Boussole(expr nbpas)=
  save $; picture $;
  picture Bouss[];
  Bouss1=image(
      draw Orienter("90");
    );
  Bouss2=image(
      _coinprec:=(0,0);
      draw Orienter("0");
    );
  Bouss3=image(
            _coinprec:=(0,0);
      draw Orienter("-90");
    );
  Bouss4=image(
            _coinprec:=(0,0);
      draw Orienter("180");
    );
  $=image(
    draw Bouss1 rotatedabout(center Bouss1,-90) shifted ((2cm,0)-(center Bouss1));
    draw Bouss2 shifted ((0,2cm)-(center Bouss2));
    draw Bouss3 rotatedabout(center Bouss3,90) shifted((-2cm,0)-(center Bouss3));
    draw Bouss4 rotatedabout(center Bouss4,180) shifted((0,-2cm)-(center Bouss4));
    pair PtBous[];
    PtBous1=(-1.2cm,-1.2cm);
    PtBous2-PtBous1=(2*1.2cm,0);
    PtBous3-PtBous2=(0,2*1.2cm);
    PtBous4-PtBous3=PtBous1-PtBous2;
    path CadreBous;
    CadreBous=(PtBous1+(0,eb)){dir-90}..{dir0}(PtBous1+(eb,0)) if nbpas="180":--0.4[PtBous1,PtBous2]--(1/2[PtBous1,PtBous2]+(0,-0.3cm))--0.6[PtBous1,PtBous2] fi--(PtBous2+(-eb,0)){dir 0}..{dir 90}(PtBous2+(0,eb)) if nbpas="90":--0.4[PtBous2,PtBous3]--(1/2[PtBous2,PtBous3]+(0.3cm,0))--0.6[PtBous2,PtBous3] fi--(PtBous3+(0,-eb)){dir90}..{dir180}(PtBous3+(-eb,0)) if nbpas="0":--0.4[PtBous3,PtBous4]--(1/2[PtBous3,PtBous4]+(0,0.3cm))--0.6[PtBous3,PtBous4] fi--(PtBous4+(eb,0)){dir 180}..{dir -90}(PtBous4-(0,eb)) if nbpas="-90":--0.4[PtBous4,PtBous1]--(1/2[PtBous4,PtBous1]+(-0.3cm,0))--0.6[PtBous4,PtBous1] fi
      --cycle;
    fill CadreBous withcolor BleuMouvTrois;
    draw CadreBous;
    path CercleBouss;
    CercleBouss=fullcircle scaled (0.55*sqrt(2)*2.4cm);
    fill CercleBouss withcolor 0.2[BleuMouvTrois,white];
    trace CercleBouss withcolor dBleuMouvTrois;
    if nbpas="0":
      fill ((0,0)--(subpath(0,2) of CercleBouss)--cycle) withcolor 0.4[BleuMouvTrois,white];
      draw (point(2) of CercleBouss)--(0,0)--(point(0) of CercleBouss) withpen pencircle scaled 1.25 withcolor white;
    fi;
    if nbpas="90":
      draw (0,0)--(point(0) of CercleBouss) withpen pencircle scaled 1.25 withcolor white;
    fi;
    if nbpas="180":
      fill ((0,0)--(subpath(6,8) of CercleBouss)--cycle) withcolor 0.4[BleuMouvTrois,white];
      draw (point(6) of CercleBouss)--(0,0)--(point(8) of CercleBouss) withpen pencircle scaled 1.25 withcolor white;
    fi;
    if nbpas="-90":
      fill ((0,0)--(subpath(0,4) of CercleBouss)--cycle) withcolor 0.4[BleuMouvTrois,white];
      draw (point(0) of CercleBouss)--(0,0)--(point(4) of CercleBouss) withpen pencircle scaled 1.25 withcolor white;
    fi;    
    for k=0 upto 17:
      draw 0.6[(0,0),point ((k/18)*length CercleBouss) of CercleBouss]--0.8[(0,0),point ((k/18)*length CercleBouss) of CercleBouss] withcolor white;
    endfor;
    picture FlecheBouss;
    FlecheBouss=image(
	fill fullcircle scaled 4mm withcolor white;
      draw fullcircle scaled 4mm;
      drawarrow (-1mm,0)--(1mm,0) withpen pencircle scaled 2 withcolor BleuMouvTrois;
      );
    draw FlecheBouss shifted (point(0) of CercleBouss);
    draw (FlecheBouss rotated 90) shifted (point(2) of CercleBouss);
    draw (FlecheBouss rotated 180) shifted (point(4) of CercleBouss);
    draw (FlecheBouss rotated -90) shifted (point(6) of CercleBouss);
    );
  $
enddef;
