%% szuthesis.cls
%% 深圳大学本科毕业论文规范 - 修正版
%% 基于 2025/11/23 用户需求定制

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{szuthesis}[2025/11/23 v1.1 SZU Thesis Template]

% ================== 0. 基础类加载 ==================
% 默认五号字(10.5pt)，A4纸
\LoadClass[zihao=5,a4paper,linespread=1.25]{ctexart}
% linespread=1.25 在 Word 中约等于单倍行距（LaTeX默认行距较窄）

% ================== 1. 页面与宏包配置 ==================
\RequirePackage[top=2.54cm, bottom=2.54cm, left=3.17cm, right=3.17cm]{geometry} % 页边距(参考常规标准，因为需求未指定页边距数值，设为Word默认)
\RequirePackage{fancyhdr}
\RequirePackage{titletoc}
\RequirePackage{caption}
\RequirePackage{fontspec}
\RequirePackage{setspace}
\RequirePackage{geometry}
\RequirePackage{titlesec}
\RequirePackage{etoolbox}
\RequirePackage[hidelinks]{hyperref}

% 定义字体 (需系统安装对应字体，Windows通常自带)
% 如果是Linux/Mac，请确保安装了SimSun, SimHei, KaiTi, STZhongsong
\setCJKmainfont[AutoFakeBold=true]{SimSun}   % 正文：宋体
\setCJKsansfont[AutoFakeBold=true]{SimHei}   % 标题：黑体
\setCJKmonofont[AutoFakeBold=true]{SimSun}   % 等宽：宋体
\newCJKfontfamily\kaiti{KaiTi}[AutoFakeBold=true]       % 楷体
\newCJKfontfamily\hwzs{STZhongsong}[AutoFakeBold=true]  % 华文中宋
\setmainfont{Times New Roman} % 英文：Times New Roman

% ================== 2. 标题格式设置 (核心需求) ==================
% 需求：连续数字 1, 1.1, 1.1.1
% 需求：单倍行距，段前段后0.5行

% 定义一个通用的间距命令
\newcommand{\baseSpacing}{
    \singlespacing       % 单倍行距
    \setlength{\parskip}{0pt} % 段落间距由 section 设置控制
}

\ctexset{
    section = {
        % 一级标题：不大于三号(16pt)，黑体加粗。这里取三号。
        format = \bfseries\heiti\zihao{3}\raggedright, 
        number = \arabic{section},
        name = {},
        beforeskip = 0.5\baselineskip,
        afterskip = 0.5\baselineskip,
        indent = 0pt,
    },
    subsection = {
        % 二级标题：比一级小半号 -> 小三号(15pt)，黑体加粗。
        format = \bfseries\heiti\zihao{-3}\raggedright,
        number = \arabic{section}.\arabic{subsection},
        beforeskip = 0.5\baselineskip,
        afterskip = 0.5\baselineskip,
        indent = 0pt,
    },
    subsubsection = {
        % 三级标题：比二级小半号 -> 四号(14pt)，黑体加粗。
        format = \bfseries\heiti\zihao{4}\raggedright,
        number = \arabic{section}.\arabic{subsection}.\arabic{subsubsection},
        beforeskip = 0.5\baselineskip,
        afterskip = 0.5\baselineskip,
        indent = 0pt,
    }
}

% ================== 3. 封面标题命令 ==================
% 需求：主标题小二号华文中宋加粗，副标题小四号宋体，1.5倍行距居中
% Pass in here

% ================== 4. 摘要与关键词 ==================
% 需求：英文摘要，字体 Times New Roman
% Pass in here 

% ================== 5. 目录格式 ==================
% 需求：小四号宋体，1.5或2倍行距
\renewcommand{\tableofcontents}{
    \clearpage
    \pagestyle{plain}
    \begin{center}
        \zihao{3}\heiti\bfseries 目\hspace{1em}录 % 目录二字通常跟随一级标题样式或自定义
    \end{center}
    \vspace{1em}
    \begin{spacing}{1.5}
        \@starttoc{toc}
    \end{spacing}
    \clearpage
}

% 配置目录项格式 (使用 titletoc)
\titlecontents{section}[0pt]{\songti\zihao{-4}}{\thecontentslabel\hspace{0.5em}}{}{\titlerule*{.}\contentspage}
\titlecontents{subsection}[2em]{\songti\zihao{-4}}{\thecontentslabel\hspace{0.5em}}{}{\titlerule*{.}\contentspage}
\titlecontents{subsubsection}[4em]{\songti\zihao{-4}}{\thecontentslabel\hspace{0.5em}}{}{\titlerule*{.}\contentspage}


% ================== 6. 图表格式 ==================
% 需求：图表题目及说明 小五号宋体
\DeclareCaptionFont{szucapfont}{\songti\zihao{-5}}
\captionsetup{font=szucapfont, labelsep=space}

% ================== 7. 参考文献与注释 ==================
% 需求：标题五号楷体顶格加粗，内容小五号楷体顶格。
\renewenvironment{thebibliography}[1]
     {\clearpage
      \section*{\raggedright\kaiti\zihao{5}\bfseries 参考文献} % 标题：五号楷体顶格加粗
      \addcontentsline{toc}{section}{参考文献}
      \kaiti\zihao{-5} % 内容：小五号楷体
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \itemsep 0pt % 紧凑
            \parsep 0pt
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

% ================== 8. 致谢 ==================
% Pass in here

% ================== 9. 全局正文设置 ==================
% 需求：正文内容五号宋体。单倍行距、段前段后0.5行、两端对齐。
% 注意：在 \begin{document} 后生效
\AtBeginDocument{
    \songti\zihao{5}
    \singlespacing
    \setlength{\parskip}{0.5\baselineskip} % 段间距近似模拟段前段后0.5行
    \setlength{\parindent}{2em}
}

\endinput