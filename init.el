;; Google related
;; (require 'google)
;; (require 'google-imports)
;; (require 'google-pyformat)
;; (require 'google-ycmd)

;; Enable the MELPA repo (https://melpa.org/#/getting-started).
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Esc-q to auto format at 80th column.
(setq-default fill-column 80)

;; Open shell in the current buffer.
(add-to-list 'display-buffer-alist
             '("^\\*shell\\*" . (display-buffer-same-window)))

;; NVIDIA cu file highlighting.
(add-to-list 'auto-mode-alist '("\.cu$" . c++-mode))
(add-to-list 'auto-mode-alist '("\.cu_inl$" . c++-mode))

;; Add Julia support.
(require 'julia-mode)

;; Python format
;; (require 'google-diformat)
;;(add-hook  'python-mode-hook
;;  (lambda ()
;;    (unless (eq major-mode 'google3-build-mode)
;;      (add-hook 'before-save-hook 'google-diformat--pyformat-changed nil t))))
;;(add-hook 'python-mode-hook
;;  (lambda ()  
;;  (unless (eq major-mode 'google3-build-mode)
;;      (add-hook 'before-save-hook 'google-pyformat nil t))))

;; Java format
;; (require 'google-java-format)
;; (global-set-key [C-M-tab] #'google-java-format-region)
;; (add-hook 'java-mode-hook
;;     #'(lambda ()
;;         (add-hook 'before-save-hook #'google-java-format-buffer nil t)))

;; JavaScript
;; adds symbols included by google closure to js2-additional-externs
(add-hook 'js2-post-parse-callbacks
	  (lambda ()
	    (let ((buf (buffer-string))
		  (index 0))
	      (while (string-match "\\(goog\\.require\\|goog\\.provide\\)('\\([^'.]*\\)" buf index)
		(setq index (+ 1 (match-end 0)))
		(add-to-list 'js2-additional-externs (match-string 2 buf))))))

;; google-lint
;; (require 'google-cc-extras)
;; (google-cc-extras/bind-default-keys)
;; (add-hook 'c-mode-common-hook (function (lambda () (local-set-key (kbd "\C-cl") 'google-clang-format))))

(global-set-key [M-down]    'next-error)
(global-set-key [M-up]      '(lambda () (interactive) (next-error -1)))


;; Remove auto-indent.
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; Disable auto-save
(setq make-backup-files nil)

;; Window swap
(defun swap-windows ()         ; Stephen Gildea
  "*Swap the positions of this window and the next one."
  (interactive)
  (let ((other-window (next-window (selected-window) 'no-minibuf)))
    (let ((other-window-buffer (window-buffer other-window))
          (other-window-hscroll (window-hscroll other-window))
          (other-window-point (window-point other-window))
          (other-window-start (window-start other-window)))
      (set-window-buffer other-window (current-buffer))
      (set-window-hscroll other-window (window-hscroll (selected-window)))
      (set-window-point other-window (point))
      (set-window-start other-window (window-start (selected-window)))
      (set-window-buffer (selected-window) other-window-buffer)
      (set-window-hscroll (selected-window) other-window-hscroll)
      (set-window-point (selected-window) other-window-point)
      (set-window-start (selected-window) other-window-start))
    (select-window other-window)))


;; keymap.el
;; ALL Key Mappings

(global-set-key "\C-c\C-s" 'dirs)
(global-set-key "\C-c\C-p" 'ps-print-buffer)
(global-set-key "\C-x\C-b" 'electric-buffer-list) ;;; Fancy select buffer menu
(global-set-key "\C-x\C-z" 'shell )
(global-set-key "\M-\r" 'gid)
(global-set-key "\C-xt" 'toggle-read-only)

;;(global-set-key "\C-z" 'undo) ;; conflicts with sending a process to background
;;(global-set-key "\C-f" 'scroll-up)
;;(global-set-key "\C-b" 'scroll-down)

(menu-bar-mode -1)
(global-set-key "\M-p" 'splogo)
(global-set-key "\C-c." 'goto-matching-paren-or-insert)
(define-key global-map "\C-cw" 'copy-region-as-kill)
(define-key global-map "\eg" 'goto-line)
(define-key global-map "\C-xf" 'find-file-at-point)
;(global-set-key [C-`] 'full-file-name)

; I need all this on emacs with terminal mode and tmux/osx
;(global-set-key "\e[5C"    'forward-word)
;(global-set-key "\e[5D"    'backward-word)
;(global-set-key "\e[31~" 'beginning-of-buffer)
;(global-set-key "\e[29~" 'end-of-buffer)

;;(if (and window-system)
;;    (progn 
;;      (define-key global-map [C-home]    'beginning-of-buffer)
;;      (define-key global-map [C-end]     'end-of-buffer)

;;      (define-key global-map [mouse-4]  'scroll-down)
;;      (define-key global-map [mouse-5]  'scroll-up)

;;      (define-key global-map [home]   'beginning-of-line)
;;      (define-key global-map [end]    'end-of-line)
;;    )
;;)


;; Shellx
;;(global-set-key "\ez" 'ashell)

;; To rename a buffer
(global-set-key "\er" 'rename-buffer)


;; In a non-window'ed emacs (emacs -nw)
;; I want the backspace key to produce backward 
;; delete effect. I don't care about the delete
;; key because I don't use it that often.
;; This has an indirect effect of ctrl-h not working 
;; as expected to be a help keymap. That's OK because
;; I have F1.

;;(when (not window-system) 
;;  (setq key-translation-map (make-sparse-keymap)) 
;;  (define-key key-translation-map "\177" "\C-h") 
;;  (define-key key-translation-map "\C-h" "\177") 
;;  (defvar BACKSPACE "\177") 
;;  (defvar DELETE    "\C-h") 
;;  (global-set-key BACKSPACE 'backward-delete-char) 
(setq split-width-threshold 1)  ; vertical split by default

  ;; for non-windowed terminals, how do I get c-home
  ;; and c-end etc. to work? Well, here's how:
  ;; Note that just this won't help. We need to setup
  ;; some funky xmodmap stuff and then start the xterm.
  ;; So, may be I will start the emacs session in a funky
  ;; xterm that passes the keys pressed as desired to emacs

;;  (global-unset-key "\C-t")

;;  (define-key global-map (kbd "C-t CPh") 'beginning-of-buffer)
;;  (define-key global-map (kbd "C-t CPe") 'end-of-buffer)
;;)


;; Delete selection mode
;; http://www.emacswiki.org/emacs/DeleteSelectionMode
(delete-selection-mode 1)


;; Insert 2 spaces for a tab
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tab-stop-list (number-sequence 2 200 2))
(setq indent-line-function 'insert-tab)

(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 2)
        (setq python-indent-offset 2)))

;; Window movement keys
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)


;; http://kb.mit.edu/confluence/display/istcontrib/How+to+get+the+Arrow+keys+to+work+in+Emacs
(if (not window-system)                ;; Only use in tty-sessions.
     (progn
      (defvar arrow-keys-map (make-sparse-keymap) "Keymap for arrow keys")
      (define-key esc-map "[" arrow-keys-map)
      (define-key arrow-keys-map "A" 'previous-line-mark)
      (define-key arrow-keys-map "B" 'next-line-mark)
      (define-key arrow-keys-map "C" 'forward-char-mark)
      (define-key arrow-keys-map "D" 'backward-char-mark)))


;; Interactively Do Things
;; -----------------------
;; I've finally started using ido-mode for more efficient file finding and
;; buffer switching.  This is based on bits from Emacswiki that extend it
;; to most other places that take input from the minibuffer.
;;
(require 'ido)
(if (fboundp 'ido-mode)
    (progn
      (ido-mode t)
      (defadvice completing-read
        (around foo activate)
        (if (boundp 'ido-cur-list)
            ad-do-it
          (setq ad-return-value
                (ido-completing-read
                 prompt
                 (all-completions "" collection predicate)
                 nil require-match initial-input hist def))))
      (define-key global-map [(meta ?x)]
        (lambda ()
          (interactive)
          (call-interactively
           (intern
            (ido-completing-read "M-x " (all-completions "" obarray 'commandp))))))))

;; paraenthese matching
;; www.gnu.org/software/emacs/manual/html_mono/faq.html#Matching-parentheses
(global-set-key "%" 'match-paren)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))


;; font size (in 1/10)
(set-face-attribute 'default nil :height 140)


;; Show column number highlighting
(column-number-mode 1)


;;; nlinum.el --- Show line numbers in the margin  -*- lexical-binding: t -*-

;; Copyright (C) 2012  Free Software Foundation, Inc.

;; Author: Stefan Monnier <monnier@iro.umontreal.ca>
;; Keywords: convenience
;; Version: 1.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This is like linum-mode, but uses jit-lock to be (hopefully)
;; more efficient.

;;; Code:

(require 'linum)                        ;For its face.

(defvar nlinum--width 2)
(make-variable-buffer-local 'nlinum--width)

;; (defvar nlinum--desc "")

;;;###autoload
(define-minor-mode nlinum-mode
  "Toggle display of line numbers in the left margin (Linum mode).
With a prefix argument ARG, enable Linum mode if ARG is positive,
and disable it otherwise.  If called from Lisp, enable the mode
if ARG is omitted or nil.

Linum mode is a buffer-local minor mode."
  :lighter nil ;; (" NLinum" nlinum--desc)
  (jit-lock-unregister #'nlinum--region)
  (remove-hook 'window-configuration-change-hook #'nlinum--setup-window t)
  (remove-hook 'after-change-functions #'nlinum--after-change)
  (kill-local-variable 'nlinum--line-number-cache)
  (remove-overlays (point-min) (point-max) 'nlinum t)
  ;; (kill-local-variable 'nlinum--ol-counter)
  (kill-local-variable 'nlinum--width)
  (when nlinum-mode
    (add-hook 'window-configuration-change-hook #'nlinum--setup-window nil t)
    (add-hook 'after-change-functions #'nlinum--after-change nil t)
    (jit-lock-register #'nlinum--region t))
  (nlinum--setup-windows))

(defun nlinum--setup-window ()
  (set-window-margins nil (if nlinum-mode nlinum--width)
                      (cdr (window-margins))))

(defun nlinum--setup-windows ()
  (dolist (win (get-buffer-window-list nil nil t))
    (with-selected-window win (nlinum--setup-window))))

(defun nlinum--new-width ()
  (nlinum--setup-windows)
  ;; (kill-local-variable 'nlinum--ol-counter)
  (remove-overlays (point-min) (point-max) 'nlinum t)
  (run-with-timer 0 nil
                  (lambda (buf)
                    (with-current-buffer buf
                      (with-silent-modifications
                        (remove-text-properties
                         (point-min) (point-max) '(fontified)))))
                  (current-buffer)))

;; (defun nlinum--ol-count ()
;;   (let ((i 0))
;;     (dolist (ol (overlays-in (point-min) (point-max)))
;;       (when (overlay-get ol 'nlinum) (incf i)))
;;     i))

;; (defvar nlinum--ol-counter 100)
;; (make-variable-buffer-local 'nlinum--ol-counter)

;; (defun nlinum--flush-overlays (buffer)
;;   (with-current-buffer buffer
;;     (kill-local-variable 'nlinum--ol-counter)
;;     ;; We've created many overlays in this buffer, which can slow
;;     ;; down operations significantly.  Let's flush them.
;;     ;; An easy way to flush them is
;;     ;;   (remove-overlays min max 'nlinum t)
;;     ;;   (put-text-property min max 'fontified nil)
;;     ;; but if the visible part of the buffer requires more than
;;     ;; nlinum-overlay-threshold overlays, then we'll inf-loop.
;;     ;; So let's be more careful about removing overlays.
;;     (let ((windows (get-buffer-window-list nil nil t))
;;           (start (point-min))
;;           (debug-count (nlinum--ol-count)))
;;       (with-silent-modifications
;;         (while (< start (point-max))
;;           (let ((end (point-max)))
;;             (dolist (window windows)
;;               (cond
;;                ((< start (1- (window-start window)))
;;                 (setq end (min (1- (window-start window)) end)))
;;                ((< start (1+ (window-end window)))
;;                 (setq start (1+ (window-end window))))))
;;             (when (< start end)
;;               (remove-overlays start end 'nlinum t)
;;               ;; Warn jit-lock that this part of the buffer is not done any
;;               ;; more.  This has the downside that font-lock will be re-applied
;;               ;; as well.  But jit-lock doesn't know how to (and doesn't want
;;               ;; to) keep track of the status of its various
;;               ;; clients independently.
;;               (put-text-property start end 'fontified nil)
;;               (setq start (+ end 1))))))
;;       (let ((debug-new-count (nlinum--ol-count)))
;;         (message "Flushed %d overlays, %d remaining"
;;                  (- debug-count debug-new-count) debug-new-count)))))


(defvar nlinum--line-number-cache nil)
(make-variable-buffer-local 'nlinum--line-number-cache)

(defun nlinum--after-change (&rest _args)
  (setq nlinum--line-number-cache nil))

(defun nlinum--line-number-at-pos ()
  "Like `line-number-at-pos' but sped up with a cache."
  ;; (assert (bolp))
  (let ((pos
         (if (and nlinum--line-number-cache
                  (> (- (point) (point-min))
                     (abs (- (point) (car nlinum--line-number-cache)))))
             (funcall (if (> (point) (car nlinum--line-number-cache))
                          #'+ #'-)
                      (cdr nlinum--line-number-cache)
                      (count-lines (point) (car nlinum--line-number-cache)))
           (line-number-at-pos))))
    ;;(assert (= pos (line-number-at-pos)))
    (setq nlinum--line-number-cache (cons (point) pos))
    pos))

(defun nlinum--region (start limit)
  (save-excursion
    ;; Text may contain those nasty intangible properties, but
    ;; that shouldn't prevent us from counting those lines.
    (let ((inhibit-point-motion-hooks t))
      (goto-char start)
      (unless (bolp) (forward-line 1))
      (remove-overlays (point) limit 'nlinum t)
      (let ((line (nlinum--line-number-at-pos))
            (fmt (format "%%%dd" nlinum--width)))
        (while
            (and (not (eobp)) (< (point) limit)
                 (let* ((ol (make-overlay (point) (1+ (point))))
                        (str (format fmt line))
                        (width (string-width str)))
                   (when (< nlinum--width width)
                     (setq nlinum--width width)
                     (nlinum--new-width))
                   (overlay-put ol 'nlinum t)
                   (overlay-put ol 'evaporate t)
                   (overlay-put ol 'before-string
                                (propertize " " 'display
                                            `((margin left-margin)
                                              ,(propertize str
                                                           'face 'linum))))
                   ;; (setq nlinum--ol-counter (1- nlinum--ol-counter))
                   ;; (when (= nlinum--ol-counter 0)
                   ;;   (run-with-idle-timer 0.5 nil #'nlinum--flush-overlays
                   ;;                        (current-buffer)))
                   (setq line (1+ line))
                   (zerop (forward-line 1))))))))
  ;; (setq nlinum--desc (format "-%d" (nlinum--ol-count)))
  nil)

;;;; ChangeLog:

;; 2012-10-24  Stefan Monnier  <monnier@iro.umontreal.ca>
;; 
;; * nlinum.el: Speed up by caching last line-number.
;; (nlinum--line-number-cache): New var.
;; (nlinum--after-change, nlinum--line-number-at-pos): New functions.
;; (nlinum-mode, nlinum--region): Use them.
;; 
;; 2012-06-08  Stefan Monnier  <monnier@iro.umontreal.ca>
;; 
;; Add nlinum.el
;; 

(provide 'nlinum)
;;; nlinum.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(julia-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
