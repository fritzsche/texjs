\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{tango}%
[2024/07/15 v0.8.0 tango document class. Michel Bovani]% %
%
% Ensure luatex engine
\RequirePackage{iftex}[2019/10/24]
\RequireLuaTeX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\TgoTempa{}
\newcommand\TgoTempb{}
\newcommand\TgoTempc{}
\newcommand\TgoSmallerSize{}
\newcommand\TgoStatementNumberSuffix{}
\newcommand\TgoStatementNumberPrefix{}
\newcommand\TgoStatementSuffix{}
\newcommand\TgoStatementName{}
\newcommand\TgoTheoremName{Theorem}
\newcommand\TgoDefinitionName{Definition}
\newcommand\TgoPropositionName{Proposition}
\newcommand\TgoLemmaName{Lemma}
\newcommand\TgoCorollaryName{Corollary}
\newcommand\TgoRemarkName{Remark}
\newcommand\TgoExampleName{Example}
\newcommand\TgoContentsName{Contents}
\newcommand\TgoExerciseName{Exercise}
\newcommand\TgoExercisesSubsectionName{Exercises}
\newcommand\TgoExercisesSectionName{Exercises}
\newcommand\TgoPublicationClass{article}
\newcommand\TgoStatementIndent{\indent}
\newif\ifTgoFrenchLanguage
\newif\ifTgoNGermanLanguage
\newif\ifTgoGermanLanguage
\newif\ifTgoNAustrianLanguage
\newif\ifTgoNSwissGermanLanguage
\newif\ifTgoItalianLanguage
\newif\ifTgoSpanishLanguage
\newif\ifTgoEnglishLanguage
\newif\ifTgoBritishLanguage
\newif\ifTgoAmericanLanguage
\newif\ifTgoCanadianLanguage
\newif\ifTgoAustralianLanguage
\newif\ifTgoNewZealandLanguage
\newif\ifTgoNoStatement
\newif\ifTgoBook
\newif\ifTgoOneSide\TgoOneSidetrue
\newif\ifTgoAfourPaperOutput\TgoAfourPaperOutputtrue
\newif\ifTgoLetterOutput
\newif\ifTgoBigTabletOutput
\newif\ifTgoAfivePaperOutput
\newif\ifTgoTabletOutput
\newif\ifTgoSmallTabletOutput
\newif\ifTgoeReaderOutput
\newif\ifTgoSmartphoneOutput
\newif\ifTgoSmallerSizeCommand
\newif\ifTgoTitleIndentZero\TgoTitleIndentZerotrue
\newcommand\TgoChapterTitleFont{RobotoCondensedBold}
\NewDocumentCommand\TgoStatementNameOffset{}{}
\NewDocumentCommand\SetTgoBaseFonts{}{%
 \setmainfont{erewhon}%
 \setmathfont{Erewhon Math}%
 }%
 \newlength\TgoAfterChapterSkip
 \newlength\TgoStandardMargin
 \newlength\TgoStatementParindent
 \newlength\TgoTitleIndent
  %%%
\AddToHook{package/xcolor/after}
{%
\definecolor{ColorOne}{rgb}{0.15,0.15,0.15}
\definecolor{ColorTwo}{rgb}{0.93,0.93,0.93}
}
\AddToHook{class/article/after}{%
\TgoTenPointsFonts}
\AddToHook{class/book/after}{%
\TgoTenPointsFonts}
%%
%
 %%
 \DeclareKeys[tango]{
 %%%%%% languages,%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 french.code= {%
 \TgoFrenchLanguagetrue
 \TgoTitleIndentZerofalse
 },
 ngerman.code= {%
 \TgoNGermanLanguagetrue
 },
 german.code= {%
 \TgoGermanLanguagetrue
 },
naustrian.code= {%
 \TgoNAustrianLanguagetrue
 },
nswissgerman.code= {%
 \TgoNSwissGermanLanguagetrue
 },
 italian.code= {%
 \TgoItalianLanguagetrue
 },
 spanish.code= {%
 \TgoSpanishLanguagetrue
 },
english.code= {%
 \TgoEnglishLanguagetrue
 },
british.code= {%
 \TgoBritishLanguagetrue
 },
american.code= {%
 \TgoAmericanLanguagetrue
 },
canadian.code= {%
 \TgoCanadianLanguagetrue
 },
australian.code= {%
 \TgoAustralianLanguagetrue
 },
newzealand.code= {%
 \TgoNewZealandLanguagetrue
 },
 %%%%%% Default Statements %%%%%%%%%%%%%%%%%%%%%%%%
 no-statement.if = TgoNoStatement,
 %%%%%% No Hyperref %%%%%%%%%%%%%%%%%%%%%%%%%%%
 no-hyperref.if = TgoNoHyperref,
 %%%%%% Parindentzero %%%%%%%%%%%%%%%%%%%%%%%%%%%
 no-indent.if = TgoParindentZero,
 indent.ifnot = TgoParindentZero,
%%%%%% Parindentzero %%%%%%%%%%%%%%%%%%%%%%%%%%%
 no-titleindent.if = TgoTitleIndentZero,
 titleindent.ifnot = TgoTitleIndentZero,
 %%%%%% ThmNamePos left/right %%%%%%%%%%%%%%%%%%%%%%%
 ThmNamePos.choice:,
 ThmNamePos / left.code:n =
 {
 \RenewDocumentCommand\TgoStatementNameOffset{}{}
 },
 ThmNamePos / right.code:n =
 {
 \RenewDocumentCommand\TgoStatementNameOffset{}{\hspace*{\fill}}
 }, 
%%%% book or article %%%%%%%%%%%%%%%%%%%%%%%%%%%
PubliClass.choice:,
PubliClass / article.code:n =
{%
\renewcommand\TgoPublicationClass{article}
\TgoBookfalse
},
PubliClass / book.code:n =
{%
\renewcommand\TgoPublicationClass{book}
\TgoBooktrue
},
%%%% oneside or two sides %%%%%%%%%%%%%%%%%%%%%%%%
oneside.if = TgoOneSide ,
twoside.ifnot = TgoOneSide ,
%%%% Font Size %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FontSize.choice:,
FontSize / 9pt.code:n =
{
\RemoveFromHook{class/article/after}
\AddToHook{class/article/after}{%
\TgoNinePointsFonts}
\RemoveFromHook{class/book/after}
\AddToHook{class/book/after}{%
\TgoNinePointsFonts}
},
FontSize / 10pt.code:n =
{
\RemoveFromHook{class/article/after}
\AddToHook{class/article/after}{%
\TgoTenPointsFonts}
\RemoveFromHook{class/book/after}
\AddToHook{class/book/after}{%
\TgoTenPointsFonts}
},
FontSize / 11pt.code:n =
{
\RemoveFromHook{class/article/after}
\AddToHook{class/article/after}{%
\TgoElevenPointsFonts}
\RemoveFromHook{class/book/after}
\AddToHook{class/book/after}{%
\TgoElevenPointsFonts}
},
FontSize / 12pt.code:n =
{
\RemoveFromHook{class/article/after}
\AddToHook{class/article/after}{%
\TgoTwelvePointsFonts}
\RemoveFromHook{class/book/after}
\AddToHook{class/book/after}{%
\TgoTwelvePointsFonts}
},
FontSize / unknown.code:n =
{
 \ClassWarning{tango}{\MessageBreak Value #1 is unknown \MessageBreak
 Possible choices are  9pt, 10pt, 11pt and 12pt.
  \MessageBreak Selecting 10pt.}
},
%%%% ColorTheme %%%%%%%%%%%%%%%%%%%%%%%%%%%%
ColorTheme.choice:,
ColorTheme / Blue.code:n =
{%
\RemoveFromHook{package/xcolor/after}
  \AddToHook{package/xcolor/after}%
{ %
 \definecolor{ColorOne}{rgb}{0.08, 0.05, 0.55}
 \definecolor{ColorTwo}{rgb}{0.87, 0.94, 0.97}
 }
},
 ColorTheme / Navy.code:n =
 {%
 \RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
   \definecolor{ColorOne}{rgb}{0.07, 0.37, 0.65}
  \definecolor{ColorTwo}{rgb}{0.87, 0.95, 0.97}
 }
 },
