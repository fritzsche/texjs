numeric longallu,epallu;
longallu=41.5mm;
epallu=2mm;
ecartpoint=epallu-0.1mm;

color BurlyWood,PfCSoufre;
BurlyWood=(222,184,135)/256;
PfCSoufre=red;

vardef Allu(expr dep,arr)=
  save Retour;
  picture Retour;
  Retour=image(
      pair depa,arra;
    depa=dep+ecartpoint*unitvector(arr-dep);
    arra=arr+ecartpoint*unitvector(dep-arr);
    pair corps[];
    corps[1]-depa=0.5*epallu*unitvector(rotation(arr,dep,-90)-dep);
    corps[4]=symetrie(corps[1],dep,arr);
    corps2=corps1+0.975*(arra-depa);
    corps3-corps2=corps4-corps1;
    path Corps;
    Corps=polygone(corps1,corps2,corps3,corps4);
    fill Corps withcolor if print: white else:BurlyWood fi;
    trace Corps withcolor 0.5[black,if print: white else:BurlyWood fi];
    pair cera,cerb,cerc;
    cera=pointarc(cercles((0,0),1.5epallu),125);
    cerb=pointarc(cercles((0,0),1.5epallu),235);
    cerc=pointarc(cercles((0,0),1.5epallu),0);
    path bout;
    bout=arccercle(cerb,cerc,(0,0))--arccercle(cerc,cera,(0,0))--cycle;
    fill (rotation(bout yscaled 0.385 xscaled 0.8,(0,0),angle(arra-depa)) shifted (arra+1.0*ecartpoint*unitvector(dep-arr))) withcolor if print:0.7white else: PfCSoufre fi;
    draw (rotation(bout yscaled 0.385 xscaled 0.8,(0,0),angle(arra-depa)) shifted (arra+1.0*ecartpoint*unitvector(dep-arr))) withcolor 0.5[black,if print: 0.7white else: PfCSoufre fi];
    );
  Retour
enddef;

vardef OldAllu(expr dep,arr)=
  save Retour;
  picture Retour;
  Retour=image(
      pair depa,arra;
    depa=dep+ecartpoint*unitvector(arr-dep);
    arra=arr+ecartpoint*unitvector(dep-arr);
    pair corps[];
    corps[1]-depa=0.5*epallu*unitvector(rotation(arr,dep,-90)-dep);
    corps[4]=symetrie(corps[1],dep,arr);
    corps2=corps1+0.975*(arra-depa);
    corps3-corps2=corps4-corps1;
    path Corps;
    Corps=polygone(corps1,corps2,corps3,corps4);
%    fill Corps withcolor if print: white else:BurlyWood fi;
%    trace Corps withcolor 0.5[black,if print: white else:BurlyWood fi] dashed evenly;
    trace Corps dashed evenly;
    pair cera,cerb,cerc;
    cera=pointarc(cercles((0,0),1.5epallu),125);
    cerb=pointarc(cercles((0,0),1.5epallu),235);
    cerc=pointarc(cercles((0,0),1.5epallu),0);
    path bout;
    bout=arccercle(cerb,cerc,(0,0))--arccercle(cerc,cera,(0,0))--cycle;
    fill (rotation(bout yscaled 0.385 xscaled 0.8,(0,0),angle(arra-depa)) shifted (arra+0.75*ecartpoint*unitvector(dep-arr))) withcolor white;
    draw (rotation(bout yscaled 0.385 xscaled 0.8,(0,0),angle(arra-depa)) shifted (arra+0.75*ecartpoint*unitvector(dep-arr)));% withcolor 0.5[black,if print: 0.7white else: PfCSoufre fi];
    );
  Retour
enddef;
  
u:=longallu+epallu;

vardef DefinirUnite(expr pfcechelle)=
    longallu:=longallu*pfcechelle;
    epallu:=epallu*pfcechelle;
    ecartpoint:=ecartpoint*pfcechelle;
    u:=longallu+epallu;
enddef;

endinput;
  
