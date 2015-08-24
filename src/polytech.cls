\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{polytech}[2015/07/15 Polytech document class by Sebastien Aupetit <aupetit@univ-tours.fr>, V1.0]

% -----------------------------------------------------------------------------
% Include generic package to extend LaTeX memory and add utility commands
% -----------------------------------------------------------------------------
\RequirePackage{etex}
\RequirePackage{etoolbox}
\RequirePackage{calc}
\RequirePackage{ifthen}

% -----------------------------------------------------------------------------
% Declare documentclass options
% -----------------------------------------------------------------------------

% Prepare document in english
\newbool{polytech@english}
\DeclareOption{english}{\setbool{polytech@english}{true}}

% Display overfullbox marks
\newbool{polytech@overfullbox}
\DeclareOption{overfullbox}{\setbool{polytech@overfullbox}{true}}

% Force black and white colors
\newbool{polytech@blackandwhite}
\DeclareOption{blackandwhite}{\setbool{polytech@blackandwhite}{true}}

\newbool{polytech@openany}
\DeclareOption{openany}{\setbool{polytech@openany}{true}}

\DeclareOption*{\PackageWarning{polytech}{Unknown option `\CurrentOption'}}

\ProcessOptions\relax


%------------- global lrbox (use \begin{lrbox*} instead of \begin{lrbox} to save the box globally instead of locally ----------------
\cslet{lrbox*}\lrbox
\expandafter\patchcmd\csname lrbox*\endcsname{\setbox}{\global\setbox}{}{}
%\expandafter\show\csname lrbox*\endcsname % uncomment to see if it has worked
\cslet{endlrbox*}\endlrbox


%-------------- Configuration ----------------

% Enable colors
\PassOptionsToPackage{svgnames,table,override}{xcolor}


\ifbool{polytech@english}{
    \PassOptionsToPackage{english}{babel} % english document
    \RequirePackage{babel}
}{
    \PassOptionsToPackage{french}{babel}  % french document
    \RequirePackage{babel}
    \frenchbsetup{StandardEnumerateEnv=true}
}






    \ifbool{polytech@openany}{\PassOptionsToClass{openany}{book}}{}
    \PassOptionsToClass{final}{book}
    \LoadClass[11pt,twoside]{book}

    \RequirePackage[rigidchapters,explicit]{titlesec}

    \setlength\paperheight{29.7cm}%
    \setlength\paperwidth{21cm}%

    \RequirePackage[
            verbose,
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
            hmargin=2cm]{geometry}



% enable overbox display as black box. must be after class loading
\ifbool{polytech@overfullbox}{
    \setlength{\overfullrule}{5pt}
}{}

\RequirePackage[T1]{fontenc}    % OT1 font encoding (must be before inputenc)
\RequirePackage[utf8]{inputenc} % encoding is set to utf8
\RequirePackage{textcomp}
\DeclareUnicodeCharacter{B0}{\textdegree}

\ifbool{polytech@english}{
	\RequirePackage[english]{babel} % english document

}{
    \RequirePackage[french]{babel}  % french document
}

\RequirePackage[frame]{crop}
\RequirePackage{layout}

%-------------- lot of packages -------------
\RequirePackage{multicol}
\RequirePackage{fancyhdr}
\RequirePackage{caption}
\RequirePackage{makeidx}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{marvosym}
\RequirePackage{stmaryrd}
\RequirePackage[final]{listings}
\RequirePackage{fancybox}
\RequirePackage{tabu}
\RequirePackage{lscape}
\RequirePackage{comment}
\RequirePackage{pgf}
\RequirePackage{tikz}
\RequirePackage{comment}
\RequirePackage{url}
\RequirePackage{framed}
\RequirePackage{fancybox}
\RequirePackage{fancyvrb}
\RequirePackage{tabu}
\RequirePackage{makerobust}
\RequirePackage{algorithm2e}
\RequirePackage[figure,table,lstlisting]{totalcount}
\RequirePackage{cite}

\usetikzlibrary{decorations.pathmorphing,calc,patterns,positioning,fit}

\ifbool{polytech@blackandwhite}{
	\PassOptionsToPackage{linkcolor=black,citecolor=black,filecolor=black,urlcolor=black}{hyperref}
}
{
	\PassOptionsToPackage{linkcolor=red,citecolor=green,filecolor=cyan,urlcolor=magenta}{hyperref}
}

\RequirePackage[plainpages=false,
                pdfpagelabels=true,
                final,
                verbose=true,
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
                bookmarks=true]{hyperref}

\RequirePackage{polytech/firstlastpage}
\RequirePackage{polytech/headings}
\RequirePackage{polytech/sectionning}
\RequirePackage{polytech/floats}
\RequirePackage{polytech/weeklyreports}


   \frenchspacing
\setlength{\parskip}{1ex plus 0.5ex minus 0.5ex}
\setlength{\topsep}{1pt plus 1pt minus 1pt}
\setlength{\parsep}{\parskip}
\setlength{\itemsep}{1pt plus 1pt minus 1pt}
\setlength{\partopsep}{1pt plus 1pt minus 1pt}

\widowpenalty=300
\clubpenalty=300

\setlength{\parindent}{0in}


\setcounter{tocdepth}{3}
\renewcommand{\@dotsep}{0.1}
\setcounter{secnumdepth}{3}

\RequirePackage{polytech/references}
\RequirePackage{polytech/listings}




\renewcommand{\baselinestretch}{1}

\arrayrulecolor{black}
\renewcommand{\arraystretch}{1.2}



\patchcmd{\tableofcontents}
{\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}
{\markboth{\contentsname}{}}
{}{}



\newcommand{\unnumberedchapter}[2][]{
	\chapter*{#2}
	\addcontentsline{toc}{chapter}{\numberline{}#2}
	\ifthenelse{\equal{#1}{}}{
		\markboth{#2}{}
	}{
		\markboth{#1}{}
	}
}








