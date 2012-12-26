;; INIT

;; server-start, use emacsclient from now on
(server-start)

;; remove promt when you kill the buffer started with emacsclient
;; http://shreevatsa.wordpress.com/2007/01/06/using-emacsclient/
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; hide welcome screen
(setq inhibit-splash-screen t)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FULLSCREEN

(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (if (equal (frame-parameter nil 'fullscreen) 'maximized) 
		 'fullboth
	   'maximized)
     ;; (when (frame-parameter nil 'fullscreen) 'maximized)
     ;; (when (not (frame-parameter nil 'fullscreen)) 'fullboth)
  ))
)

(toggle-fullscreen)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ASPECT

;; remove upper bars 
(tool-bar-mode -1)
;; you can allways C-<mouse right> to get the menus when using the GUI
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Default font size (* 10)
(set-face-attribute 'default nil :height 100)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; STATUS BAR

;; Ver la posición en la linea
(column-number-mode t)
;; Set column number mode.
(setq column-number-mode t)

;; Date and time in status bar
(setq display-time-day-and-date t
                display-time-24hr-format t)
(display-time)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MINOR MODES

;; To navigate buffers easier
(ido-mode t)

;; Saves session, more on http://www.emacswiki.org/emacs/DeskTop
(desktop-save-mode 1)

;; C-c <left> to go to previous windows config
(winner-mode 1)
;;To save and load concrete window configs in registers
;; C-x r w a writes in reg a
;; C-x r j a jumps to reg a

;; Spellchecking
(add-hook 'org-mode-hook 'flyspell-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CEDET

;; 
;; (semantic-mode 1)

;; ;; 
;; (global-ede-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CHANGED DEFAULTS

;; Tab width 4.
(setq-default tab-width 4)

;; disabling prompts emacs
;; http://www.masteringemacs.org/articles/2010/11/14/disabling-prompts-emacs/
(fset 'yes-or-no-p 'y-or-n-p)

;; To use marks the old way (shift + arrows still works as expected)
;; (transient-mark-mode nil)

;; Enable C-x C-u
(put 'upcase-region 'disabled nil)

;; Enable C-x C-l
(put 'downcase-region 'disabled nil)

;; Reopen a file when it is modified (only for doc-view and image)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(add-hook 'image-mode 'auto-revert-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BACKUP

;; To place all back-ups in one place ( /tmp/jtimon )
(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPATIBILITY

;; To integrate with clipboard (default after 24)
(setq x-select-enable-clipboard t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIRED 

;; Dired-omit to hide "uninteresting" files
;; Toggle with 'M-o'
;; http://www.emacswiki.org/emacs/DiredOmitMode
(require 'dired-x)
    (setq-default dired-omit-files-p t) ; this is buffer-local variable
    (setq dired-omit-files
          (concat dired-omit-files "\\|^\\..+$"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXTERN PROGRAMS

;; Rendering plantuml
(defun plantuml-render-buffer ()
  (interactive)
  (message "PLANTUML Start rendering")
  (shell-command (concat "java -jar ~/programas/jar/plantuml.jar " 
                         buffer-file-name))
  (message (concat "PLANTUML Rendered:  " (buffer-name))))

;; Exuberant ctags
  (setq path-to-ctags "ctags") ;; <- your ctags path here
  (defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "%s -f %s/TAGS -R %s" path-to-ctags dir-name (directory-file-name dir-name)))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE REPOS

(require 'package)

;; Repositorios para paquetes

;; official GNU Emacs package repository. This repository contains the minimal set, most or all are FSF signed. Must be Free Software as defined by FSF.
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")) 

;; ELPA (more extensive number of packages). Must be Debian definition of Free Software.
(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/packages/"))

;; Marmalade (probably most extensive number of packages)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; melpa. Another one. Seems to be as extensive as Marmalade but more well-maintained.
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXPERIMENTAL
;; EXPERIMENTAL
;; EXPERIMENTAL

;; kill shells when exit
;;(add-hook 'ess-post-run-hook 
;;	(lambda () (set-process-query-on-exit-flag 
;;		(get-ess-process ess-current-process-name) nil)) nil)

;; Another failed try
;;(setq kill-buffer-query-functions
;;  (remq 'process-kill-buffer-query-function
;;         kill-buffer-query-functions))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ORG-MODE 

;; org-mode export latex with syntax highlight
;; (require 'org-latex)
;(setq org-export-latex-listings 'minted)
;(add-to-list 'org-export-latex-packages-alist '("" "minted"))

;; Plant UML from org mode
;; #+BEGIN_UML
;;   Alice -> Bob: Authentication Request
;;   Bob --> Alice: Authentication Response
;; #+END_UML
(add-to-list 'load-path "~/.emacs.d/org-export-blocks-format-plantuml.el")
;(require 'org-export-blocks-format-plantuml)

;; CEDET

;; http://lwn.net/Articles/502119/

;; (require 'cedet)
;; (require 'semantic)
;; (require 'srecode)
;;  ;;(require 'auto-complete-config)

;; ;; ;; Turn on project management.

;; ;; (setq ede-locate-setup-options '(ede-locate-global ede-locate-locate ede-locate-base))
;; (global-ede-mode 1)
;; (global-srecode-minor-mode 1)

;; ;; ;; Kick off the semantic bovinator, function menu, C-warning mode, and flashing
;; ;; ;; brackets.

;; ;; (setq semantic-default-submodes (append semantic-default-submodes
;; ;;                                         '(global-semantic-idle-local-symbol-highlight-mode
;; ;;                                           global-semantic-idle-summary-mode
;; ;;                                           global-semantic-decoration-mode
;; ;;                                           global-semantic-highlight-func-mode
;; ;;                                           global-semantic-stickyfunc-mode
;; ;;                                           global-semantic-show-unmatched-syntax-mode
;; ;;                                           global-semantic-mru-bookmark-mode)))

;; ;; (setq semantic-decoration-styles '(("semantic-decoration-on-includes" . t)
;; ;;                                    ("semantic-decoration-on-protected-members")
;; ;;                                    ("semantic-decoration-on-private-members")))

;; (semantic-mode 1)
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)

;; ;; ;; auto-complete should use Semantic.

;; ;; ;;(ac-config-default)
;; ;; ;;(ac-set-trigger-key "TAB")

;; (defun nix-setup-auto-complete-semantic ()
;;    "Arrange to do semantic autocompletion."
;;    (add-to-list 'ac-sources 'ac-source-semantic))

;; (add-hook 'c-mode-common-hook 'nix-setup-auto-complete-semantic t)

;; ;; Yasnippet code templates
;; (yas-global-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OPEN WITH

(when (require 'openwith nil 'noerror)
  (setq openwith-associations
		(list
		 (list (openwith-make-extension-regexp
				'("mpg" "mpeg" "mp3" "mp4"
				  "avi" "wmv" "wav" "mov" "flv"
				  "ogm" "ogg" "mkv"))
			   "vlc"
			   '(file))
		 ;; (list (openwith-make-extension-regexp
		 ;;        '("xbm" "pbm" "pgm" "ppm" "pnm"
		 ;;          "png" "gif" "bmp" "tif" "jpeg" "jpg"))
		 ;;       "geeqie"
		 ;;       '(file))
		 (list (openwith-make-extension-regexp
				'("doc" "xls" "ppt" "odt" "ods" "odg" "odp"))
			   "libreoffice"
			   '(file))
		 ;; '("\\.lyx" "lyx" (file))
		 ;; '("\\.chm" "kchmviewer" (file))
		 (list (openwith-make-extension-regexp
		 		'("torrent"))
		 	   "transmission-gtk"
		 	   '(file))
		 (list (openwith-make-extension-regexp
				'("pdf" "ps" "ps.gz" "dvi"))
			   "evince"
			   '(file))
		 ))
  (openwith-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TESTING

;; open files as sudo
;; (require 'tramp)
;; (setq tramp-default-method "scp")
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; KEY MAPPINGS

(global-set-key (kbd "<escape>")      'keyboard-quit)

(global-set-key [f11] 'toggle-fullscreen)

(global-set-key (kbd "M-n") 'next-buffer)
(global-set-key (kbd "M-p") 'previous-buffer)

(global-set-key (kbd "M-<escape>") 'other-frame)
;; (global-set-key "M-<ESC>" 'other-frame)

(global-set-key "\C-ci"  'irc)

;; (define-key semantic-mode-map (kbd "C-c , .") 'semantic-ia-fast-jump)
;; (define-key semantic-mode-map [f3] 'semantic-ia-fast-jump)

;; (define-key semantic-mode-map (kbd "C-c , P") 'semantic-analyze-proto-impl-toggle)
;; (define-key semantic-mode-map (kbd "C-c , h") 'semantic-decoration-include-visit)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PERSONAL

(load-file "~/private/emacs.el")
