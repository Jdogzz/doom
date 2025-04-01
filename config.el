;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "flakeuser"
      user-mail-address "jerzor@pacbell.net")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-monokai-pro)
;;(setq doom-theme 'doom-one-light)
;;(setq doom-theme 'doom-molokai)

(use-package! base16-stylix-theme)
(require 'base16-stylix-theme)
(setq doom-theme 'base16-stylix)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/generalsync/actions/")
(setq org-roam-directory "~/generalsync")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (use-package! company
;;   :requires (company-bibtex company-jedi)
;;   :config
;;   ;;(global-company-mode)
;;   ;;(setq company-minimum-prefix-length 2)
;;   (setq company-idle-delay 0.25)
;;   (add-to-list 'company-backends 'company-bibtex)
;;   ;;(add-to-list 'company-backends 'company-capf)
;;   (add-to-list 'company-backends 'company-jedi)
;;   )

;; Set the biblatex dialect so org-bibtex works with biblatex.
(require 'bibtex)
(bibtex-set-dialect 'biblatex nil)

(use-package! nov
  :defer-incrementally t
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  )

(use-package! org-edna
  :after org
  :config
  (org-edna-mode)
  )

(after! org
  (add-to-list 'org-structure-template-alist
               '("sl" . "src elisp"))
  (add-to-list 'org-structure-template-alist
               '("sp" . "src python"))
  (add-to-list 'org-structure-template-alist
               '("sh" . "src shell"))
  (add-to-list 'org-modules 'org-id)
  (setq org-link-file-path-type 'relative)
  ;;(setq org-agenda-todo-ignore-scheduled 'future)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  ;;(setq org-agenda-sorting-strategy '(tag-down priority-down))
  (setq org-log-done 'time)
  (setq org-link-search-must-match-exact-headline nil)

  (setq org-capture-templates `(
                                ;; ("i" "Inbox" entry  (file "~/generalsync/inbox/inbox.org")
                                ;;  ,(concat "* %?\n"
                                ;;           "/Entered on/ %U"))
                                ("a" "Action" entry  (file "~/generalsync/actions/actions.org")
                                 ,(concat "* NEXT %?\n"
                                          "/Entered on/ %U")
                                 :jump-to-captured t
                                 )
                                ;; ;;("n" "Note" entry  (file "~/gtd/gtddocs/inbox.org")
                                ;; ;; ,(concat "* Note (%a)\n"
                                ;; ;;          "/Entered on/ %U\n" "\n" "%?"))
                                ;; ("t" "Trigger" entry (file+headline "~/gtd/gtddocs/calendar.org" "Actions")
                                ;;  ,(concat "* NEXT Trigger %?\n"
                                ;;           "/Entered on/ %U")
                                ;;  )
                                ;; ("w" "Waiting" entry (file+headline "~/gtd/gtddocs/calendar.org" "Actions")
                                ;;  ,(concat "* WAITING %?\n"
                                ;;           "/Entered on/ %U")
                                ;;  )
                                ))

  (setq org-refile-allow-creating-parent-nodes 'confirm)
  ;; (setq org-refile-targets '(("~/gtd/gtddocs/projects.org" :maxlevel . 2)
  ;;                            ("~/gtd/gtddocs/calendar.org" :maxlevel . 2)
  ;;                            ("~/gtd/gtddocs/nextactions.org" :level . 1)
  ;;                            ("~/gtd/gtddocs/someday-maybe.org" :maxlevel . 2)
  ;;                            ("~/gtd/gtddocs/agendas.org" :maxlevel . 2)
  ;;                            ("~/gtd/gtddocs/dailyroutine.org" :maxlevel . 1)
  ;;                            ))

  (setq org-src-fontify-natively t)
  (setq org-babel-tangle-use-relative-file-links t)
                                        ;(setq org-cite-global-bibliography '("~/gtd/general-reference/My Library.bib"))

  (require 'org-attach)
  (setq org-attach-store-link-p 'attached)

  ;; (setq ps-print-color-p nil)
  (setq org-agenda-custom-commands
        '(
          ;;         ;; ("G" "GTD Block Agenda"
          ;;         ;;  ((tags-todo "-morningroutine-eveningroutine/!-WAITING-TODO"))
          ;;         ;;  ((org-agenda-sorting-strategy '(tag-up))
          ;;         ;;   (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled)))
          ;;         ;;  )
          ;;         ;; ("XG" "PDF export of GTD Block Agenda"
          ;;         ;;  ((tags-todo "-morningroutine-eveningroutine/!-WAITING-TODO"))
          ;;         ;;  ((org-agenda-sorting-strategy '(tag-up))
          ;;         ;;   (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))
          ;;         ;;   (org-agenda-with-colors nil)
          ;;         ;;   )
          ;;         ;;  ("~/pdfexportofgtd/next-actions.txt") ;; exports block to this file with C-c a e
          ;;         ;;  )
          ;;         ("n" "Next actions anywhere"
          ;;          ((tags-todo "anywhere/!-WAITING-TODO"))
          ;;          (            (org-agenda-todo-ignore-scheduled 'future)
          ;;                       (org-agenda-tags-todo-honor-ignore-options t)
          ;;                       (org-agenda-overriding-header "")
          ;;                       (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/nextactions-anywhere.org"))
          ;;         ("c" "Next actions calls"
          ;;          ((tags-todo "calls/!-WAITING-TODO"))
          ;;          (            (org-agenda-todo-ignore-scheduled 'future)
          ;;                       (org-agenda-tags-todo-honor-ignore-options t)
          ;;                       (org-agenda-overriding-header "")
          ;;                       (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/nextactions-calls.org"))
          ;;         ("o" "Next actions computer"
          ;;          ((tags-todo "computer/!-WAITING-TODO"))
          ;;          (            (org-agenda-todo-ignore-scheduled 'future)
          ;;                       (org-agenda-tags-todo-honor-ignore-options t)
          ;;                       (org-agenda-overriding-header "")
          ;;                       (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/nextactions-computer.org"))
          ;;         ("p" "Next actions computer physics"
          ;;          ((tags-todo "computerphysics/!-WAITING-TODO"))
          ;;          (            (org-agenda-todo-ignore-scheduled 'future)
          ;;                       (org-agenda-tags-todo-honor-ignore-options t)
          ;;                       (org-agenda-overriding-header "")
          ;;                       (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/nextactions-computerphysics.org"))
          ;;         ("e" "Next actions emails"
          ;;          ((tags-todo "emails/!-WAITING-TODO"))
          ;;          (            (org-agenda-todo-ignore-scheduled 'future)
          ;;                       (org-agenda-tags-todo-honor-ignore-options t)
          ;;                       (org-agenda-overriding-header "")
          ;;                       (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/nextactions-emails.org"))
          ;;         ("r" "Next actions errands"
          ;;          ((tags-todo "errands/!-WAITING-TODO"))
          ;;          (            (org-agenda-todo-ignore-scheduled 'future)
          ;;                       (org-agenda-tags-todo-honor-ignore-options t)
          ;;                       (org-agenda-overriding-header "")
          ;;                       (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/nextactions-errands.org"))
          ;;         ("h" "Next actions home"
          ;;          ((tags-todo "home/!-WAITING-TODO"))
          ;;          (            (org-agenda-todo-ignore-scheduled 'future)
          ;;                       (org-agenda-tags-todo-honor-ignore-options t)
          ;;                       (org-agenda-overriding-header "")
          ;;                       (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/nextactions-home.org"))
          ;;         ("m" "Next actions letters"
          ;;          ((tags-todo "letters/!-WAITING-TODO"))
          ;;          (            (org-agenda-todo-ignore-scheduled 'future)
          ;;                       (org-agenda-tags-todo-honor-ignore-options t)
          ;;                       (org-agenda-overriding-header "")
          ;;                       (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/nextactions-letters.org"))
          ;;         ("b" "Next actions mastercontrol"
          ;;          ((tags-todo "service/!-WAITING-TODO"))
          ;;          (            (org-agenda-todo-ignore-scheduled 'future)
          ;;                       (org-agenda-tags-todo-honor-ignore-options t)
          ;;                       (org-agenda-overriding-header "")
          ;;                       (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/nextactions-mastercontrol.org"))
          ;;         ("s" "Next actions service"
          ;;          ((tags-todo "service/!-WAITING-TODO"))
          ;;          (            (org-agenda-todo-ignore-scheduled 'future)
          ;;                       (org-agenda-tags-todo-honor-ignore-options t)
          ;;                       (org-agenda-overriding-header "")
          ;;                       (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/nextactions-service.org"))
          ;;         ("t" "Next actions texts"
          ;;          ((tags-todo "texts/!-WAITING-TODO"))
          ;;          (            (org-agenda-todo-ignore-scheduled 'future)
          ;;                       (org-agenda-tags-todo-honor-ignore-options t)
          ;;                       (org-agenda-overriding-header "")
          ;;                       (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/nextactions-texts.org"))
          ;;         ("k" "Next actions work"
          ;;          ((tags-todo "work/!-WAITING-TODO"))
          ;;          ((org-agenda-todo-ignore-scheduled 'future)
          ;;           (org-agenda-tags-todo-honor-ignore-options t)
          ;;           (org-agenda-overriding-header "")
          ;;           (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/nextactions-work.org"))
          ;;         ("w" "Waiting" todo "WAITING"
          ;;          (            (org-agenda-overriding-header "")
          ;;                       (org-agenda-sorting-strategy '(deadline-up)))
          ;;          ("~/pdfexportofgtd/waiting.org"))
          ;;         ("y" agenda "Year of agenda with events"
          ;;          ((org-agenda-ndays-to-span 7)
          ;;           (org-agenda-span 'year)
          ;;           (org-agenda-with-colors nil)
          ;;           (org-agenda-prefix-format "  %?-12t% s"))
          ;;          ("~/pdfexportofgtd/agenda.pdf"))
          ("b" "aabs"
           ((agenda ""))
           (
            (org-agenda-category-filter-preset '("+aabs"))
            (org-agenda-span 'year)
            (org-agenda-with-colors nil)
            (org-agenda-use-time-grid nil)
            (org-agenda-prefix-format "  %?-12t% s")
            (org-agenda-write-buffer-name "AABS-Schedule")
            (ps-left-header (list 'org-agenda-write-buffer-name))
            (ps-print-color-p 'black-white)
            )
           ("~/generalsync/inbox/Public/AABS-Schedule.pdf"))
          ("s" "ascw"
           ((agenda ""))
           (
            (org-agenda-category-filter-preset '("+ascw"))
            (org-agenda-span 'year)
            (org-agenda-with-colors nil)
            (org-agenda-use-time-grid nil)
            (org-agenda-prefix-format "  %?-12t% s")
            (org-agenda-write-buffer-name "ASCW-Schedule")
            (ps-left-header (list 'org-agenda-write-buffer-name))
            (ps-print-color-p 'black-white)
            )
           ("~/generalsync/inbox/Public/ASCW-Schedule.pdf"))
          ("m" "mdcw"
           ((agenda ""))
           (
            (org-agenda-category-filter-preset '("+mdcw"))
            (org-agenda-span 'year)
            (org-agenda-with-colors nil)
            (org-agenda-use-time-grid nil)
            (org-agenda-prefix-format "  %?-12t% s")
            (org-agenda-write-buffer-name "MDCW-Schedule")
            (ps-left-header (list 'org-agenda-write-buffer-name))
            (ps-print-color-p 'black-white)
            )
           ("~/generalsync/inbox/Public/MDCW-Schedule.pdf"))

          )
        )

  (setq org-publish-project-alist
        '(
          ("mygtddocsdirect"
           :base-directory "~/gtd/gtddocs/"
           :base-extension "org"
           :publishing-directory "~/pdfexportofgtd/"
           :publishing-function org-latex-publish-to-pdf
           :exclude "calendar.org\\|nextactions.org"
           :with-planning t
           :with-toc nil
           )
          ("mygtddocsagenda"
           :base-directory "~/pdfexportofgtd/"
           :base-extension "org"
           :publishing-directory "~/pdfexportofgtd/"
           :publishing-function org-latex-publish-to-pdf
           :with-planning t
           :with-toc nil
           )
          ("thegtdexport" :components ("mygtddocsdirect" "mygtddocsagenda"))
          ))

  (setq org-attach-id-dir "./data/")
  (setq org-attach-dir-relative t)

  (require 'org-checklist)

  ;;(setq org-roam-database-connector 'sqlite-builtin)
  (setq org-roam-file-extensions '("org"))

  (setq org-roam-capture-templates
        '(
          ("i" "inbox" plain "%?"
           :target (file+head "inbox/%<%Y%m%d%H%M%S>-${slug}.org"
                	      "#+title: ${title}\n\n")
           :unnarrowed t)
          ;; ("p" "project" plain "%?"
          ;;  :target (file+head "actions/%<%Y%m%d%H%M%S>-${slug}.org"
          ;;       	      "#+title: ${title}\n#+filetags: :project:\n\n")
          ;;  :unnarrowed t
          ;;  :jump-to-captured t)
          ;; ("P" "project instant" plain "%?"
          ;;  :target (file+head "actions/%<%Y%m%d%H%M%S>-${slug}.org"
          ;;       	      "#+title: ${title}\n#+filetags: :project:\n\n")
          ;;  :immediate-finish t
          ;;  :unnarrowed t)
          ;; ("r" "reference note" plain "%?"
          ;;  :target (file+head "reference/reference-note/%<%Y%m%d%H%M%S>-${slug}.org"
          ;;       	      "#+title: ${title}\n#+filetags: :reference:reference-note:\n\n")
          ;;  :unnarrowed t)
          ;; ("R" "reference instant" plain "%?"
          ;;  :target (file+head "reference/reference-note/%<%Y%m%d%H%M%S>-${slug}.org"
          ;;       	      "#+title: ${title}\n#+filetags: :reference:reference-note:\n\n")
          ;;  :immediate-finish t
          ;;  :unnarrowed t)
          ;; ("b" "bib pdf reference" plain "%?"
          ;;  :if-new
          ;;  (file+head "reference/%<%Y%m%d%H%M%S>-${slug}.org" ":PROPERTIES:\n:NOTER_DOCUMENT: ${file}\n:END:\n#+title: ${title}\n#+filetags: :reference:\n")
          ;;  :immediate-finish t
          ;;  :unnarrowed t)
          ;; ("n" "unbound reference" plain "%?"
          ;;  :if-new
          ;;  (file+head "reference/%<%Y%m%d%H%M%S>-${slug}.org"
          ;;             "#+title: ${title}\n#+filetags: :reference:\n")
          ;;  :unnarrowed t)
          ("r" "reference note" plain "%?"
           :target (file+head "reference/reference-note/%<%Y%m%d%H%M%S>-${citar-citekey}.org"
                              "#+title: Notes on ${title} (${citar-date})\n#+filetags: :reference:reference-note:\n\n")
           :unnarrowed t)
          ("k" "knowledge note" plain "%?"
           :target (file+head "reference/knowledge-note/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+filetags: :reference:knowledge-note:\n\n")
           :unnarrowed t)
          ("I" "knowledge note index" plain "%?"
           :target (file+head "reference/knowledge-note/index/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+filetags: :reference:knowledge-note-index:\n\n")
           :unnarrowed t)
          ("s" "someday-maybe" plain "%?"
           :target (file+head "someday-maybe/%<%Y%m%d%H%M%S>-${slug}.org"
        		      "#+title: ${title}\n#+filetags: :someday-maybe:\n\n")
           :unnarrowed t)
          ("S" "someday-maybe instant" plain "%?"
           :target (file+head "someday-maybe/%<%Y%m%d%H%M%S>-${slug}.org"
        		      "#+title: ${title}\n#+filetags: :someday-maybe:\n\n")
           :immediate-finish t
           :unnarrowed t)
          ;; ("I" "index" plain "%?"
          ;;  :target (file+head "index/$%<%Y%m%d%H%M%S>-{slug}.org"
          ;;       	      "#+title: ${title}\n#+filetages: :index:\n\n")
          ;;  :immediate-finish t
          ;;  :unnarrowed t)
          ;; ("m" "meeting" plain "%?"
          ;;  :target (file+head "meeting/%<%Y%m%d%H%M%S>-${slug}.org"
          ;;       	      "#+title: ${title}\n#+filetags: :meeting:\n")
          ;;  :unnarrowed t)
          ("p" "person" plain "%?"
           :target (file+head "reference/person/%<%Y%m%d%H%M%S>-${slug}.org"
                	      "#+title: ${title}\n#+filetags: :reference:\n\n")
           :unnarrowed t)
          ("P" "person instant" plain "%?"
           :target (file+head "reference/person/%<%Y%m%d%H%M%S>-${slug}.org"
                	      "#+title: ${title}\n#+filetags: :reference:\n\n")
           :immediate-finish t
           :unnarrowed t)
          ;; ("c" "communication" plain "%?"
          ;;  :target (file+head "communication/%<%Y%m%d%H%M%S>-${slug}.org"
          ;;       	      "#+title: ${title}\n#+filetags: :communication:\n")
          ;;  :unnarrowed t)
          ;; ("a" "animal" plain "%?"
          ;;  :target (file+head "animal/%<%Y%m%d%H%M%S>-${slug}.org"
          ;;       	      "#+title: ${title}\n#+filetags: :animal:\n")
          ;;  :unnarrowed t)
          ;; ("A" "animal instant" plain "%?"
          ;;  :target (file+head "animal/%<%Y%m%d%H%M%S>-${slug}.org"
          ;;       	      "#+title: ${title}\n#+filetags: :animal:\n")
          ;;  :immediate-finish t
          ;;  :unnarrowed t)
          ))

  ;; (setq org-roam-dailies-directory "daily/")

  ;; (setq org-roam-dailies-capture-templates
  ;;       '(("d" "default" entry
  ;;          "* %?"
  ;;          :target (file+head "%<%Y-%m-%d>.org"
  ;;       		      "#+title: %<%Y-%m-%d>\n"))))

  ;; (setq org-roam-mode-sections
  ;;       (list #'org-roam-backlinks-section
  ;;             #'org-roam-reflinks-section
  ;;             #'org-roam-unlinked-references-section
  ;;             ))

  ;; (setq +org-roam-auto-backlinks-buffer t)
  ;; (setq org-roam-node-display-template
  ;;       (concat "${title:*} "
  ;;       	(propertize "${tags:100}" 'face 'org-tag)))

  ;;   ;; for org-roam-buffer-toggle
  (add-to-list 'display-buffer-alist
               '(("\\*org-roam\\*"
        	  (display-buffer-in-direction)
        	  (direction . right)
        	  (window-width . 0.33)
        	  (window-height . fit-window-to-buffer))))

  (define-key org-roam-mode-map [mouse-1] #'org-roam-buffer-visit-thing)
  ;;(add-hook 'org-roam-mode-hook #'olivetti-mode)
  (setq org-roam-completion-ignore-case t)
  (put 'org-roam-directory 'safe-local-variable #'stringp)
  (put 'org-roam-db-location 'safe-local-variable #'stringp)

  (setf org-roam-mode-sections '(org-roam-backlinks-section
                                 org-roam-reflinks-section
                                 org-roam-unlinked-references-section))

  (setq citar-bibliography '("~/generalsync/reference/bibfiles/My Library.bib" "~/generalsync/reference/bibfiles/My books.bib"))
  ;;(setq citar-library-file-extensions nil)
  ;;(setq citar-notes-paths '("~/generalsync/reference/reference-note/"))
  ;;(setq citar-file-note-extensions '("org"))

  (setq citar-file-parser-functions
        '(citar-file--parser-default
          citar-file--parser-triplet))

  (setq citar-org-roam-capture-template-key "r")

  (setq org-export-allow-bind-keywords t)

  (require 'ox-koma-letter)

  ;;(setq org-contacts-files '("~/orgroam/general-reference/contacts.org"))

  (setq org-roam-timestamps-parent-file t)
  (org-roam-timestamps-mode)
  )


;;(use-package! orderless
;;  :after vertico
;;  :custom
;;  (completion-styles '(orderless))
;;  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package! zetteldesk
  :config
  (zetteldesk-mode 1)
  )

(require 'calc)
(require 'ob-calc)

;; (defun my-gtd-export ()
;;   (interactive)
;;   (org-batch-store-agenda-views)
;;   (org-publish-project "thegtdexport")
;;   ;;(shell-command-to-string "~/gitrepos/gtdexportscripts/gtdconvert.sh")
;;   (shell-command-to-string "~/gitrepos/gtdexportscripts/gtdupload.sh")
;;   ;;(org-caldav-sync)
;;   )

;;(use-package! conda
;;  :config
;;  (conda-env-initialize-eshell)
;;  )

;; This makes sure undo won't clear out large amounts of changes when doing lengthy edits.
(setq evil-want-fine-undo t)

(require 'openwith)
(openwith-mode t)
(setq openwith-associations '(("\\.mp4\\'" "vlc" (file))))
(setq openwith-associations '(("\\.webm\\'" "vlc" (file))))

(dirvish-peek-mode)
(dirvish-side-follow-mode)

;;(set-frame-parameter nil 'alpha-background 80)
;;(add-to-list 'default-frame-alist '(alpha-background . 80))

(after! mu4e
  (setq sendmail-program (executable-find "msmtp")
	send-mail-function #'smtpmail-send-it
	message-sendmail-f-is-evil t
	message-sendmail-extra-arguments '("--read-envelope-from")
	message-send-mail-function #'message-send-mail-with-sendmail
        mu4e-attachment-dir "~/generalsync/inbox/")
  (add-to-list 'mu4e-bookmarks
               '( :name  "Emails to process"
                  :query "NOT (maildir:/trash OR maildir:/comcast/Trash OR maildir:/pacbell/Trash OR maildir:/outlook/Deleted OR maildir:/finances OR maildir:/rss/.fun OR maildir:/rss/.geek)"
                  :key   ?e)
               )
  (add-to-list 'mu4e-bookmarks
               '( :name  "RSS to process"
                  :query "flag:unread AND (maildir:/rss/.fun OR maildir:/rss/.geek)"
                  :key   ?r)
               )
  )

;; (require 'julia-formatter)
;; (add-hook 'julia-mode-hook #'julia-formatter-mode)
;;
;;
;;
;;
;;
;;
;; ("c" "Contacts" entry (file "~/Org/contacts.org")
;;          "* %(org-contacts-template-name)
;; :PROPERTIES:
;; :EMAIL: %(org-contacts-template-email)
;; :END:")))
;;
;; You can also use a complex template, for example:
;;
;;         ("c" "Contacts" entry (file "~/Org/contacts.org")
;;          "* %(org-contacts-template-name)
;; :PROPERTIES:
;; :EMAIL: %(org-contacts-template-email)
;; :PHONE:
;; :ALIAS:
;; :NICKNAME:
;; :IGNORE:
;; :ICON:
;; :NOTE:
;; :ADDRESS:
;; :BIRTHDAY:
;; :END:")))
