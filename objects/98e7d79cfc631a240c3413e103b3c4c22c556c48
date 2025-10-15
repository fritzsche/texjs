%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Lego boxes by Anthony Phan.
% file: lego.mp
% last modification: January 29, 2001.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Licence? Feel-free-to-send-me-a-postcard
%
% Anthony Phan,
%
% D\'epartement de Math\'ematiques,
% SP2MI, T\'el\'eport 2,
% Boulevard Marie et Pierre Curie,
% BP 30179,
% F-86962 Futuroscope-Chasseneuil cedex.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

magnification=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Les figures d\'efinies par ce programme
% repr\'esente une tentative de programmation
% tridimensionnelle avec MetaPost. Les trucs
% essentiels sont l'usage d'un rep\`ere par
% lequel s'effectue la projection sur le plan,
% et l'affichage des faces dans le plan dont
% le contour est orient\'e positivement qui
% corespondent alors \`a des faces visibles.
%
% Le niveau math\'ematique correspondant
% \`a ce programme devrait \^etre le niveau
% premier cycle en sciences.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Param\`etres de projection
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rep\`ere initial

pair e_x,e_y,e_z,e_xi,e_yi,e_zi;
e_xi=sqrt 0.5*dir 210;
e_yi=sqrt 0.5*dir -30;
e_zi=sqrt 0.5*dir 90;

% trois coordonn\'ees du vecteur de profondeur,
% il v\'erifie depth_xi*e_xi+depth_yi*e_yi+depth_zi*e_zi=(0,0);

depth_xi:=-1; depth_yi:=-1; depth_zi:=-1;

% Param\`etres d'\'eclairement

% vecteur unitaire de l'origine \`a la source lumineuse

light_xi=0; light_yi=0; light_zi=1;

% r\'eglage du contraste

light_min=0.25; light_max=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Param\`etres, unit\'es et mesures essentielles
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

color currentcolor; currentcolor=red;

lego_unit        :=magnification*0.8cm; % official
lego_height      :=1.2lego_unit;        % official
lego_plate_height:=0.4lego_unit;        % official
lego_thickness   :=1/6lego_unit;
lego_eps         :=1/20lego_unit;
lego_overshoot   :=lego_plate_height-lego_thickness;%0.2133lego_unit;
lego_diam        :=lego_unit-2lego_thickness;
lego_Diam        :=(sqrt 2)*lego_unit-lego_diam;
cyl_steps        :=60;

path upper_path, lower_path, temp_path;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Rotation du rep\`ere initial
% selon des pr\'etendus angles d'Euler.
% avec d\'etermination des facteurs d'ensoleillement.
% et des facteurs de profondeur...
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef euler(expr theta,phi,psi)=
  save ctheta,stheta,cphi,sphi,cpsi,spsi;
  ctheta=cosd theta; stheta=sind theta;
  cphi=cosd phi; sphi=sind phi;
  cpsi=cosd psi; spsi=sind psi;
  %
  e_x:= cphi*ctheta*e_xi + cphi*stheta*e_yi + sphi*e_zi;
  e_y:=-(cpsi*stheta+spsi*sphi*ctheta)*e_xi
  +     (cpsi*ctheta-spsi*sphi*stheta)*e_yi
  +     spsi*cphi*e_zi;
  e_z:=(spsi*stheta-cpsi*sphi*ctheta)*e_xi
  -    (spsi*ctheta+cpsi*sphi*stheta)*e_yi
  +    cpsi*cphi*e_zi;
  %
  light_x:= cphi*ctheta*light_xi + cphi*stheta*light_yi + sphi*light_zi;
  light_y:=-(cpsi*stheta+spsi*sphi*ctheta)*light_xi
  +     (cpsi*ctheta-spsi*sphi*stheta)*light_yi
  +     spsi*cphi*light_zi;
  light_z:=(spsi*stheta-cpsi*sphi*ctheta)*light_xi
  -    (spsi*ctheta+cpsi*sphi*stheta)*light_yi
  +    cpsi*cphi*light_zi;
  %
  depth_x:= cphi*ctheta*depth_xi + cphi*stheta*depth_yi + sphi*depth_zi;
  depth_y:=-(cpsi*stheta+spsi*sphi*ctheta)*depth_xi
  +     (cpsi*ctheta-spsi*sphi*stheta)*depth_yi
  +     spsi*cphi*depth_zi;
  depth_z:=(spsi*stheta-cpsi*sphi*ctheta)*depth_xi
  -    (spsi*ctheta+cpsi*sphi*stheta)*depth_yi
  +    cpsi*cphi*depth_zi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Nous ne remplissons une face que
% si elle est orient\'ee positivement.
% L'argument ``factor'' correspond \`a 
% l'\'eclairement.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

def fill_special(expr p,factor)=
  if turningnumber p>=0:
    fill p withcolor mycolor factor
  fi
enddef;

vardef mycolor expr factor=
  ((0.5*(1+factor))[light_min,light_max])*currentcolor
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% D\'etermination de l'ordre d'affichage (cylindres)
% sur une ligne, sur un rectangle...
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

def ordered_row(expr e_n,e_m,depth_n,n)=
  if depth_n<0:
    for $=1 step 1 until n: row_command(e_n,e_m,$); endfor
  else:
    for $=n step -1 until 1: row_command(e_n,e_m,$); endfor
  fi
enddef;

def ordered_rows(expr depth_n,depth_m,n,m)=
  if depth_n<0:
    if depth_m<0:
      if depth_n<depth_m:
	for $$=1 step 1 until m: for $=1 step 1 until n:
	    row_command($,$$); endfor endfor
      else:
	for $=1 step 1 until n: for $$=1 step 1 until m:
	    row_command($,$$); endfor endfor
      fi
    else:
      if depth_n<depth_m:
	for $$=m step -1 until 1: for $=1 step 1 until n:
	    row_command($,$$); endfor endfor
      else:
	for $=1 step 1 until n:  for $$=m step -1 until 1:
	    row_command($,$$); endfor endfor
      fi
    fi
  else:
    if depth_m<0:
      if depth_n<depth_m:
	for $$=1 step 1 until m: for $=n step -1 until 1:
	    row_command($,$$); endfor endfor
      else:
	for $=n step -1 until 1: for $$=1 step 1 until m:
	    row_command($,$$); endfor endfor
      fi
    else:
      if depth_n<depth_m:
	for $$=m step -1 until 1: for $=n step -1 until 1:
	    row_command($,$$); endfor endfor
      else:
	for $=n step -1 until 1: for $$=m step -1 until 1:
	    row_command($,$$); endfor endfor
      fi
    fi
  fi
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Cylindres divers
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

def z_cylinder(expr basepoint,radius,height,external)=
  lower_path:=(for i=0 upto cyl_steps:
      basepoint+radius*cosd(i*360/cyl_steps)*e_x
      +radius*sind(i*360/cyl_steps)*e_y --
    endfor basepoint+radius*e_x);
  upper_path:=lower_path shifted (height*e_z);
  for i=0 upto cyl_steps:
    fill_special(if external:
	point i of lower_path--point (i+1) of lower_path
	--point (i+1) of upper_path--point i of upper_path--cycle
      else:
	point i of upper_path--point (i+1) of upper_path
	--point (i+1) of lower_path--point i of lower_path--cycle
      fi,
      if external: else: - fi
      (cosd((i+0.5)*360/cyl_steps)*light_x
	+sind((i+0.5)*360/cyl_steps)*light_y));
  endfor
enddef;

def teton_command(expr $,$$)=
  z_cylinder(M1+($-0.5)*lego_unit*e_x+($$-0.5)*lego_unit*e_y,
    0.5lego_diam-lego_eps,lego_overshoot,true);
  fill_special(upper_path--cycle,light_z);
enddef;

def stick_command(expr e_n,e_m,$)=
  z_cylinder(M1'+$*lego_unit*e_n+0.5lego_unit*e_m,
    lego_thickness,lego_height-lego_thickness,true);
  fill reverse lower_path--cycle withcolor mycolor -light_z;
enddef;

def cyl_command(expr $,$$)=
  z_cylinder(M1'+$*lego_unit*e_x+$$*lego_unit*e_y,
    0.5lego_diam,lego_height-lego_thickness,false);
  temp_path:=lower_path;
  z_cylinder(M1'+$*lego_unit*e_x+$$*lego_unit*e_y,
    0.5lego_Diam,lego_height-lego_thickness,true);
  fill (reverse lower_path)--temp_path--cycle
  withcolor mycolor -light_z;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Le plat principal : Adaptation à plusieurs legos sur une même figure par CP
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pair M[],M[]',M[]'',M[]''';

numeric currentnumber;
currentnumber=0;

color TR;
TR=(0,0,0);

vardef Lego_box(expr n,m,lego_color)=
  currentcolor:=lego_color;
  currentnumber:=currentnumber+1;
  %
  % Points clefs de la brique
  %
  if currentnumber=1:
    M1=0.5(-n*lego_unit*e_x-m*lego_unit*e_y+lego_height*e_z)+(lego_unit*redpart(TR)*e_x+lego_unit*greenpart(TR)*e_y+lego_height*bluepart(TR)*e_z);
  M1'-M1=-lego_height*e_z;
  M2-M1=M2'-M1'=n*lego_unit*e_x;
  M3-M1=M3'-M1'=n*lego_unit*e_x+m*lego_unit*e_y;
  M4-M1=M4'-M1'=m*lego_unit*e_y;
  M1'''-M1+lego_thickness*e_z=M1''-M1'=lego_thickness*(e_x+e_y);
  M2'''-M2+lego_thickness*e_z=M2''-M2'=lego_thickness*(-e_x+e_y);
  M3'''-M3+lego_thickness*e_z=M3''-M3'=lego_thickness*(-e_x-e_y);
  M4'''-M4+lego_thickness*e_z=M4''-M4'=lego_thickness*(e_x-e_y);
  else:
    M1:=0.5(-n*lego_unit*e_x-m*lego_unit*e_y+lego_height*e_z)+(lego_unit*redpart(TR)*e_x+lego_unit*greenpart(TR)*e_y+lego_height*bluepart(TR)*e_z);
    M1':=M1-lego_height*e_z;
    M2:=M1+n*lego_unit*e_x;
    M2':=M1'+n*lego_unit*e_x;
    M3:=M1+n*lego_unit*e_x+m*lego_unit*e_y;
    M3':=M1'+n*lego_unit*e_x+m*lego_unit*e_y;
    M4:=M1+m*lego_unit*e_y;
    M4':=M1'+m*lego_unit*e_y;
    M1''':=M1-lego_thickness*e_z+lego_thickness*(e_x+e_y);
    M1'':=M1'+lego_thickness*(e_x+e_y);
    M2''':=M2-lego_thickness*e_z+lego_thickness*(-e_x+e_y);
    M2'':=M2'+lego_thickness*(-e_x+e_y);
    M3''':=M3-lego_thickness*e_z+lego_thickness*(-e_x-e_y);
    M3'':=M3'+lego_thickness*(-e_x-e_y);
    M4''':=M4-lego_thickness*e_z+lego_thickness*(e_x-e_y);
    M4'':=M4'+lego_thickness*(e_x-e_y);
  fi;
  %%
  %% (face du dessus et t\'etons)
  %%             ou
  %% (t\'etons, faces lat\'erales internes
  %% et faces du dessous) 
  %%
  if turningnumber(M1--M2--M3--M4--cycle)>0:
    fill_special(M1--M2--M3--M4--cycle,light_z);
    let row_command=teton_command;
    ordered_rows(depth_x,depth_y,n,m);
  else:
    let row_command=teton_command;
    ordered_rows(depth_x,depth_y,n,m);
    fill_special(M4'''--M3'''--M2'''--M1'''--cycle,-light_z);
    fill_special(M1''--M1'''--M2'''--M2''--cycle,light_y);
    fill_special(M3''--M3'''--M4'''--M4''--cycle,-light_y);
    fill_special(M1''--M4''--M4'''--M1'''--cycle,light_x);
    fill_special(M2''--M2'''--M3'''--M3''--cycle,-light_x);
    if (n>1) and (m>1):
      let row_command=cyl_command;
      ordered_rows(depth_x,depth_y,n-1,m-1);
    else: if (n>1) and (m=1):
	let row_command=stick_command;
	ordered_row(e_x,e_y,depth_x,n-1); fi
      if (n=1) and (m>1):
	let row_command=stick_command;
	ordered_row(e_y,e_x,depth_y,m-1); fi
    fi
    fill_special(M4'--M3'--M2'--M1'--M4'--M4''--M1''--M2''
      --M3''--M4''--cycle,-light_z);
  fi;
 % %
 % % faces lat\'erales externes
 % %
  fill_special(M1--M1'--M2'--M2--cycle,-light_y);
  fill_special(M3--M3'--M4'--M4--cycle,light_y);
  fill_special(M1--M4--M4'--M1'--cycle,-light_x);
  fill_special(M2--M2'--M3'--M3--cycle,light_x);
enddef;

endinput
