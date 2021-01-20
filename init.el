;; Lisp 모듈 저장 경로 추가
(add-to-list 'load-path "~/.emacs.d/lisp/")
;; Package cl is deprecated 경고 표시 제거
(setq byte-compile-warnings '(cl-functions))

;; Unicad helps Emacs to guess the correct coding system when opening a file.
;; https://www.emacswiki.org/emacs/Unicad
(require 'unicad)

;; Do not use 'init.el' for 'custom-*' code, use 'custom.el' instead
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Emacs 내장 한글입력기 사용
;; OS 한영 키와 Emacs 한영 키를 다르게 운영
(setq default-input-method "korean-hangul")
(global-set-key (kbd "S-SPC") 'toggle-input-method)

;; Org-mode 키 바인딩 등록
;; https://orgmode.org/manual/Activation.html#Activation
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)

;; 패키지 매니저 활성화
;; 아카이브 사이트에서 패키지 목록을 수동으로 받아오는 작업 필요
;; M-x package-refresh-contents RET
;; 패키지 업그레이드
;; M-x package-refresh-contents RET
;; M-x list-packages RET
;; Hit 'U' to mark available upgrades
;; Then 'x' to upgrade
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

;; 패키지 이용하기 전에 설치 작업 필요
;; M-x package-install RET use-package RET
;; use-package 선언적인 패키지 관리를 위한 패키지
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; Nord 테마 패키지 사용
;; https://www.nordtheme.com/ports/emacs
(use-package nord-theme
  :ensure t
  :config
  (load-theme 'nord t))

;; Spacemacs 테마 패키지 사용
(use-package ewal-spacemacs-themes
  :disabled
  :ensure t
  :config
  (load-theme 'spacemacs-dark t))

;; Ivy, Counsel and Swiper 패키지 사용
;; 파일 오픈이나 버퍼 변경시 fuzzy find 구현해 줌
;; https://writequit.org/denver-emacs/presentations/2017-04-11-ivy.html
(use-package counsel
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  (setq ivy-height 16)
  (ivy-mode 1))

;; Recentf 패키지 사용
(use-package recentf
  :ensure t
  :config
  (setq recentf-auto-cleanup 'never
        recentf-max-saved-items 50
        recentf-save-file (concat user-emacs-directory "recentf"))
  (recentf-mode t))

;; Magit 패키지 사용
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

;; Which key 패키지 사용
;; It displays available key bindings in popup.
;; Waiting after a prefix key will show the contents of the corresponding keymap.
;; M-x which-key-show-major mode may also be helpful.
(use-package which-key
  :ensure t
  :config
  (setq which-key-lighter "")
  (setq which-key-idle-delay 1.0)
  (which-key-mode 1))

;; Org 패키지 사용
(use-package org
  :ensure t
  :init
  ;; Org-mode hook 등록
  (add-hook 'org-mode-hook #'toggle-word-wrap)
  (add-hook 'org-mode-hook #'toggle-truncate-lines)
  (add-hook 'org-mode-hook #'display-line-numbers-mode)
  (add-hook 'org-mode-hook #'org-indent-mode)

  ;; Org-habit module 활성화
  (with-eval-after-load 'org
    (add-to-list 'org-modules 'org-habit t))

  :config
  ;; Show clocked items for the day in the agenda
  (setq org-agenda-start-with-log-mode t)
  ;; Log a time stamp when tasks completed
  (setq org-log-done 'time)
  ;; Insert state change notes and time stamps into a drawer
  (setq org-log-into-drawer t)
  ;; Force UTF-8
  (setq org-export-coding-system 'utf-8)
  ;; Set a default target file for captures
  (setq org-directory "~/Repos/orgnotes")
  (setq org-default-notes-file (concat org-directory "/Capture.org"))
  ;; Do not create a capture bookmark
  (setq org-capture-bookmark nil)
  ;; Configure org-capture templates
  (setq org-capture-templates
    '(("t" "Todo list item"
       entry (file+headline org-default-notes-file "Tasks")
       "* TODO %?\n %i\n %a" :empty-lines 1)
      ("j" "Journal entry"
       entry (file+olp+datetree "~/Repos/orgnotes/Journal.org")
       (file "~/.emacs.d/org-templates/journal.orgcaptmpl.txt") :empty-lines 1)
     )
  )
)
