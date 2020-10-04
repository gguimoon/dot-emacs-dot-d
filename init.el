;; Lisp 모듈 저장 경로 추가
(add-to-list 'load-path "~/.emacs.d/lisp/")
;; Package cl is deprecated 경고 표시 제거
(setq byte-compile-warnings '(cl-functions))

;; Unicad helps Emacs to guess the correct coding system when opening a file.
;; https://www.emacswiki.org/emacs/Unicad
(require 'unicad)

;; 패키지 매니저 활성화
;; 아카이브 사이트에서 패키지 목록을 수동으로 받아오는 작업 필요
;; M-x package-refresh-contents RET
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
  (load-theme 'nord t)
  :delight)

;; Spacemacs 테마 패키지 사용
(use-package ewal-spacemacs-themes
  :disabled
  :ensure t
  :config
  (load-theme 'spacemacs-dark t)
  :delight)

;; Ivy, Counsel and Swiper 패키지 사용
;; 파일 오픈이나 버퍼 변경시 fuzzy find 구현해 줌
;; https://writequit.org/denver-emacs/presentations/2017-04-11-ivy.html
(use-package counsel
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy)))
  (setq ivy-height 16)
  (ivy-mode 1)
  )

;; 프레임 영역 기본 글꼴로 D2Coding 12pt 사용
(set-frame-font "D2Coding-12" nil t)

;; Emacs Customizer UI 사용한 설정 결과 custom.el 저장
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Emacs 내장 한글입력기 사용
;; OS 한영 키와 Emacs 한영 키를 다르게 운영
(setq default-input-method "korean-hangul")
(global-set-key (kbd "S-SPC") 'toggle-input-method)
