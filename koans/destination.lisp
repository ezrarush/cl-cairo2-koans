;; from http://cairographics.org/tutorial/

;; Destination

;; The destination is the surface on which you're drawing. It may be tied to an array of pixels like in this tutorial, or it might be tied to a SVG or PDF file, or something else. This surface collects the elements of your graphic as you apply them, allowing you to build up a complex work as though painting on a canvas.

(define-test test-pdf-surface
    "create-pdf-surface is an function in cl-cairo2"
  (true-or-false? ___ (fboundp 'cl-cairo2:create-pdf-surface)))
