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
color CoulLignes; CoulLignes:=white;
color ColBloc; % alias des couleurs de bloc

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
      label(TEX(demitt),(0,0));
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
  TTv="\barre "&ar;%
  TAvar=OvalBox(TTv);
  Ovar=image(
    %  fill TAvar if print=false : withcolor OrangeTrois else : withcolor white fi;
    %draw TAvar;% if print=false : withcolor coefprint*white fi;
    label(TEX("\sffamily\barre "&ar),(0,0)) if print=false : withcolor white fi;
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
    %fill tabloc if print=false : withcolor BlocTrois else: withcolor white fi;
    %draw tabloc if print=true : withcolor black else: withcolor BlocDefLigneTrois fi;
    label(TEX("\sffamily\barre "&ar),(0,0)) if print=false : withcolor blanc fi;
    );
  $
enddef;

vardef OvalMiniBox(text t)=
  save $; path $; path xo;
  if string t:
    string demit;
    demit=t&"\barre";
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
    label(TEX("\barre "&ar),(0,0));
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
    label(TEX("\barre "&ar),(0,0));
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
      %fill ta if print=false : withcolor VioletAppTrois else: withcolor white fi;
    %draw ta ;%if print=false : withcolor coefprint*white fi;
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
      %fill ta if print=false : withcolor SonTrois else: withcolor white fi;
    %draw ta if print=false : withcolor coefprint*white fi;
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
    TT=ColleBoxNew("tempo");
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
    %fill ta if print=false : withcolor BleuMouvTrois else: withcolor white fi;
    %draw ta if print=false : withcolor coefprint*white fi;
    label(TEX("\longbarre "&ar),center ta) if print=false : withcolor blanc fi;
    );
  $
enddef;

vardef OvalMenuCap(expr art)=OvalCapMenu(art) enddef;

vardef OvalCapMenu(expr ar)=
  save $; picture $;
  string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}";
  fi;
  path TAMC;
  TAMC=OvalBox(TTm);
  $=image(
      fill TAMC if print : withcolor white else : withcolor CapFonceTrois fi;
    draw TAMC if print=false : withcolor coefprint*white fi;
    label(TEX(TTm),center TAMC);
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
%    fill TAcap if print=false : withcolor CapteurTrois else : withcolor white fi;
    draw LOCMcap;
%    draw TAcap if print=false : withcolor coefprint*white fi;
    );
  Cap:=Cap shifted(-center Cap);
  Cap
enddef;

vardef OvalMouvMenu(expr ar)=
  save $;  picture $;
  path ta; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else:
      "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}"
  fi;
  ta=OvalBox(TTm);
  $=image(
      fill ta if print=false : withcolor dBleuMouvTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(TEX(TTm),center ta);
    );
  $
enddef;

vardef OvalAppMenu(expr ar)=
  save $;  picture $;
  path ta; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}";
  fi;
  ta=OvalBox(TTm);
  $=image(
      fill ta if print=false : withcolor FondOvalAppMenu else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(TEX(TTm),center ta);
    );
  $
enddef;

vardef OvalSonMenu(expr art)=OvalMenuSon(art) enddef;

vardef OvalMenuSon(expr ar)=
  save $; save TA;
  picture $;
  string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}";
  fi;
  path TA;
  TA=OvalBox(TTm);
  $=image(%
    fill TA if print : withcolor white else : withcolor DSonTrois fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(TEX(TTm),center TA);
    );
  $
enddef;

vardef OvalMenuControle(expr ar)=
  save $; save TA;
  picture $;
  string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}";
  fi;
  path TA;
  TA=OvalBox(TTm);
  $=image(
      fill TA if print : withcolor white else : withcolor CloneTrois fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(TEX(TTm), center TA);
    );
  $
enddef;

