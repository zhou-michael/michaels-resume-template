%% ==============================================================================
%% Michael Resume Class (michael-resume.cls)
%% A modern, elegant, ATS-friendly LaTeX resume template inspired by michael.sty
%% and minimalist typographic design.
%% ==============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{michael-resume}[2026/09/08 Modern Resume Template]

% ------------------------------------------------------------------------------
% Class Options & Defaults
% ------------------------------------------------------------------------------
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=mresume,
  prefix=mresume@
}

% Color themes:
%   midnight   - deep navy / midnight blue accent inspired by michael.sty
%   slate      - cool modern steel/slate gray matching Michael's resume image
%   charcoal   - sleek dark graphite / carbon
%   forest     - deep ForestGreen inspired by michael.sty
\DeclareStringOption[midnight]{color}[midnight]

% Font family:
%   fira         - Fira Sans (default, modern humanist tech sans)
%   inter        - Inter (sleek modern UI sans)
%   sourcesans   - Source Sans 3 / Pro (Adobe clean sans, alias: sourcesanspro)
%   roboto       - Roboto (Google neo-grotesque sans)
%   raleway      - Raleway (elegant geometric sans)
%   cantarell    - Cantarell (GNOME humanist sans)
%   carlito      - Carlito (Calibri metric-compatible)
%   helvetica    - Helvetica / Arial style neutral sans (alias: helvet)
%   noto         - Noto Sans (Google universal sans, alias: notosans)
%   tgheros      - TeX Gyre Heros (high-fidelity Swiss neutral)
%   charter      - Bitstream Charter (clean technical serif)
%   ebgaramond   - EB Garamond (classic Renaissance serif, alias: garamond)
%   libertine    - Linux Libertine (refined transitional serif)
%   lmodern      - Latin Modern (classic Computer Modern serif, alias: latinmodern)
\DeclareStringOption[fira]{font}[fira]

