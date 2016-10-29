;;; toggle-source.el --- Toggle between source and implementation files.

;; Copyright (C) 2000 by Free Software Foundation, Inc.

;; Author: Steve Kemp <skx@tardis.ed.ac.uk>
;; Keywords: tools

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;   This is a piece of simple code that will toggle between source
;;  and header files.
;;
;;   There is also a function for loading a file on the systems include
;; path - this probably shouldn't be included, but it almost makes sense
;; to have the C/C++ programmers file handling pieces of code together.
;;

;;;  Usage:

;;   Insert into your .emacs file the following line, (and eval it for
;;  immediate usage:
;;
;;   (require 'toggle-source)
;;
;;   Optionally byte compile this file, and change the default
;;  keybinding.
;;   By default the main function, `toggle-source' is bound to C-t
;;  which will clobber the transpose character function.
;;


;;; History:
;; 
;;   The latest version of this file should be available from
;;  
;;   http://www.gnusoftware.com/Emacs/Lisp/

;;   0.1 :  Initial version.
;;   0.2 :  Added `toggle-source-load-include-file'
;;   0.3 :  Documentation fixups.


;;; Code:

(defvar toggle-source::version "0.3"
  "The version of `toggle-source'.")


(defvar toggle-source::mappings
  (list
   (cons ".hh" ".cc")
   (cons ".h" ".c")
   )
  "The file extensions that we toggle between.
If the current buffer contains a file that has an extension
in this list then we attempt to open the file with the
'other' extension.
(This only works in the current directory).")


(defun toggle-source ()
  "Toggle between source, and header files, and vice versa.
This is a handy function that allows you to toggle between pairs
of files that are both in the same directory.
The toggling is based upon the file extension, and by default
this is setup in to make it simple to toggle between header
and implementation files for C++ developers.

For example if you are currently editting a buffer containing
the contents of \"file.cpp\" running `toggle-source' would
take you to the buffer \"file.h\" - assuming this file existed."
  (interactive)
  (let ((filename (buffer-file-name))
	(list nil)
	(entry nil)
	(found nil))
    (setq list toggle-source::mappings)
    (while (and list (not found) filename)
      (setq entry (car list))
      (setq list  (cdr list))
      (if (string-match (concat (regexp-quote (car entry)) "$") filename)
	  (setq found (cdr entry)))
      (if (string-match (concat (regexp-quote (cdr entry)) "$") filename)
	  (setq found (car entry))))
    (if found
	(toggle-source::load (substring filename 0 (match-beginning 0)) found)
      )))


(defun toggle-source::load( file desiredExt )
  "Load the file that has the desired extension."
  (interactive)
  (setq file (concat file desiredExt))
  (if (file-exists-p file)
      (find-file file)))


(defun toggle-source-load-include-file ( FILE  )
  "Load the file FILE from the system include path.
The system include path is assumed to be stored
in the environmental variable INCLUDE.
 This function is handy for developers using C/C++,
and is included for completeness."
  (interactive "sSystem include filename : ")
  (let ((includedirs
	 ;; Different OS's use different ENV. seperators.
	 (if (eq 'windows-nt system-type)
	     (split-string (getenv "INCLUDE") ";")
	   (split-string (getenv "INCLUDE") ":")))
	(dir nil)
	(finished nil))
    (while (and includedirs
		(not finished))
      (setq dir (car includedirs))
      (setq includedirs (cdr includedirs))
      (if (not (file-exists-p (concat dir "/" FILE )))
	  ()
	(find-file (concat dir "/" FILE ))
	(setq finished t)))
    ))


; (global-set-key 'f4 'toggle-source)

(provide 'toggle-source)
;;; toggle-source.el ends here
