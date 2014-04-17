<?xml version="1.0" encoding="utf-8"?>
<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node text="node.org" background_color="#00bfff">
<richcontent TYPE="NOTE"><html><head></head><body><p>--org-mode: WHOLE FILE</p></body></html></richcontent>
<node text="&#x7b80&#x4ecb" position="left">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x4e4b&#x524d&#x7684&#x56e0&#x4e3a&#x9879&#x76ee&#x7528node&#x6765&#x6784&#x5efa&#xff0c&#x7f51&#x4e0a&#x641c&#x96c6&#x4e86&#x76f8&#x5173&#x7684&#x63d2&#x4ef6&#xff0c&#x6d89&#x53ca&#x5230&#x6574&#x4e2a&#x5f00&#x53d1&#x6d41&#x7a0b&#xff0c&#x5171&#x5927&#x5bb6&#x53c2&#x8003</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "&#x7b80&#x4ecb" --</p></body></html></richcontent>
</node>
</node>
<node text="javascript / node.js &#x8bed&#x6cd5&#x76f8&#x5173" position="left">
<node text="js2-mode">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x5bf9&#x4e8e&#x4f7f&#x7528emacs&#x6765&#x5f00&#x53d1javascript&#x7684&#x4eba&#x6765&#x8bf4js2-mode&#x5e94&#x8be5&#x662f&#x5fc5&#x5907&#x795e&#x5668&#xff0c&#x6b64&#x5de5&#x5177&#x53ef&#x4ee5&#x63d0&#x793ajs&#x8bed&#x6cd5&#x9519&#x8bef&#xff0c<br />&#x5e76&#x7528&#x7ea2&#x8272&#x4e0b&#x6ed1&#x7ebf&#x7ed9&#x4e88&#x63d0&#x793a(&#x5f53&#x521d&#x50cf&#x6211&#x8fd9&#x6837js&#x8bed&#x6cd5&#x90fd&#x6ca1&#x6709&#x8fc7&#x5173&#x7684&#x4eba&#x6765&#x8bb2&#x786e&#x5b9e&#x5e2e&#x52a9&#x633a&#x5927&#x7684^^)</p><p><br />&#x914d&#x7f6e&#x8fc7&#x7a0b&#xff1a<br />#+BEGIN_EXAMPLE<br />$ svn checkout<a href="http://js2-mode.googlecode.com/svn/trunk/">http://js2-mode.googlecode.com/svn/trunk/</a> js2-mode<br />$ cd js2-mode<br />$ emacs --batch -f batch-byte-compile js2-mode.el<br />$ cp js2-mode.elc ~/.emacs.d/<br />#+END_EXAMPLE<br />*&#x6709&#x7684&#x7ae5&#x978b&#x53ef&#x80fd&#x4f1a&#x95ee&#x600e&#x4e48&#x4fee&#x6539~/.emacs &#x6587&#x4ef6&#xff0c&#x4e0b&#x9762&#x6211&#x4f1a&#x4e00&#x8d77&#x63d0&#x4f9b*</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "js2-mode" --</p></body></html></richcontent>
</node>
</node>
<node text="espresso">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x521a&#x63a5&#x89e6node&#x7684&#x4eba&#x5bf9&#x7f29&#x8fdb&#x4f1a&#x6709&#x4e9b&#x5934&#x75db&#xff0c&#x8fd9&#x4e2a&#x63d2&#x4ef6&#x5c31&#x5e2e&#x6211&#x4eec&#x641e&#x5b9anode&#x7684&#x7f29&#x8fdb<br />#+BEGIN_EXAMPLE<br />$wget<a href="http://download.savannah.gnu.org/releases-noredirect/espresso/espresso.el">http://download.savannah.gnu.org/releases-noredirect/espresso/espresso.el</a><br />$cp ./espresso.el ~/.emacs.d/<br />#+END_EXAMPLE<br />*&#x56e0&#x4e3a&#x4f7f&#x7528espresso&#x7684&#x65f6&#x5019&#x53ef&#x80fd&#x4f1a&#x8ddfyasnippet&#x7684&#x5feb&#x6377&#x952e&#x51b2&#x7a81&#xff0c&#x5efa&#x8bae&#x5927&#x5bb6&#x6309&#x7167&#x4e0b&#x9762&#x8fdb&#x884c&#x4fee&#x6539*</p><p><br />&#x9996&#x5148&#x521b&#x5efanodejs.el&#x6587&#x4ef6<br />#+BEGIN_EXAMPLE<br />$touch ~/.emacs.d/nodejs.el<br />#+END_EXAMPLE<br />&#x628a&#x4ee5&#x4e0b&#x5185&#x5bb9&#x62f7&#x8d1d&#x5230nodejs.el&#x91cc&#x9762<br />#+BEGIN_SRC javascript<br />;;;; load &amp; configure js2-mode <br />(autoload 'js2-mode &quot;js2-mode&quot; nil t)<br />(add-to-list 'auto-mode-alist '(&quot;\\.js$&quot; . js2-mode))</p><p><br />;;; espresso mode<br />(autoload 'espresso-mode &quot;espresso&quot;)</p><p><br />(add-hook 'js2-mode-hook<br />(lambda ()<br />(yas-global-mode 1)))</p><p><br />(eval-after-load 'js2-mode<br />'(progn<br />(define-key js2-mode-map (kbd &quot;TAB&quot;) (lambda()<br />(interactive)<br />(let ((yas/fallback-behavior 'return-nil))<br />(unless (yas/expand)<br />(indent-for-tab-command)<br />(if (looking-back &quot;^\s*&quot;)<br />(back-to-indentation))))))))</p><p><br /> </p><p><br />(defun my-js2-indent-function ()<br />(interactive)<br />(save-restriction<br />(widen)<br />(let* ((inhibit-point-motion-hooks t)<br />(parse-status (save-excursion (syntax-ppss (point-at-bol))))<br />(offset (- (current-column) (current-indentation)))<br />(indentation (espresso--proper-indentation parse-status))<br />node)</p><p><br />(save-excursion</p><p><br />;; I like to indent case and labels to half of the tab width<br />(back-to-indentation)<br />(if (looking-at &quot;case\\s-&quot;)<br />(setq indentation (+ indentation (/ espresso-indent-level 2))))</p><p><br />;; consecutive declarations in a var statement are nice if<br />;; properly aligned, i.e:<br />;;<br />;; var foo = &quot;bar&quot;,<br />;; bar = &quot;foo&quot;;<br />(setq node (js2-node-at-point))<br />(when (and node<br />(= js2-NAME (js2-node-type node))<br />(= js2-VAR (js2-node-type (js2-node-parent node))))<br />(setq indentation (+ 4 indentation))))</p><p><br />(indent-line-to indentation)<br />(when (&gt; offset 0) (forward-char offset)))))</p><p><br />(defun my-indent-sexp ()<br />(interactive)<br />(save-restriction<br />(save-excursion<br />(widen)<br />(let* ((inhibit-point-motion-hooks t)<br />(parse-status (syntax-ppss (point)))<br />(beg (nth 1 parse-status))<br />(end-marker (make-marker))<br />(end (progn (goto-char beg) (forward-list) (point)))<br />(ovl (make-overlay beg end)))<br />(set-marker end-marker end)<br />(overlay-put ovl 'face 'highlight)<br />(goto-char beg)<br />(while (&lt; (point) (marker-position end-marker))<br />;; don't reindent blank lines so we don't set the &quot;buffer<br />;; modified&quot; property for nothing<br />(beginning-of-line)<br />(unless (looking-at &quot;\\s-*$&quot;)<br />(indent-according-to-mode))<br />(forward-line))<br />(run-with-timer 0.5 nil '(lambda(ovl)<br />(delete-overlay ovl)) ovl)))))</p><p><br />(defun my-js2-mode-hook ()<br />(require 'espresso)<br />(setq espresso-indent-level 2<br />indent-tabs-mode nil<br />c-basic-offset 2)<br />(c-toggle-auto-state 0)<br />(c-toggle-hungry-state 1)<br />(set (make-local-variable 'indent-line-function) 'my-js2-indent-function)<br />(define-key js2-mode-map [(meta control |)] 'cperl-lineup)<br />(define-key js2-mode-map [(meta control \;)]<br />'(lambda()<br />(interactive)<br />(insert &quot;/* -----[ &quot;)<br />(save-excursion<br />(insert &quot; ]----- */&quot;))<br />))<br />(define-key js2-mode-map [(return)] 'newline-and-indent)<br />(define-key js2-mode-map [(backspace)] 'c-electric-backspace)<br />(define-key js2-mode-map [(control d)] 'c-electric-delete-forward)<br />(define-key js2-mode-map [(control meta q)] 'my-indent-sexp)<br />(if (featurep 'js2-highlight-vars)<br />(js2-highlight-vars-mode))<br />(message &quot;My JS2 hook&quot;))</p><p><br />(add-hook 'js2-mode-hook 'my-js2-mode-hook)</p><p><br />(provide 'nodejs)<br />#+END_SRC<br />&#x7136&#x540e&#x6700&#x540e&#x4fee&#x6539~/.emacs &#x6587&#x4ef6,&#x589e&#x52a0&#x4ee5&#x4e0b&#x5185&#x5bb9<br />#+BEGIN_EXAMPLE<br />(require 'nodejs)<br />#+END_EXAMPLE</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "espresso" --</p></body></html></richcontent>
</node>
</node>
<node text="exuberant-ctags &#x63d0&#x4f9b&#x7c7b&#x4f3cGo To Definition &#x529f&#x80fd">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x6b64&#x5de5&#x5177&#x7ed9&#x6211&#x4eec&#x63d0&#x4f9b&#x8df3&#x5230&#x51fd&#x6570&#x5b9a&#x4e49&#x5904&#x7c7b&#x4f3c&#x7684&#x529f&#x80fd , &#x4e0d&#x8fc7&#x5982&#x679c&#x51fa&#x73b0&#x540c&#x540d&#x51fd&#x6570&#x7684&#x8bdd&#x8fd8&#x662f&#x4f1a&#x51fa&#x73b0&#x8bef&#x8df3&#x7684&#x73b0&#x8c61&#x3002</p><p><br />&#x6240&#x4ee5&#x5982&#x679c&#x5bf9&#x51fd&#x6570&#x540d&#x547d&#x540d&#x7684&#x65f6&#x5019&#x591a&#x52a0&#x8003&#x8651&#x7684&#x8bdd&#x4e00&#x822c&#x8fd8&#x662f&#x53ef&#x4ee5&#x51c6&#x786e&#x7684&#x8df3&#x8f6c&#x5230&#x5b9a&#x4e49&#x5904&#x7684&#x3002<br />#+BEGIN_EXAMPLE<br />$sudo apt-get install exuberant-ctags<br />$cd your_project_dir<br />$ctags -e --recurse (&#x8ddf&#x76ee&#x5f55&#x4e0b&#x4f1a&#x521b&#x5efaTAGS&#x7d22&#x5f15&#x6587&#x4ef6)<br />&#x6253&#x5f00&#x7f16&#x8f91&#x5668&#xff0c &#x5149&#x6807&#x79fb&#x52a8&#x5230&#x8981&#x627e&#x7684&#x51fd&#x6570&#x540d&#x5904&#xff0c &quot;M-.&quot; &#x89e6&#x53d1&#x67e5&#x627etag&#x547d&#x4ee4, &#x7b2c&#x4e00&#x6b21&#x4f1a&#x8ba9&#x4f60&#x9009&#x62e9&#x7d22&#x5f15&#x6587&#x4ef6&#xff0c&#x5c31&#x628a&#x521a&#x624d&#x521b&#x5efa&#x7684TAGS&#x6587&#x4ef6&#x627e&#x51fa&#x6765&#x6253&#x5f00&#x5c31&#x53ef&#x4ee5&#x4e86&#x3002<br />#+END_EXAMPLE<br /></p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "exuberant-ctags &#x63d0&#x4f9b&#x7c7b&#x4f3cGo To Definition &#x529f&#x80fd" --</p></body></html></richcontent>
</node>
</node>
<node text="js2-highlight-vars &#x4f5c&#x7528&#x57df&#x5185&#x53d8&#x91cf&#x7684 highlight &#x529f&#x80fd">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x5f53&#x5199node&#x7684&#x65f6&#x5019&#x5d4c&#x5957&#x5f88&#x591a&#x5c42&#xff0c&#x6709&#x65f6&#x5019&#x81ea&#x5df1&#x4e5f&#x72af&#x8ff7&#x7cca&#xff0c&#x6240&#x4ee5&#x81ea&#x52a8&#x9ad8&#x4eae&#x663e&#x793a&#x5149&#x6807&#x6240&#x5728&#x53d8&#x91cf&#x7684&#x8bdd&#x4e5f&#x4f1a&#x5f88&#x6709&#x5e2e&#x52a9&#x7684<br />#+BEGIN_EXAMPLE<br />$wget<a href="http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode/js2-highlight-vars-mode/js2-highlight-vars.el">http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode/js2-highlight-vars-mode/js2-highlight-vars.el</a><br />$cp js2-highlight-vars.el ~/.emacs.d<br />#+END_EXAMPLE<br />&#x4fee&#x6539~/.emacs&#x6587&#x4ef6<br />#+BEGIN_EXAMPLE<br />;; ;;js2-highlight vars<br />(require 'js2-highlight-vars)<br />(if (featurep 'js2-highlight-vars)<br />    (js2-highlight-vars-mode))<br />#+END_EXAMPLE</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "js2-highlight-vars &#x4f5c&#x7528&#x57df&#x5185&#x53d8&#x91cf&#x7684 highlight &#x529f&#x80fd" --</p></body></html></richcontent>
</node>
</node>
</node>
<node text="&#x5176&#x4ed6&#x5404&#x79cd&#x901a&#x7528&#x795e&#x5668">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x4ecb&#x7ecd&#x901a&#x7528&#x7684emacs&#x5199&#x4ee3&#x7801&#x5fc5&#x5907&#x795e&#x5668&#xff0c &#x76f8&#x4fe1&#x4f60&#x80af&#x5b9a&#x4e5f&#x9700&#x8981^^</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "&#x5176&#x4ed6&#x5404&#x79cd&#x901a&#x7528&#x795e&#x5668" --</p></body></html></richcontent>
</node>
<node text="find-file-suggest">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x9047&#x5230&#x591a&#x7ea7&#x9879&#x76ee&#x5de5&#x7a0b&#x76ee&#x5f55&#x7ed3&#x6784&#xff0c&#x662f&#x5426&#x201cC-x C-f&quot; &#x6309&#x5230&#x624b&#x75db&#xff1f&#x6216&#x8005&#x6dfb&#x52a0 bookmark ?</p><p><br />&#x8fd9&#x4e2a&#x63d2&#x4ef6&#x5c31&#x662f&#x5e2e&#x6211&#x4eec&#x7d22&#x5f15&#x9879&#x76ee&#x6587&#x4ef6&#x7684&#xff0c&#x5c31&#x50cfsource insight&#x90a3&#x6837&#xff0c&#x53ea&#x8981&#x8f93&#x5165&#x6587&#x4ef6&#x540d&#x4efb&#x610f&#x5b57&#x6bb5(&#x5f53&#x7136&#x652f&#x6301RegExp)&#xff0c&#x5c31&#x5e2e&#x4f60&#x5b9a&#x4f4d&#x5230&#x90a3&#x4e2a&#x6587&#x4ef6&#x91cc&#x3002</p><p><br />&#x914d&#x7f6e&#x8fc7&#x7a0b&#xff1a<br />#+BEGIN_EXAMPLE<br />$wget https://find-file-suggest.googlecode.com/files/find-file-suggest_2010-03-02.zip<br />$unzip find-file-suggest_2010-03-02.zip<br />$cp find-file-suggest_2010-03-02 ~/.emacs.d<br />#+END_EXAMPLE<br />&#x7136&#x540e&#x4fee&#x6539~/.emacs,&#x628a&#x4ee5&#x4e0b&#x5185&#x5bb9&#x6dfb&#x52a0&#x8fdb&#x53bb<br />#+BEGIN_EXAMPLE<br />;;find-file-suggest<br />(require 'find-file-suggest)<br />(global-set-key [(control x) (meta f)] 'find-file-suggest)<br />(global-set-key [(control x) (meta g)] 'ffs-grep)<br />#+END_EXAMPLE<br />&#x7136&#x540e&#x5c31&#x662f&#x8981&#x5efa&#x7acb&#x641c&#x5f15&#xff0c&#x4ee5&#x4e0b&#x7ed9&#x51fa&#x4e24&#x4e2anode&#x5de5&#x7a0b&#x548cC/C++&#x5de5&#x7a0b&#x7684&#x4f8b&#x5b50<br />#+BEGIN_EXAMPLE<br />;;c/c++ &#x5de5&#x7a0b&#x521b&#x5efa&#x7d22&#x5f15(&#x53c2&#x6570&#xff1a&#x522b&#x540d, &#x5de5&#x7a0b&#x76ee&#x5f55, &#x8981&#x7d22&#x5f15&#x7684&#x6587&#x4ef6&#x540d&#x540e&#x7f00, &#x8981&#x8fc7&#x6ee4&#x7684&#x6587&#x4ef6&#x5939)<br />(ffs-create-file-index &quot;ejoy&quot; &quot;~/code/github/ejoy2d&quot; &quot;\\.h\\|\\.c\\|\\.lua&quot; &quot;\\doc$\\|\\.git$&quot;)<br />;;js/node.js &#x5de5&#x7a0b&#x521b&#x5efa&#x7d22&#x5f15<br />(ffs-create-file-index &quot;sails&quot; &quot;/usr/local/lib/node_modules/sails/lib&quot; &quot;\\.js\\|\\.ejs\\|\\.html&quot; &quot;&quot;) <br />#+END_EXAMPLE<br />&#x7528&#x6cd5&#xff1a<br />#+BEGIN_EXAMPLE<br />- &#x6253&#x5f00emacs&#xff0c &#x8f93&#x5165 &quot;M-x ffs-use-file-index&quot; &#x56de&#x8f66<br />- &#x8f93&#x5165 ejoy2d(&#x4e4b&#x524d&#x5efa&#x7acb&#x7684&#x5de5&#x7a0b&#x522b&#x540d) &#x56de&#x8f66<br />- &quot;C-x M-f&quot; &#x4e4b&#x540e&#x4f1a&#x663e&#x793a&#x6240&#x6709&#x7d22&#x5f15&#x5230&#x7684&#x6587&#x4ef6&#x5217&#x8868<br />- &#x76f4&#x63a5&#x8f93&#x5165&#x60f3&#x8981&#x67e5&#x627e&#x7684&#x6587&#x4ef6&#x540d&#xff08C-n &#x5411&#x4e0b&#xff0c C-p &#x5411&#x4e0a&#xff09&#xff0c&#x56de&#x8f66<br />#+END_EXAMPLE</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "find-file-suggest" --</p></body></html></richcontent>
</node>
</node>
<node text="highlight-parentheses &#x9ad8&#x4eae&#x663e&#x793a&#x914d&#x5bf9&#x7684&#x62ec&#x53f7&#xff08&#x4e0d&#x540c&#x989c&#x8272&#x663e&#x793a&#xff09">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x591a&#x5c42&#x5d4c&#x5957&#x7684&#x95ee&#x9898&#xff0c&#x5bf9&#x521a&#x5b66node&#x7684&#x4eba&#x6765&#x8bf4&#x4f1a&#x6709&#x4e9b&#x5934&#x75bc&#xff0c1&#x4e2a tab 2&#x4e2a&#x7a7a&#x683c&#x5df2&#x7ecf&#x591f&#x5934&#x75db&#x4e86&#xff0c&#x8fd8&#x591a&#x5c42&#x5d4c&#x5957 -_-!&#xff0c</p><p><br />&#x62ec&#x53f7&#x5c31&#x66f4&#x770b&#x4e0d&#x6e05&#x4e86&#x3002&#x6240&#x4ee5&#x628a&#x8fd9&#x4e2a&#x63d2&#x4ef6&#x63a8&#x8350&#x7ed9&#x5927&#x5bb6&#xff01&#xff08&#x8bdd&#x8bf4node&#x5d4c&#x5957&#x95ee&#x9898&#xff0c&#x5df2&#x7ecf&#x6709&#x4e86&#x5f88&#x591a&#x89e3&#x51b3&#x65b9&#x6848&#x4e86 async, step, eventproxy...&#x6709&#x5174&#x8da3&#x7ae5&#x978b&#x53ef&#x4ee5&#x67e5&#x627e&#x76f8&#x5173&#x8d44&#x6599&#xff09</p><p><br />#+BEGIN_EXAMPLE<br />$wget<a href="http://nschum.de/src/emacs/highlight-parentheses/highlight-parentheses.el">http://nschum.de/src/emacs/highlight-parentheses/highlight-parentheses.el</a><br />$cp highlight-parentheses.el ~/.emacs.d<br />&#x4fee&#x6539~/.emacs<br />(require 'highlight-parentheses)<br />&#x6253&#x5f00emacs<br />(M-x highlight-parentheses-mode) &#x6765&#x89e6&#x53d1&#x8be5&#x529f&#x80fd<br />#+END_EXAMPLE<br /></p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "highlight-parentheses &#x9ad8&#x4eae&#x663e&#x793a&#x914d&#x5bf9&#x7684&#x62ec&#x53f7&#xff08&#x4e0d&#x540c&#x989c&#x8272&#x663e&#x793a&#xff09" --</p></body></html></richcontent>
</node>
</node>
<node text="tramp &#x76f4&#x63a5&#x4fee&#x6539&#x670d&#x52a1&#x7aef&#x4ee3&#x7801&#x6216&#x914d&#x7f6e&#x6587&#x4ef6&#x5982&#x540c&#x672c&#x5730&#x64cd&#x4f5c">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>emscs23 &#x4ee5&#x4e0a&#x7248&#x672c&#x5f00&#x59cb&#x5df2&#x7ecf&#x628atramp&#x96c6&#x6210&#x8fdb&#x53bb&#x4e86&#xff0c&#x6240&#x4ee5&#x514d&#x989d&#x5916&#x7684&#x914d&#x7f6e&#x8fc7&#x7a0b&#xff0c&#x76f4&#x63a5&#x4f7f&#x7528&#x3002<br /></p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "tramp &#x76f4&#x63a5&#x4fee&#x6539&#x670d&#x52a1&#x7aef&#x4ee3&#x7801&#x6216&#x914d&#x7f6e&#x6587&#x4ef6&#x5982&#x540c&#x672c&#x5730&#x64cd&#x4f5c" --</p></body></html></richcontent>
</node>
<node text="&#x5229&#x7528tramp&#x63d0&#x5347root&#x6743&#x9650&#x4fee&#x6539&#xff1a">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>#+BEGIN_EXAMPLE<br />&#x6253&#x5f00emacs<br />&quot;C-x C-f&quot; &#x6253&#x5f00&#x6587&#x4ef6&#x64cd&#x4f5c<br />&quot;C-a C-k&quot; &#x5220&#x9664&#x5f53&#x524d&#x8def&#x5f84<br />&#x8f93&#x5165 /su::/etc/ &#x6309&#x4e0b Tab&#x6309&#x952e<br />&#x8f93&#x5165 &#x5bc6&#x7801 &#xff08&#x5f53&#x7136&#xff0c &#x524d&#x63d0&#x662f&#x5f53&#x524d&#x7528&#x6237&#x662f sudoer&#xff09<br />&#x518d&#x6b21&#x6309&#x4e0bTab &#x5c31&#x80fd&#x901a&#x8fc7root&#x8bbf&#x95ee&#x6240&#x6709&#x6587&#x4ef6&#x4e86<br />#+END_EXAMPLE</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "&#x5229&#x7528tramp&#x63d0&#x5347root&#x6743&#x9650&#x4fee&#x6539&#xff1a" --</p></body></html></richcontent>
</node>
</node>
<node text="&#x5229&#x7528tramp&#x4fee&#x6539&#x8fdc&#x7a0b&#x670d&#x52a1&#x5668&#x4ee3&#x7801">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>#+BEGIN_EXAMPLE<br />&quot;C-x C-f&quot; &#x6253&#x5f00&#x6587&#x4ef6&#x64cd&#x4f5c<br />&quot;C-a C-k&quot; &#x5220&#x9664&#x5f53&#x524d&#x8def&#x5f84<br />&#x8f93&#x5165 /luckyan315@192.168.3.2:/home/ &#x6309&#x4e0bTab<br />&#x6309&#x63d0&#x793a&#x8f93&#x5165&#xff0c&#x7b2c&#x4e00&#x6b21&#x53ef&#x80fd&#x8981&#x5efa&#x7acbssh&#x8fde&#x63a5&#xff08&#x53cd&#x6b63&#x6309&#x7167&#x63d0&#x793a&#x8f93&#x5165yes &#x6216&#x8005 y&#x5c31&#x884c&#x4e86&#xff09&#xff0c&#x7136&#x540e&#x8f93&#x5165&#x5bc6&#x7801<br />&#x518d&#x6b21&#x6309&#x4e0bTab &#x5c31&#x80fd&#x8bbf&#x95ee&#x8fdc&#x7a0b&#x670d&#x52a1&#x5668&#x76ee&#x5f55&#x4e86 ^_^<br />#+END_EXAMPLE</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "&#x5229&#x7528tramp&#x4fee&#x6539&#x8fdc&#x7a0b&#x670d&#x52a1&#x5668&#x4ee3&#x7801" --</p></body></html></richcontent>
</node>
</node>
</node>
<node text="yasnippet &#x63d0&#x4f9b&#x5404&#x79cd&#x8bed&#x8a00&#x7684&#x6a21&#x677f&#x4ee3&#x7801">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x4eceTextMate&#x7ee7&#x5c42&#x8fc7&#x6765&#x7684&#x975e&#x5e38&#x6709&#x7528&#x7684&#x4e00&#x4e2a&#x529f&#x80fd&#xff0c&#x63d0&#x4f9b&#x5404&#x79cd&#x8bed&#x8a00&#x7684&#x6a21&#x677f&#x4ee3&#x7801&#x3002<br />#+BEGIN_EXAMPLE<br />$wget<a href="http://yasnippet.googlecode.com/files/yasnippet-0.6.1c.tar.bz2">http://yasnippet.googlecode.com/files/yasnippet-0.6.1c.tar.bz2</a><br />$cp yasnippet-0.6.1c ~/.emacs.d<br />$cd ~/.emacs.d<br />$mv yasnippet-0.6.1c yasnippet<br />&#x4fee&#x6539~/.emacs<br />(add-to-list 'load-path<br />             &quot;~/.emacs.d/yasnippet&quot;)<br />(require 'yasnippet) ;; not yasnippet-bundle<br />(yas-global-mode 1)<br />#+END_EXAMPLE<br />*&#x5f53&#x6211&#x4eec&#x5b89&#x88c5js2-mode&#x4e4b&#x540e&#xff0c&#x6211&#x4eec&#x9700&#x8981&#x624b&#x52a8&#x521b&#x5efa&#x4e00&#x4e2ajs2-mode&#x76f8&#x5173&#x7684snippets*<br />#+BEGIN_EXAMPLE<br />$cd ~/.emacs.dyasnippet/snippets<br />$cp -r js-mode js2-mode<br />#+END_EXAMPLE</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "yasnippet &#x63d0&#x4f9b&#x5404&#x79cd&#x8bed&#x8a00&#x7684&#x6a21&#x677f&#x4ee3&#x7801" --</p></body></html></richcontent>
</node>
</node>
<node text="&#x7248&#x672c&#x63a7&#x5236">
<node text="psvn &#x901a&#x8fc7SVN&#x7ba1&#x7406&#x4f60&#x7684&#x4ee3&#x7801">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x524d&#x671f&#x539f&#x5f62&#x4ee3&#x7801&#x5f88&#x591a&#x4eba&#x7528svn&#x6765&#x7ba1&#x7406&#xff0c&#x4f7f&#x7528&#x8fc7&#x7a0b&#x4e2d &#x7528psvn&#x4e2a&#x4eba&#x611f&#x89c9&#x5df2&#x7ecf&#x591f&#x7528&#x4e86<br />#+BEGIN_EXAMPLE<br />$wget<a href="http://lifegoo.pluskid.org/wiki/lisp/psvn.el">http://lifegoo.pluskid.org/wiki/lisp/psvn.el</a><br />$cp ./psvn.el ~/.emacs.d<br />&#x4fee&#x6539~/.emacs, &#x6dfb&#x52a0&#x4ee5&#x4e0b&#x5185&#x5bb9<br />;;svn support<br />(require 'psvn)<br />#+END_EXAMPLE</p><p><br />&#x5177&#x4f53&#x7528&#x6cd5:<br />#+BEGIN_EXAMPLE<br />g     - svn-status-update:               run 'svn status -v'<br />M-s   - svn-status-update:               run 'svn status -v'<br />C-u g - svn-status-update:               run 'svn status -vu'<br />=     - svn-status-show-svn-diff         run 'svn diff'<br />l     - svn-status-show-svn-log          run 'svn log'<br />i     - svn-status-info                  run 'svn info'<br />r     - svn-status-revert                run 'svn revert'<br />X v   - svn-status-resolved              run 'svn resolved'<br />U     - svn-status-update-cmd            run 'svn update'<br />M-u   - svn-status-update-cmd            run 'svn update'<br />c     - svn-status-commit                run 'svn commit'<br />a     - svn-status-add-file              run 'svn add --non-recursive'<br />A     - svn-status-add-file-recursively  run 'svn add'<br />+     - svn-status-make-directory        run 'svn mkdir'<br />R     - svn-status-mv                    run 'svn mv'<br />D     - svn-status-rm                    run 'svn rm'<br />M-c   - svn-status-cleanup               run 'svn cleanup'<br />b     - svn-status-blame                 run 'svn blame'<br />X e   - svn-status-export                run 'svn export'<br />RET   - svn-status-find-file-or-examine-directory<br />^     - svn-status-examine-parent<br />~     - svn-status-get-specific-revision<br />E     - svn-status-ediff-with-revision<br />X X   - svn-status-resolve-conflicts<br />s     - svn-status-show-process-buffer<br />e     - svn-status-toggle-edit-cmd-flag<br />?     - svn-status-toggle-hide-unknown<br />_     - svn-status-toggle-hide-unmodified<br />m     - svn-status-set-user-mark<br />u     - svn-status-unset-user-mark<br />$     - svn-status-toggle-elide<br />w     - svn-status-copy-filename-as-kill<br />DEL   - svn-status-unset-user-mark-backwards<br />\* !   - svn-status-unset-all-usermarks<br />\* ?   - svn-status-mark-unknown<br />\* A   - svn-status-mark-added<br />\* M   - svn-status-mark-modified<br />\* D   - svn-status-mark-deleted<br />\* *   - svn-status-mark-changed<br />.     - svn-status-goto-root-or-return<br />f     - svn-status-find-file<br />o     - svn-status-find-file-other-window<br />v     - svn-status-view-file-other-window<br />I     - svn-status-parse-info<br />V     - svn-status-svnversion<br />P l   - svn-status-property-list<br />P s   - svn-status-property-set<br />P d   - svn-status-property-delete<br />P e   - svn-status-property-edit-one-entry<br />P i   - svn-status-property-ignore-file<br />P I   - svn-status-property-ignore-file-extension<br />P C-i - svn-status-property-edit-svn-ignore<br />P k   - svn-status-property-set-keyword-list<br />P y   - svn-status-property-set-eol-style<br />P x   - svn-status-property-set-executable<br />h     - svn-status-use-history<br />q     - svn-status-bury-buffer</p><p><br />C-x C-j - svn-status-dired-jump<br />#+END_EXAMPLE</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "psvn &#x901a&#x8fc7SVN&#x7ba1&#x7406&#x4f60&#x7684&#x4ee3&#x7801" --</p></body></html></richcontent>
</node>
</node>
<node text="git-emacs &#x901a&#x8fc7git&#x7ba1&#x7406&#x4ee3&#x7801">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x56e0&#x4e3a&#x5f88&#x591a&#x5feb&#x6377&#x952e&#x548c psvn &#x76f8&#x540c&#xff0c&#x5982&#x679c&#x719f&#x6089&#x4e86psvn&#xff0c&#x4e0d&#x9700&#x8981&#x8bb0&#x4f4f&#x989d&#x5916&#x7684&#x5feb&#x6377&#x952e&#x5c31&#x53ef&#x4ee5&#x4f7f&#x7528git-emacs&#x6765&#x5b8c&#x6210&#x5e38&#x7528&#x64cd&#x4f5c&#x4e86(&#x662f&#x7684&#xff0c&#x6211&#x4eec&#x662f&#x61d2&#x60f0&#x7684 -_-!)&#x3002<br />#+BEGIN_EXAMPLE<br />$git clone https://github.com/tsgates/git-emacs.git<br />$cp git-emacs ~/.emacs.d<br />&#x4fee&#x6539~/.emacs<br />(add-to-list 'load-path &quot;~/.emacs.d/git-emacs/&quot;)<br />(require 'git-emacs)<br />#+END_EXAMPLE<br />&#x548cpsvn&#x4e00&#x6837&#xff0c&#x8fdb&#x5165&#x201cM-x git-status&#x201d &#x8fdb&#x5165&#x63a7&#x5236&#x9762&#x677f&#x3002</p><p><br />&#x5e38&#x7528&#x547d&#x4ee4&#xff1a</p><p><br />|---------+------------------------------------------|<br />| Command | Comment                                  |<br />|---------+------------------------------------------|<br />| p/n     | &#x5728&#x6240&#x6709&#x6587&#x4ef6&#x4e4b&#x95f4&#x4e0a&#x4e0b&#x79fb&#x52a8        |<br />|---------+------------------------------------------|<br />| P/N     | &#x5728&#x53d8&#x66f4&#x8fc7&#x7684&#x6587&#x4ef6&#x4e4b&#x95f4&#x4e0a&#x4e0b&#x79fb&#x52a8  |<br />|---------+------------------------------------------|<br />| &lt;/&gt;     | &#x5b9a&#x4f4d&#x5230&#x5217&#x8868&#x7684&#x5934&#x90e8/&#x5c3e&#x90e8          |<br />|---------+------------------------------------------|<br />| v       | &#x4ee5&#x53ea&#x8bfb&#x65b9&#x5f0f&#x6253&#x5f00&#x6587&#x4ef6              |<br />|---------+------------------------------------------|<br />| m/u/SPC | &#x8bbe&#x7f6e/&#x53d6&#x6d88/&#x5207&#x6362&#x6807&#x8bb0&#xff0c&#x6807&#x8bb0&#x7528&#x4e8e&#x6279&#x91cf&#x5904&#x7406&#x6587&#x4ef6 |<br />|---------+------------------------------------------|<br />| a       | &#x5c06&#x6587&#x4ef6&#x52a0&#x5165&#x7248&#x672c&#x63a7&#x5236              |<br />|---------+------------------------------------------|<br />| i       | &#x5c06&#x6587&#x4ef6&#x52a0&#x5165ignore                    |<br />|---------+------------------------------------------|<br />| c       | &#x63d0&#x4ea4                                     |<br />|---------+------------------------------------------|<br /></p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "git-emacs &#x901a&#x8fc7git&#x7ba1&#x7406&#x4ee3&#x7801" --</p></body></html></richcontent>
</node>
</node>
</node>
<node text="Unit Test">
<node text="Mocha yas &#x6a21&#x677f">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x56e0&#x4e3a&#x6211&#x4eec&#x4e4b&#x524d&#x5b89&#x88c5&#x4e86 yasnippet &#xff0c&#x6240&#x4ee5&#x5f88&#x591a&#x6a21&#x677f&#x6211&#x4eec&#x90fd&#x53ef&#x4ee5&#x7f51&#x4e0a&#x627e&#x5f97&#x5230&#xff0c&#x4ee5&#x4e0b&#x662fmocha &#x5355&#x5143&#x6d4b&#x8bd5&#x76f8&#x5173&#x7684&#x6a21&#x677f<br />#+BEGIN_EXAMPLE<br />$git clone https://github.com/jamescarr/mochajs-snippets.git<br />$cp -r mochajs-snippets/javascript/* ~/.emacs.d/yasnippet/snippet/js2-mode<br />&#x5982&#x679c&#x5df2&#x7ecf&#x6253&#x5f00emacs &#xff08&#x91cd&#x65b0&#x6253&#x5f00&#x65f6&#x5019&#x81ea&#x52a8reload&#xff09<br />&quot;M-x yas-reload-all&quot; <br />&#x5c31&#x53ef&#x4ee5&#x4f7f&#x7528&#x5404&#x79cd&#x65ad&#x8a00&#x6a21&#x677f&#x4e86&#xff0c&#x975e&#x5e38&#x4fbf&#x5229^^<br />#+END_EXAMPLE</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "Mocha yas &#x6a21&#x677f" --</p></body></html></richcontent>
</node>
</node>
</node>
</node>
<node text="&#x603b&#x7ed3">
<node style="bubble" background_color="#eeee00">
<richcontent TYPE="NODE"><html>
<head>
<style type="text/css">
<!--
p { margin-top: 0 }
-->
</style>
</head>
<body>
<p>&#x4ee5&#x4e0a&#x6240&#x6709&#x6d89&#x53ca&#x5230&#x7684&#x6587&#x4ef6&#xff0c&#x90fd&#x53ef&#x4ee5&#x5728 https://github.com/luckyan315/site-lisp &#x8fd9&#x91cc&#x627e&#x5230&#xff0c&#x5e0c&#x671b&#x8fd9&#x4e2a&#x6587&#x7ae0&#x5bf9&#x5927&#x5bb6&#x5b66&#x4e60 node &#x6216&#x8005 emacs &#x6709&#x6240&#x5e2e&#x52a9!<br />&#x4eca&#x5929&#x5c31&#x5230&#x8fd9&#x91cc&#xff0c&#x6539&#x5929&#x7ee7&#x7eed^^ <br /></p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE"><html><head></head><body><p>-- This is more about "&#x603b&#x7ed3" --</p></body></html></richcontent>
</node>
</node>
</node>
</map>
