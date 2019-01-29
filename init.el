;;; package --- Summary
;;; Commentary:
;;; Code:
(add-to-list 'load-path "~/.emacs.d/lisp")
;; Color Theme カラーテーマ 
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/themes")
;; (add-to-list 'load-path "~/.emacs.d/themes/tomorrow")
;; (setq custom-theme-directory "~/.emacs.d/themes/tomorrow")
;; (load-theme 'tomorrow-night-bright t)

(add-to-list 'load-path "~/.emacs.d/themes/gruvbox")
(setq custom-theme-directory "~/.emacs.d/themes/gruvbox")
(load-theme 'gruvbox-dark-hard t)


(require 'platform-p)
;;; カッコのハイライト
(show-paren-mode t)

;; 言語を日本語にする
(set-language-environment 'Japanese)
;; 極力UTF-8とする
(prefer-coding-system 'utf-8)

;; フォントをRicty 15ptに設定
;; 同様のフォント設定があればコメントアウトしておくべき
(add-to-list 'default-frame-alist '(font . "ricty-15"))

;; ユーザー名とメールアドレスの設定 
(setq user-full-name "Ryodo Tanaka"
user-mail-address "GRoadPG@gmail.com")

;; 背景を透明にする(透明度合いは 95/100)
(set-frame-parameter nil 'alpha 95)

;;; 色分けの設定
;; (global-font-lock-mode t)
;; (if (>= emacs-major-version 21)
;;   (setq font-lock-support-mode 'jit-lock-mode)   ; Just-In-Timeな文字装飾方式
;;   (setq font-lock-support-mode 'lazy-lock-mode)  ; Emacs20以前では古い方式
;; )

;;; 行番号の表示
;;;(line-number-mode t)
(require 'linum)
(global-linum-mode t)
(setq linum-format " %d ")

;バッファ自動再読み込み
(global-auto-revert-mode 1)


;;フレーム設定
(size-indication-mode t) ; ファイルサイズを表示
(setq frame-title-format "%f") ; タイトルに編集中ファイルのフルパスを表示

;; バッファの終わりでのnewlineを禁止する
(setq next-line-add-newlines nil)
;;常に最終行に一行追加する(自動的に)
(setq require-final-newline t)


;;ファイルが #! から始まる場合， +x (実行権限) を付けて保存する
(add-hook 'after-save-hook
	  'executable-make-buffer-file-executable-if-script-p)

;; スペース、タブなどを可視化する
(global-whitespace-mode 1)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)

;;; 列番号の表示
;;;(column-number-mode t)
;;key-bind setting

;; ;;一定間隔でバッファを自動保存する.
(when (require 'auto-save-buffers nil t)
  (run-with-idle-timer 2.0 t 'auto-save-buffers))

;; Window 移動
(global-set-key (kbd "M-<left>")  'windmove-left)
(global-set-key (kbd "M-<down>")  'windmove-down)
(global-set-key (kbd "M-<up>")    'windmove-up)
(global-set-key (kbd "M-<right>") 'windmove-right)
(keyboard-translate ?\C-h ?\C-?); C-hをバックスペースに変更

;;; スクロール時のカーソル位置の維持
(setq scroll-preserve-screen-position t)

;;; スクロール行数（一行ごとのスクロール）
(setq vertical-centering-font-regexp ".*")
(setq scroll-conservatively 35)
(setq scroll-margin 0)
(setq scroll-step 1)

;;; 画面スクロール時の重複行数
(setq next-screen-context-lines 1)

;;; 起動メッセージの非表示
(setq inhibit-startup-message t)

;;; スタートアップ時のエコー領域メッセージの非表示
(setq inhibit-startup-echo-area-message -1)

;;; @ backup

;;; 変更ファイルのバックアップ
(setq make-backup-files nil)

;;; 変更ファイルの番号つきバックアップ
(setq version-control nil)

;;; 編集中ファイルのバックアップ
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)

;;; 編集中ファイルのバックアップ先
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;; 編集中ファイルのバックアップ間隔（秒）
(setq auto-save-timeout 30)

;;; 編集中ファイルのバックアップ間隔（打鍵）
(setq auto-save-interval 500)

;;;バックアップ世代数
(setq kept-old-versions 1)
(setq kept-new-versions 2)

;;; 上書き時の警告表示
(setq trim-versions-without-asking nil)

;;; 古いバックアップファイルの削除
(setq delete-old-versions t)

(require 'cedet)


;;; Arduino Mode
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)
; 拡張子の関連付け
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))

;;; .launch, .xacro, .urdf, .config, .sdf, .world を xml-mode で読み込む
(add-to-list 'auto-mode-alist '("\\.launch\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.xacro\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.urdf\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.config\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.sdf\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.world\\'" . xml-mode))

;;; yaml Mode
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

;;; C++ style
(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (setq indent-tabs-mode nil)     ;; インデントは空白文字で行う（TABコードを空白に変換）
	     (setq tab-width 4)
             (c-set-offset 'innamespace 0)   ;;;namespace {}の中はインデントしない
             (c-set-offset 'arglist-close 0) ;;;関数の引数リストの閉じ括弧はインデントしない
             )
	  (semantic-mode 1)
      )

;;; smooth-scroll
(require 'smooth-scroll)
(smooth-scroll-mode t)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;;; one line at at time
(setq mouse-wheel-progressive-speed nil) ;;; dont accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;;; scroll window under mouse
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (gruvbox-theme yaml-mode web-mode vimish-fold sublime-themes smartparens scss-mode sass-mode rust-mode pdf-tools multi-term matlab-mode markdown-mode magit-gitflow gnuplot-mode gitignore-mode flycheck-pos-tip elscreen counsel company cmake-mode avy-migemo avy-menu avy-flycheck autothemer arduino-mode 0blayout)))
 '(show-paren-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(tool-bar-position (quote bottom)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ricty" :foundry "unknown" :slant normal :weight normal :height 128 :width normal)))))

;;;YaTexの設定
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode)  auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq load-path (cons (expand-file-name "~/.emacs.d/site-lisp/yatex") load-path))
(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-kanji-code nil)
(setq YaTeX-latex-message-code 'utf-8)

(setq tex-command "latexmk -pvc")  ;;保存したら自動で再コンパイル
;; (setq tex-command "latexmk")
(setq dvi2-command "evince")
(setq bibtex-command "pbibtex")     ; BibTeX のコマンド

(when platform-linux-p ; for GNU/Linux
;;; inverse search
  (require 'dbus)
  
  (defun un-urlify (fname-or-url)
	"A trivial function that replaces a prefix of file:/// with just /."
	(if (string= (substring fname-or-url 0 8) "file:///")
		(substring fname-or-url 7)
	  fname-or-url))
  
  (defun evince-inverse-search (file linecol &rest ignored)
	(let* ((fname (un-urlify file))
		   (buf (find-file fname))
		   (line (car linecol))
		   (col (cadr linecol)))
	  (if (null buf)
		  (message "[Synctex]: %s is not opened..." fname)
		(switch-to-buffer buf)
		(goto-line (car linecol))
		(unless (= col -1)
		  (move-to-column col)))))
  
  (dbus-register-signal
   :session nil "/org/gnome/evince/Window/0"
   "org.gnome.evince.Window" "SyncSource"
   'evince-inverse-search)
  )

;; texファイルを開くと自動でRefTexモード
;(add-hook 'latex-mode-hook 'turn-on-reftex)
(add-hook 'yatex-mode-hook 'turn-on-reftex)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flycheck
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'after-init-hook #'global-flycheck-mode)

;;; MELPA
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; 
(defun in-directory (dir)
  "Runs execute-extended-command with default-directory set to the given directory."
  (interactive "DIn directory: ")
  (let ((default-directory dir))
	(call-interactively 'execute-extended-command)))

(global-set-key (kbd "M-X") 'in-directory)

; roslaunch highlighting
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))

;; shellに色をつける
;; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'compilation-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'compilation-filter-hook
          '(lambda ()
             (let ((start-marker (make-marker))
                   (end-marker (process-mark (get-buffer-process (current-buffer)))))
               (set-marker start-marker (point-min))
               (ansi-color-apply-on-region start-marker end-marker))))

;; yatex-indent
(autoload 'latex-indent-command "~/misc/latex-indent"
  "Indent current line accroding to LaTeX block structure.")
(autoload 'latex-indent-region-command "~/misc/latex-indent"
  "Indent each line in the region according to LaTeX block structure.")
(add-hook
 'latex-mode-hook
 '(lambda ()
    (define-key tex-mode-map "\t"       'latex-indent-command)
    (define-key tex-mode-map "\M-\C-\\" 'latex-indent-region-command)))

;; elscreen.el
;;; プレフィクスキーはC-z
(setq elscreen-prefix-key (kbd "C-z"))
(elscreen-start)
;;; タブの先頭に[X]を表示しない
(setq elscreen-tab-display-kill-screen nil)
;;; header-lineの先頭に[<->]を表示しない
(setq elscreen-tab-display-control nil)
;;; バッファ名・モード名からタブに表示させる内容を決定する(デフォルト設定)
(setq elscreen-buffer-to-nickname-alist
      '(("^dired-mode$" .
         (lambda ()
           (format "Dired(%s)" dired-directory)))
        ("^Info-mode$" .
         (lambda ()
           (format "Info(%s)" (file-name-nondirectory Info-current-file))))
        ("^mew-draft-mode$" .
         (lambda ()
           (format "Mew(%s)" (buffer-name (current-buffer)))))
        ("^mew-" . "Mew")
        ("^irchat-" . "IRChat")
        ("^liece-" . "Liece")
        ("^lookup-" . "Lookup")))
(setq elscreen-mode-to-nickname-alist
      '(("[Ss]hell" . "shell")
        ("compilation" . "compile")
        ("-telnet" . "telnet")
        ("dict" . "OnlineDict")
        ("*WL:Message*" . "Wanderlust")))

;; smartparent
(smartparens-global-mode)
;; [DEL]キーもしくは[C-h]に当てられているdelete-backward-charにadviceをかけられて削除するたびにフリーズする．これを無効化
(ad-disable-advice 'delete-backward-char 'before 'sp-delete-pair-advice)
(ad-activate 'delete-backward-char)

;; gnuplot-mode
(require 'gnuplot-mode)
(setq auto-mode-alist 
(append '(("\\.\\(gp\\|gnuplot\\|plt\\)$" . gnuplot-mode)) auto-mode-alist))

;; doc-view-modeのときに行番号を表示すると非常に重たい
(add-hook 'doc-view-mode-hook
		  (lambda ()
			(linum-mode -1)
			))
(add-hook 'pdf-view-mode-hook
		  (lambda ()
			(linum-mode -1)
			))
;; pdf-tools
(pdf-tools-install)
;;(setq revert-without-query 'yes)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; for ssh
(require 'tramp)
(setq tramp-default-method "scp")

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist
'(("php"    . "\\.phtml\\'")
  ("blade"  . "\\.blade\\.")))
(setq web-mode-enable-current-element-highlight t)
(defun my-web-mode-hook () "Hooks for Web mode." 
  (setq web-mode-markup-indent-offset 2) 
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  ) 
(add-hook 'web-mode-hook 'my-web-mode-hook)
;;;(setq web-mode-enable-current-column-highlight t)
;;(setq web-mode-current-element-highlight-face "#0000cd")

;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;選択した範囲の行と列を表示する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(line-number-mode t)
(column-number-mode t)
;;選択範囲の情報表示
(defun count-lines-and-chars ()
  (if mark-active
      (format "[%3d:%4d]" 
              (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
    ""))

;;; Emacs 26以上用の設定
(if (string-match "26" emacs-version)
    (setq default-mode-line-format (default-value 'mode-line-format)))
(add-to-list 'default-mode-line-format
             '(:eval (count-lines-and-chars)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;cudaプログラムを色分け
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-mode-alist
(cons (cons "\\.cu$" 'c++-mode) auto-mode-alist))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;magit-flow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (require 'magit-gitflow)
 (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)

(prefer-coding-system 'utf-8)
(setq default-process-coding-system 'utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; line limit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'whitespace)
(setq whitespace-line-column 256) ;; limit line length
(setq whitespace-style '(face lines-tail))

(add-hook 'prog-mode-hook 'whitespace-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spell Check
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(mapc
(lambda (hook)
(add-hook hook 'flyspell-prog-mode))
'(
c-mode-common-hook
cpp-mode-common-hook
emacs-lisp-mode-hook
python-mode-common-hook
))
(mapc
(lambda (hook)
(add-hook hook
'(lambda () (flyspell-mode 1))))
'(
yatex-mode-hook
markdown-mode-hook
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Folding a code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'c++-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'c-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'scheme-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'python-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'xml-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))

;; (define-key global-map (kbd "C-:") 'hs-toggle-hiding)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; vimish-folding
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'vimish-fold)
(global-set-key (kbd "C-c C-f") #'vimish-fold)
(global-set-key (kbd "C-c C-v") #'vimish-fold-delete)
(global-set-key (kbd "C-c C-d") #'vimish-fold-delete-all)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs mozc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "/usr/share/emacs24/site-lisp/emacs-mozc")

(require 'mozc)
(setq default-input-method "japanese-mozc")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ivy設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-height 15) ;; minibufferのサイズを拡大！（重要）
(setq ivy-extra-directories nil)
(setq ivy-re-builders-alist
      '((t . ivy--regex-plus)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; counsel設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defvar counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; swiper設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
(defvar swiper-include-line-number-in-search t) ;; line-numberでも検索可能

;; migemo + swiper（日本語をローマ字検索できるようになる）
;; (require 'avy-migemo)
;; (avy-migemo-mode 1)
;; (require 'avy-migemo-e.g.swiper)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; company 設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'company)
(global-company-mode) ; 全バッファで有効にする
(setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 3) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(setq completion-ignore-case t)
(setq company-dabbrev-downcase nil)
(global-set-key (kbd "C-M-i") 'company-complete)
(define-key company-active-map (kbd "C-.") 'company-files) ;; filenameを見せる
(define-key company-active-map (kbd "C-n") 'company-select-next) ;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
(define-key company-active-map (kbd "C-i") 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map (kbd "C-f") 'company-complete-selection) ;; C-fで候補を設定
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで comp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; git complete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/lisp/git-complete") ;; お好きなように
(require 'git-complete)
(global-unset-key (kbd "C-c C-c")) ;; 一応unbindしておきましょう
(global-set-key (kbd "C-c C-c") 'git-complete)
(setq git-complete-enable-autopair t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dump jump
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/lisp/dumb-jump")
(require 'dumb-jump)
(global-unset-key (kbd "C-j")) ;; 一応unbindしておきましょう
(global-set-key (kbd "C-j j") 'dumb-jump-go)
(global-set-key (kbd "C-j b") 'dumb-jump-back)
(setq dumb-jump-mode t)
(setq dumb-jump-selector 'ivy) ;; 候補選択をivyに任せます
(setq dumb-jump-use-visible-window nil)
(define-key global-map [(super d)] 'dumb-jump-go) ;; go-to-definition!
(define-key global-map [(super shift d)] 'dumb-jump-back)

(provide 'init)
;;; init.el ends here
