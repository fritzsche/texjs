%D'après https://tex.stackexchange.com/questions/39296/simulating-hand-drawn-lines

let normaldraw = draw ;
let normalfill = fill ;
let normaldrawarrow = drawarrow ;
let normaldbldrawarrow = drawdblarrow ;
let normalarrowhead = normalarrowhead;

path fullsquare;
fullsquare := unitsquare shifted - center unitsquare ;

%D The variable \type{sketch_amount} determines the amount of randomness in the
%D drawing
numeric sketch_amount; sketch_amount := 3;
numeric old_sketch_amount;
%D The macro \type{sketchdraw} randomized the path before drawing it. The 
%D \type{expr} ... \type{text} trick is copied from the definition of 
%D \type{drawarrow}

def sketchdraw expr p =
  do_sketchdraw(p if (path p): randomized sketch_amount fi)
enddef;

def do_sketchdraw(expr p) text t =
    normaldraw p t ;
enddef;

%cp
%%%%%%%%%%%%%%%%%%
vardef sketcharrowhead expr p =
  save q,e; path q; pair e;
  e = point length p of p;
  q = gobble(p shifted -e cutafter makepath(pencircle scaled 2ahlength))
    cuttings;
  ((q rotated .5ahangle & reverse q rotated -.5ahangle -- cycle)  shifted e) randomized (sketch_amount/3)
enddef;

path _apth;
def sketchdrawarrow expr p = _apth:=p randomized sketch_amount; _sketchfinarr enddef;
def sketchdrawdblarrow expr p = _apth:=p; _sketchfindarr enddef;

def _sketchfinarr text t =
  old_sketch_amount:=sketch_amount;
  sketch_amount:=0;
  draw _apth t;
  sketch_amount:=old_sketch_amount;
  filldraw sketcharrowhead _apth  t
enddef;

def _sketchfindarr text t =
  old_sketch_amount:=sketch_amount;
  sketch_amount:=0;
  draw _apth t;
    sketch_amount:=old_sketch_amount;
  filldraw sketcharrowhead _apth withpen currentpen  t;
  filldraw sketcharrowhead  reverse _apth  withpen currentpen  t
enddef;
%%%%%%%%%%%%%%%%%%

%D The macro \type{sketchfill} randomizes the path before filling it.
path _sketch_path_;

def sketchfill expr p =
  _sketch_path_ := p randomized sketch_amount;
   do_sketchfill  
enddef ;

def do_sketchfill text t =
    normalfill _sketch_path_ t ;
enddef ;

%D The macro \type{sketchypaths} is modeled after \type{visualizepaths} from
%D \filename{mp-tool}.

def sketchypaths =
  let draw = sketchdraw ;
  let fill = sketchfill ;
  %cp
  let drawarrow = sketchdrawarrow ;
  let drawdblarrow = sketchdrawdblarrow ;
  let arrowhead = sketcharrowhead ;
  %fin cp
enddef ;

%cp
def normalpaths =
  let draw = normaldraw ;
  let fill = normalfill ;
  let drawarrow = normaldrawarrow ;
  let drawdblarrow = normaldrawdblarrow ;
  let arrowhead = normalarrowhead;
enddef ;
 %fincp

%By metafun
vardef mfun_randomized_picture(expr p,s)(text rnd) =
    save currentpicture ;
    picture currentpicture ;
    currentpicture := nullpicture ;
    for i within p :
        addto currentpicture
            if stroked i :
                doublepath pathpart i rnd s
                dashed dashpart i
                withpen penpart i
                withcolor colorpart i
                withprescript prescriptpart i
                withpostscript postscriptpart i
            elseif filled i :
                contour pathpart i rnd s
                withpen penpart i
                withcolor colorpart i
                withprescript prescriptpart i
                withpostscript postscriptpart i
            else :
                also i
            fi
        ;
    endfor ;
    currentpicture
enddef ;

primarydef p randomized s = (
    if path p :
      for i=0 upto length(p)-1 :
	((point       i    of p) randomshifted s) .. controls
	  ((postcontrol i    of p) randomshifted s) and
	  ((precontrol (i+1) of p) randomshifted s) ..
      endfor
      if cycle p :
	cycle
      else :
	((point length(p) of p) randomshifted s)
      fi
    elseif pair p :
      p randomshifted s
    elseif cmykcolor p :
      if cmykcolor s :
	((uniformdeviate cyanpart    s) * cyanpart    p,
            (uniformdeviate magentapart s) * magentapart p,
            (uniformdeviate yellowpart  s) * yellowpart  p,
            (uniformdeviate blackpart   s) * blackpart   p)
      elseif pair s :
	((xpart s + (uniformdeviate (ypart s - xpart s))) * p)
      else :
	((uniformdeviate s) * p)
      fi
    elseif rgbcolor p :
      if rgbcolor s :
	((uniformdeviate redpart   s) * redpart   p,
            (uniformdeviate greenpart s) * greenpart p,
            (uniformdeviate bluepart  s) * bluepart  p)
      elseif pair s :
	((xpart s + (uniformdeviate (ypart s - xpart s))) * p)
      else :
	((uniformdeviate s) * p)
      fi
    elseif color p :
      if color s :
	((uniformdeviate greypart s) * greypart p)
      elseif pair s :
	((xpart s + (uniformdeviate (ypart s - xpart s))) * p)
      else :
	((uniformdeviate s) * p)
      fi
    elseif string p :
      (resolvedcolor(p)) randomized s
    elseif picture p :
      mfun_randomized_picture(p,s)(randomized)
    else :
      % p - s/2 + uniformdeviate s % would have been better but we want to be positive
      p + uniformdeviate s
    fi
    )
enddef ;
  
primarydef p randomshifted s =
  begingroup ;
    save ss ; pair ss ;
    ss := paired(s) ;
    p shifted (-.5xpart ss + uniformdeviate xpart ss,-.5ypart ss + uniformdeviate ypart ss)
  endgroup
enddef ;

def resolvedcolor(expr s) =
    .5white
enddef ;

vardef paired primary d =
  if pair d : d else : (d,d) fi
enddef ;

  extra_endfig := "picture retiens; retiens=currentpicture; draw (retiens randomized 1) withpen pencircle scaled 0.5 withcolor 0.25white;" & extra_endfig;

endinput
