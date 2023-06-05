;; mlscript-mode.el -- a poorly written mlscript mode

(defvar mls-types
  '("int" "bool" "string" "Array"))

(defvar mls-keywords
  '("let" "fun"
    "class" "trait" "mixin" "extends"
    "if" "then" "else" "and"))

(defvar mls-font-lock-defaults
  `((
     ;; double quote
     ("\"\\.\\*\\?" . font-lock-string-face)
     ;; special : , ; =
     (":\\|,\\|;\\|=" . font-lock-keyword-face)
     ;; keywords
     ( ,(regexp-opt mls-keywords 'words) . font-lock-builtin-face)
     ;; types
     ( ,(regexp-opt mls-types 'words) . font-lock-type-face)
     ;; operator + - * / & | ~ ^
     ("+\\|-\\|*\\|/\\|&\\||\\|~\\|^" . font-lock-constant-face)
     )))

(defvar mls-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?/ ". 124b" st)
    (modify-syntax-entry ?* ". 23" st)
    ;; newline and formfeed end comments
    (modify-syntax-entry ?\n "> b" st)
    (modify-syntax-entry ?\f "> b" st)
    ;; '
    (modify-syntax-entry ?' "w" st)
    st))

(defvar mlscript-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "(") (lambda () (interactive) (insert "()") (backward-char)))
    (define-key map (kbd "[") (lambda () (interactive) (insert "[]") (backward-char)))
    (define-key map (kbd "{") (lambda () (interactive) (insert "{}") (backward-char)))
    (define-key map (kbd "\"") (lambda () (interactive) (insert "\"\"") (backward-char)))
    map)
  "Keymap for mlscript mode")

(define-derived-mode mlscript-mode fundamental-mode "mlscript"
  "mlscript mode for editing mlscript file"
  (set-syntax-table mls-syntax-table)
  (setq-local font-lock-defaults mls-font-lock-defaults)
  (setq-local comment-start "// ")
  (display-line-numbers-mode)
  )

(provide 'mlscript-mode)
(add-to-list 'auto-mode-alist '("\\.mls$" . mlscript-mode))