vardef OvalStylo(expr ar)=
  save $; save TA;
  picture $;
  string TT,TTI;
  if string ar:
    if print:
      TT=ar&"\hbox to1em{\barre}\blacktriangledown"
    else:
      TT=ar&"\hbox to1em{\barre}{\color{white}\blacktriangledown}"
    fi;
    TTI=ar&"\hbox to1em{\barre}\phantom{\blacktriangledown}";
    path TA;
    TA=OvalBox(TT);
    $=image(
	fill TA if print : withcolor white else : withcolor OvalStyloTrois fi;
      draw TA if print=false : withcolor coefprint*white fi;
      label(TEX(TT),(0,0)) if print=false : withcolor white fi;
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
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}";
  fi;
  path TA;
  TA=OvalBox(TTm);
  $=image(
      fill TA if print : withcolor white else : withcolor MessageTrois fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(TEX(TTm), center TA);
    );
  $
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rectangles
vardef RecMouvMenu(expr ar)=
  save $;  picture $;
  path ta; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}"
  fi;
  ta=RecBox(TTm);
  $=image(
      fill ta if print=false : withcolor BleuMouvTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(TEX(TTm),center ta);
    );
  $
enddef;

vardef RecMenuApp(expr ar)=
  save $;  picture $;
  save ta; path ta; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}";
  fi;
  ta=RecBox(TTm);
  $=image(
      fill ta if print=false : withcolor VioletAppTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(TEX(TTm),center ta);
    );
  $
enddef;

vardef RecMenuOp(expr ar)=
  save $; save TA;
  picture $; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}";
  fi;
  path TA;
  TA=RecBox(TTm);
  $=image(
      fill TA if print : withcolor white else : withcolor FondOvalOp fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(TEX(TTm), center TA);
    );
  $
enddef;

vardef RecMenuSon(expr ar)=
  save $; save TA;
  picture $; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}" fi;
  path TA;
  TA=RecBox(TTm);
  $=image(
      fill TA if print : withcolor white else : withcolor SonTrois fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(TEX(TTm), center TA);
    );
  $
enddef;

vardef RecEvenementMenu(expr ar)=
  save $;  picture $;
  path ta; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}";
  fi;
  ta=RecBox(TTm);
  $=image(
      fill ta if print=false : withcolor EvenementTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(TEX(TTm),center ta);
    );
  $
enddef;

vardef RecMenuCap(expr ar)=
    save $;  picture $;
  path ta; string TTm;
    TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}";
    fi;
  ta=RecBox(TTm);
  $=image(
      fill ta if print=false : withcolor CapteurTrois else: withcolor white fi;
    draw ta if print=false : withcolor coefprint*white fi;
    label(TEX(TTm),center ta);
    );
  $
enddef;

vardef RecMenuVar(expr ar)=
  save $; save TA;
  picture $; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}";
  fi;
  path TA;
  TA=RecBox(TTm);
  $=image(
      fill TA if print : withcolor white else : withcolor OrangeTrois fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(TEX(TTm), center TA);
    );
  $
enddef;

