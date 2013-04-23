;;An's emacs 

;;disable toolbar
(tool-bar-mode nil)

;;show line number
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(require 'linum)
(global-linum-mode 1)

;; 防止页面滚动时跳动,scroll-margin 3可以在靠近屏幕边沿3行时就开始滚动,可以很好的看到上下文
(setq scroll-margin 3
      scroll-conservatively 10000)

;;### Scroll mode line### 
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(require 'scroll-mode-line-mode)

;;load yasnippet
(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(require 'yasnippet) 
(yas-global-mode 1)

;;svn support
(require 'psvn)

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(require 'cr-js)

;;json mode, hotkey: "C-c C-f"---> beautify-json
(require 'json-mode)

;; ;;js2-highlight vars
(require 'js2-highlight-vars)
(if (featurep 'js2-highlight-vars)
    (js2-highlight-vars-mode))

;;rhtml mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/rhtml/")
(require 'rhtml-mode)

;;set the color-theme-blackboard
(load-file "~/.emacs.d/site-lisp/color-theme.el")
(require 'color-theme)
(load-file "~/.emacs.d/site-lisp/color-theme-blackboard.el")
(color-theme-blackboard)

;;comment/ uncomment
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)

;; Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode js-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end))
                 (message "Copied line")
                 (list (line-beginning-position)
                       (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point)
                  (line-end-position))
  ;; (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(global-set-key (kbd "M-k") 'qiang-copy-line)


;;不显示GNU emacs启动界面
(setq inhibit-startup-message t) 

;; 尽快显示按键序列
(setq echo-keystrokes 0.1)

;; 显示列号
(setq column-number-mode t)

;; 不要总是没完没了的问yes or no, 为什么不能用y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; 防止页面滚动时跳动,scroll-margin 3可以在靠近屏幕边沿3行时就开始滚动,可以很好的看到上下文
(setq scroll-margin 3
      scroll-conservatively 10000)

;;### Scroll mode line### 
(load-file "~/.emacs.d/site-lisp/scroll-mode-line-mode.el")
(scroll-mode-line-mode 1)


;;load xcscope
(load-file "~/.emacs.d/site-lisp/xcscope.el")
(require 'xcscope) 

;;ctrl + scroll , implement zoom in/out
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

;;highlight the word
(load-file "~/.emacs.d/site-lisp/highlight-symbol.el")
(require 'highlight-symbol)                                                   
;;(global-set-key "/C-cgg" 'highlight-symbol-at-point)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-prev)





;;load cedet 
(load-file "~/.emacs.d/site-lisp/cedet-1.0.1/common/cedet.el")

(setq semanticdb-project-roots
      (list
       (expand-file-name "/")))

(setq qt4-base-dir "/usr/include/qt4")
(semantic-add-system-include qt4-base-dir 'c++-mode)
(add-to-list 'auto-mode-alist (cons qt4-base-dir 'c++-mode))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig-dist.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qglobal.h"))


(defun my-indent-or-complete ()
  (interactive)
  (if(looking-at "\\>")
      (hippie-expand nil)
    (indent-for-tab-command)
    )
  )

(global-set-key [(control tab)] 'my-indent-or-complete)

(autoload 'senator-try-expand-semantic "senator")

(setq hippie-expand-try-functions-list
      '(
        senator-try-expand-semantic
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-list
        try-expand-list-all-buffers
        try-expand-line
        try-expand-line-all-buffers
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-whole-kill
        )
      )

(global-set-key [(f5)] 'speedbar)





;; Enabling Semantic (code-parsing, smart completion) features

;; Select one of the following:
(semantic-load-enable-minimum-features)

;;(semantic-load-enable-code-helpers)

;;(semantic-load-enable-gaudy-code-helpers)

(semantic-load-enable-excessive-code-helpers)

;;(semantic-load-enable-semantic-debugging-helpers)



;;;; 使函数体能够折叠或展开

;; Enable source code folding

(global-semantic-tag-folding-mode 1)

(defun my-cedet-hook ()

  (local-set-key [(control return)] 'semantic-ia-complete-symbol)

  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)

  (local-set-key "\C-c>" 'semantic-complete-analize-inline)

  (local-set-key "\C-cp" 'semantic-analize-protdo-impl-toggle))

(add-hook 'c-mode-common-hook 'my-cedet-hook)



;;;; 当输入"."或">"时，在另一个窗口中列出结构体或类的成员

(defun my-c-mode-cedet-hook ()

  (local-set-key "." 'semantic-complete-self-insert)

  (local-set-key ">" 'semantic-complete-self-insert))

(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)


(add-to-list 'magic-mode-alist'("#include" . c++-mode))
(add-to-list 'magic-mode-alist'("#ifndef" . c++-mode))


;;install ecb 
;; (add-to-list 'load-path "/home/luckyan315/.emacs.d/site-lisp/ecb-2.40")
;; (require 'ecb)

;;;auto start ecb 
;; (setq ecb-auto-activate t
;; ecb-tip-of-the-day nil)
;;;; 各窗口间切换

(global-set-key [M-left] 'windmove-left)

(global-set-key [M-right] 'windmove-right)

(global-set-key [M-up] 'windmove-up)

(global-set-key [M-down] 'windmove-down)



;;;; 隐藏和显示ecb窗口

(define-key global-map [(control f1)] 'ecb-hide-ecb-windows)

(define-key global-map [(control f2)] 'ecb-show-ecb-windows)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;set auto-complete
(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete-1.3.1/")
					; Load the default configuration
(require 'auto-complete-config)
					; Make sure we can find the dictionaries
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/auto-complete-1.3.1/dict")
					; Use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
					; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
					; case sensitivity is important when finding matches
(setq ac-ignore-case nil)

;;js2-mode
;; (autoload 'js2-mode "js2-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))



;;在buffer和shell之间快速切换需要加载shell-toggle.el
(autoload 'shell-toggle "shell-toggle"
  "Toggles between the *shell* buffer and whatever buffer you are editing." t)
(autoload 'shell-toggle-cd "shell-toggle"
  "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)
(global-set-key [C-f9] 'shell-toggle-cd)

;;在buffer和shell之间快速切换END
;;不产生备份文件,临时文件
(setq make-backup-files nil)
(setq-default make-backup-files nil) 


;; set the smooth-scroll
(add-to-list 'load-path "~/.emacs.d/site-lisp/smooth-scroll/")
(require 'smooth-scroll)
;; (smooth-scroll-mode t)

(global-set-key [(control  down)]  'scroll-up-1)
(global-set-key [(control  up)]    'scroll-down-1)
;; (global-set-key [(control  left)]  'scroll-right-1)
;; (global-set-key [(control  right)] 'scroll-left-1)
(global-set-key (kbd "M-n") 'scroll-up-1)
(global-set-key (kbd "M-p") 'scroll-down-1)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)


;;;; CC-mode配置  http://cc-mode.sourceforge.net/
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)

;;;;我的C/C++语言编辑策略

(defun my-c-mode-common-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  ;;; hungry-delete and auto-newline
  (c-toggle-auto-hungry-state 1)
  ;;按键定义
  (define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
  (define-key c-mode-base-map [(return)] 'newline-and-indent)
  (define-key c-mode-base-map [(f7)] 'compile)
  (define-key c-mode-base-map [(meta \`)] 'c-indent-command)
  ;;  (define-key c-mode-base-map [(tab)] 'hippie-expand)
  (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
  (define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)
  ;;预处理设置
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")
  (setq c-macro-cppflags " ")
  (setq c-macro-prompt-flag t)
  (setq hs-minor-mode t)
  (setq abbrev-mode t)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;;;我的C++语言编辑策略
(defun my-c++-mode-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  (c-set-style "stroustrup")
  ;;  (define-key c++-mode-map [f3] 'replace-regexp)
  )

;; 实现全屏效果，快捷键为f11
(global-set-key [f11] 'my-maximized)
(global-set-key [f12] 'my-fullscreen)
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
  )
;; 最大化
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  )




(defun reload-conf-file ()

  "reload your .emacs file without restarting Emacs"

  (interactive)

  (load-file "~/.emacs") )

;; set c-mode indentation style
(setq c-default-style "linux"
      c-basic-offset 4)