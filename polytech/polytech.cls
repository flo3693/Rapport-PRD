\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\def\polytechfileversion{1.0}
\def\polytechfiledate{2016/02/01}
\ProvidesClass{polytech/polytech}[\polytechfiledate\space Polytech document class by Sebastien Aupetit <aupetit@univ-tours.fr>, V\polytechfileversion]

%###

% -----------------------------------------------------------------------------
% Include generic packages to extend LaTeX memory and add common utility commands
% -----------------------------------------------------------------------------
\RequirePackage{etex}
\RequirePackage{atveryend}
\RequirePackage{etoolbox}
\RequirePackage{calc}

% -----------------------------------------------------------------------------
% Declare documentclass options
% -----------------------------------------------------------------------------

% Prepare document in english
\newbool{polytech@english}
\def\polytech@lang{fr}
\DeclareOption{english}{
	\setbool{polytech@english}{true}
	\gdef\polytech@lang{en}
}

% Display overfullbox marks
\newbool{polytech@overfullbox}
\DeclareOption{overfullbox}{\booltrue{polytech@overfullbox}}

% Force black and white colors
\newbool{polytech@blackandwhite}
\DeclareOption{blackandwhite}{\booltrue{polytech@blackandwhite}}

% Open chapter on any page
\newbool{polytech@openany}
\DeclareOption{openany}{\booltrue{polytech@openany}}

\newbool{polytech@hideweeklyreports}
\DeclareOption{hideweeklyreports}{\booltrue{polytech@hideweeklyreports}}

% define if contributors details (mail and addresses) are included
\newbool{polytech@contributors@expanded}
\DeclareOption{expandedcontributors}{\booltrue{polytech@contributors@expanded}}

\newbool{polytech@contributors@noseparatepage}
\DeclareOption{noseparatecontributorspage}{\booltrue{polytech@contributors@noseparatepage}}

\newbool{polytech@nodate}
\DeclareOption{nodate}{\booltrue{polytech@nodate}}

\newbool{polytech@nobibannotations}
\DeclareOption{nobibannotations}{\booltrue{polytech@nobibannotations}}

\newbool{polytech@roundtofour}
\DeclareOption{roundtofour}{\booltrue{polytech@roundtofour}}

\newbool{polytech@twoside}
\DeclareOption{twoside}{\booltrue{polytech@twoside}}

\newbool{polytech@firstlastonly}
\DeclareOption{firstlastonly}{\booltrue{polytech@firstlastonly}}

\newbool{polytech@poster}
\DeclareOption{poster}{\booltrue{polytech@poster}}

\newbool{polytech@onlyposter}
\DeclareOption{onlyposter}{\booltrue{polytech@onlyposter}\booltrue{polytech@poster}}

\newbool{polytech@aiiiposter}
\DeclareOption{a3poster}{\booltrue{polytech@aiiiposter}\booltrue{polytech@onlyposter}\booltrue{polytech@poster}}