vardef RecMenuList(expr ar)=
  save $; save TA;
  picture $; string TTm;
  TTm=if print:ar&"\hbox to1em{\barre}\blacktriangledown" else: "{\color{white}"&ar&"\hbox to1em{\barre}\blacktriangledown}";
  fi;
  path TA;
  TA=RecBox(TTm);
  $=image(
      fill TA if print : withcolor white else : withcolor OrangeListTrois fi;
    draw TA if print=false : withcolor coefprint*white fi;
    label(TEX(TTm), center TA);
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
	    label(TEX("\sffamily\longbarre "&p_),(0,0)) if print=false : withcolor white fi;%->ok
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
      draw texta;
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
  label(TEX("\footnotesize"&decimal(Nblignes)&""),_coinnum);
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
    draw texta;
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
  label(TEX("\footnotesize"&decimal(Nblignes)&""),_coinnum);
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
    draw texta;
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
  label(TEX("\footnotesize"&decimal(Nblignes)&""),_coinnum);
  Nblignes:=Nblignes+1;
fi;
$
enddef;

%%% section Mouvement %%%%%%%%%%
vardef Avancer(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("avancer de",nbpas,"pas");
  $=Affichage(texto);
  $
enddef;

vardef Tournerd(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("tourner à droite de",nbpas,"degré(s)");
  $=Affichage(texto);
  $
enddef;

vardef Tournerg(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("tourner à gauche de",nbpas,"degré(s)");
  $=Affichage(texto);
  $
enddef;

vardef Orienter(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("s'orienter à",nbpas);
  $=Affichage(texto);
  $
enddef;

vardef Orienterdirection(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("s'orienter vers",nbpas);
  $=Affichage(texto);
  $
enddef;

vardef OrienterVers(expr nbpass)=Orienterdirection(nbpass) enddef;

vardef Aller(expr xa,ya)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("aller à $x =$",if string xa:xa else: xa fi," et $y =$",if string ya:ya else: ya fi);
  $=Affichage(texto);
  $
enddef;

vardef Glisser(expr na,xa,ya)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("glisser en", na ,"seconde(s) à $x =$", xa ,"$y =$", ya);
  $=Affichage(texto);
  $
enddef;

vardef Allera(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  if string nbpas:
    texto=ColleBoxNew("aller à",nbpas);
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
    texto=ColleBoxNew("glisser en", na ,"seconde(s) à",xa);
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
    texto=ColleBoxNew("ajouter",nba,"à","$"&xa&"$");
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
    texto=ColleBoxNew("mettre","$"&xa&"$","à",nba);
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
  $=Affichage(texto);
  $
enddef;

vardef FixerSensRotation(expr nbpas)=
  LONG:=0;
  save $;
  picture $, texto;
  if string nbpas:
    texto=ColleBoxNew("fixer le sens de rotation",nbpas);
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
  texto=ColleBoxNew("dire",if string na:na else: na fi,"pendant",if string xa : xa else: xa fi,"seconde(s)");
$=Affichage(texto);
$
enddef;

vardef Dire(expr na)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("dire",if string na:na else: na fi);
$=Affichage(texto);
$
enddef;

vardef PenserT(expr na,xa)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("penser à",if string na:na else: na fi,"pendant",if string xa : xa else: xa fi,"seconde(s)");
$=Affichage(texto);
$
enddef;

vardef Penser(expr na)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("penser à",if string na:na else: na fi);
$=Affichage(texto);
$
enddef;

vardef Montrer=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("montrer");
  $=Affichage(texto);
  $
enddef;

vardef Cacher=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("cacher");
  $=Affichage(texto);
  $
enddef;

vardef Basculer(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("basculer sur le costume",nbpas);
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
  $=Affichage(texto);
$
enddef;

vardef ARSuivant=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("arrière-plan suivant");
  $=Affichage(texto);
$
enddef;

vardef BasculerAR(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("basculer sur l'arrière-plan",nbpas);
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
    texto=ColleBoxNew("basculer sur l'arrière-plan",nbpas," et attendre");
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
    texto=ColleBoxNew("ajouter",if string nbpas: nbpas else: nbpas fi," à l'effet",xa);
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
    texto=ColleBoxNew("mettre l'effet",xa,"à",if string nbpas:nbpas else: nbpas fi);
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
  $=Affichage(texto);
$
enddef;

vardef AnnulerEffets=AnnulerEffet enddef;

vardef AjouterTaille(expr na)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("ajouter",if string na:na else: na fi,"à la taille");
$=Affichage(texto);
$
enddef;

vardef MettreA(expr na)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("mettre la taille à",if string na:na else: na fi,"\% de la taille initiale");
$=Affichage(texto);
$
enddef;

vardef MettreTaille(expr art)=MettreA(art) enddef;

vardef AllerPlan(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("aller à l'",nbpas,"plan");
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
    texto=ColleBoxNew("déplacer de",if string nbpas:nbpas else: nbpas fi,"plan(s) vers l'",xa);
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
    texto=ColleBoxNew("jouer le son",nbpas);
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
    texto=ColleBoxNew("jouer le son",nbpas," jusqu'au bout");
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
  texto=ColleBoxNew("ajouter",if string xa:xa else: xa fi,"au volume");
  $=Affichage(texto);
  $
enddef;

vardef MettreVol(expr xa)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("mettre le volume à",if string xa: xa else: xa fi,"~\%");
  $=Affichage(texto);
  $
enddef;

vardef AjouterEffetSon(expr nombre, effet)=
  LONG:=0;
  save $;
  picture $, texto;
  if string effet:
    texto=ColleBoxNew("ajouter",if string nombre : nombre else: nombre fi," à l'effet",effet);
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
    texto=ColleBoxNew("mettre l'effet",effet,"à",if string nombre:nombre else: nombre fi);
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
  $=Affichage(texto);
  $
enddef;

%Musique
vardef Tambour(expr na,xa)=
  LONG:=0;
  save $;
  picture $, texto;
  if string na:
    texto=ColleBoxNew("jouer du tambour",na,"pendant",if string xa:xa else: xa fi,"temps");
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
  texto=ColleBoxNew("faire une pause pendant",if string na: na else: na fi," temps");
  $=Affichage(texto);
  $
enddef;

vardef JouerNote(expr na,xa)=
  LONG:=0;
  save $;
  picture $, texto;
  texto=ColleBoxNew("jouer la note",if string na:na else: na fi," pendant",if string xa:xa else: xa fi," temps");
$=Affichage(texto);
$
enddef;

vardef ChoisirInstrument(expr na)=
  LONG:=0;
  save $;
  picture $, texto;
  if string na:
    texto=ColleBoxNew("choisir l'instrument \no{}",na);
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
  texto=ColleBoxNew("mettre le tempo à",if string xa:xa else: xa fi);
  $=Affichage(texto);
  $
enddef;

vardef AjouterTempo(expr xa)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("ajouter",if string xa:xa else: xa fi," au tempo");
$=Affichage(texto);
$
enddef;
%%%%%% fin Section Son %%%%%%%%%

%%%%%% Section Stylo %%%%%%%%%
vardef Effacer=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("effacer tout");
  $=Affichage(texto);
  $
enddef;

vardef Estampiller=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("estampiller");
  $=Affichage(texto);
  $
enddef;

vardef PoserStylo=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("stylo en position d'écriture");
  $=Affichage(texto);
$
enddef;

vardef ReleverStylo=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("relever le stylo");
  $=Affichage(texto);
$
enddef;

vardef MettreCouleur(expr redc,greenc,bluec)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("mettre la couleur du stylo à",OvalCouleur(redc,greenc,bluec));
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
  texto=ColleBoxNew("ajouter",if string nombre:nombre else: nombre fi,"à la",effet,"du stylo");
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
  texto=ColleBoxNew("mettre la",effet,"du stylo à",if string nombre:nombre else: nombre fi);
$=Affichage(texto);
$
enddef;

%taille du stylo
vardef AjouterTS(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("ajouter",if string nbpas:nbpas else: nbpas fi,"à la taille du stylo");
$=Affichage(texto);
$
enddef;

vardef MettreTS(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("mettre la taille du stylo à",if string nbpas:nbpas else: nbpas fi);
$=Affichage(texto);
$
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
    draw texto;
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
  texto=ColleBoxNew("\textbf{répéter}",xa,"fois");
  LongRep[numblocrep]:=abs(llcorner texto-lrcorner texto);%afin de conserver la longueur du"répéter..."
  $=AffichageControle(texto);
  $
enddef;

vardef RepeterI=
  LONG:=0;
  save $;
  numblocrep:=numblocrep+1;
  picture $,texto;
  texto=ColleBoxNew("\textbf{répéter indéfiniment}");
  LongRep[numblocrep]:=abs(llcorner texto-lrcorner texto);%afin de conserver la longueur du"répéter..."
  $=AffichageControle(texto);
  $
enddef;

vardef RepeterJ(expr xa)=
  LONG:=0;
  save $;
  numblocrep:=numblocrep+1;
  picture $,texto;
  if picture xa:
    texto=ColleBoxNew("\textbf{répéter jusqu'à ce que}",xa);
    LongRep[numblocrep]:=abs(llcorner texto-lrcorner texto);%afin de conserver la longueur du"répéter..."
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
    label.lrt(TEX("\barre\hbox to"&decimal(LongRep[numblocrep])&"pt{}"),if unknown _coinprec: (0,0) else:_coinprec fi);
  labeloffset:=3;
  );
path cadre;
cadre=(lrcorner texto+(-eb,0.25cm))--%
  (llcorner texto+(0.25cm,0.25cm)+(eb,0)){dir180}..
  {dir90}(llcorner texto+(0.25cm,0.25cm)+(0,eb))--
  (coindebutbloc[numblocrep]+(0.25cm,0.125));
$=image(
    draw cadre withpen pencircle scaled 1.5;
  );
_coinprec:=(llcorner $);
_coinprec:=_coinprec+(-0.25cm,eb-0.25cm);
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
    texto=ColleBoxNew("\textbf{si}",xa,"\textbf{alors}");
    LongRep[numblocrep]:=abs(llcorner texto-lrcorner texto);%afin de conserver la longueur du"répéter..."
      $=AffichageControle(texto);
  else:
    message("La commande -- Si -- n'admet qu'un argument de type picture.");
    $=nullpicture;
  fi;
  $
enddef;

vardef FinBlocSi=FinBlocRepeter enddef;

vardef Sinon=
  LONG:=0;
  save $;
  picture $,texto;
  _coinprec:=_coinprec-(0.5cm,0);
  drawoptions();
  texto=image(
      labeloffset:=0;
    label.lrt(TEX("\hbox to"&decimal(LongRep[numblocrep])&"pt{\sffamily\barre\textbf{sinon}}"),if unknown _coinprec: (0,0) else:_coinprec fi) if print=false : withcolor blanc fi;
    labeloffset:=3;
    );
  path cadre;
      cadre=(ulcorner texto+(0.25cm+0.125,0))--
	(coindebutbloc[numblocrep]+(0.25cm+0.125,0));%--
$=image(
  draw cadre withpen pencircle scaled 1.5;
  draw texto;
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
  texto=ColleBoxNew("attendre",if string nbpas:nbpas else: nbpas fi,"seconde(s)");
$=Affichage(texto);
$
enddef;

vardef AttendreJ(expr xa)=
  LONG:=0;
  save $;
  picture $,texto;
  if picture xa:
    texto=ColleBoxNew("attendre jusqu'à ce que",xa);
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
  TTm=if print:nbpas else:"{\color{white}"&nbpas&"\hbox to1em{\barre}\blacktriangledown}";
  fi;
  texto=image(
      path ti;
    ti=Box("stop");
    label(TEX("\sffamily\barre stop"),center ti) if print=false : withcolor white fi;%_>ok
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
%      if print=false : fill ta withcolor ControleTrois fi;
 %     draw ta withcolor 0.95white;
      label(TEX(TTm),center ta);
      drawoptions();
    fi;
  );
$=AffichageStop shifted (if unknown _coinprec:(0,0) else :_coinprec fi - ulcorner AffichageStop);
_coinprec:=llcorner $;
_coinprec:=_coinprec;%+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(TEX("\footnotesize"&decimal(Nblignes)&""),_coinnum);
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
    texto=ColleBoxNew("créer un clone de",nbpas);
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
    label(TEX("\sffamily\barre supprimer ce clone"),center ti);%_>ok
    );
  $=AffichageStop shifted (if unknown _coinprec:(0,0) else :_coinprec fi - ulcorner AffichageStop);
_coinprec:=llcorner $;
_coinprec:=_coinprec+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(TEX("\footnotesize"&decimal(Nblignes)&""),_coinnum);
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
  texto=ColleBoxNew("quand le drapeau vert est cliqué");
  $=Affichage(texto);
  $
enddef;

vardef QPresse(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("quand la touche",nbpas,"est pressée");
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
  $=AffichageED(texto);
  $
enddef;

vardef QSpritePresse=QLutinPresse enddef;

vardef QScenePressee=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("quand la scène est cliquée");
  $=AffichageED(texto);
  $
enddef;

vardef QBasculeAR(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("quand l'arrière-plan bascule sur",nbpas);
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
    texto=ColleBoxNew("quand le",nbpas,"$>$",if string xa:xa else: xa fi);
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
    texto=ColleBoxNew("quand je reçois",nbpas);
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
    texto=ColleBoxNew("envoyer à tous",nbpas);
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
    texto=ColleBoxNew("envoyer à tous",nbpas,"et attendre");
      $=Affichage(texto);
  else:
    message("La commande -- EnvoyerMessageA -- accepte un argument de type string.");
    $=nullpicture;
  fi;
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
    draw texto;
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
  $=Affichage(texto);
  $
enddef;

vardef NouveauBloc(text nbpasbloc)=
  LONG:=0;
  save $;
  numblocrep:=numblocrep+1;
  picture $,texto;
  texto=ColleBoxNew("Définir",nbpasbloc);
  LongRep[numblocrep]:=abs(llcorner texto-lrcorner texto);%afin de conserver la longueur du"répéter..."
  $=AffichageControle(texto);
  $
enddef;

vardef FinNouveauBloc=%
  LONG:=0;
  save $;
  picture $,texto;
  _coinprec:=_coinprec-(0.5cm,0);
  drawoptions();
  texto=image(
      labeloffset:=0;
    label.lrt(TEX("\barre\hbox to"&decimal(LongRep[numblocrep])&"pt{}"),if unknown _coinprec: (0,0) else:_coinprec fi);
  labeloffset:=3;
  );
path cadre;
cadre=(llcorner texto+(0.25cm,0.25cm)+(0,eb))--
  (coindebutbloc[numblocrep]+(0.25cm,0.125));
$=image(
    draw cadre withpen pencircle scaled 1.5;
  );
_coinprec:=(llcorner $);
_coinprec:=_coinprec+(-0.25cm,eb-0.25cm);
numblocrep:=numblocrep-1;
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
	label.lrt(TEX("\barre \hbox to"&commande&"cm{}"),if unknown _coinprec: (0,0) else:_coinprec fi);
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
      label.lrt(TEX("\barre \hbox to2cm{}"),if unknown _coinprec: (0,0) else:_coinprec fi);
  );
TEXT=image(
    path cadre;
  cadre=CADRE(texto);
  unfill cadre;
  );
$=TEXT shifted (if unknown _coinprec:(0,0) else :_coinprec fi - ulcorner TEXT);
_coinprec:=llcorner $;
_coinprec:=_coinprec+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(TEX("\footnotesize"&decimal(Nblignes)&""),_coinnum);
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
	label.lrt(TEX("\barre \hbox to2cm{}"),if unknown _coinprec: (0,0) else:_coinprec fi);
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
  );
$=TEXT shifted (if unknown _coinprec:(0,0) else :_coinprec fi - ulcorner TEXT);
_coinprec:=llcorner $;
_coinprec:=_coinprec+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(TEX("\footnotesize"&decimal(Nblignes)&""),_coinnum);
  Nblignes:=Nblignes+1;
fi;
$
enddef;

vardef LignePointilles=
  LONG:=0;
  save $;
  picture $,texto,TEXT;
  texto=image(
      label.lrt(TEX("\barre\Large \strut\ldots\hbox to1em{}"),if unknown _coinprec: (0,0) else:_coinprec fi);
  );
TEXT=image(
    path cadre;
  cadre=CADRE(texto);
  draw texto;
  );
$=TEXT shifted (if unknown _coinprec:(0,0) else :_coinprec fi - ulcorner TEXT);
_coinprec:=llcorner $;
_coinprec:=_coinprec+(0,eb);
_coincom:=1/2[lrcorner $,urcorner $]+(eb,0);
_coinnum:=(xpart(DebutListe+(-3*eb,0)),ypart(1/2[llcorner $,ulcorner $]));
if NumeroteLignes=true:
  label(TEX("\footnotesize"&decimal(Nblignes)&""),_coinnum);
  Nblignes:=Nblignes+1;
fi;
$
enddef;

vardef Commentaires(expr commande)=
  LONG:=0;
  save $;
  picture $,texto,TEXT;
  texto=image(
      label.lrt(TEX("\barre "& commande &""),if unknown _coinprec: (0,0) else:_coinprec fi) withcolor 0.5*white;
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
      label.rt(TEX(commande), _coincom) withcolor colcom;
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
    label(TEX(TTm),center ta) if print=false : withcolor blanc fi;
    );
$
enddef;

vardef BlocGrisMulti(text argris)=
  LONG:=0;
  save $;  picture $;
  path ta; picture TTm;
  TTm=ColleBoxNew(argris);
  ta=OvalMiniBox(TTm);
  $=image(
    draw ta;
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
  picture $,texto,TEXT;
  texto=image(
      label.lrt(TEX("\barre \hbox to4cm{}"),if unknown _coinprec: (0,0) else:_coinprec fi);
  );
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
    texto=ColleBoxNew("demander",nbpas,"et attendre");
    Dem=Affichage(texto);
  else:
    message("La commande -- Demander -- admet un argument de type string.");
    Dem=nullpicture;
  fi;
  Dem
enddef;

vardef ReinitChrono=
  LONG:=0;
  save $;
  picture $,texto;
  texto=ColleBoxNew("réinitialiser le chronomètre");
  $=Affichage(texto);
  $
enddef;

vardef MettreGlissement(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("mettre mode de glissement à",nbpas);
    $=Affichage(texto);
  else:
    message("La commande -- MettreGlissement -- admet un argument de type string.");
    $=nullpicture;
  fi;
  $
enddef;

%video
vardef ActiverVideo(expr nbpas)=
  LONG:=0;
  save $;
  picture $,texto;
  if string nbpas:
    texto=ColleBoxNew("vidéo",nbpas);
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
    texto=ColleBoxNew("mettre la transparence vidéo sur",nbpas);
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
    texto=ColleBoxNew("quand mouvement vidéo $>$",nbpas);
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
    texto=ColleBoxNew("vidéo",nbpas,"sur",xa);
    path ta;
    ta=OvalBox(texto);
    $=image(
	draw ta withcolor CoulLignes;
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
    texto=ColleBoxNew("mettre",nbpas,"à",if string xa:xa else: xa fi);
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
    texto=ColleBoxNew("ajouter",if string nbpas:nbpas else: nbpas fi,"à",xa);
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
    texto=ColleBoxNew("montrer la variable",nbpas);
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
    texto=ColleBoxNew("cacher la variable",nbpas);
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
    texto=ColleBoxNew("ajouter",if string nbpas:nbpas else: nbpas fi,"à",xa);
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
    texto=ColleBoxNew("supprimer l'élément",if string nbpas:nbpas else: nbpas fi,"de",xa);
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
      texto=ColleBoxNew("supprimer tous les éléments de la liste",nbpas);
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
      texto=ColleBoxNew("insérer",if string xa:xa else: xa fi,"en position",if string nbpas:nbpas else: nbpas fi,"de",ya);
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
    texto=ColleBoxNew("remplacer l'élément",if string xa:xa else: xa fi,"de la liste",nbpas,"par",if string ya:ya else: ya fi);
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
    texto=ColleBoxNew("montrer la liste",xa);
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
    texto=ColleBoxNew("cacher la liste",xa);
      $=Affichage(texto);
  else:
    message("La commande -- CacherListe -- admet un paramètre de type string.");
    $=nullpicture;
  fi;
  $
enddef;

%%% Section Operateur %%%

vardef OpRecap(expr pasun,signe,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew(if string pasun : pasun else: pasun fi,signe,if string pasdeux : pasdeux else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
    draw LOPop;
  );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpAdd(expr pasun,pasdeux)=OpRecap(pasun,"$+$",pasdeux) enddef;

vardef OpSous(expr pasun,pasdeux)=OpRecap(pasun,"$-$",pasdeux) enddef;

vardef OpMul(expr pasun,pasdeux)=OpRecap(pasun,"$\times$",pasdeux) enddef;

vardef OpDiv(expr pasun,pasdeux)=OpRecap(pasun,"$\div$",pasdeux) enddef;

vardef OpModulo(expr pasun,pasdeux)=OpRecap(pasun,"modulo",pasdeux) enddef;

vardef OpFonction(expr pasun,pasdeux)=OpRecap(pasun,"de",pasdeux) enddef;

vardef OpAlea(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew("nombre aléatoire entre",if string pasun : pasun else: pasun fi,"et",if string pasdeux : pasdeux else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
    draw LOPop;
  );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpRegrouper(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew("regrouper",if string pasun : pasun else: pasun fi,"et",if string pasdeux : pasdeux else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
    draw LOPop;
  );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpLettre(expr pasun,pasdeux)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew("lettre",if string pasun : pasun else: pasun fi,"de",if string pasdeux : pasdeux else: pasdeux fi);
  TAao=OvalBox(LOPop);
  Oop=image(
    draw LOPop;
  );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpLongueur(expr pasun)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew("longueur de",if string pasun : pasun else: pasun fi);
  TAao=OvalBox(LOPop);
  Oop=image(
    draw LOPop;
  );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef OpArrondi(expr pasun)=
  save Oop; picture Oop;
  save TAao; path TAao;
  save LOPop; picture LOPop;
  LOPop=ColleBoxNew("arrondi de",if string pasun : pasun else: pasun fi);
  TAao=OvalBox(LOPop);
  Oop=image(
    draw LOPop;
  );
  Oop:=Oop shifted(-center Oop);
  Oop
enddef;

vardef TestOpRecap(expr pasun,entredeux,pasdeux)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(if string pasun : pasun else: pasun fi,entredeux,if string pasdeux : pasdeux else: pasdeux fi);
  TAa=DiamondBox(LTa);
  $=image(
    draw LTa;
  );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestOpSup(expr pasun, pasdeux)=TestOpRecap(pasun,"$>$",pasdeux) enddef;

vardef TestOpInf(expr pasun, pasdeux)=TestOpRecap(pasun,"$<$",pasdeux) enddef;

vardef TestOpEgal(expr pasun, pasdeux)=TestOpRecap(pasun,"$=$",pasdeux) enddef;

vardef TestOpEt(expr pasun, pasdeux)=TestOpRecap(pasun,"et",pasdeux) enddef;

vardef TestOpOu(expr pasun, pasdeux)=TestOpRecap(pasun,"ou",pasdeux) enddef;

vardef TestOpContient(expr pasun, pasdeux)=TestOpRecap(pasun,"contient",pasdeux) enddef;

vardef TestOpNon(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("non",if string pasun : pasun else: pasun fi);
  TAa=DiamondBox(LTa);
  $=image(
    draw LTa;
  );
  $:=$ shifted(-center $);
  $
enddef;

vardef AppCostume(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(pasun,"du costume");
  TAa=OvalBox(LTa);
  $=image(
    draw LTa;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef AppAP(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(pasun,"de l'arrière-plan");
  TAa=OvalBox(LTa);
  $=image(
    draw LTa;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef CapDistance(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("distance de",pasun);
  TAa=OvalBox(LTa);
  $=image(
    draw LTa;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef CapTemps(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(pasun,"actuelle");
  TAa=OvalBox(LTa);
  $=image(
    draw LTa;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef CapNumero(expr pasun,pasdeux)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(pasun,"de",pasdeux);
  TAa=OvalBox(LTa);
  $=image(
    draw LTa;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestCapToucheObjet(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("touche le",pasun,"?");
  TAa=DiamondBox(LTa);
  $=image(
    draw LTa;
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
    draw LTa;
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
    draw LTa;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestCapTouche(expr pasun)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("touche",pasun,"pressée ?");
  TAa=DiamondBox(LTa);
  $=image(
      draw LTa;
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
      draw LTa;
    );
  $:=$ shifted(-center $);
  $
enddef;

vardef TestListeContient(expr nbpas,nbbas)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew(nbpas,"contient",if string nbbas:nbbas else: nbbas fi);
  TAa=DiamondBox(LTa);
  $=image(
    draw LTa;
  );
  $:=$ shifted(-center $);
  $
enddef;

vardef ListeElement(expr nbpas,nbbas)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("élément",if string nbpas:nbpas else: nbpas fi,"de",nbbas);
  TAa=OvalBox(LTa);
  $=image(
    draw LTa;
  );
  $:=$ shifted(-center $);
  $
enddef;

vardef ListePosition(expr nbpas,nbbas)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("position de",if string nbpas:nbpas else: nbpas fi,"de",nbbas);
  TAa=OvalBox(LTa);
  $=image(
    draw LTa;
  );
  $:=$ shifted(-center $);
  $
enddef;

vardef ListeLongueur(expr nbpas)=
  save $; picture $;
  save TAa; path TAa;
  save LTa; picture LTa;
  LTa=ColleBoxNew("longueur de",nbpas);
  TAa=OvalBox(LTa);
  $=image(
      draw LTa;
    );
  $:=$ shifted(-center $);
  $
enddef;
