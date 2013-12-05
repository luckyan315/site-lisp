;;; find-file-suggest.el --- adaptive filename suggestions based on
;;; user-defined file indexes
;;   
;; Author: Christian Jauvin <cjauvin@gmail.com>
;; Created: December 2008
;; Last updated: 2010-03-02
;;
;; This extension performs filename matching against an index of files
;; living below a user-specified directory. The 'find-file-suggest'
;; function is meant to be invoked in a similar way to the 'find-file'
;; built-in function. The difference is that the current buffer will
;; be replaced by a new one in which indexed filename suggestions
;; matching the "query" (from the minibuffer) are presented.  These
;; suggestions are easily navigated with the mouse or up/down arrows,
;; and are also dynamically recomputed whenever the query minibuffer
;; changes (as the user types a longer filename, for instance).
;;
;; The system is somewhat adaptive because the suggested files are
;; sorted in decreasing order of the number of times that they've been
;; visited (in the current session), thus making the ones that are
;; used the most often percolate to the top.
;;
;; Multiple file indexes can be created, with different
;; inclusion/exclusion rules, based at different directory points, and
;; it's easy to switch between them, as needed.
;;
;; One limitation with this mechanism is that whenever a file is
;; created, the corresponding file index has to be recreated
;; (refreshed) explicitly. As for my own style of work, I find that
;; it's not a serious limitation however.
;;
;; To create a file index, only one function call is needed
;; (interactively, or in .emacs). One example would be:
;;
;; (ffs-create-file-index "project1" "/base/dir" "\\.py$\\|\\.js$" "\\.svn$")
;;
;; (or alternatively: M-x ffs-create-file index) which would create a
;; file index named "project1", over all the Python and JavaScript
;; files in /base/dir, excluding whatever is found in .svn subfolders.
;;
;; A file index for a second project could also be created:
;;
;; (ffs-create-file-index "project2" "/other/dir" "" "")
;;
;; This one would contain all the files (no inclusion/exclusion rules)
;; under /other/dir.
;;
;; To determine which file index will have the focus at the start, the
;; default-directory (at Emacs load time) is used: if it is found to
;; be a sub-directory of a given file index directory, then this file 
;; index has the focus.
;;
;; To manually switch to another file index, use the interactive
;; command with an existing file index name:
;;
;; M-x ffs-use-file-index
;;
;; To refresh a file index (if new files were created after Emacs has
;; loaded, and you want them included in the corresponding file
;; index):
;;
;; M-x ffs-refresh-file-index
;;
;; Note that this will not change the file index focus however. You
;; can also know what is the current file index with:
;;
;; M-x ffs-which-file-index
;;
;; Note that to prevent a hang that would result from the unwanted
;; creation of a file index based at the root of your drive, for
;; instance, there is a limit of 1000 files (for each index) that can
;; easily be adjusted with the ffs-max-file-index-size variable.
;;
;; I also added 'ffs-grep', a function that performs a basic grep on a
;; file index, using the same interface.  Again this is a very crude
;; and not terribly efficient function that is in no way meant to
;; replace the real grep, as it simply tries to 'match-string' your
;; query against the set of files, no more. If the index does not
;; contain too many files however this can be an acceptable and quick
;; way to check for the occurrence of a certain string, and visit the
;; retrieved files, using the same mechanism.
;;
;; Once a file index is created and has the focus, invoking the
;; 'find-file-suggest' or 'ffs-grep' functions will display a buffer
;; with filename suggestions interactively matching your minibuffer
;; query. You can navigate this buffer while still typing in the
;; minibuffer, using the up/down arrow keys, or the mouse, and
;; <return> or click to visit the highlighted file.
;;
;; To install:
;;   (1) Put find-file-suggest.el somewhere in your load-path
;;   (2) Add to your .emacs file:
;;         (require 'find-file-suggest)
;;   (3) Optionally, you can set shortcut keys, I use:
;;         (global-set-key [(control x) (meta f)] 'find-file-suggest)
;;         (global-set-key [(control x) (meta g)] 'ffs-grep)
;;   (4) Create at least one file index (interactively, or in .emacs):
;;         (ffs-create-file-index <name> <base dir> <inclusion regexp> <exclusion regexp>)
;;       This for instance would index all Python, JS and SQL source files under "/some/dir", 
;;       while excluding all .svn subfolders:
;;         (ffs-create-file-index "bla" "/some/dir/" "\\.py$\\|\\.js$\\|\\.sql$" "\\.svn")
;;         
;; Issues: This extension works best with Emacs >= 22. It works with
;;    21 as well, but for some reason the highlighting mechanism does
;;    not work properly, making it less visually pleasing.
;;
;; Acknoledgement: I would like to thank Justin Weiss: although
;;    working quite differently, the code from his
;;    fuzzy-find-in-project extension was my starting point for this
;;    project.
;;


(defvar ffs-mode nil)
(defvar ffs-initialized nil)
(defvar ffs-buffer-name "*Indexed files matching your query*")
(defvar ffs-file-indexes nil); alist of (file-index-name . (dir include-filter exclude-filter file-index))
                             ; where file-index is: alist of (file . n_visited)
(defvar ffs-current-file-index-name nil)
(defvar ffs-max-file-index-size 1000) ; max number of files per index


(defun ffs-command-hook ()
  (let ((q (buffer-substring-no-properties (minibuffer-prompt-end) (point-max)))) 
    (set-buffer ffs-buffer-name)
    (use-local-map ffs-result-buffer-keymap)
    (let ((buffer-read-only nil))
      (erase-buffer)
      (let ((found nil))
        (dolist (file-cell (ffs-get-current-file-index)) ; each file-cell is: (file . n_visited)          
          (if (string-match (concat ".*" q ".*") (car file-cell))
              (progn
                (insert (car file-cell))
                (add-text-properties (line-beginning-position) (line-end-position) '(mouse-face 'highlight))
                (insert "\n")
                (setq found t))))
        (if (not found)
          (progn
            (insert "<no match>"))
          (progn
            (goto-line 1)
            (hl-line-mode t))))
      (display-buffer ffs-buffer-name))))


(defun ffs-grep-command-hook ()
  (let ((q (buffer-substring-no-properties (minibuffer-prompt-end) (point-max)))) 
    (set-buffer ffs-buffer-name)
    (use-local-map ffs-result-buffer-keymap)
    (let ((buffer-read-only nil))
      (erase-buffer)
      (let ((found nil))
        (dolist (file-cell (ffs-get-current-file-index)) ; each file-cell is: (file . n_visited)
          (progn 
            (with-temp-buffer
              (insert-file-contents (car file-cell))
              (if (or (re-search-forward q nil t) (string= q ""))
                  (progn
                    (set-buffer ffs-buffer-name)
                    (insert (car file-cell))
                    (add-text-properties
                     (line-beginning-position) (line-end-position)
                     '(mouse-face 'highlight))
                    (insert "\n")
                    (setq found t))))))
          (if (not found)
              (progn
                (insert "<no match>"))
            (progn
              (goto-line 1)
              (hl-line-mode t))))
        (display-buffer ffs-buffer-name))))


(defun ffs-minibuffer-setup ()
  (when (eq ffs-mode t)
    (add-hook 'post-command-hook 'ffs-command-hook nil t)
    (use-local-map ffs-keymap)))

(defun ffs-grep-minibuffer-setup ()
  (when (eq ffs-mode t)
    (add-hook 'post-command-hook 'ffs-grep-command-hook nil t)
    (use-local-map ffs-keymap)))


(defun ffs-minibuffer-exit ()
  (when (eq ffs-mode t)
    (kill-buffer ffs-buffer-name)
    (setq ffs-mode nil)))


(defun ffs-initialize ()
  (if (not ffs-initialized)
      (progn
        ;; minibuffer keymap
        (setq ffs-keymap (make-sparse-keymap))
        (set-keymap-parent ffs-keymap minibuffer-local-map)
        (define-key ffs-keymap (kbd "<up>") 'ffs-up)
        (define-key ffs-keymap (kbd "<down>") 'ffs-down)
        (define-key ffs-keymap (kbd "<RET>") 'ffs-pick-file)
        (define-key ffs-keymap "\C-p" 'ffs-up)
        (define-key ffs-keymap "\C-n" 'ffs-down)

        ;; results buffer keymap
        (setq ffs-result-buffer-keymap (make-sparse-keymap))
        (define-key ffs-result-buffer-keymap (kbd "<RET>") 'ffs-pick-file)
        (define-key  ffs-result-buffer-keymap [mouse-1] 'ffs-pick-file)

        (setq ffs-initialized t))))


(defun ffs-down ()
  (interactive)
  (set-buffer ffs-buffer-name)
  (let ((buffer-read-only nil))
    (progn
      (forward-line 1)
      (set-window-point (get-buffer-window ffs-buffer-name) (point)))))


(defun ffs-up ()
  (interactive)
  (set-buffer ffs-buffer-name)
  (let ((buffer-read-only nil))
    (progn
      (forward-line -1)
      (set-window-point (get-buffer-window ffs-buffer-name) (point)))))


(defun ffs-pick-file ()
  (interactive)
  (set-buffer ffs-buffer-name)
  (setq ffs-picked-file (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
  ; increment n_visited for picked file
  (setf (cdr (assoc ffs-picked-file (ffs-get-current-file-index)))
        (1+ (cdr (assoc ffs-picked-file (ffs-get-current-file-index)))))
  ; sort file index cells (which is a list of (file . n_visited) cells) 
  ; by decreasing order of n_visited
  ; (*) note: we can't use setf on (ffs-get-current-file-index), so we have to reexpress it as (nth 3 ...)
  (setf (nth 3 (cdr (assoc ffs-current-file-index-name ffs-file-indexes)))
        (sort (ffs-get-current-file-index) '(lambda (a b)
                                              (>= (cdr a) (cdr b)))))
  (exit-minibuffer))

  
(defun ffs-index-files-below-directory (dir include-filter exclude-filter)
  (let (file-index
        (cur-dir-list (directory-files-and-attributes dir t)))
    (while cur-dir-list
       ; if is directory
       (if (eq t (car (cdr (car cur-dir-list))))
           (if (or (equal "." (substring (car (car cur-dir-list)) -1)) 
                   (and (not (string= exclude-filter "")) 
                        (string-match exclude-filter (car (car cur-dir-list))))
                   (> ffs-size-of-file-index-being-built ffs-max-file-index-size))
               () ; dont go if "." or ".." or match exclude filter or exceeds max file index size
             ; else descend
             (if (or (not (string-match exclude-filter (car (car cur-dir-list)))) (string= exclude-filter ""))
                 (setq file-index (append (ffs-index-files-below-directory (car (car cur-dir-list)) include-filter exclude-filter) file-index))))            
         ; else if is regular file, index it if it passes the include/exclude tests and nb of files is <= max file index size
         (if (and (or (string-match include-filter (car (car cur-dir-list))) (string= include-filter ""))
                  (or (not (string-match exclude-filter (car (car cur-dir-list)))) (string= exclude-filter ""))
                  (< ffs-size-of-file-index-being-built ffs-max-file-index-size))
             (progn 
               (setq file-index (cons (cons (car (car cur-dir-list)) 0) file-index))
               (setq ffs-size-of-file-index-being-built (1+ ffs-size-of-file-index-being-built))))) ; push file-cell: (file . n_visited=0)       
      (setq cur-dir-list (cdr cur-dir-list)))
    file-index))


(defun ffs-get-current-file-index ()
  (car (last (cdr (assoc ffs-current-file-index-name ffs-file-indexes)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; interactive functions ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun find-file-suggest ()
  (interactive)
  (if (not (ffs-get-current-file-index))
      (message "Warning: there is no current file index in use (you can set one with M-x ffs-use-file-index, after having created it with M-x ffs-create-file-index)"))
  (if (ffs-get-current-file-index)
      (progn
        (setq ffs-mode t)
        (switch-to-buffer (get-buffer-create ffs-buffer-name))
        (setq ffs-picked-file "")
        (ffs-initialize)
        (remove-hook 'minibuffer-setup-hook 'ffs-grep-minibuffer-setup)
        (add-hook 'minibuffer-setup-hook 'ffs-minibuffer-setup)
        (add-hook 'minibuffer-exit-hook 'ffs-minibuffer-exit) 
        (read-string (format "Find indexed file (%s): " ffs-current-file-index-name))
        ;; this is executed after the minibuffer is exited (user hit <ret> or clicked a file)
        (if (not (or (string= ffs-picked-file "") (string= ffs-picked-file "<no match>")))
            (find-file ffs-picked-file)))))


(defun ffs-grep () 
  (interactive)
  (if (not (ffs-get-current-file-index))
      (message "Warning: there is no current file index in use (you can set one with M-x ffs-use-file-index, after having created it with M-x ffs-create-file-index)"))
  (if (ffs-get-current-file-index)
      (progn
        (setq ffs-mode t)
        (switch-to-buffer (get-buffer-create ffs-buffer-name))
        (setq ffs-picked-file "")
        (ffs-initialize)
        (remove-hook 'minibuffer-setup-hook 'ffs-minibuffer-setup)
        (add-hook 'minibuffer-setup-hook 'ffs-grep-minibuffer-setup)
        (add-hook 'minibuffer-exit-hook 'ffs-minibuffer-exit) 
        (read-string (format "FFS-grep (%s): " ffs-current-file-index-name))
        ;; this is executed after the minibuffer is exited (user hit <ret> or clicked a file)
        (if (not (or (string= ffs-picked-file "") (string= ffs-picked-file "<no match>")))
            (find-file ffs-picked-file)))))


(defun ffs-create-file-index (name dir include-filter exclude-filter)
  (interactive "sName of file index: \nDBase directory: \nsInclude filter (regexp, or nothing to include all): \nsExclude filter (regexp, or nothing for no exclusion): ")
  (setq ffs-size-of-file-index-being-built 0) ; reset this value so that ffs-index-files-below-directory can use it
  (let ((file-index (ffs-index-files-below-directory dir include-filter exclude-filter)))
    (setq ffs-file-indexes 
          (cons (cons name (list dir include-filter exclude-filter file-index)) ffs-file-indexes)))
  (message "File index '%s': %d files %s" name ffs-size-of-file-index-being-built
           (if (>= ffs-size-of-file-index-being-built ffs-max-file-index-size) "(limit reached)" ""))
  ;; If the current directory is under this particular file index's directory, we set it as the default one
  (if (string-match (downcase (expand-file-name dir)) (downcase (expand-file-name default-directory)))
      (progn 
        (message "Setting file index '%s' as default" name)
        (ffs-use-file-index name))))


(defun ffs-use-file-index (name)
  (interactive "sName of file index: ")
  (if (not (assoc name ffs-file-indexes))
      (message "Warning: no such file index exists (%s)" name)
    (progn 
      (setq ffs-current-file-index-name name)
      (message "Now using file index '%s'" name))))


(defun ffs-refresh-file-index ()
  (interactive)
  (let ((name (read-string "Name of file index: " ffs-current-file-index-name)))
    (if (not (assoc name ffs-file-indexes))
        (message "Warning: no such file index exists (%s)" name)
      (progn 
        (setq ffs-size-of-file-index-being-built 0)
        ; see (*) above
        (setf (nth 3 (cdr (assoc name ffs-file-indexes))) ; file index
              (ffs-index-files-below-directory (nth 0 (cdr (assoc name ffs-file-indexes))) ; dir
                                               (nth 1 (cdr (assoc name ffs-file-indexes))) ; inc. regexp
                                               (nth 2 (cdr (assoc name ffs-file-indexes))))) ; exc. regexp
        (message "File index '%s': %d files %s" name (length (nth 3 (cdr (assoc name ffs-file-indexes)))) 
                 (if (>= ffs-size-of-file-index-being-built ffs-max-file-index-size) "(limit reached)" ""))))))


(defun ffs-which-file-index ()
  (interactive)
  (if ffs-current-file-index-name
      (message "Current file index is '%s'" ffs-current-file-index-name)
      (message "Warning: there is no current file index in use (you can set one with M-x ffs-use-file-index, after having created it with M-x ffs-create-file-index)")))


(provide 'find-file-suggest)