\DeclareOption*{\PackageWarning{polytech}{Unknown option `\CurrentOption'}}

\ProcessOptions\relax

%------------- global lrbox (use \begin{lrbox*} instead of \begin{lrbox} to save the box globally instead of locally ----------------
\cslet{lrbox*}\lrbox
\expandafter\patchcmd\csname lrbox*\endcsname{\setbox}{\global\setbox}{}{}
%\expandafter\show\csname lrbox*\endcsname % uncomment to see if it has worked
\cslet{endlrbox*}\endlrbox



%-------------- Configuration ----------------

% upgrade PDF version of the document
\pdfoptionpdfminorversion=6

% allow url to break on multiple lines
\PassOptionsToPackage{hyphens}{url}

% Enable colors
\PassOptionsToPackage{svgnames,table,override}{xcolor}

% babel
\ifbool{polytech@english}{
    \PassOptionsToPackage{french,main=english}{babel} % english document
    \RequirePackage{babel}
    \PassOptionsToPackage{english}{algorithm2e}
}{
    \PassOptionsToPackage{english,main=french}{babel}  % french document
    \RequirePackage{babel}
    \frenchbsetup{StandardEnumerateEnv=true}
    \frenchspacing
    \PassOptionsToPackage{frenchstyle}{kpfonts}
    \PassOptionsToPackage{french}{algorithm2e}
}

\ifbool{polytech@openany}{\PassOptionsToClass{openany}{book}}{}

\ifbool{polytech@twoside}{
	\PassOptionsToClass{twoside}{book}
}{
	\PassOptionsToClass{openany}{book}
}

\PassOptionsToClass{final,11pt}{book}
\LoadClass{book}

\ifbool{polytech@aiiiposter}{%
	\setlength\paperheight{42cm}%
	\setlength\paperwidth{29.7cm}%
}{%
	\setlength\paperheight{29.7cm}%
	\setlength\paperwidth{21cm}%
}

\RequirePackage[
        papersize={\paperwidth,\paperheight},
        twoside,
        bindingoffset=0cm,
        heightrounded,
        includeall,
        nomarginpar,
        headheight=14pt,
        headsep=12pt,
        footskip=30pt,
        vmargin=1.5cm,
        hmargin=2.5cm]{geometry}

\csdef{polytech@output@setupfirstlastpagegeometry}{%
	\newgeometry{%
    twoside,
    bindingoffset=0cm,
    heightrounded,
    includeall,
    nomarginpar,
    headheight=0pt,
    headsep=0pt,
    footskip=0pt,
    vmargin=1.5cm,
    hmargin=2.5cm
  }%
}

% enable overbox display as black box. must be after class loading
\ifbool{polytech@overfullbox}{
    \setlength{\overfullrule}{5pt}
}{}

\RequirePackage[T1]{fontenc}    % OT1 font encoding (must be before inputenc)
\RequirePackage[utf8]{inputenc} % encoding is set to utf8
\RequirePackage[full]{textcomp}
\DeclareUnicodeCharacter{B0}{\textdegree}

\RequirePackage{csquotes}
\RequirePackage[%
	backend=biber,
	style=numeric-comp,
	sorting=nyt,
	sortcase=false,
	sortcites=true,
	maxnames=10,
	minnames=10,
	autocite=plain,
	defernumbers,
	bibencoding=utf8
	]{biblatex}


% options are processed then we do some update
\ifbool{polytech@blackandwhite}{
	\PassOptionsToPackage{light}{kpfonts}	% better printing in light
}{}

\RequirePackage[nofligatures,nointlimits,sumlimits]{kpfonts} % switch to richer and more scallable fonts
\RequirePackage[final,babel]{microtype}

\RequirePackage[rigidchapters,explicit,toctitles,clearempty]{titlesec}

%-------------- lot of packages -------------

\RequirePackage{nameref}
\RequirePackage{fancyhdr}
\RequirePackage{makeidx}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{marvosym}
\RequirePackage{stmaryrd}
\RequirePackage[final]{listings}[2015/06/04]
\RequirePackage{fancybox}
\RequirePackage{tabu}
\RequirePackage{lscape}
\RequirePackage{comment}
\RequirePackage{pgf}
\RequirePackage{tikz}
\RequirePackage{url}
\RequirePackage{framed}
\RequirePackage{fancyvrb}
\RequirePackage{makerobust}
\RequirePackage[lined,boxed]{algorithm2e}
\RequirePackage[figure,table,lstlisting]{totalcount}

\RequirePackage{eurosym} % symbol euro
\RequirePackage[user]{zref} % allow for better \ref and  \label
\RequirePackage{environ}
\RequirePackage[calc]{adjustbox} % box sizing utilities

\usetikzlibrary{decorations.pathmorphing,calc,patterns,positioning,fit}

\ifbool{polytech@blackandwhite}{
	% disable hyperlinks
	\PassOptionsToPackage{draft,linkcolor=black,citecolor=black,filecolor=black,urlcolor=black}{hyperref}
}
{
	\PassOptionsToPackage{final,linkcolor=red,citecolor=green,filecolor=cyan,urlcolor=magenta}{hyperref}
}

\RequirePackage[plainpages=false,
                pdfpagelabels=true,
                verbose=false,
                breaklinks=true,
                colorlinks=true,
                bookmarksopen=true,
                pdfborder={0 0 0},
                unicode=true,
                bookmarksnumbered,
                pdfnewwindow=true,
                pdfstartview={FitH},
                pdftoolbar=true,
                pdfmenubar=true,
                linktocpage=true,
                bookmarks=true]{hyperref}

\RequirePackage{bookmark}
\RequirePackage{pageslts} % to have total page count of the document. Must be at the end for proper functionning

\RequirePackage[planb=false]{newfloat}
\RequirePackage{caption}

% colors
\definecolor{polytechdarkblue}{RGB}{0,74,117}
\definecolor{polytechlightblue}{RGB}{0,156,221}
\definecolor{polytechorange}{RGB}{221,56,0}

% sub packages
\RequirePackage{polytech/firstlastpage}
\RequirePackage{polytech/copyright}
\RequirePackage{polytech/headings}
\RequirePackage{polytech/sectionning}
\RequirePackage{polytech/floats}
\RequirePackage{polytech/weeklyreports}
\RequirePackage{polytech/listings}
\RequirePackage{polytech/references}
\RequirePackage{polytech/poster}

\setlength{\parskip}{1ex plus 0.5ex minus 0.5ex}
\setlength{\topsep}{1pt plus 1pt minus 1pt}
\setlength{\parsep}{\parskip}
\setlength{\itemsep}{1pt plus 1pt minus 1pt}
\setlength{\partopsep}{1pt plus 1pt minus 1pt}
\setlength{\parindent}{0in}

\widowpenalty=300
\clubpenalty=300


\setcounter{tocdepth}{3}
\renewcommand{\@dotsep}{0.1}
\setcounter{secnumdepth}{3}

\renewcommand{\baselinestretch}{1}

\ifbool{polytech@blackandwhite}{
	\arrayrulecolor{black}
}{
	\arrayrulecolor{polytechdarkblue}
}

\renewcommand{\arraystretch}{1.2}
\extrarowsep=1mm
\tabulinesep=1mm

% tableofcontents need patching
\patchcmd{\tableofcontents}
{\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}
{\markboth{\contentsname}{}}
{}{}

% allow proper handling of unnumbered chapters in \ref
\newbool{polytech@ref@unnumberedchapter}

% unnumbered chapter but in toc
\newcommand{\unnumberedchapter}[2][]{
	\chapter*{#2}
	\addcontentsline{toc}{chapter}{\numberline{}#2}
	\booltrue{polytech@ref@unnumberedchapter}
	\ifstrequal{#1}{}{
		\markboth{#2}{}
	}{
		\markboth{#1}{}
	}
}

% force long title in TOC but keep short title for headings
\patchcmd{\@chapter}%
{\addcontentsline {toc}{chapter}{\protect\numberline {\thechapter }#1}}
{\addcontentsline {toc}{chapter}{\protect\numberline {\thechapter }#2}%
}
{}{}


\newbool{polytech@contentsline@lof@written}
\newbool{polytech@contentsline@lot@written}

\let\polytech@contentsline@oldaddcontentsline\addcontentsline


\renewcommand{\addcontentsline}[3]{
	\ifcsdef{polytech@contentsline@add@#1@#2}{
		\csuse{polytech@contentsline@add@#1@#2}{#1}{#2}{#3}
	}{}
	\polytech@contentsline@oldaddcontentsline{#1}{#2}{#3}
}


\newcommand{\polytech@contentsline@add@toc@chapter}[3]{%
	\boolfalse{polytech@contentsline@lot@written}%
	\boolfalse{polytech@contentsline@lof@written}%
	\global\csdef{polytech@contentsline@current@content}{#3}
	%\csxdef{polytech@contentsline@current@page}{\thepage}
	\csxdef{polytech@contentsline@current@href}{\@currentHref}%
}

\newcommand{\polytech@contentsline@add@lof@figure}[3]{
	\ifbool{polytech@contentsline@lof@written}{%
	}%
	{%
		\addtocontents{lof}{\protect \contentsline {chapter}{\csuse{polytech@contentsline@current@content}}{\csuse{polytech@contentsline@current@page}}{\csuse{polytech@contentsline@current@href}}}%
		\global\booltrue{polytech@contentsline@lof@written}%
	}%
}
\newcommand{\polytech@contentsline@add@lot@table}[3]{%
	\ifbool{polytech@contentsline@lot@written}{%
	}%
	{%
		\addtocontents{lot}{\protect \contentsline {chapter}{\csuse{polytech@contentsline@current@content}}{\csuse{polytech@contentsline@current@page}}{\csuse{polytech@contentsline@current@href}}}%
		\global\booltrue{polytech@contentsline@lot@written}%
	}%
}

% \appendix called ?
\newbool{polytech@ref@appendix}
% is an appendix chapter ?
\newbool{polytech@ref@appendixchapter}

\preto{\appendix}{\booltrue{polytech@ref@appendix}}
\ifbool{polytech@english}{
	\appto{\appendix}{\part*{Appendices}}
}{
	\appto{\appendix}{\part*{Annexes}}
}

\preto{\chapter}{
	% reset unnumbered chapter boolean
	\boolfalse{polytech@ref@unnumberedchapter}%
	% handle appendix chapter detection
	\ifbool{polytech@ref@appendix}{\booltrue{polytech@ref@appendixchapter}}{}%
}

\preto{\part}{
	% do not store chapter number for part until new chapter is defined
	\booltrue{polytech@ref@unnumberedchapter}
}

% replace \cleardoublepage by \clearpage on oneside printing
\ifbool{polytech@twoside}{}{\renewcommand{\cleardoublepage}{\clearpage}}


%###
