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
    )
  )
)

(toggle-fullscreen)
(global-set-key [f11] 'toggle-fullscreen)

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

;; Color code parts on org-mode
(setq org-src-fontify-natively t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BACKUP

;; To place all back-ups in one place ( /tmp/jtimon ) ("c:/DOCUME~1/jtimon/CONFIG~1/Temp/" )
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

;; SQL PLUS

;; (add-to-list 'load-path "C:/Documents and Settings/jtimon/Datos de programa/.emacs.d/")
;; (load "plsql.el")