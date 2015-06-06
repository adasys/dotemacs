;;─────────────────────────────────────────────────────────────────────────────
;; Initialize the interface settings
;;─────────────────────────────────────────────────────────────────────────────


;; Global default settings
(setq-default
 show-trailing-whitespace 1                      ; Display trailing whitespaces
 indent-tabs-mode nil                            ; Stop using tabs to indent
 indicate-empty-lines 1)                         ; Indicate empty line (require left fringe)


;; Buffer local settings
(setq
 inhibit-startup-screen 1                        ; Remove start-up screen
 scroll-step 1                                   ; Line by line scrolling
 default-tab-width 4                             ; Set width for tabs
 x-select-enable-clipboard 1                     ; Merge both system's and Emacs' clipboard
 sgml-basic-offset 4                             ; Set indent to 4 spaces
 mouse-yank-at-point 1                           ; Yank at mouse cursor rather than click location
 ad-redefinition-action 'accept)                 ; Turn off the warnings due to functions being redefined


;; Toggle interface elements
(scroll-bar-mode -1)                             ; Remove scroll bar
(menu-bar-mode -1)                               ; Remove menu bar
(tool-bar-mode -1)                               ; Remove the toolbar
(fringe-mode '(12 . 0))                          ; Display left fringe
(line-number-mode 1)                             ; Display line number of the cursor current position
(column-number-mode 1)                           ; Display column number of the cursor current position
(display-battery-mode 1)                         ; Display battery level in the mode-line
(display-time-mode 1)                            ; Display time clock in the mode-line
(global-hl-line-mode 1)                          ; Hightlight current line
(global-whitespace-mode 0)                       ; Hightlight spaces and tabs characters


;; Goodies
(global-subword-mode 1)                          ; Iterate through CamelCase words
(mouse-avoidance-mode 'animate)                  ; Move pointer when point reaches cursor location
(set-frame-parameter nil 'fullscreen 'fullboth)  ; Pseudo fullscreen (only tested with OS X)


;;─────────────────────────────────────────────────────────────────────────────
;; Sort directories first while in dired mode
;;─────────────────────────────────────────────────────────────────────────────


(defun me/list-directories-first ()
  "Display directories first in `dired-mode'."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2)
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
    (set-buffer-modified-p nil)))


(defadvice dired-readin
  (after dired-after-updating-hook first () activate)
  (me/list-directories-first))


;;─────────────────────────────────────────────────────────────────────────────
;; Highlight hexadecimal color strings
;;─────────────────────────────────────────────────────────────────────────────


(defun me/highlight-hex-strings ()
  "Find and highlight hexadecimal color strings with a colored background."
  (interactive)
  (font-lock-add-keywords nil
   '(("#[abcdefABCDEF[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-fontify-buffer))


(add-hook 'emacs-lisp-mode-hook 'me/highlight-hex-strings)
(add-hook 'emmet-mode-hook 'me/highlight-hex-strings)
(add-hook 'python-mode-hook 'me/highlight-hex-strings)


;;─────────────────────────────────────────────────────────────────────────────
;; End of init-interface.el
;;─────────────────────────────────────────────────────────────────────────────


(provide 'init-interface)