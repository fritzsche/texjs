u:=1cm;

vardef Afficheur(expr nb,creux)=
  pair Aa[];
  Aa1=u*(-0.5,-1);
  Aa2-Aa1=u*(1,0);
  Aa4-Aa2=u*(0,2);
  Aa3=1/2[Aa2,Aa4];
  Aa5-Aa4=Aa1-Aa2;
  Aa6-Aa3=Aa1-Aa2;
  pair Bb[];
  Bb1=Aa1 xscaled0.7 yscaled 0.85;
  Bb2=Aa2 xscaled0.7 yscaled 0.85;
  Bb4=Aa4 xscaled0.7 yscaled 0.85;
  Bb5=Aa5 xscaled0.7 yscaled 0.85;
  Bb3=1/2[Bb2,Bb4];
  Bb6=1/2[Bb1,Bb5];
  Bb7=1/2[Bb6,Bb3]+(0,4);
  Bb8=1/2[Bb6,Bb3]-(0,6);
  pair Cc[];
  Cc1=u*(0.4,-0.85)+(0,-1);
  ecarth:=1.5;
  ecartv:=0.05;
  path ASegment[];
  ASegment[1]=1/10[Bb1,Bb2]--9/10[Bb1,Bb2];
  ASegment[2]=1/10[Bb2,Bb3]--9/10[Bb2,Bb3];
  ASegment[3]=1/10[Bb3,Bb4]--9/10[Bb3,Bb4];
  ASegment[4]=1/10[Bb4,Bb5]--9/10[Bb4,Bb5];
  ASegment[5]=1/10[Bb5,Bb6]--9/10[Bb5,Bb6];
  ASegment[6]=1/10[Bb6,Bb1]--9/10[Bb6,Bb1];
  ASegment[7]=1/10[Bb6,Bb3]--9/10[Bb6,Bb3];
  color fondsegment;
  fondsegment=0.2[LightSteelBlue,white];
  save $;
  picture $;
  $=image(
      fill Aa1--Aa2--Aa4--Aa5--cycle withcolor LightSteelBlue;
    draw Aa1--Aa2--Aa4--Aa5--cycle withcolor LightSteelBlue;
    if creux=0:
      fill (unitsquare scaled 2) shifted Cc1 withcolor fondsegment;
    else:
      fill (unitsquare scaled 2) shifted Cc1 withcolor Crimson;
    fi;
    if nb=1:
      drawoptions(withpen pensquare scaled2 withcolor Crimson);
      draw ASegment[2];
      draw ASegment[3];
      drawoptions(withpen pensquare scaled2 withcolor fondsegment);
      draw ASegment[1];
      draw ASegment[4];
      draw ASegment[5];
      draw ASegment[6];
      draw ASegment[7];
      drawoptions();
    fi;
    if nb=2:
      drawoptions(withpen pensquare scaled2 withcolor Crimson);
      draw ASegment[1];
      draw ASegment[3];
      draw ASegment[4];
      draw ASegment[6];
      draw ASegment[7];
      drawoptions(withpen pensquare scaled2 withcolor fondsegment);
      draw ASegment[2];
      draw ASegment[5];
      drawoptions();
    fi;
    if nb=3:
      drawoptions(withpen pensquare scaled2 withcolor Crimson);
      draw ASegment[1];
      draw ASegment[2];
      draw ASegment[3];
      draw ASegment[4];
      draw ASegment[7];
      drawoptions(withpen pensquare scaled2 withcolor fondsegment);
      draw ASegment[5];
      draw ASegment[6];
      drawoptions();
    fi;
    if nb=4:
      drawoptions(withpen pensquare scaled2 withcolor Crimson);
      draw ASegment[2];
      draw ASegment[3];
      draw ASegment[5];
      draw ASegment[7];
      drawoptions(withpen pensquare scaled2 withcolor fondsegment);
      draw ASegment[1];
      draw ASegment[4];
      draw ASegment[6];
      drawoptions();
    fi;
    if nb=5:
      drawoptions(withpen pensquare scaled2 withcolor Crimson);
      draw ASegment[1];
      draw ASegment[2];
      draw ASegment[4];
      draw ASegment[5];
      draw ASegment[7];
      drawoptions(withpen pensquare scaled2 withcolor fondsegment);
      draw ASegment[3];
      draw ASegment[6];
      drawoptions();
    fi;
    if nb=6:
      drawoptions(withpen pensquare scaled2 withcolor Crimson);
      draw ASegment[1];
      draw ASegment[2];
      draw ASegment[4];
      draw ASegment[5];
      draw ASegment[6];
      draw ASegment[7];
      drawoptions(withpen pensquare scaled2 withcolor fondsegment);
      draw ASegment[3];
      drawoptions();
    fi;
    if nb=7:
      drawoptions(withpen pensquare scaled2 withcolor Crimson);
      draw ASegment[2];
      draw ASegment[3];
      draw ASegment[4];
      drawoptions(withpen pensquare scaled2 withcolor fondsegment);
      draw ASegment[1];
      draw ASegment[5];
      draw ASegment[6];
      draw ASegment[7];
      drawoptions();
    fi;
    if nb=8:
      drawoptions(withpen pensquare scaled2 withcolor Crimson);
      draw ASegment[1];
      draw ASegment[2];
      draw ASegment[3];
      draw ASegment[4];
      draw ASegment[5];
      draw ASegment[6];
      draw ASegment[7];
      drawoptions();
    fi;
    if nb=9:
      drawoptions(withpen pensquare scaled2 withcolor Crimson);
      draw ASegment[1];
      draw ASegment[2];
      draw ASegment[3];
      draw ASegment[4];
      draw ASegment[5];
      draw ASegment[7];
      drawoptions(withpen pensquare scaled2 withcolor fondsegment);
      draw ASegment[6];
      drawoptions();
    fi;
    if nb=0:
      drawoptions(withpen pensquare scaled2 withcolor Crimson);
      draw ASegment[1];
      draw ASegment[2];
      draw ASegment[3];
      draw ASegment[4];
      draw ASegment[5];
      draw ASegment[6];
      drawoptions(withpen pensquare scaled2 withcolor fondsegment);
      draw ASegment[7];
      drawoptions();
    fi;
    if nb=10:
      drawoptions(withpen pensquare scaled2 withcolor Crimson);
      fill (unitsquare scaled 2) shifted Bb7 withcolor Crimson;
      fill (unitsquare scaled 2) shifted Bb8 withcolor Crimson;
      drawoptions(withpen pensquare scaled2 withcolor fondsegment);
      draw ASegment[1];
      draw ASegment[2];
      draw ASegment[3];
      draw ASegment[4];
      draw ASegment[5];
      draw ASegment[6];
      draw ASegment[7];
      drawoptions();
    fi;
    );
  $
enddef;

endinput;
  