ColorTheme / USAF.code:n =
 {%
 \RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
 \definecolor{ColorOne}{rgb}{0.24, 0.41, 0.54}
 \definecolor{ColorTwo}{rgb}{0.92, 0.94, 0.96}
 }
 },
   ColorTheme / Azur.code:n =
{%
\RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
\definecolor{ColorOne}{rgb}{0.15, 0.32, 0.75}
\definecolor{ColorTwo}{rgb}{0.88, 0.94, 0.97}
}
},
 ColorTheme / Red.code:n =
 {%
 \RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
\definecolor{ColorOne}{rgb}{0.75,0.05,0.1}
\definecolor{ColorTwo}{rgb}{1,0.94,0.9}
}
 },
  ColorTheme / Framboise.code:n =
 {%
 \RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
\definecolor{ColorOne}{rgb}{0.64, 0.25, 0.45}
\definecolor{ColorTwo}{rgb}{1, 0.95, 0.94}
}
 },
   ColorTheme / Brique.code:n =
{%
\RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
\definecolor{ColorOne}{rgb}{0.68, 0.1, 0.0}
\definecolor{ColorTwo}{rgb}{1, 0.95, 0.89}
}
},
  ColorTheme / Sienne.code:n =
 {%
 \RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
\definecolor{ColorOne}{rgb}{0.55, 0.27, 0.1}
\definecolor{ColorTwo}{rgb}{1, 0.95, 0.87}
 }
 },
   ColorTheme / Caramel.code:n =
{%
\RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
\definecolor{ColorOne}{rgb}{0.66, 0.26, 0.0}
\definecolor{ColorTwo}{rgb}{1, 0.96, 0.86}
}
},
  ColorTheme / Olive.code:n =
 {%
 \RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
\definecolor{ColorOne}{rgb}{0.28, 0.43, 0.03}
\definecolor{ColorTwo}{rgb}{0.95, 0.98, 0.9}
}
 },
  ColorTheme / Tannen.code:n =
{%
\RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
\definecolor{ColorOne}{rgb}{0.09, 0.44, 0.28}
\definecolor{ColorTwo}{rgb}{0.92, 0.97, 0.94}
}
},
  ColorTheme / GrayGray.code:n =
{%
\RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
\definecolor{ColorOne}{rgb}{0.25,0.25,0.25}
\definecolor{ColorTwo}{rgb}{0.95,0.95,0.95}
}
},
 ColorTheme / BlackAndWhite.code:n =
{%
\RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
\definecolor{ColorOne}{rgb}{0,0,0}
\definecolor{ColorTwo}{rgb}{1,1,1}
}
},
  ColorTheme / Ink.code:n =
{%
\RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
\definecolor{ColorOne}{rgb}{0.25, 0.25, 0.33}
\definecolor{ColorTwo}{rgb}{0.94, 0.95, 0.97}
}
},
  ColorTheme / Steel.code:n =
{%
\RemoveFromHook{package/xcolor/after}
 \AddToHook{package/xcolor/after}%
{ %
\definecolor{ColorOne}{rgb}{0.27, 0.25, 0.2}
\definecolor{ColorTwo}{rgb}{0.96, 0.96, 0.93}
}
},
 ColorTheme / unknown.code:n =
 {
 \ClassWarning{tango}{\MessageBreak “ColorTheme” #1 is unknown!\MessageBreak
Possible choices are: \MessageBreak
Blue, Navy, USAF, Azur, Red, Framboise, Brique,
 \MessageBreak Sienne, Caramel, Olive, Tannen, GrayGray, BlackAndWhite, Ink and Steel.
\MessageBreak  Stay in GrayGray}
},
%%%% User defined colors %%%%%%%%%%%%%%%%%%%%%%%%
ColorOne.code = \AddToHook{package/xcolor/after}{\definecolor{ColorOne}#1},
ColorTwo.code = \AddToHook{package/xcolor/after}{\definecolor{ColorTwo}#1},
ColorOneNamed.code = \AddToHook{package/xcolor/after}{\colorlet{ColorOne}{#1}},
ColorTwoNamed.code = \AddToHook{package/xcolor/after}{\colorlet{ColorTwo}{#1}},
%%%% Output %%%%%%%%%%%%%%%%%%%%%%%%%%
 Output.choice:,
 Output / A4paper.code:n =
 {
\TgoAfourPaperOutputtrue
 }, 
Output / Letter.code:n =
{
\TgoLetterOutputtrue
\TgoBigTabletOutputtrue
\TgoAfourPaperOutputfalse
},
Output / BigTablet.code:n =
 {
\TgoBigTabletOutputtrue
\TgoAfourPaperOutputfalse
 },
Output / A5paper.code:n =
 {
\TgoAfivePaperOutputtrue
\TgoTabletOutputtrue
\TgoAfourPaperOutputfalse
 },
Output / Tablet.code:n =
 {
\TgoTabletOutputtrue
\TgoAfourPaperOutputfalse
 },
Output / SmallTablet.code:n =
 {
\TgoSmallTabletOutputtrue
\TgoAfourPaperOutputfalse
 },
Output / eReader.code:n =
 {
\TgoeReaderOutputtrue
\TgoAfourPaperOutputfalse
 },
Output / Smartphone.code:n =
 {
\TgoSmartphoneOutputtrue
\TgoAfourPaperOutputfalse
 },
 Output / unknown.code:n =
 {
  \ClassWarning{tango}{\MessageBreak Value #1 is unknown \MessageBreak
 Possible choices are  A4paper, A5paper, Letter, BigTablet,\MessageBreak
 Tablet, SmallTablet, eReader and Smartphone. 
  \MessageBreak Selecting A4paper.}
\TgoAfourPaperOutputtrue
  },
  %%%%% Stylistic Set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  StylisticSet.multichoice:,
  StylisticSet / upint.code:n =
  {
  \AddToHook{package/fontspec/after}%
  {\defaultfontfeatures+[Erewhon Math]{RawFeature=+ss03}}
  },
 StylisticSet / leqslant.code:n =
  {
\AddToHook{package/fontspec/after}%
  {\defaultfontfeatures+[Erewhon Math]{RawFeature=+ss04}}
   }, 
StylisticSet / smaller.code:n =
  {
  \AddToHook{package/fontspec/after}%
  {\defaultfontfeatures+[Erewhon Math]{RawFeature=+ss05}}
  },
StylisticSet / subsetneq.code:n =
 {
  \AddToHook{package/fontspec/after}%
  {\defaultfontfeatures+[Erewhon Math]{RawFeature=+ss06}}
  },
StylisticSet / parallelslant.code:n =
  {
  \AddToHook{package/fontspec/after}%
  {\defaultfontfeatures+[Erewhon Math]{RawFeature=+ss07}}
  },
 %%%%%%% Character Variants %%%%%%%%%%%%%%%%%%%%%%%%%%
  CharacterVariant.multichoice:, 
  CharacterVariant / zero.code:n =
  {
   \AddToHook{package/fontspec/after}%
 { \defaultfontfeatures+[Erewhon Math]{CharacterVariant=0}}
  },  
  CharacterVariant / hslash.code:n =
  {
  \AddToHook{package/fontspec/after}%
  {\defaultfontfeatures+[Erewhon Math]{CharacterVariant=1}}
  },  
  CharacterVariant / emptyset.code:n =
  {
  \AddToHook{package/fontspec/after}%
  {\defaultfontfeatures+[Erewhon Math]{CharacterVariant=2}}
  },  
  CharacterVariant / epsilon.code:n =
  {
  \AddToHook{package/fontspec/after}%
 { \defaultfontfeatures+[Erewhon Math]{CharacterVariant=3}}
  },  
 CharacterVariant / kappa.code:n =
  {
 \AddToHook{package/fontspec/after}%
 { \defaultfontfeatures+[Erewhon Math]{CharacterVariant=4}}
  },  
 CharacterVariant / pi.code:n =
  {
  \AddToHook{package/fontspec/after}%
 { \defaultfontfeatures+[Erewhon Math]{CharacterVariant=5}}
  },  
 CharacterVariant / phi.code:n =
  {
  \AddToHook{package/fontspec/after}%
 { \defaultfontfeatures+[Erewhon Math]{CharacterVariant=6}}
  },  
 CharacterVariant / rho.code:n =
  {
 \AddToHook{package/fontspec/after}%
 {  \defaultfontfeatures+[Erewhon Math]{CharacterVariant=7}}
  },  
 CharacterVariant / sigma.code:n =
  {
 \AddToHook{package/fontspec/after}%
 {  \defaultfontfeatures+[Erewhon Math]{CharacterVariant=8}}
  },  
 CharacterVariant / theta.code:n =
  {
   \AddToHook{package/fontspec/after}%
{ \defaultfontfeatures+[Erewhon Math]{CharacterVariant=9}}
  },  
CharacterVariant / Theta.code:n =
  {
   \AddToHook{package/fontspec/after}%
 {\defaultfontfeatures+[Erewhon Math]{CharacterVariant=10}}
  },  
CharacterVariant / partial.code:n =
  {
   \AddToHook{package/fontspec/after}%
 {\defaultfontfeatures+[Erewhon Math]{CharacterVariant=11}}
  },  
CharacterVariant / Ecal.code:n =
  {
 \AddToHook{package/fontspec/after}%
  { \defaultfontfeatures+[Erewhon Math]{CharacterVariant=20}}
  },  
CharacterVariant / Qcal.code:n =
  {
 \AddToHook{package/fontspec/after}%
  { \defaultfontfeatures+[Erewhon Math]{CharacterVariant=21}}
  },  
CharacterVariant / Tcal.code:n =
  {
 \AddToHook{package/fontspec/after}%
  { \defaultfontfeatures+[Erewhon Math]{CharacterVariant=22}}
  }, 
  %%%%%%% Numbers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
  Numbers.choice:,
  Numbers /  MathOldStyle.code:n =
  {
  \AddToHook{package/fontspec/after}%
{\defaultfontfeatures+[Erewhon Math]{Numbers=OldStyle}}
  }, 
  Numbers /  TextOldStyle.code:n =
  {
  \AddToHook{package/fontspec/after}%
{ \defaultfontfeatures+[erewhon]{Numbers=OldStyle}}
  }, 
Numbers / OldStyle.code:n =
  {
  \AddToHook{package/fontspec/after}%
{ \defaultfontfeatures+{Numbers=OldStyle}
   \defaultfontfeatures+[Erewhon Math]{RawFeature=-onum}}
  }, 
 Numbers / FullOldStyle.code:n =
  {
 \AddToHook{package/fontspec/after}%
{  \defaultfontfeatures+{Numbers=OldStyle}}
  },  
 %%%% usage 
 french.usage=load,
 no-statement.usage=load,
 no-hyperref.usage=load,
 indent.usage=load,
no-indent.usage=load,
ThmNamePos.usage=general,
oneside.usage=load,
twoside.usage=load,
PubliClass.usage=load,
FontSize.usage=general,
ColorTheme.usage=general,
ColorOne.usage=general,
ColorTwo.usage=general,
Output.usage=load,
StylisticSet.usage=load,
CharacterVariant.usage=load,
Numbers.usage=load
}
%%%%%
\ProcessKeyOptions[tango]
%%%%%
\NewDocumentCommand\tgosetup{}{\SetKeys[tango]}
%%%%%%%%
%%%%%%% 10pt %%%%%%%%%%%%%
\NewDocumentCommand\TgoTenPointsFonts{}{%
\renewcommand\TgoSmallerSize{%
\TgoSmallerSizeCommandtrue%
\tgosetup{FontSize=9pt}%
\TgoSmallerSizeCommandfalse%
}%
\renewcommand\normalsize{%
   \fontsize{10}{12.7}\selectfont%
   \setlength\abovedisplayskip{6pt plus 3pt minus 2pt}%
   \setlength\abovedisplayshortskip{0pt plus 3pt}%
   \setlength\belowdisplayshortskip{4.5pt plus 2.5pt minus 1.5pt}%
   \setlength\belowdisplayskip{\abovedisplayskip}%
   \let\@listi\@listI%
   }%
\normalsize%
\ifTgoSmallerSizeCommand%
\else%
\setlength\TgoStandardMargin{1.5em}%
\fi%
\ifx\MakeRobust\@undefined \else%
    \MakeRobust\normalsize%
\fi%
\DeclareRobustCommand\small{%
   \fontsize{9}{11.45}\selectfont%
   \setlength\abovedisplayskip{6pt plus 3pt minus 2pt}%
   \setlength\abovedisplayshortskip {0pt plus 3pt}%
   \setlength\belowdisplayshortskip {4pt plus 2pt minus 2pt}%
   \def\@listi{\leftmargin\leftmargini%
               \topsep 6\p@ \@plus2\p@ \@minus2\p@%
               \parsep 2\p@ \@plus2\p@ \@minus\p@%
               \itemsep \parsep}%
  \setlength \belowdisplayskip {\abovedisplayskip}%
    \let\@listi\@listI%
 }%
\DeclareRobustCommand\footnotesize{%
   \fontsize{8}{10.2}\selectfont%
   \setlength\abovedisplayskip{6pt plus 2pt minus  4pt}%
   \setlength\abovedisplayshortskip{0pt plus 1 pt}%
   \setlength\belowdisplayshortskip{3pt plus 2pt minus 1 pt}%
   \def\@listi{\leftmargin\leftmargini%
               \topsep 4\p@ \@plus2\p@ \@minus2\p@%
               \parsep 2\p@ \@plus\p@ \@minus\p@%
               \itemsep \parsep}%
 \setlength \belowdisplayskip {\abovedisplayskip}%
 }%
\DeclareRobustCommand\scriptsize{\fontsize{7}{8.9}\selectfont}%
\DeclareRobustCommand\tiny{\fontsize{5}{6.4}\selectfont}%
\DeclareRobustCommand\large{\fontsize{11.5}{14.6}\selectfont}%
\DeclareRobustCommand\Large{\fontsize{14}{17}\selectfont}%
\DeclareRobustCommand\LARGE{\fontsize{17}{20}\selectfont}%
\DeclareRobustCommand\huge{\fontsize{20}{23}\selectfont}%
\DeclareRobustCommand\Huge{\fontsize{24}{27}\selectfont}%
\DeclareRobustCommand\HUGE{\fontsize{58}{58}\selectfont}%
}%
%%%%%%%%%%%%%% 11pt %%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand\TgoElevenPointsFonts{}{%
\renewcommand\TgoSmallerSize{%
\TgoSmallerSizeCommandtrue%
\tgosetup{FontSize=10pt}%
\TgoSmallerSizeCommandfalse%
}%
\renewcommand\normalsize{%
   \fontsize{11}{13.9}\selectfont%
   \setlength\abovedisplayskip {6pt plus 3pt minus 2pt}%
   \setlength\abovedisplayshortskip{0pt plus 3pt}%
   \setlength\belowdisplayshortskip {4.5pt plus 2.5pt minus 2 pt}%
   \setlength\belowdisplayskip{\abovedisplayskip}%
   \let\@listi\@listI}%
\normalsize%
\ifTgoSmallerSizeCommand%
\else%
\setlength\TgoStandardMargin{1.5em}%
\fi%
\ifx\MakeRobust\@undefined \else%
    \MakeRobust\normalsize%
\fi%
\DeclareRobustCommand\small{%
   \fontsize{10}{12.7}\selectfont%
   \setlength\abovedisplayskip{6pt plus 3pt minus 2pt}%
   \setlength\abovedisplayshortskip{0pt plus 3pt}%
   \setlength\belowdisplayshortskip {4pt plus 2 pt minus 2pt}%
   \def\@listi{\leftmargin\leftmargini%
               \topsep 6\p@ \@plus2\p@ \@minus2\p@%
               \parsep 2\p@ \@plus2\p@ \@minus\p@%
               \itemsep \parsep}%
   \setlength\belowdisplayskip{\abovedisplayskip}%
    \let\@listi\@listI%
 }%
\DeclareRobustCommand\footnotesize{%
   \fontsize{9}{11.35}\selectfont%
   \setlength\abovedisplayskip{6pt plus 2pt minus 4pt}%
   \setlength\abovedisplayshortskip{0pt plus 1pt}%
   \setlength\belowdisplayshortskip{3pt plus 2pt minus 1pt}%
   \def\@listi{\leftmargin\leftmargini%
               \topsep 4\p@ \@plus2\p@ \@minus2\p@%
               \parsep 2\p@ \@plus\p@ \@minus\p@%
               \itemsep \parsep}%
   \setlength\belowdisplayskip{\abovedisplayskip}%
}%
\DeclareRobustCommand\scriptsize{\fontsize{8}{10.2}\selectfont}%
\DeclareRobustCommand\tiny{\fontsize{6}{7.6}\selectfont}%
\DeclareRobustCommand\large{\fontsize{13}{15.85}\selectfont}%
\DeclareRobustCommand\Large{\fontsize{15}{18}\selectfont}%
\DeclareRobustCommand\LARGE{\fontsize{18}{21}\selectfont}%
\DeclareRobustCommand\huge{\fontsize{21}{24}\selectfont}%
\DeclareRobustCommand\Huge{\fontsize{24}{27}\selectfont}%
\DeclareRobustCommand\HUGE{\fontsize{60}{60}\selectfont}%
}%
%%%%%%% 12pt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand\TgoTwelvePointsFonts{}{%
\renewcommand\TgoSmallerSize{%
\TgoSmallerSizeCommandtrue%
\tgosetup{FontSize=11pt}%
\TgoSmallerSizeCommandfalse%
}%
\renewcommand\normalsize{%
   \fontsize{12}{15.1}\selectfont%
   \setlength\abovedisplayskip{6pt plus 3pt minus 2pt}%
    \setlength\abovedisplayshortskip{0pt plus 3pt}%
    \setlength\belowdisplayshortskip {4.5pt plus 2.5pt minus2pt}%
    \setlength\belowdisplayskip{\abovedisplayskip}%
   \let\@listi\@listI}%
\normalsize%
\ifTgoSmallerSizeCommand%
\else%
\setlength\TgoStandardMargin{1.5em}%
\fi%
\ifx\MakeRobust\@undefined \else%
    \MakeRobust\normalsize%
\fi%
\DeclareRobustCommand\small{%
   \fontsize{11}{13.9}\selectfont%
    \setlength\abovedisplayskip{6pt plus 3pt minus 2pt}%
    \setlength\abovedisplayshortskip{0pt plus 3pt}%
    \setlength\belowdisplayshortskip{4pt plus 2pt minus 2pt}%
   \def\@listi{\leftmargin\leftmargini%
               \topsep 6\p@ \@plus2\p@ \@minus2\p@%
               \parsep 2\p@ \@plus2\p@ \@minus\p@%
               \itemsep \parsep}%
    \setlength\belowdisplayskip{\abovedisplayskip}%
    \let\@listi\@listI%
 }%
\DeclareRobustCommand\footnotesize{%
   \fontsize{10}{12.7}\selectfont%
    \setlength\abovedisplayskip {6pt plus 2pt minus 4pt}%
    \setlength\abovedisplayshortskip{0pt plus 1pt}%
    \setlength\belowdisplayshortskip{3pt plus 2pt minus 1pt}%
   \def\@listi{\leftmargin\leftmargini%
               \topsep 4\p@ \@plus2\p@ \@minus2\p@%
               \parsep 2\p@ \@plus\p@ \@minus\p@%
               \itemsep \parsep}%
    \setlength\belowdisplayskip{\abovedisplayskip}%
}%
\DeclareRobustCommand\scriptsize{\fontsize{9}{11.45}\selectfont}%
\DeclareRobustCommand\tiny{\fontsize{7}{8.9}\selectfont}%
\DeclareRobustCommand\large{\fontsize{14.2}{16.85}\selectfont}%
\DeclareRobustCommand\Large{\fontsize{16.5}{19.2}\selectfont}%
\DeclareRobustCommand\LARGE{\fontsize{19.2}{22}\selectfont}%
\DeclareRobustCommand\huge{\fontsize{22}{25}\selectfont}%
\DeclareRobustCommand\Huge{\fontsize{25}{28}\selectfont}%
\DeclareRobustCommand\HUGE{\fontsize{63}{63}\selectfont}%
}%
%%
%%%%%%% 9pt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand\TgoNinePointsFonts{}{%
\renewcommand\TgoSmallerSize{}
\renewcommand\normalsize{%
   \fontsize{9}{11.45}\selectfont%
   \setlength\abovedisplayskip{6pt plus 3pt minus 2pt}%
   \setlength\abovedisplayshortskip{0pt plus 3pt}%
   \setlength\belowdisplayshortskip{4.5pt plus 2.5pt minus 2pt}%
   \setlength\belowdisplayskip{\abovedisplayskip}%
   \let\@listi\@listI}%
\normalsize%
\setlength\TgoStandardMargin{1.5em}%
\ifx\MakeRobust\@undefined\else%
    \MakeRobust\normalsize%
\fi%
\DeclareRobustCommand\small{%
   \fontsize{8}{10.25}\selectfont%
   \setlength\abovedisplayskip{6pt plus 3pt minus 2pt}%
   \setlength\abovedisplayshortskip{0pt plus 3pt}%
   \setlength\belowdisplayshortskip{4pt plus 2pt minus 2pt}%
   \def\@listi{\leftmargin\leftmargini%
               \topsep 6\p@ \@plus2\p@ \@minus2\p@%
               \parsep 2\p@ \@plus2\p@ \@minus\p@%
               \itemsep \parsep}%
   \setlength\belowdisplayskip{\abovedisplayskip}%
    \let\@listi\@listI%
 }%
\DeclareRobustCommand\footnotesize{%
   \fontsize{7}{9}\selectfont%
   \setlength\abovedisplayskip{6pt plus 2pt minus 4pt}%
   \setlength\abovedisplayshortskip{0pt plus 1pt}%
   \setlength\belowdisplayshortskip{3pt plus 2pt minus 1pt}%
   \def\@listi{\leftmargin\leftmargini%
               \topsep 4\p@ \@plus2\p@ \@minus2\p@%
               \parsep 2\p@ \@plus\p@ \@minus\p@%
               \itemsep \parsep}%
   \setlength\belowdisplayskip{\abovedisplayskip}%
}%
\DeclareRobustCommand\scriptsize{\fontsize{6}{7.7}\selectfont}%
\DeclareRobustCommand\tiny{\fontsize{5}{6.4}\selectfont}%
\DeclareRobustCommand\large{\fontsize{10.3}{13}\selectfont}%
\DeclareRobustCommand\Large{\fontsize{12.7}{15.4}\selectfont}%
\DeclareRobustCommand\LARGE{\fontsize{15.2}{17.3}\selectfont}%
\DeclareRobustCommand\huge{\fontsize{18}{20}\selectfont}%
\DeclareRobustCommand\Huge{\fontsize{20}{24}\selectfont}%
\DeclareRobustCommand\HUGE{\fontsize{52}{52}\selectfont}%
}%
%%
%%
\ifTgoOneSide%
 \LoadClass[oneside]{\TgoPublicationClass}%
 \else%
  \LoadClass[twoside]{\TgoPublicationClass}%
\fi%
%%%%%%%%%%%
\RequirePackage{xcolor}
%%%%
\RequirePackage{mathtools}
\RequirePackage{amsthm}
%%%%
\RequirePackage{graphicx,microtype,geometry,enumitem,float,afterpage}
%
\RequirePackage{titletoc}
%
\RequirePackage[pagestyles,toctitles,newlinetospace,clearempty,noindentafter]{titlesec}
%
%
\assignpagestyle{\chapter}{empty}
\assignpagestyle{\part}{empty}
\RequirePackage{ccaption,caption}
\DeclareCaptionLabelFormat{tango}{\sffamily\fontseries{sb}\selectfont#1\nobreakspace#2}
\captionsetup{font={sf,small},labelformat=tango,labelfont={color=ColorOne}}
\newfixedcaption{\tgofigcaption}{figure}
\newfixedcaption{\tgotabcaption}{table}
 %%% Fontes
  %%
 \RequirePackage{fontspec}
\RequirePackage{unicode-math}[2020/01/31]
 \defaultfontfeatures+{Ligatures=TeX,RawFeature={+pnum}}
%
 \SetTgoBaseFonts
  %%
 \thinmuskip=2.5mu
 \medmuskip=3mu plus 1mu minus 3mu
 \thickmuskip=4mu plus 3mu minus 0.5mu
 %%
\setmonofont{Inconsolatazi4}[Scale=MatchLowercase]
%
 \setsansfont{NotoSans}[%
 Scale=0.9,
 Ligatures=TeX,
 UprightFeatures={
Font=NotoSansMedium
},
ItalicFeatures={
Font=NotoSansMediumItalic
},
BoldFeatures={
Font=NotoSansBold
},
BoldItalicFeatures={
Font=NotoSansBoldItalic
},
FontFace={ul}{n}{Font=NotoSansThin},
FontFace={ul}{it}{Font=NotoSansThinItalic},
FontFace={el}{n}{Font=NotoSansExtraLight},
FontFace={el}{it}{Font=NotoSansExtraLightItalic},
FontFace={l}{n}{Font=NotoSansLight},
FontFace={l}{it}{Font=NotoSansLightItalic},
FontFace={sl}{n}{Font=NotoSansRegular},
FontFace={sl}{it}{Font=NotoSansItalic},
FontFace={sb}{n}{Font=NotoSansSemiBold},
FontFace={sb}{it}{Font=NotoSansSemiBoldItalic},
FontFace={eb}{n}{Font=NotoSansExtraBold},
FontFace={eb}{it}{Font=NotoSansExtraBoldItalic},
FontFace={ub}{n}{Font=NotoSansBlack},
FontFace={ub}{it}{Font=NotoSansBlackItalic},
]
%%
\DeclareFontSeriesDefault[sf]{md}{sl}
%
%
\RequirePackage{fourier-orns}%
%
%% OTF Fonts Commands
%%
\NewDocumentCommand{\superiors}{}{\addfontfeature{RawFeature=+sups}}
\NewDocumentCommand{\scinferiors}{}{\addfontfeature{RawFeature=+sinf}}
\NewDocumentCommand{\smartfracs}{}{\addfontfeature{RawFeature=+frac}}
\NewDocumentCommand{\fullsc}{m}{{\addfontfeature{RawFeature=+c2sc}\MakeUppercase{#1}}}
\DeclareTextFontCommand{\textsup}{\superiors}
\DeclareTextFontCommand{\textscinf}{\scinferiors}
\DeclareTextFontCommand{\smartfrac}{\smartfracs}
\NewDocumentCommand{\olddigits}{}{\addfontfeature{RawFeature={-lnum,+onum}}}
\NewDocumentCommand{\propdigits}{}{\addfontfeature{RawFeature={-tnum,+pnum}}}
\NewDocumentCommand{\liningdigits}{}{\addfontfeature{RawFeature={-onum,+lnum}}}
\NewDocumentCommand{\tabulardigits}{}{\addfontfeature{RawFeature={-pnum,+tnum}}}
%
 %
 %%%%%%%% My taylor is rich %%%%%%%%%%%
%
\RequirePackage{iflang}
\RequirePackage{babel}
\IfLanguageName{nil}{%
\ClassError{tango}{No language option is given}
{%
You *must* pass at least one language\MessageBreak 
option for babel to the tango class.}
}{}
%
%
\ifTgoFrenchLanguage
\frenchsetup{StandardLists,og=«, fg=»,PartNameFull=false,
SmallCapsFigTabCaptions=false,
CustomiseFigTabCaptions=false}
\addto\captionsfrench{% DF
\renewcommand\TgoTheoremName{Théorème}
\renewcommand\TgoDefinitionName{Définition}
\renewcommand\TgoPropositionName{Proposition}
\renewcommand\TgoLemmaName{Lemme}
\renewcommand\TgoCorollaryName{Corollaire}
\renewcommand\TgoRemarkName{Remarque}
\renewcommand\TgoExampleName{Exemple}
\renewcommand\TgoContentsName{Sommaire}
\renewcommand\TgoExerciseName{Exercice}
\renewcommand\TgoExercisesSubsectionName{Exercices}
\renewcommand\TgoExercisesSectionName{Exercices}
}
\fi
%%%
\ifTgoNGermanLanguage
\addto\captionsngerman{%
\renewcommand\TgoTheoremName{Satz}
\renewcommand\TgoDefinitionName{Definition}
\renewcommand\TgoPropositionName{Proposition}
\renewcommand\TgoLemmaName{Lemma}
\renewcommand\TgoCorollaryName{Korollar}%% ????
\renewcommand\TgoRemarkName{Bemerkung}
\renewcommand\TgoExampleName{Beispiel}
\renewcommand\TgoContentsName{Inhaltsverzeichnis}
\renewcommand\TgoExerciseName{Übung}
\renewcommand\TgoExercisesSubsectionName{Übungen}
\renewcommand\TgoExercisesSectionName{Übungen}
}
\fi
%
%%%
\ifTgoGermanLanguage
\addto\captionsgerman{%
\renewcommand\TgoTheoremName{Satz}
\renewcommand\TgoDefinitionName{Definition}
\renewcommand\TgoPropositionName{Proposition}
\renewcommand\TgoLemmaName{Lemma}
\renewcommand\TgoCorollaryName{Korollar}%% ????
\renewcommand\TgoRemarkName{Bemerkung}
\renewcommand\TgoExampleName{Beispiel}
\renewcommand\TgoContentsName{Inhaltsverzeichnis}
\renewcommand\TgoExerciseName{Übung}
\renewcommand\TgoExercisesSubsectionName{Übungen}
\renewcommand\TgoExercisesSectionName{Übungen}
}
\fi
%
%%%
\ifTgoNAustrianLanguage
\addto\captionsnaustrian{%
\renewcommand\TgoTheoremName{Satz}
\renewcommand\TgoDefinitionName{Definition}
\renewcommand\TgoPropositionName{Proposition}
\renewcommand\TgoLemmaName{Lemma}
\renewcommand\TgoCorollaryName{Korollar}%% ????
\renewcommand\TgoRemarkName{Bemerkung}
\renewcommand\TgoExampleName{Beispiel}
\renewcommand\TgoContentsName{Inhaltsverzeichnis}
\renewcommand\TgoExerciseName{Übung}
\renewcommand\TgoExercisesSubsectionName{Übungen}
\renewcommand\TgoExercisesSectionName{Übungen}
}
\fi
%
%%%
\ifTgoNSwissGermanLanguage
\addto\captionsnswissgerman{%
\renewcommand\TgoTheoremName{Satz}
\renewcommand\TgoDefinitionName{Definition}
\renewcommand\TgoPropositionName{Proposition}
\renewcommand\TgoLemmaName{Lemma}
\renewcommand\TgoCorollaryName{Korollar}%% ????
\renewcommand\TgoRemarkName{Bemerkung}
\renewcommand\TgoExampleName{Beispiel}
\renewcommand\TgoContentsName{Inhaltsverzeichnis}
\renewcommand\TgoExerciseName{Übung}
\renewcommand\TgoExercisesSubsectionName{Übungen}
\renewcommand\TgoExercisesSectionName{Übungen}
}
\fi
%
%%%
\ifTgoItalianLanguage
\addto\captionsitalian{%
\renewcommand\TgoTheoremName{Teorema}
\renewcommand\TgoDefinitionName{Definizione}
\renewcommand\TgoPropositionName{Proposizione}
\renewcommand\TgoLemmaName{Lemma}
\renewcommand\TgoCorollaryName{Corollario}
\renewcommand\TgoRemarkName{Nota}%%????
\renewcommand\TgoExampleName{Esempio}
\renewcommand\TgoContentsName{Sommario}%%Contenuti????
\renewcommand\TgoExerciseName{Esercizio}
\renewcommand\TgoExercisesSubsectionName{Esercizi}
\renewcommand\TgoExercisesSectionName{Esercizi}
}
\fi
%
%%%
\ifTgoSpanishLanguage
\addto\captionsspanish{%
\renewcommand\TgoTheoremName{Teorema}
\renewcommand\TgoDefinitionName{Definición}
\renewcommand\TgoPropositionName{Proposición}
\renewcommand\TgoLemmaName{Lema}
\renewcommand\TgoCorollaryName{Corolario}
\renewcommand\TgoRemarkName{Osservación}%%????
\renewcommand\TgoExampleName{Ejemplo}
\renewcommand\TgoContentsName{Sumario}%%????
\renewcommand\TgoExerciseName{Ejercicio}
\renewcommand\TgoExercisesSubsectionName{Ejercicios}
\renewcommand\TgoExercisesSectionName{Ejercicios}
}
\fi
%
%%%
\ifTgoEnglishLanguage
\addto\captionsenglish{%
\renewcommand\TgoTheoremName{Theorem}
\renewcommand\TgoDefinitionName{Definition}
\renewcommand\TgoPropositionName{Proposition}
\renewcommand\TgoLemmaName{Lemma}
\renewcommand\TgoCorollaryName{Corollary}
\renewcommand\TgoRemarkName{Remark}
\renewcommand\TgoExampleName{Example}
\renewcommand\TgoContentsName{Contents}
\renewcommand\TgoExerciseName{Exercise}
\renewcommand\TgoExercisesSubsectionName{Exercises}
\renewcommand\TgoExercisesSectionName{Exercises}
}
\fi
%
%%%
\ifTgoBritishLanguage
\addto\captionsbritish{%
\renewcommand\TgoTheoremName{Theorem}
\renewcommand\TgoDefinitionName{Definition}
\renewcommand\TgoPropositionName{Proposition}
\renewcommand\TgoLemmaName{Lemma}
\renewcommand\TgoCorollaryName{Corollary}
\renewcommand\TgoRemarkName{Remark}
\renewcommand\TgoExampleName{Example}
\renewcommand\TgoContentsName{Contents}
\renewcommand\TgoExerciseName{Exercise}
\renewcommand\TgoExercisesSubsectionName{Exercises}
\renewcommand\TgoExercisesSectionName{Exercises}
}
\fi
%
%%%
\ifTgoAmericanLanguage
\addto\captionsamerican{%
\renewcommand\TgoTheoremName{Theorem}
\renewcommand\TgoDefinitionName{Definition}
\renewcommand\TgoPropositionName{Proposition}
\renewcommand\TgoLemmaName{Lemma}
\renewcommand\TgoCorollaryName{Corollary}
\renewcommand\TgoRemarkName{Remark}
\renewcommand\TgoExampleName{Example}
\renewcommand\TgoContentsName{Contents}
\renewcommand\TgoExerciseName{Exercise}
\renewcommand\TgoExercisesSubsectionName{Exercises}
\renewcommand\TgoExercisesSectionName{Exercises}
}
\fi
%
%%%
\ifTgoCanadianLanguage
\addto\captionscanadian{%
\renewcommand\TgoTheoremName{Theorem}
\renewcommand\TgoDefinitionName{Definition}
\renewcommand\TgoPropositionName{Proposition}
\renewcommand\TgoLemmaName{Lemma}
\renewcommand\TgoCorollaryName{Corollary}
\renewcommand\TgoRemarkName{Remark}
\renewcommand\TgoExampleName{Example}
\renewcommand\TgoContentsName{Contents}
\renewcommand\TgoExerciseName{Exercise}
\renewcommand\TgoExercisesSubsectionName{Exercises}
\renewcommand\TgoExercisesSectionName{Exercises}
}
\fi
%
%%%
\ifTgoAustralianLanguage
\addto\captionsaustralian{%
\renewcommand\TgoTheoremName{Theorem}
\renewcommand\TgoDefinitionName{Definition}
\renewcommand\TgoPropositionName{Proposition}
\renewcommand\TgoLemmaName{Lemma}
\renewcommand\TgoCorollaryName{Corollary}
\renewcommand\TgoRemarkName{Remark}
\renewcommand\TgoExampleName{Example}
\renewcommand\TgoContentsName{Contents}
\renewcommand\TgoExerciseName{Exercise}
\renewcommand\TgoExercisesSubsectionName{Exercises}
\renewcommand\TgoExercisesSectionName{Exercises}
}
\fi
%
%%%
\ifTgoNewZealandLanguage
\addto\captionsnewzealand{%
\renewcommand\TgoTheoremName{Theorem}
\renewcommand\TgoDefinitionName{Definition}
\renewcommand\TgoPropositionName{Proposition}
\renewcommand\TgoLemmaName{Lemma}
\renewcommand\TgoCorollaryName{Corollary}
\renewcommand\TgoRemarkName{Remark}
\renewcommand\TgoExampleName{Example}
\renewcommand\TgoContentsName{Contents}
\renewcommand\TgoExerciseName{Exercise}
\renewcommand\TgoExercisesSubsectionName{Exercises}
\renewcommand\TgoExercisesSectionName{Exercises}
}
\fi
%
%%% Last package
\ifTgoNoHyperref
\else
\RequirePackage[colorlinks,linkcolor=ColorOne,urlcolor=ColorOne]{hyperref}
\fi
%%
 %%%
%%%%%%% parindent %%%%%%%%%%%%%%%%%%%%%%%%
\setlength\parindent{\TgoStandardMargin}
\setlength{\parskip}{0pt plus 1pt}
\ifTgoSmartphoneOutput
\setlength{\parindent}{0pt}
\setlength{\parskip}{3pt plus 2pt minus1pt}
\else
\ifTgoParindentZero
\setlength{\parindent}{0pt}
\setlength{\parskip}{3pt plus 1pt}
\fi\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\TgoCurrentLists{}
%\ifTgoFrenchLanguage
%\setlength{\TgoTitleIndent}{\parindent}
%\else
%\setlength{\TgoTitleIndent}{0em}
%\fi
\ifTgoTitleIndentZero
\setlength{\TgoTitleIndent}{0em}
\else
\setlength{\TgoTitleIndent}{\parindent}
\fi
%
%
\renewcommand\labelitemi{\textbullet}
\renewcommand\labelitemii{\textopenbullet}
\renewcommand\labelitemiii{\starredbullet}
\renewcommand\labelitemiv{\textperiodcentered}
%%%%%
\NewDocumentCommand\renewtgolabels{%
s E{1234}{ {} {} {} {} }%
}
{%
\IfBooleanTF{#1}%
{%
\IfBlankTF{#2}%
{\renewcommand\labelitemi{\textbullet}}%
{\renewcommand\labelitemi{#2}}%
\IfBlankTF{#3}%
{\renewcommand\labelitemii{\textopenbullet}}%
{\renewcommand\labelitemii{#3}}%
\IfBlankTF{#4}%
{\renewcommand\labelitemiii{\starredbullet}}%
{\renewcommand\labelitemiii{#4}}%
\IfBlankTF{#5}%
{\renewcommand\labelitemiv{\textperiodcentered}}%
{\renewcommand\labelitemiv{#5}}%
}%
{%
\IfBlankF{#2}{\renewcommand\labelitemi{#2}}%
\IfBlankF{#3}{\renewcommand\labelitemii{#3}}%
\IfBlankF{#4}{\renewcommand\labelitemiii{#4}}%
\IfBlankF{#5}{\renewcommand\labelitemiv{#5}}%
}%
\TgoCurrentLists%
}%
\NewDocumentCommand\tgosmartlists{}
{%
\RenewDocumentCommand\TgoCurrentLists{}{\tgosmartlists}
\setlength{\leftmargini}{\TgoStandardMargin}
\setlength{\leftmarginii}{\TgoStandardMargin}
\setlength{\leftmarginiii}{\TgoStandardMargin}
\setlength{\leftmarginiv}{\TgoStandardMargin}
\setlist{
         itemsep=0.3ex plus 0.1ex minus 0.1ex,
         parsep=0.3ex plus 0.1ex minus 0.1ex,
         topsep=0.3ex plus 0.2ex minus 0.1ex,
         partopsep=0.3ex plus 0.1ex minus 0.1ex
}
\setlist[itemize]{nosep, leftmargin=\TgoStandardMargin, align=left, labelsep=0.5em, labelindent=\TgoStandardMargin+\parindent,
itemindent=*}
%
\setlist[itemize,1]{leftmargin=0em, align=left,  labelsep=0.5em, labelindent=\parindent, itemindent=*  }
%
\setlist[enumerate]{nosep, leftmargin=\TgoStandardMargin, align=left, labelsep=0.5em, 
labelindent=\TgoStandardMargin+\parindent,widest=0, itemindent=*}
%
\setlist[enumerate,1]{leftmargin=0em, align=left,  labelsep=0.5em, labelindent=\parindent, itemindent=*  }
%
}
%%%
\NewDocumentCommand\tgostandardlists{}
{%
\RenewDocumentCommand\TgoCurrentLists{}{\tgostandardlists}
\setlength{\leftmargini}{\TgoStandardMargin}
\setlength{\leftmarginii}{\TgoStandardMargin}
\setlength{\leftmarginiii}{\TgoStandardMargin}
\setlength{\leftmarginiv}{\TgoStandardMargin}
\setlist{
         itemsep=0.4ex plus 0.2ex minus 0.2ex,
         parsep=0.4ex plus 0.2ex minus 0.2ex,
         topsep=0.8ex plus 0.4ex minus 0.4ex,
         partopsep=0.4ex plus 0.2ex minus 0.2ex
}
\setlist[itemize]{leftmargin=\TgoStandardMargin, align=left, labelindent=0em, 
labelwidth=0.75\TgoStandardMargin, labelsep=0.25\TgoStandardMargin, itemindent=!}
%%
\setlist[itemize,1]{leftmargin=2\TgoStandardMargin, align=left, labelindent=\TgoStandardMargin, labelwidth=0.75\TgoStandardMargin, labelsep=0.25\TgoStandardMargin, itemindent=!}
%
\setlist[enumerate]{leftmargin=\TgoStandardMargin, align=left, labelindent=0em, 
labelwidth=0.75\TgoStandardMargin, labelsep=0.25\TgoStandardMargin, itemindent=!}
%
\setlist[enumerate,1]{leftmargin=2\TgoStandardMargin, align=left, labelindent=\TgoStandardMargin, labelwidth=0.75\TgoStandardMargin, labelsep=0.25\TgoStandardMargin, itemindent=!}
}
\renewcommand{\labelenumii}{\alph{enumii}.}

\tgostandardlists
%
%
%\NewDocumentCommand\testlists{}{
%\setlength{\leftmargini}{\TgoStandardMargin}
%\setlength{\leftmarginii}{\TgoStandardMargin}
%\setlength{\leftmarginiii}{\TgoStandardMargin}
%\setlength{\leftmarginiv}{\TgoStandardMargin}
%\setlist{
%         itemsep=0.4ex plus 0.2ex minus 0.2ex,
%         parsep=0.4ex plus 0.2ex minus 0.2ex,
%         topsep=0.8ex plus 0.4ex minus 0.4ex,
%         partopsep=0.4ex plus 0.2ex minus 0.2ex
%}
%\setlist[itemize]{nosep, leftmargin=\TgoStandardMargin, align=left, labelsep=0.5em, labelindent=\TgoStandardMargin+\parindent,
%itemindent=*}
%%
%\setlist[itemize,1]{leftmargin=0em, align=left,  labelsep=0.5em, labelindent=\parindent, itemindent=*  }
%%
%\setlist[enumerate]{nosep, leftmargin=\TgoStandardMargin, align=left, labelsep=0.5em, 
%labelindent=\TgoStandardMargin+\parindent,widest=0, itemindent=*}
%%
%\setlist[enumerate,1]{leftmargin=0em, align=left,  labelsep=0.5em, labelindent=\parindent, itemindent=*  }
%%
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpagestyle{tango}{
  \ifTgoOneSide
\ifTgoBook
  \sethead {\sffamily\addfontfeature{RawFeature=+c2sc}\MakeUppercase\chaptertitle}{}
  {\sffamily\thepage} % all
 \else
  \sethead{\sffamily\addfontfeature{RawFeature=+c2sc}\MakeUppercase\sectiontitle}{}
  {\sffamily\thepage}% all
  \fi
\else
\ifTgoBook
\sethead[\sffamily\thepage]
[\sffamily\addfontfeature{RawFeature=+c2sc}\MakeUppercase\chaptertitle][] % even
          {}{\sffamily\addfontfeature{RawFeature=+c2sc}\MakeUppercase\sectiontitle}
          {\sffamily\thepage} % odd
\else
  \sethead[\sffamily\thepage][\sffamily\addfontfeature{RawFeature=+c2sc}\MakeUppercase\sectiontitle][] % even
          {}{\sffamily\addfontfeature{RawFeature=+c2sc}\MakeUppercase\sectiontitle}
          {\sffamily\thepage}% odd
\fi
\fi}
  %%%%%%%%%%%%
\pagestyle{tango}
%%%%%%%%%%%%%%
%%% Mise en forme des titres %%%%%%%%%%%%%%%
\setcounter{secnumdepth}{2}
%%%
\ifTgoBook
\newcommand\TgoChapterBox[1]{%
{\filright\sffamily\addfontfeature{RawFeature=-onum}\fontseries{eb}\selectfont\HUGE\hspace*{-0.06em}\thechapter}%
\quad\parbox{0.75\textwidth}{\filright#1}
}
\titleformat{\part}[display]{\centering\color{ColorOne}\sffamily
\addfontfeature{RawFeature=-onum}\fontseries{eb}\selectfont\Huge}
{\LARGE\partname~\thepart}{\baselineskip}{}
%%
\titleformat{name=\chapter}[block]{\filright\color{ColorOne}\fontspec{\TgoChapterTitleFont}\addfontfeature{RawFeature=-onum}\huge}
{}{0em}{\TgoChapterBox}
%%%
\titleformat{name=\chapter,numberless}[block]{\filright\color{ColorOne}\fontspec{\TgoChapterTitleFont}\addfontfeature{RawFeature=-onum}\huge}
{}{0em}{}
\fi%
\titleformat{\section}{\color{ColorOne}\sffamily\addfontfeature{RawFeature=-onum}%
\fontseries{b}\selectfont\large}{\thesection}{1em}{\uppercase}%
\titleformat{\subsection}{\color{ColorOne}\sffamily\fontseries{sb}\selectfont\large}{\thesubsection}{1em}{}%
\titleformat{\subsubsection}{\color{ColorOne}\sffamily\fontseries{sb}\selectfont}{\thesubsubsection}{0.7em}{}%
\titleformat{\paragraph}[runin]{\itshape}{\theparagraph.}{0.5em}{}[. — ]%
\titleformat{\subparagraph}[runin]{}{\thesubparagraph.}{0.5em}{}[. — ]%
\titlespacing{\chapter}{\TgoTitleIndent}{0pt}{6ex}%
\titlespacing{\section}{\TgoTitleIndent}{12pt  plus 5pt  minus 4pt}{6pt plus 3pt minus 2pt}%
\titlespacing{\subsection}{\TgoTitleIndent}{12pt plus 5pt minus 4pt}{6pt plus 3pt minus 2pt}%
\titlespacing{\subsubsection}{\TgoTitleIndent}{7pt plus 3pt  minus 2pt}{3pt plus 2pt minus 1pt}%
\titlespacing{\paragraph}{\TgoTitleIndent}{7pt plus 3pt  minus 2pt}{3pt plus 1pt minus 1pt}%
\titlespacing{\subparagraph}{\TgoTitleIndent}{4pt plus 2pt  minus 2pt}{3pt plus 1pt minus 1pt}%
%
\ifTgoBook
\NewCommandCopy{\tgotitle}{\chapter}
\else%%article
\NewDocumentCommand\tgotitle{s m}{%
\IfBooleanTF{#1}{%
\clearpage\thispagestyle{empty}
%  \vspace*{5\p@}%
  {\parindent=0pt \raggedright
    \normalfont
    \interlinepenalty\@M
\advance\leftskip by \TgoTitleIndent
\fontspec{\TgoChapterTitleFont}\huge\color{ColorOne}#2 
\par}    \vspace {\TgoAfterChapterSkip}\par}
 {%
\clearpage\thispagestyle{empty}
%  \vspace*{5\p@}%
  {\parindent=0pt \raggedright
    \normalfont
    \interlinepenalty\@M
\advance\leftskip by \TgoTitleIndent
\fontspec{\TgoChapterTitleFont}\huge\color{ColorOne}#2 
\par}    \vspace {\TgoAfterChapterSkip}\par}
 }
 \fi
%%%%%%%
%%%%%%%Table des matières
%%%%%%%
\ifTgoBook\else
\RenewDocumentCommand\tableofcontents{}{%
{\color{ColorOne}\parskip=0pt%
\noindent\titlerule[1.3pt]%
\vspace{-1\baselineskip}\vspace{1.6pt} \par %
\noindent\titlerule[.5pt]%
}%
 \vspace{-10pt}\par%
    \section*{\contentsname}
            \@starttoc{toc}%
{\color{ColorOne}\parskip=0pt%
\noindent\titlerule[0.5pt]%
\vspace{-1\baselineskip}\vspace{2.4pt} \par %
\noindent\titlerule[1.3pt]%
}%
\par %
\vspace{2\baselineskip}%
\par  %        
 }%
 \fi
   \IfPackageLoadedTF{hyperref}%
{%
\NewCommandCopy{\TgoOriginalToc}{\tableofcontents}%
\RenewDocumentCommand\tableofcontents{}{{\hypersetup{hidelinks}\TgoOriginalToc}}%
}%
{}
%%
%%
\ifTgoBook
\NewDocumentCommand\tgoshorttoc{}{}
\titlecontents{part}
                [50pt] % ie, 1.5em (chapter) + 2.3em
                 {\large\sffamily\fontseries{sb}\selectfont\color{ColorOne}}
                  {\contentslabel{50pt}}
                 {\hspace*{-50pt}}
                 {\titlerule*[1pc]{}\contentspage}
\titlecontents{chapter}
                [16pt] % ie, 1.5em (chapter) + 2.3em
                 {\sffamily\fontseries{b}\selectfont\color{ColorOne}}
                  {\contentslabel{16pt}}
                 {\hspace*{-6pt}}
                 {\titlerule*[1pc]{}\contentspage}
\titlecontents{section}
                 [3.6em] % ie, 1.5em (chapter) + 2.3em
                  {\sffamily\fontseries{m}\selectfont}
                  {\contentslabel{2.5em}}
                  {\hspace*{-2.5em}}
                  {\titlerule*[1pc]{.}\contentspage}
\titlecontents{subsection}
                 [6.4em] % ie, 1.5em (chapter) + 2.3em
                  {\sffamily\fontseries{l}\selectfont}
                  {\contentslabel{3.2em}}
                  {\hspace*{-3.2em}}
                  {\titlerule*[1pc]{.}\contentspage}
 \else
 \NewCommandCopy{\tgoshorttoc}{\tableofcontents}
  \RenewDocumentCommand\tableofcontents{}{}
  \ifTgoFrenchLanguage
  \renewcommand{\frenchcontentsname}{\TgoContentsName}
\fi
 \setcounter{tocdepth}{2}
 \titlecontents{section}
                [1.7em] % ie, 1.5em (chapter) + 2.3em
                 {\sffamily\fontseries{sb}\selectfont}
                  {\contentslabel{2.em}}
                 {\hspace*{-2.em}}
                 {\titlerule*[1pc]{}\contentspage}
\titlecontents{subsection}
                 [4em] % ie, 1.5em (chapter) + 2.3em
                  {\sffamily}
                  {\contentslabel{2.7em}}
                  {\hspace*{-2.7em}}
                  {\titlerule*[1pc]{.}\contentspage}
\titlecontents{subsubsection}
                 [6em] % ie, 1.5em (chapter) + 2.3em
                  {\sffamily\fontseries{l}\selectfont}
                  {\contentslabel{3.5em}}
                  {\hspace*{-3.5em}}
                  {\titlerule*[1pc]{.}\contentspage}
 \fi
%
%%Init
\NewDocumentCommand\AfourCommand{+m}{}
%
\NewDocumentCommand\LetterCommand{+m}{}
%
\NewDocumentCommand\BigTabletCommand{+m}{}
%
\NewDocumentCommand\TabletCommand{+m}{}
%
\NewDocumentCommand\AfiveCommand{+m}{}
%
\NewDocumentCommand\SmallTabletCommand{+m}{}
%
\NewDocumentCommand\eReaderCommand{+m}{}
%
\NewDocumentCommand\SmartphoneCommand{+m}{}
%
\NewDocumentCommand\XAfourCommand{+m}{}
%
\NewDocumentCommand\XLetterCommand{+m}{}
%
\NewDocumentCommand\XBigTabletCommand{+m}{}
%
\NewDocumentCommand\XTabletCommand{+m}{}
%
\NewDocumentCommand\XAfiveCommand{+m}{}
%
\NewDocumentCommand\XSmallTabletCommand{+m}{}
%
\NewDocumentCommand\XeReaderCommand{+m}{}
%
\NewDocumentCommand\XSmartphoneCommand{+m}{}
 %
%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Output Format %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%% Afour %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
\ifTgoAfourPaperOutput
%
\RenewDocumentCommand\AfourCommand{+m}{#1}
%
\RenewDocumentCommand\XLetterCommand{+m}{#1}
%
\RenewDocumentCommand\XBigTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XAfiveCommand{+m}{#1}
%
\RenewDocumentCommand\XTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XSmallTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XeReaderCommand{+m}{#1}
%
\RenewDocumentCommand\XSmartphoneCommand{+m}{#1}
 %
 %%
%\ifTgoOneSide
\geometry{paperwidth=21cm,paperheight=29.7cm,
heightrounded,top=2cm,inner=2.75cm,outer=2.75cm,bottom=3.6cm,
headheight=16pt,headsep=21pt,footskip=50pt}
%\else
%\geometry{paperwidth=21cm,paperheight=29.7cm,
%heightrounded,top=2cm,inner=2.3cm,outer=3.2cm,bottom=3.6cm,
%headheight=16pt,headsep=21pt,footskip=50pt}
%\fi
%
\setlength{\TgoAfterChapterSkip}{21pt}
%
\NewDocumentCommand\tgocover{O{A4Cover}}{\InputIfFileExists{#1}{}{%
\ClassWarning{tango}{Fichier #1.tex absent}}}
\flushbottom\emergencystretch=2.5em
\tolerance800
\clubpenalty1000
\widowpenalty1000%
%
\fi
%%%%%%%
%%%%%% Big Tablet or Letter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifTgoBigTabletOutput
%
\ifTgoLetterOutput
%
\RenewDocumentCommand\LetterCommand{+m}{#1}
%
\RenewDocumentCommand\XBigTabletCommand{+m}{#1}
%
\else
%
\RenewDocumentCommand\BigTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XLetterCommand{+m}{#1}
%
\fi
%
\RenewDocumentCommand\XAfourCommand{+m}{#1}
%
\RenewDocumentCommand\XAfiveCommand{+m}{#1}
%
\RenewDocumentCommand\XTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XSmallTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XeReaderCommand{+m}{#1}
%
\RenewDocumentCommand\XSmartphoneCommand{+m}{#1}
 %
%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%
%
%%
\ifTgoLetterOutput
%\ifTgoOneSide
\geometry{paperwidth=8.5in,paperheight=11in,
heightrounded,top=1.9cm,inner=2.8cm,outer=2.8cm,bottom=3cm,
headheight=16pt,headsep=20pt,footskip=14pt}
%\else
%\geometry{paperwidth=8.5in,paperheight=11in,
%heightrounded,top=1.9cm,inner=2.4cm,outer=3.2cm,bottom=3.6cm,
%headheight=16pt,headsep=20pt,footskip=14pt}
%\fi
%
\setlength{\TgoAfterChapterSkip}{22pt}
%
\NewDocumentCommand\tgocover{O{LetterCover}}{\InputIfFileExists{#1}{}{%
\ClassWarning{tango}{Fichier #1.tex absent}}}
\flushbottom\emergencystretch=2.5em
\tolerance800
\clubpenalty1000
\widowpenalty1000%
%
\else
%
\setlength{\TgoAfterChapterSkip}{21pt}
%
\geometry{paperwidth=19.8cm,paperheight=26.4cm,
heightrounded,top=1.8cm,inner=2.4cm,outer=2.4cm,bottom=2.7cm,
headheight=16pt,headsep=14pt,footskip=14pt}
%
\NewDocumentCommand\tgocover{O{BigTabletCover}}{\InputIfFileExists{#1}{}{%
\ClassWarning{tango}{Fichier #1.tex absent}}}
\flushbottom\emergencystretch=2.5em
\tolerance800
\clubpenalty1000
\widowpenalty1000%
\fi
\fi
%%%%%%%
%%%%%% Tablet or A5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifTgoTabletOutput
%
\ifTgoAfivePaperOutput
\RenewDocumentCommand\AfiveCommand{+m}{#1}
%
\RenewDocumentCommand\XTabletCommand{+m}{#1}
%
\else
%
\RenewDocumentCommand\TabletCommand{+m}{#1}
%
\RenewDocumentCommand\XAfiveCommand{+m}{#1}
%
\fi
%
\RenewDocumentCommand\XLetterCommand{+m}{#1}
%
\RenewDocumentCommand\XAfourCommand{+m}{#1}
%
\RenewDocumentCommand\XBigTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XSmallTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XeReaderCommand{+m}{#1}
%
\RenewDocumentCommand\XSmartphoneCommand{+m}{#1}
 %
%
%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%
%
%%
\ifTgoAfivePaperOutput
%\ifTgoOneSide
\geometry{paperwidth=14.85cm,paperheight=21cm,
heightrounded,top=1.2cm,inner=1.8cm,outer=1.8cm,bottom=2.4cm,
headheight=16pt,headsep=11pt,footskip=14pt}
%\else
%\geometry{paperwidth=14.85cm,paperheight=21cm,
%heightrounded,top=1.3cm,inner=1.5cm,outer=2.1cm,bottom=2.4cm,
%headheight=16pt,headsep=11pt,footskip=14pt}
%\fi
%
\setlength{\TgoAfterChapterSkip}{15pt}
%
\NewDocumentCommand\tgocover{O{A5Cover}}{\InputIfFileExists{#1}{}{%
\ClassWarning{tango}{Fichier #1.tex absent}}}
\flushbottom\emergencystretch=2.5em
\tolerance800
\clubpenalty1000
\widowpenalty1000%
%%
\else
%%%
\geometry{paperwidth=16cm,paperheight=22.88cm,
heightrounded,top=1.2cm,inner=1.4cm,outer=1.4cm,bottom=1.8cm,
headheight=16pt,headsep=11pt,footskip=14pt}
%
\setlength{\TgoAfterChapterSkip}{18pt}
%
\NewDocumentCommand\tgocover{O{TabletCover}}{\InputIfFileExists{#1}{}{%
\ClassWarning{tango}{Fichier #1.tex absent}}}
\flushbottom\emergencystretch=2.5em
\tolerance800
\clubpenalty1000
\widowpenalty1000%
\fi
\fi
%%%%%% Small Tablet%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifTgoSmallTabletOutput
%
\RenewDocumentCommand\SmallTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XAfourCommand{+m}{#1}
%
\RenewDocumentCommand\XLetterCommand{+m}{#1}
%
\RenewDocumentCommand\XBigTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XAfiveCommand{+m}{#1}
%
\RenewDocumentCommand\XTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XeReaderCommand{+m}{#1}
%
\RenewDocumentCommand\XSmartphoneCommand{+m}{#1}
 %
%%%%%%%%%%%%%%%%%%%%%
\setlength{\TgoAfterChapterSkip}{11pt}
%%
 \geometry{paperwidth=12cm,paperheight=18.24cm,
heightrounded,top=1.1cm,inner=0.75cm,outer=0.75cm,bottom=1.3cm,
headheight=14pt,headsep=6pt,footskip=13pt}
%
\NewDocumentCommand\tgocover{O{SmallTabletCover}}{\InputIfFileExists{#1}{}{%
\ClassWarning{tango}{Fichier #1.tex absent}}}
\flushbottom\emergencystretch=2.5em
\tolerance800
\clubpenalty1000
\widowpenalty1000%
\fi
%%%%%% eReader %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifTgoeReaderOutput
%
\RenewDocumentCommand\eReaderCommand{+m}{#1}
%
\RenewDocumentCommand\XAfourCommand{+m}{#1}
%
\RenewDocumentCommand\XLetterCommand{+m}{#1}
%
\RenewDocumentCommand\XBigTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XAfiveCommand{+m}{#1}
%
\RenewDocumentCommand\XTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XSmallTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XSmartphoneCommand{+m}{#1}
 %
%%%%%%%%%%%%%%%%%%%%%
\setlength{\TgoAfterChapterSkip}{3pt}
%%%%%%%%%%%
%
%
\geometry{paperwidth=10.7cm,paperheight=14.4cm,
heightrounded,top=0.82cm,left=0.5cm,right=0.5cm,bottom=0.8cm,
headheight=18pt,headsep=5pt,footskip=10pt}
%%
%
\NewDocumentCommand\tgocover{O{eReaderCover}}{\InputIfFileExists{#1}{}{%
\ClassWarning{tango}{Fichier #1.tex absent}}}
\flushbottom\sloppy
\fi
%%%%%%%% Smartphone %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifTgoSmartphoneOutput
%
\RenewDocumentCommand\SmartphoneCommand{+m}{#1}
%
\RenewDocumentCommand\XLetterCommand{+m}{#1}
%
\RenewDocumentCommand\XAfourCommand{+m}{#1}
%
\RenewDocumentCommand\XBigTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XAfiveCommand{+m}{#1}
%
\RenewDocumentCommand\XTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XSmallTabletCommand{+m}{#1}
%
\RenewDocumentCommand\XeReaderCommand{+m}{#1}
 %
%%%%%%%%%%%%%%%%%%%%%
\setlength{\TgoAfterChapterSkip}{7pt}%
%%%%%%%%%%%
%
%%
\geometry{paperwidth=10cm,paperheight=18cm,
heightrounded,top=1.1cm,inner=0.32cm,outer=0.32cm,bottom=1cm,
headheight=14pt,headsep=10pt,footskip=17pt}
%
\NewDocumentCommand\tgocover{O{SmartphoneCover}}{\InputIfFileExists{#1}{}{%
\ClassWarning{tango}{Fichier #1.tex absent}}}
\flushbottom\sloppy
\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\abovecaptionskip}{4pt plus 1pt minus 1pt}
\setlength{\belowcaptionskip}{4pt plus 1 pt minus 1pt}
%
%
\setlength{\textfloatsep}{10pt plus 4 pt minus 3pt}
\setlength{\intextsep}{4pt plus 2pt minus 1 pt}
%
%%%Environnements %%%%%%%%%%%%%%%%%%%
%
%%%%%% Stolen to amsthm %%%%%%%%%%%%%%%
%
\RenewDocumentCommand\qedsymbol{}{{\ensuremath{\color{ColorOne}\rule{7pt}{7pt}}}}%
\RenewDocumentEnvironment{proof}{o}{%
\IfValueTF{#1}%
{\renewcommand\TgoTempa{#1}}
{\renewcommand\TgoTempa{\proofname}}
\pushQED{\qed}%
\par\nobreak\addvspace{6pt plus 3pt minus 2pt}%
{\color{ColorOne}\sffamily\fontseries{m}\selectfont\itshape%
 \TgoTempa}\par\nobreak
 }% 
{\popQED\par\addvspace{6pt plus 3pt minus 2pt}}
%%%%
%%%%
\newcounter{tgoexo}%
%%
\NewDocumentCommand\exo{s d<> o}{%
\IfValueTF{#2}%
{%
\renewcommand\TgoTempa{#2}%
}%
{%
\renewcommand\TgoTempa{\TgoExerciseName}%
}%
\IfBooleanTF{#1}%
{%
\renewcommand\TgoTempb{\TgoTempa}%
}%
{%
\refstepcounter{tgoexo}%
\renewcommand\TgoTempb{\TgoTempa~\thetgoexo}%
}%
\IfValueTF{#3}%
{%
\renewcommand\TgoTempc{\TgoTempb\space(#3)}%
}%
{%
\renewcommand\TgoTempc{\TgoTempb}%
}%
\@afterindenttrue
\vspace{5pt plus 2pt minus 2pt}
\par%
\textsf{\fontseries{sb}\selectfont\TgoTempc}%
\par\nobreak\vspace{0pt plus 1pt}\par%
}%
%
\newsavebox{\TgoBox}
%%%%
%
\NewDocumentCommand\sec@exo{m}{%
\titleformat{\subsection}[block]{\filcenter\color{ColorOne}\sffamily\addfontfeature{RawFeature=-onum}%
\fontseries{b}\selectfont}{\thesubsection}{1em}{\MakeUppercase}%
\titlespacing{\subsection}{0em}{10pt  plus 10pt  minus 4pt}{8pt plus 5pt minus 3pt}%
\subsection*{#1}
\addcontentsline{toc}{subsection}{\protect\numberline{}#1}
}
%
\NewDocumentCommand\secexo{O{\TgoExercisesSubsectionName}}{%
\sec@exo{#1}
\tgostandardlists
}%
\ExpandArgs{c}\NewDocumentCommand{secexo*}{O{\TgoExercisesSubsectionName}}{%
\sec@exo{#1}
\TgoSmallerSize
\tgostandardlists
}%
\NewDocumentCommand\endsecexo{}
{\renewtgolabels\par\addvspace{10pt plus 3pt minus 2pt}\par}%
%
\ExpandArgs{c}\NewDocumentCommand{endsecexo*}{}
{\renewtgolabels\par\addvspace{10pt plus 3pt minus 2pt}\par}%
%
\NewDocumentCommand\chap@exo{m}{%
\titleformat{\section}[block]{\filcenter\color{ColorOne}\sffamily\addfontfeature{RawFeature=-onum}%
\fontseries{b}\selectfont\large}{\thesection}{1em}{\MakeUppercase}%
\tgostandardlists
\titlespacing{\section}{0em}{18pt  plus 10pt  minus 4pt}{8pt plus 5pt minus 3pt}%
\section*{#1}
\addcontentsline{toc}{section}{\protect\numberline{}#1}
}
%
\NewDocumentCommand\chapexo{O{\TgoExercisesSectionName}}{%
\chap@exo{#1}
}%
\ExpandArgs{c}\NewDocumentCommand{chapexo*}{O{\TgoExercisesSectionName}}{%
\chap@exo{#1}
\TgoSmallerSize
}%
\NewDocumentCommand\endchapexo{}
{\renewlabelitems\par\addvspace{18pt plus 3pt minus 2pt}\par}%
%
\ExpandArgs{c}\NewDocumentCommand{endchapexo*}{}
{\renewlabelitems\par\addvspace{18pt plus 3pt minus 2pt}\par}%
%%%%
%%
\NewDocumentEnvironment{example}{O{\TgoExampleName}}{%
\par\addvspace{6pt plus 3pt minus 2pt}%
{\sffamily\itshape #1}\par\nobreak%
\@afterheading}%
{\par\addvspace{6pt plus 3pt minus 2pt}\par}
%%%
\NewDocumentEnvironment{remark}{O{\TgoRemarkName}}{%
\par\addvspace{6pt plus 3pt minus 2pt}%
{\sffamily\itshape #1. \textemdash~}\ignorespaces}%
{\par\addvspace{6pt plus 3pt minus 2pt}}
%%%
%%%
\NewDocumentEnvironment{alert}{O{\caution}}{%
\par\addvspace{6pt plus 3pt minus 2pt}\noindent%
{\color{ColorOne}\Large #1}\hspace{1ex}\ignorespaces}%
{\par\addvspace{6pt plus 3pt minus 2pt}}
%
%%
\NewDocumentCommand\newstatement{s m m m o}{%
\setlength\TgoStatementParindent{\parindent}
\ExpandArgs{c}\NewDocumentCommand{#2}{d<> o}%
{% beginning env commands
\refstepcounter{#3}
\IfBooleanTF{#1}
{%
\renewcommand\TgoTempa{#3}
\renewcommand\TgoTempb{subsection}
\ifx\TgoTempa\TgoTempb
\ifTgoTitleIndentZero
\renewcommand\TgoStatementIndent{\noindent}
\setlength\TgoStatementParindent{0em}
\fi
\renewcommand\TgoStatementNumberPrefix{\large\fontseries{sb}\selectfont%
\UseName{the#3}\hspace{1em}}%
\else
\renewcommand\TgoTempb{subsubsection}
\ifx\TgoTempa\TgoTempb
\ifTgoTitleIndentZero
\renewcommand\TgoStatementIndent{\noindent}
\setlength\TgoStatementParindent{0em}
\fi
\fi
\renewcommand\TgoStatementNumberPrefix{\fontseries{sb}\selectfont%
\UseName{the#3}\hspace{1em}}%
\fi
\renewcommand\TgoStatementNumberSuffix{}%
}
{
\renewcommand\TgoStatementNumberSuffix{~\UseName{the#3}}%
\renewcommand\TgoStatementNumberPrefix{}%
}
\IfValueTF{##2}%
{%
\renewcommand\TgoStatementSuffix{~{\normalshape(##2)}}%
}%
{%
\renewcommand\TgoStatementSuffix{}%
}%
\renewcommand\TgoStatementName{#4}
\IfValueT{##1}{%
\renewcommand\TgoStatementName{##1}
}
\par%
\addvspace{8pt plus 3pt minus 2pt}%
\begin{lrbox}{\TgoBox}%
\par%
%\begin{minipage}{\linewidth-\fboxsep-\TgoStatementParindent}\IfValueT{#5}{#5}%
\begin{minipage}{\linewidth-\TgoStatementParindent}\IfValueT{#5}{#5}%
}%
\ExpandArgs{c}\NewDocumentCommand{end#2}{}
{% end env commands
\end{minipage}\end{lrbox}
\TgoStatementIndent\parbox{\linewidth-\TgoStatementParindent}{
{\color{ColorOne}\sffamily\fontseries{m}\selectfont\scshape\TgoStatementNameOffset%
\TgoStatementNumberPrefix\fontseries{sb}\selectfont\TgoStatementName%
\TgoStatementNumberSuffix\TgoStatementSuffix\par\nobreak}%
\vspace{2pt}\par%
\addtolength\leftskip{-\fboxsep}
\addtolength\rightskip{-\fboxsep}
\colorbox{ColorTwo}{%
\usebox{\TgoBox}}}%
\par\addvspace{6pt  plus 3pt minus 2pt}\par%
}%
\ExpandArgs{c}\NewDocumentCommand{#2*}{d<> o}%
{% beginning env commands
\IfValueTF{##2}%
{%
\renewcommand\TgoStatementSuffix{~{\normalshape(##2)}}%
}%
{%
\renewcommand\TgoStatementSuffix{}%
}%
\renewcommand\TgoStatementName{#4}
\IfValueT{##1}{%
\renewcommand\TgoStatementName{##1}
}
\par%
\addvspace{8pt plus 3pt minus 2pt}%
\begin{lrbox}{\TgoBox}%
\par%
%\begin{minipage}{\linewidth-\fboxsep-\TgoStatementParindent}\IfValueT{#5}{#5}%
\begin{minipage}{\linewidth-\TgoStatementParindent}\IfValueT{#5}{#5}
}%
\ExpandArgs{c}\NewDocumentCommand{end#2*}{}
{% end env commands
\end{minipage}\end{lrbox}
\TgoStatementIndent\parbox{\linewidth-\TgoStatementParindent}{
{\color{ColorOne}\sffamily\fontseries{m}\selectfont\scshape\TgoStatementNameOffset%
\fontseries{sb}\selectfont\TgoStatementName\TgoStatementSuffix\par\nobreak}%
\vspace{2pt}\par%
\addtolength\leftskip{-\fboxsep}
\addtolength\rightskip{-\fboxsep}
\colorbox{ColorTwo}{%
\usebox{\TgoBox}}}%
\par\addvspace{6pt  plus 3pt minus 2pt}\par%
}%
}%%%%
%%%%%%%%%%%%
%%%%%%%%%%%%%
%%%%%%%%%%%%
\NewDocumentCommand\renewstatement{s m m m o}{%
\setlength\TgoStatementParindent{\parindent}
\ExpandArgs{c}\RenewDocumentCommand{#2}{d<> o}%
{% beginning env commands
\refstepcounter{#3}
\IfBooleanTF{#1}
{%
\renewcommand\TgoTempa{#3}
\renewcommand\TgoTempb{subsection}
\ifx\TgoTempa\TgoTempb
\ifTgoTitleIndentZero
\renewcommand\TgoStatementIndent{\noindent}
\setlength\TgoStatementParindent{0em}
\fi
\renewcommand\TgoStatementNumberPrefix{\large\fontseries{sb}\selectfont%
\UseName{the#3}\hspace{1em}}%
\else
\renewcommand\TgoTempb{subsubsection}
\ifx\TgoTempa\TgoTempb
\ifTgoTitleIndentZero
\renewcommand\TgoStatementIndent{\noindent}
\setlength\TgoStatementParindent{0em}
\fi
\fi
\renewcommand\TgoStatementNumberPrefix{\fontseries{sb}\selectfont%
\UseName{the#3}\hspace{1em}}%
\fi
\renewcommand\TgoStatementNumberSuffix{}%
}
{
\renewcommand\TgoStatementNumberSuffix{~\UseName{the#3}}%
\renewcommand\TgoStatementNumberPrefix{}%
}
\IfValueTF{##2}%
{%
\renewcommand\TgoStatementSuffix{~{\normalshape(##2)}}%
}%
{%
\renewcommand\TgoStatementSuffix{}%
}%
\renewcommand\TgoStatementName{#4}
\IfValueT{##1}{%
\renewcommand\TgoStatementName{##1}
}
\par%
\addvspace{8pt plus 3pt minus 2pt}%
\begin{lrbox}{\TgoBox}%
\par%
%\begin{minipage}{\linewidth-\fboxsep-\TgoStatementParindent}\IfValueT{#5}{#5}%
\begin{minipage}{\linewidth-\TgoStatementParindent}\IfValueT{#5}{#5}
}%
\ExpandArgs{c}\RenewDocumentCommand{end#2}{}
{% end env commands
\end{minipage}\end{lrbox}
\TgoStatementIndent\parbox{\linewidth-\TgoStatementParindent}{
{\color{ColorOne}\sffamily\fontseries{m}\selectfont\scshape\TgoStatementNameOffset%
\TgoStatementNumberPrefix\fontseries{sb}\selectfont\TgoStatementName%
\TgoStatementNumberSuffix\TgoStatementSuffix\par\nobreak}%
\vspace{2pt}\par%
\addtolength\leftskip{-\fboxsep}
\addtolength\rightskip{-\fboxsep}
\colorbox{ColorTwo}{%
\usebox{\TgoBox}}}%
\par\addvspace{6pt  plus 3pt minus 2pt}\par%
}%
\ExpandArgs{c}\RenewDocumentCommand{#2*}{d<> o}%
{% beginning env commands
\IfValueTF{##2}%
{%
\renewcommand\TgoStatementSuffix{~{\normalshape(##2)}}%
}%
{%
\renewcommand\TgoStatementSuffix{}%
}%
\renewcommand\TgoStatementName{#4}
\IfValueT{##1}{%
\renewcommand\TgoStatementName{##1}
}
\par%
\addvspace{8pt plus 3pt minus 2pt}%
\begin{lrbox}{\TgoBox}%
\par%
%\begin{minipage}{\linewidth-\fboxsep-\TgoStatementParindent}\IfValueT{#5}{#5}%
\begin{minipage}{\linewidth-\TgoStatementParindent}\IfValueT{#5}{#5}
}%
\ExpandArgs{c}\RenewDocumentCommand{end#2*}{}
{% end env commands
\end{minipage}\end{lrbox}
\TgoStatementIndent\parbox{\linewidth-\TgoStatementParindent}{
{\color{ColorOne}\sffamily\fontseries{m}\selectfont\scshape\TgoStatementNameOffset%
\fontseries{sb}\selectfont\TgoStatementName\TgoStatementSuffix\par\nobreak}%
\vspace{2pt}\par%
\addtolength\leftskip{-\fboxsep}
\addtolength\rightskip{-\fboxsep}
\colorbox{ColorTwo}{%
\usebox{\TgoBox}}}%
\par\addvspace{6pt  plus 3pt minus 2pt}\par%
}%
}%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifTgoNoStatement
\else
\newcounter{thm}
\newstatement{thm}{thm}{\TgoTheoremName}[\itshape]
\newcounter{defin}
\newstatement{defin}{defin}{\TgoDefinitionName}
\newcounter{coro}
\newstatement{coro}{coro}{\TgoCorollaryName}
\newcounter{propo}
\newstatement{propo}{propo}{\TgoPropositionName}[\itshape]
\newcounter{lem}
\newstatement{lem}{lem}{\TgoLemmaName}
\fi
%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
\AtBeginDocument{%
 \Umathchardef\Bbbbackslash =        0 0 "E020 \relax
  \Umathchardef\varemptyset =         0 0 "E021 \relax
  \Umathchardef\mupvarzero =          0 0 "E022 \relax
  \Umathchardef\mbfvarzero =          0 0 "E023 \relax
  \Umathchardef\mupvarpartial =       0 0 "E030 \relax
  \Umathchardef\mupvarvarpi =         0 0 "E032 \relax
  \Umathchardef\mbfvarpartial =       0 0 "E040 \relax
  \Umathchardef\mbfvarvarrho =        0 0 "E041 \relax
  \Umathchardef\mbfvarvarpi =         0 0 "E042 \relax
  \Umathchardef\mbfvec =              0 0 "E044 \relax
  \Umathchardef\mbfwp =               0 0 "E045 \relax
  \Umathchardef\mbfdotlessi =         0 0 "E046 \relax
  \Umathchardef\mbfdotlessj =         0 0 "E047 \relax
  \Umathchardef\mbfhbar =             0 0 "E048 \relax
  \Umathchardef\mbfell =              0 0 "E049 \relax
  \Umathchardef\mbftriangleleft =     0 0 "E04E \relax
  \Umathchardef\mbftriangleright =    0 0 "E04F \relax
  \Umathchardef\mbfitvarpartial =     0 0 "E060 \relax
  \Umathchardef\mbfitvarvarrho =      0 0 "E061 \relax
  \Umathchardef\mbfitvarvarpi =       0 0 "E062 \relax
  \Umathchardef\mbfitwp =             0 0 "E065 \relax
  \Umathchardef\mbfimath =            0 0 "E066 \relax
  \Umathchardef\mbfjmath =            0 0 "E067 \relax
  \Umathchardef\mbfithbar =           0 0 "E068 \relax
  \Umathchardef\mbfitell =            0 0 "E069 \relax
  \Umathchardef\mitvarpartial =       0 0 "E070 \relax
  \Umathchardef\mitvarvarrho =        0 0 "E071 \relax
  \Umathchardef\mitvarvarpi =         0 0 "E072 \relax
  \Umathchardef\mithbar =             0 0 "E078 \relax
  \Umathchardef\mapstochar =          3 0 "E08D \relax
  \Umathchardef\lhook =               3 0 "E08E \relax
  \Umathchardef\rhook =               3 0 "E08F \relax
  \Umathchardef\parallelslant  =      3 0 "E090 \relax
  \Umathchardef\nparallelslant =      3 0 "E091 \relax
  \Umathchardef\shortparallelslant =  3 0 "E092 \relax
  \Umathchardef\nshortparallelslant = 3 0 "E093 \relax
  \Umathchardef\lesseqslantgtr =      3 0 "E094 \relax
  \Umathchardef\gtreqslantless =      3 0 "E095 \relax
  \Umathchardef\lesseqqslantgtr =     3 0 "E096 \relax
  \Umathchardef\gtreqqslantless =     3 0 "E097 \relax
  \Umathchardef\nleqqslant =          3 0 "E098 \relax
  \Umathchardef\ngeqqslant =          3 0 "E099 \relax
  \Umathchardef\varsymscrE =          0 0 "E07D \relax
  \Umathchardef\varsymscrQ =          0 0 "E07E \relax
  \Umathchardef\varsymscrT =          0 0 "E07F \relax
  \Umathchardef\varsymbfscrE =        0 0 "E06D \relax
  \Umathchardef\varsymbfscrQ =        0 0 "E06E \relax
  \Umathchardef\varsymbfscrT =        0 0 "E06F \relax
 % \widearc and\overrightarc
  \newcommand*{\widearc}{\Umathaccent 0 0 "E540 }%
  \newcommand*{\overrightarc}{\Umathaccent 0 0 "20D5 }%
  % From FourierOrns
  \Umathchardef\forbidden =           0 0 "E0B0 \relax
  \Umathchardef\beware =              0 0 "E0B1 \relax
  \Umathchardef\boom =                0 0 "E0B2 \relax
  \Umathchardef\thething =            0 0 "E0B4 \relax
  \Umathchardef\xswordsup =           0 0 "E0B5 \relax
  \Umathchardef\xswordsdown =         0 0 "E0B6 \relax
  % amssymb
  \IfPackageLoadedTF{amssymb}%
    {\ClassWarning{tango}{%
       Tango provides all AMS symbols.\MessageBreak
       Loading amssymb.sty is not advisable.\MessageBreak
       Reported}%
    }%
    {% AMS Symbols not referenced in unicode-math-table.tex
     % \Umathchardef\<cmd> = <math type> <family> <slot>
     % <math type> : \mathord=0 \mathrel=3 ; <family>=0
     \Umathchardef\circledR =       0 0 "24C7 \relax
     \Umathchardef\circledS =       0 0 "24C8 \relax
     \Umathchardef\diagup =         0 0 "27CB \relax
     \Umathchardef\diagdown =       0 0 "27CD \relax
     \Umathchardef\shortmid =       3 0 "E0A2 \relax
     \Umathchardef\shortparallel =  3 0 "E0A3 \relax
     \Umathchardef\nshortmid =      3 0 "E0A4 \relax
     \Umathchardef\nshortparallel = 3 0 "E0A5 \relax
     \Umathchardef\lvertneqq =      3 0 "E0A6 \relax
     \Umathchardef\gvertneqq =      3 0 "E0A7 \relax
     \Umathchardef\nleqslant =      3 0 "E0A8 \relax
     \Umathchardef\ngeqslant =      3 0 "E0A9 \relax
     \Umathchardef\nleqq =          3 0 "E0AA \relax
     \Umathchardef\ngeqq =          3 0 "E0AB \relax
     \Umathchardef\varsubsetneq =   3 0 "E0AC \relax
     \Umathchardef\varsupsetneq =   3 0 "E0AD \relax
     \Umathchardef\nsubseteqq =     3 0 "E0AE \relax
     \Umathchardef\nsupseteqq =     3 0 "E0AF \relax
     \Umathchardef\varsubsetneqq =  3 0 "E09C \relax
     \Umathchardef\varsupsetneqq =  3 0 "E09D \relax
     \Umathchardef\npreceq =        3 0 "E09E \relax
     \Umathchardef\nsucceq =        3 0 "E09F \relax
     \let\centerdot\cdotp
     \let\restriction\upharpoonright
     \let\doteqdot\Doteq
     \let\doublecup\Cup
     \let\doublecap\Cap
     \let\llless\lll
     \let\gggtr\ggg
     \let\circlearrowleft\acwopencirclearrow
     \let\circlearrowright\cwopencirclearrow
     \let\lozenge\mdlgwhtlozenge
     \let\blacklozenge\mdlgblklozenge
     \let\square\mdlgwhtsquare
     \let\blacksquare\mdlgblksquare
     \let\dashleftarrow\leftdasharrow
     \let\dashrightarrow\rightdasharrow
     \let\ntriangleleft\nvartriangleleft
     \let\ntriangleright\nvartriangleright
     \let\varpropto\propto
     \let\thicksim\sim
     \let\thickapprox\approx
     \let\smallsmile\smile
     \let\smallfrown\frown
    }%
  % latexsym
  \IfPackageLoadedTF{latexsym}%
    {\ClassWarning{tango}{%
       Tango provides all LaTeX symbols.\MessageBreak
       Loading latexsym.sty is not advisable.\MessageBreak
       Reported}%
    }%
    {\let\lhd\vartriangleleft
     \let\rhd\vartriangleright
     \let\unlhd\trianglelefteq
     \let\unrhd\trianglerighteq
     \let\leadsto\rightcurvedarrow
     \let\Box\lgwhtsquare
     \let\Diamond\mdlgwhtdiamond
    }%
}
\endinput