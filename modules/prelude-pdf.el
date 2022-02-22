;;; prelude-pdf.el --- Emacs Prelude: Typescript programming support.
;;
;; Copyright © 2022 Agung Tuanany
;;
;; Author: Agung Tuanany <agung.tuanany@gmail.com>


;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;; This file is not part of GNU Emacs.
;; make Emacs open '.pdf' by default.


;;; Code:

(require 'pdf-tools)
(require 'saveplace-pdf-view)

;; initializing
(pdf-tools-install)
(save-place-mode 1)

;; open pdfs scaled to fit page
(setq-default pdf-view-display-size 'fit-page)

;; automatically annotate highlights
(setq pdf-annot-activate-created-annotations t)

;; more fine-grained zooming
(setq pdf-view-resize-factor 1.1)

(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
      TeX-source-correlate-start-server t)

(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)

(add-hook 'pdf-view-mode-hook (lambda () (linum-mode -1)))

;; turn off cua so copy works
(add-hook 'pdf-view-mode-hook (lambda () (cua-mode 0)))


;;; custom keyboard shortcut
;; use normal isearch
(define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
(define-key pdf-view-mode-map (kbd "h") 'pdf-annot-add-highlight-markup-annotation)
(define-key pdf-view-mode-map (kbd "t") 'pdf-annot-add-text-annotation)
(define-key pdf-view-mode-map (kbd "D") 'pdf-annot-delete)


(provide 'prelude-pdf)

;;; prelude-pdf.el ends here