% Divider style:
%   rule   - subtle horizontal line before each section (default, matches Michael's resume)
%   title  - thin rule directly under each section header
%   none   - pure whitespace separation
\DeclareStringOption[rule]{divider}[rule]

% Bullet style:
%   dash   - sleek en-dash (matches Michael's resume)
%   circle - tiny solid bullet
%   none   - no bullet symbol
\DeclareStringOption[dash]{bullet}[dash]

% Header alignment:
%   left   - modern left-aligned (matches Michael's resume)
%   center - centered layout
\DeclareStringOption[left]{headeralign}[left]

% Margins:
%   standard - 0.48in (optimal single-page balance)
%   compact  - 0.38in (dense content)
%   relaxed  - 0.65in (spacious)
\DeclareStringOption[standard]{margin}[standard]

% Pass all undeclared options to article
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
\LoadClass[10pt,letterpaper]{article}

% ------------------------------------------------------------------------------
% Required Packages
% ------------------------------------------------------------------------------
\RequirePackage{iftex}
\RequirePackage{calc}
\RequirePackage{etoolbox}
\RequirePackage{xcolor}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{parskip}

% ------------------------------------------------------------------------------
% Page Geometry & Margins
% ------------------------------------------------------------------------------
\RequirePackage{geometry}
\ifdefstring{\mresume@margin}{compact}{
  \geometry{left=0.38in, right=0.38in, top=0.35in, bottom=0.35in}
}{
  \ifdefstring{\mresume@margin}{relaxed}{
    \geometry{left=0.65in, right=0.65in, top=0.60in, bottom=0.60in}
  }{
    % standard
    \geometry{left=0.48in, right=0.48in, top=0.40in, bottom=0.38in}
  }
}

\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}

% ------------------------------------------------------------------------------
% ATS Compatibility (glyph-to-unicode)
% ------------------------------------------------------------------------------
\ifpdftex
  \input{glyphtounicode}
  \pdfgentounicode=1
\fi

% ------------------------------------------------------------------------------
% Typography & Fonts
% ------------------------------------------------------------------------------
\ifpdftex
  % pdfLaTeX engine
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \ifdefstring{\mresume@font}{inter}{%
    \RequirePackage{fontaxes}%
    \def\Inter@scale{0.93}\renewcommand*\sfdefault{Inter-TLF}%
    \renewcommand*\familydefault{\sfdefault}%
    \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
    \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
  }{%
  \ifboolexpr{ test {\ifdefstring{\mresume@font}{sourcesans}} or test {\ifdefstring{\mresume@font}{sourcesanspro}} }{%
    \RequirePackage[default,scaled=0.95]{sourcesanspro}%
    \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
    \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
  }{%
  \ifdefstring{\mresume@font}{roboto}{%
    \RequirePackage[sfdefault]{roboto}%
    \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
    \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
  }{%
  \ifdefstring{\mresume@font}{raleway}{%
    \RequirePackage[default]{raleway}%
    \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
    \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
  }{%
  \ifdefstring{\mresume@font}{cantarell}{%
    \RequirePackage[default]{cantarell}%
    \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
    \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
  }{%
  \ifdefstring{\mresume@font}{carlito}{%
    \RequirePackage[sfdefault]{carlito}%
    \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
    \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
  }{%
  \ifboolexpr{ test {\ifdefstring{\mresume@font}{helvet}} or test {\ifdefstring{\mresume@font}{helvetica}} }{%
    \RequirePackage[scaled=0.95]{helvet}%
    \renewcommand{\familydefault}{\sfdefault}%
    \newcommand{\resumeTitleFont}{\Huge}%
    \newcommand{\resumeSectionFont}{\Large}%
  }{%
  \ifboolexpr{ test {\ifdefstring{\mresume@font}{noto}} or test {\ifdefstring{\mresume@font}{notosans}} }{%
    \RequirePackage[sfdefault]{noto-sans}%
    \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
    \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
  }{%
  \ifdefstring{\mresume@font}{tgheros}{%
    \RequirePackage{tgheros}%
    \renewcommand{\familydefault}{\sfdefault}%
    \newcommand{\resumeTitleFont}{\Huge}%
    \newcommand{\resumeSectionFont}{\Large}%
  }{%
  \ifdefstring{\mresume@font}{charter}{%
    \RequirePackage{charter}%
    \renewcommand{\familydefault}{\rmdefault}%
    \newcommand{\resumeTitleFont}{\Huge}%
    \newcommand{\resumeSectionFont}{\Large}%
  }{%
  \ifboolexpr{ test {\ifdefstring{\mresume@font}{ebgaramond}} or test {\ifdefstring{\mresume@font}{garamond}} }{%
    \RequirePackage{ebgaramond}%
    \renewcommand{\familydefault}{\rmdefault}%
    \newcommand{\resumeTitleFont}{\Huge}%
    \newcommand{\resumeSectionFont}{\Large}%
  }{%
  \ifdefstring{\mresume@font}{libertine}{%
    \RequirePackage{libertine}%
    \renewcommand{\familydefault}{\rmdefault}%
    \newcommand{\resumeTitleFont}{\Huge}%
    \newcommand{\resumeSectionFont}{\Large}%
  }{%
  \ifboolexpr{ test {\ifdefstring{\mresume@font}{lmodern}} or test {\ifdefstring{\mresume@font}{latinmodern}} }{%
    \RequirePackage{lmodern}%
    \renewcommand{\familydefault}{\rmdefault}%
    \newcommand{\resumeTitleFont}{\Huge}%
    \newcommand{\resumeSectionFont}{\Large}%
  }{%
    % Default: fira
    \IfFileExists{FiraSans.sty}{%
      \RequirePackage[sfdefault]{FiraSans}%
      \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
      \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
    }{%
      \RequirePackage[scaled=0.95]{helvet}%
      \renewcommand{\familydefault}{\sfdefault}%
      \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
      \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
    }%
  }}}}}}}}}}}}}%
\else
  % XeLaTeX / LuaLaTeX / Tectonic engine
  \RequirePackage{fontspec}
  \ifdefstring{\mresume@font}{inter}{%
    \IfFontExistsTF{Inter}{%
      \setmainfont{Inter}[BoldFont = {Inter-Bold}]%
      \IfFontExistsTF{Inter Light}{%
        \newfontfamily\resumeLightFont{Inter Light}%
        \newcommand{\resumeTitleFont}{\resumeLightFont\Huge}%
        \newcommand{\resumeSectionFont}{\resumeLightFont\Large}%
      }{%
        \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
        \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
      }%
    }{%
      \setmainfont{DejaVu Sans}%
      \newcommand{\resumeTitleFont}{\Huge}%
      \newcommand{\resumeSectionFont}{\Large}%
    }%
  }{%
    \IfFontExistsTF{Fira Sans}{%
      \setmainfont{Fira Sans}[BoldFont = {Fira Sans SemiBold}]%
      \IfFontExistsTF{Fira Sans Light}{%
        \newfontfamily\resumeLightFont{Fira Sans Light}%
        \newcommand{\resumeTitleFont}{\resumeLightFont\Huge}%
        \newcommand{\resumeSectionFont}{\resumeLightFont\Large}%
      }{%
        \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
        \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
      }%
    }{%
      \IfFontExistsTF{Open Sans}{%
        \setmainfont{Open Sans}[BoldFont = {Open Sans SemiBold}]%
        \IfFontExistsTF{Open Sans Light}{%
          \newfontfamily\resumeLightFont{Open Sans Light}%
          \newcommand{\resumeTitleFont}{\resumeLightFont\Huge}%
          \newcommand{\resumeSectionFont}{\resumeLightFont\Large}%
        }{%
          \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
          \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
        }%
      }{%
        \setmainfont{DejaVu Sans}%
        \newcommand{\resumeTitleFont}{\fontseries{l}\selectfont\Huge}%
        \newcommand{\resumeSectionFont}{\fontseries{l}\selectfont\Large}%
      }%
    }%
  }%
\fi

% ------------------------------------------------------------------------------
% Color Palette Definitions (Harmonized with michael.sty)
% ------------------------------------------------------------------------------
% Colors inspired by michael.sty:
%   MidnightBlue!70!black
%   Mahogany!50!black
%   ForestGreen!30!black
\definecolor{michaelDarkMidnight}{RGB}{20, 35, 60}
\definecolor{michaelMidnightBlue}{RGB}{25, 55, 95}
\definecolor{michaelSlate}{RGB}{100, 110, 125}
\definecolor{michaelCharcoal}{RGB}{50, 58, 65}
\definecolor{michaelForestGreen}{RGB}{25, 65, 45}
\definecolor{michaelTextDark}{RGB}{33, 37, 41}
\definecolor{michaelSubtleGray}{RGB}{115, 122, 130}
\definecolor{michaelLightDivider}{RGB}{205, 210, 216}
\definecolor{michaelLinkBlue}{RGB}{37, 99, 175}

\ifdefstring{\mresume@color}{slate}{
  \colorlet{resumePrimary}{michaelTextDark}
  \colorlet{resumeSectionCol}{michaelSlate}
  \colorlet{resumeRuleCol}{michaelLightDivider}
  \colorlet{resumeLinkCol}{michaelSlate!90!black}
  \colorlet{resumeMutedCol}{michaelSubtleGray}
}{
  \ifdefstring{\mresume@color}{charcoal}{
    \colorlet{resumePrimary}{michaelTextDark}
    \colorlet{resumeSectionCol}{michaelCharcoal}
    \colorlet{resumeRuleCol}{black!20}
    \colorlet{resumeLinkCol}{michaelCharcoal}
    \colorlet{resumeMutedCol}{michaelSubtleGray}
  }{
    \ifdefstring{\mresume@color}{forest}{
      \colorlet{resumePrimary}{michaelTextDark}
      \colorlet{resumeSectionCol}{michaelForestGreen}
      \colorlet{resumeRuleCol}{michaelForestGreen!25}
      \colorlet{resumeLinkCol}{michaelForestGreen!85!black}
      \colorlet{resumeMutedCol}{michaelSubtleGray}
    }{
      \ifdefstring{\mresume@color}{monochrome}{
        \colorlet{resumePrimary}{black}
        \colorlet{resumeSectionCol}{black!75}
        \colorlet{resumeRuleCol}{black!22}
        \colorlet{resumeLinkCol}{black}
        \colorlet{resumeMutedCol}{black!60}
      }{
        % default: midnight (michael.sty palette)
        \colorlet{resumePrimary}{michaelTextDark}
        \colorlet{resumeSectionCol}{michaelMidnightBlue}
        \colorlet{resumeRuleCol}{michaelMidnightBlue!22!gray!35}
        \colorlet{resumeLinkCol}{michaelLinkBlue}
        \colorlet{resumeMutedCol}{michaelSubtleGray}
      }
    }
  }
}

% ------------------------------------------------------------------------------
% Hyperref Settings
% ------------------------------------------------------------------------------
\hypersetup{
  colorlinks=true,
  urlcolor=resumeLinkCol,
  linkcolor=resumeLinkCol,
  pdfborder={0 0 0},
  breaklinks=true
}

% ------------------------------------------------------------------------------
% Helper Delimiters & Formatting Macros
% ------------------------------------------------------------------------------
\newcommand{\pipe}{\textcolor{resumeRuleCol}{\;\textbar\;}}
\newcommand{\pipesep}{\textcolor{resumeRuleCol}{\hspace{0.45em}\textbar\hspace{0.45em}}}
\newcommand{\bulletsep}{\textcolor{resumeRuleCol}{\hspace{0.4em}\textbullet\hspace{0.4em}}}

\newcommand{\email}[1]{\href{mailto:#1}{#1}}
\newcommand{\link}[2]{\href{#1}{#2}}
\newcommand{\web}[2][]{\ifstrempty{#1}{\href{https://#2}{#2}}{\href{https://#1}{#2}}}

% ------------------------------------------------------------------------------
% Header Commands
% ------------------------------------------------------------------------------
\newcommand{\mresume@name}{}
\newcommand{\mresume@contact}{}

\providecommand{\name}[1]{\renewcommand{\mresume@name}{#1}}
\newcommand{\contact}[1]{\renewcommand{\mresume@contact}{#1}}

\newcommand{\makeheader}{%
  \begingroup
  \hypersetup{urlcolor=resumePrimary,linkcolor=resumePrimary}%
  \ifdefstring{\mresume@headeralign}{center}{%
    \begin{center}
      {\resumeTitleFont\color{resumePrimary} \mresume@name}\par
      \vspace{2.5pt}
      {\small\color{resumePrimary} \mresume@contact}\par
    \end{center}
  }{%
    % Modern left-aligned layout matching Michael's resume
    {\resumeTitleFont\color{resumePrimary} \mresume@name}\par
    \vspace{2.5pt}
    {\small\color{resumePrimary} \mresume@contact}\par
  }%
  \par\vspace{0.5pt}%
  \endgroup
}

% ------------------------------------------------------------------------------
% Section Environment & Commands
% ------------------------------------------------------------------------------
\newenvironment{resumeSection}[1]{%
  \par\vspace{2.0pt}%
  \ifdefstring{\mresume@divider}{none}{}{%
    \ifdefstring{\mresume@divider}{title}{}{%
      \textcolor{resumeRuleCol}{\rule{\linewidth}{0.5pt}}\par\vspace{5.0pt}%
    }%
  }%
  \ifdefstring{\mresume@divider}{title}{\vspace{3.0pt}}{}%
  \noindent\hspace*{-1.5pt}{\resumeSectionFont\color{resumeSectionCol} #1}\par
  \ifdefstring{\mresume@divider}{title}{%
    \vspace{2.0pt}\textcolor{resumeRuleCol}{\rule{\linewidth}{0.5pt}}\par\vspace{3.0pt}%
  }{%
    \vspace{2.5pt}%
  }%
}{%
  \par\vspace{0.5pt}%
}

% Standalone \sectionHeader command
\newcommand{\sectionHeader}[1]{%
  \par\vspace{2.0pt}%
  \ifdefstring{\mresume@divider}{none}{}{%
    \ifdefstring{\mresume@divider}{title}{}{%
      \textcolor{resumeRuleCol}{\rule{\linewidth}{0.5pt}}\par\vspace{5.0pt}%
    }%
  }%
  \ifdefstring{\mresume@divider}{title}{\vspace{3.0pt}}{}%
  \noindent\hspace*{-1.5pt}{\resumeSectionFont\color{resumeSectionCol} #1}\par
  \ifdefstring{\mresume@divider}{title}{%
    \vspace{2.0pt}\textcolor{resumeRuleCol}{\rule{\linewidth}{0.5pt}}\par\vspace{3.0pt}%
  }{%
    \vspace{2.5pt}%
  }%
}

% ------------------------------------------------------------------------------
% Entry Layout Commands
% ------------------------------------------------------------------------------
% 1. Piped inline entry (clean, modern, exactly matching Michael's resume)
% Usage: \resumeEntryInline[options]{PrimaryTitle}{SecondaryTitle}{Date/Details}{Extra}
% Options:
%   nobold - render PrimaryTitle in regular font instead of bold
\NewDocumentCommand{\resumeEntryInline}{O{} m m m m}{%
  \par\vspace{1.0pt}%
  \ifstrequal{#1}{nobold}{%
    \noindent #2%
  }{%
    \noindent\textbf{#2}%
  }%
  {\small
    \ifstrempty{#3}{}{\pipe \textcolor{resumeMutedCol}{#3}}%
    \ifstrempty{#4}{}{\pipe \textcolor{resumeMutedCol}{#4}}%
    \ifstrempty{#5}{}{\pipe \textcolor{resumeMutedCol}{#5}}%
  }%
  \par\vspace{0.8pt}%
}

% 2. Two-column split entry (Title on left, Date on right; Subtitle on left, Location on right)
% Usage: \resumeEntrySplit{LeftTitle}{RightDate}{LeftSubtitle}{RightLocation}
\newcommand{\resumeEntrySplit}[4]{%
  \par\vspace{1.0pt}%
  \noindent
  \begin{tabular*}{\linewidth}{@{}l@{\extracolsep{\fill}}r@{}}
    \textbf{#1}\ifstrempty{#2}{}{ & \textcolor{resumeMutedCol}{#2}} \\
    \ifstrempty{#3}{}{\textit{\small #3}}\ifstrempty{#4}{}{ & \textit{\small\textcolor{resumeMutedCol}{#4}}} \\
  \end{tabular*}%
  \par\vspace{0.8pt}%
}

% 3. Project Entry (Project Name | Context | Date)
\newcommand{\resumeProject}[3]{%
  \par\vspace{1.0pt}%
  \noindent\textbf{#1}%
  {\small
    \ifstrempty{#2}{}{\pipe \textit{\textcolor{resumeMutedCol}{#2}}}%
    \ifstrempty{#3}{}{\pipe \textcolor{resumeMutedCol}{#3}}%
  }%
  \par\vspace{0.8pt}%
}

% 4. Note / Coursework line (slightly smaller, italicized, muted gray; supports optional block indent, e.g. [10pt])
\newcommand{\resumeNote}[2][0pt]{%
  \par\vspace{0.5pt}%
  \begingroup\leftskip=#1\noindent{\small\color{resumeMutedCol} #2\par}\endgroup\vspace{0.8pt}%
}

% 5. Skill Group (Category | Items)
\newcommand{\resumeSkillGroup}[2]{%
  \resumeEntryInline{#1}{#2}{}{}%
}

% 6. Inline Piped List (for Awards / compact lists)
\newcommand{\resumeInlineList}[1]{%
  \par\vspace{1.0pt}%
  \noindent{\small #1}\par\vspace{0.8pt}%
}

% ------------------------------------------------------------------------------
% Bulleted List Environments
% ------------------------------------------------------------------------------
\ifdefstring{\mresume@bullet}{circle}{%
  \newcommand{\mresume@labelitem}{\textcolor{resumeSectionCol}{\footnotesize$\bullet$}}
}{%
  \ifdefstring{\mresume@bullet}{none}{%
    \newcommand{\mresume@labelitem}{}
  }{%
    % default: sleek en-dash (matching Michael's resume)
    \newcommand{\mresume@labelitem}{\textcolor{resumeSectionCol!80!black}{\textendash}}
  }%
}

\newenvironment{resumeItemList}{%
  \begin{itemize}[
    leftmargin=1.15em,
    itemsep=0.4pt,
    topsep=0.6pt,
    partopsep=0pt,
    parsep=0pt,
    label=\mresume@labelitem
  ]
}{%
  \end{itemize}%
  \vspace{0.3pt}%
}

\newcommand{\resumeItem}[1]{\item \small #1}

\endinput
