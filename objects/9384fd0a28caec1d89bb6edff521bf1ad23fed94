vardef LATEX primary s =
  write "verbatimtex" to "mptextmp.mp";
  write "%&latex" to "mptextmp.mp";
  write "\documentclass[]{article}" to "mptextmp.mp";
  write "\usepackage{mathtools,amssymb}" to "mptextmp.mp";
  write "\usepackage{siunitx}" to "mptextmp.mp";
  write "\sisetup{locale=FR,mode = match, propagate-math-font = true,reset-math-version = false, reset-text-family = false,reset-text-series = false, reset-text-shape = false,text-family-to-math = true, text-series-to-math = true, output-decimal-marker={,},group-minimum-digits=4}" to "mptextmp.mp";
  write "\usepackage[utf8]{inputenc}" to "mptextmp.mp";
  write "\usepackage[T1]{fontenc}" to "mptextmp.mp";
  write "\usepackage{fourier}" to "mptextmp.mp";
  write "\usepackage[french]{babel}" to "mptextmp.mp";
  write "\begin{document}" to "mptextmp.mp";
  %write "\UseRawInputEncoding" to "mptextmp.mp";
  write "etex" to "mptextmp.mp";
  write "btex "&s&" etex" to "mptextmp.mp";
  write EOF to "mptextmp.mp";
  scantokens "input mptextmp"
enddef;

vardef LATEXProf primary s =
  write "verbatimtex" to "mptextmp.mp";
  write "%&latex" to "mptextmp.mp";
  write "\documentclass[]{article}" to "mptextmp.mp";
  write "\usepackage{ProfCollege}" to "mptextmp.mp";
  write "\usepackage[utf8]{inputenc}" to "mptextmp.mp";
  write "\usepackage[T1]{fontenc}" to "mptextmp.mp";
  write "\usepackage{fourier}" to "mptextmp.mp";
  write "\usepackage[french]{babel}" to "mptextmp.mp";
  write "\begin{document}" to "mptextmp.mp";
  %write "\UseRawInputEncoding" to "mptextmp.mp";
  write "etex" to "mptextmp.mp";
  write "btex "&s&" etex" to "mptextmp.mp";
  write EOF to "mptextmp.mp";
  scantokens "input mptextmp"
enddef;
