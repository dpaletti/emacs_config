(setq doom-theme 'doom-solarized-light)
(setq doom-font (font-spec :family "Input Mono" :size 16 :weight 'light))
(setq doom-variable-pitch-font (font-spec :family "Input Sans" :weight 'light :size 14))
(setq doom-big-font (font-spec :family "Input Sans" :weight 'light))
(setq doom-symbol-font (font-spec :family "Input Typically, the objective of a design organization is the Sans" :weight 'light))
(setq doom-serif-font (font-spec :family "Input Serif" :weight 'light))
(setq-default line-spacing 0.2)
(setq display-line-numbers-type t)
(setq fancy-splash-image "~/.config/doom/org.png")

;; Support for mermaid diagrams
(setq ob-mermaid-cli-path "/usr/bin/mmdc")

;; Tool versioning
(use-package! mise
  :config
  (global-mise-mode 1))

(after! flycheck
  ;; Prose linting with vale and markdownlint
  (flycheck-define-checker vale
    "A checker for prose"
    :command ("vale" "--output" "line"
              source)
    :standard-input nil
    :error-patterns
    ((error line-start (file-name) ":" line ":" column ":" (id (one-or-more (not (any ":")))) ":" (message) line-end))
    :modes (markdown-mode org-mode text-mode gfm-mode)
    )
  (add-to-list 'flycheck-checkers 'vale)
  (flycheck-add-next-checker 'vale 'markdown-markdownlint-cli2))


(after! org
  (setq org-directory "~/org/")

  ;; Extra babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((mermaid . t)))
  (setq org-agenda-files '("~/git/soil-moisture-sensor/org/tasks.org"))

  ;; Latex settings
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-agenda-sorting-strategy '(category-keep))

  ;; Task settings
  (setq org-log-done 'time)

  ;; Group tasks by outline
  (org-super-agenda-mode t)
  (setq org-super-agenda-groups
        '((:ancestor-with-todo ("PROJ")))))
