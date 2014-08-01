(ql:quickload "cl-cairo2")

(in-package :cl-cairo2)

;; http://cairographics.org/tutorial/

;; (defparameter *surface* (create-pdf-surface "example.pdf" 200 200))

;; *context* already exists as part of cl-cairo2
;; (setf *context* (create-context *surface*))

;; destroying the surface will not close the file until you destroy the context.
;; (destroy *surface*)

;; destroy context, this also destroys the surface and closes the file
;; (destroy *context*)

  ;; There are three main kinds of sources in cairo: colors, gradients, and images. Colors are the simplest; they use a uniform hue and opacity for the entire source. You can select these without any preparation with cairo_set_source_rgb() and cairo_set_source_rgba(). Using cairo_set_source_rgb (cr, r, g, b) is equivalent to using cairo_set_source_rgba (cr, r, g, b, 1.0), and it sets your source color to use full opacity.

(with-png-file ("cairo-tutorial-colors.png" :argb32 200 200)
  
  ;; (set-source-rgb r g b) is equivalent to using (set-source-rgba r g b 1.0)
  (set-source-rgb 1 1 1)
  
  ;; clear background to the source 
  (paint)
  
  ;; lines that form a cross
  (set-source-rgb 0 0 0)
  (move-to 0 0) 
  (line-to 200 200)
  (move-to 200 0)
  (line-to 0 200)
  (set-line-width 40)
  (stroke)

  ;; fun with transparency
  (rectangle 0 0 100 100)
  (set-source-rgba 1 0 0 0.80)
  (fill-path)

  (rectangle 0 100 100 100)
  (set-source-rgba 0 1 0 0.60)
  (fill-path)

  (rectangle 100 0 100 100)
  (set-source-rgba 0 0 1 0.40)
  (fill-path))

;;Gradients describe a progression of colors by setting a start and stop reference location and a series of "stops" along the way. Linear gradients are built from two points which pass through parallel lines to define the start and stop locations. Radial gradients are also built from two points, but each has an associated radius of the circle on which to define the start and stop locations. Stops are added to the gradient with (pattern-add-color-stop-rgb pattern offset red green blue) and (pattern-add-color-stop-rgba pattern offset red green blue alpha) which take a color like set-source-rgb*, as well as an offset to indicate where it lies between the reference locations. The colors between adjacent stops are averaged over space to form a smooth blend. Finally, the behavior beyond the reference locations can be controlled with (patter-set-extend pattern extend).

(with-png-file ("cairo-tutorial-gradients.png" :argb32 200 200)
  (let ((rad-pat (create-radial-pattern 50 50 20 100 100 100))
	(lin-pat (create-linear-pattern 50 70 150 130)))
    (pattern-add-color-stop-rgb rad-pat 0 1.0 0.8 0.8)
    (pattern-add-color-stop-rgb rad-pat 1 0.9 0.0 0.0)
    
    (loop for i from 1 to 9 do
      (loop for j from 1 to 9 do
	(rectangle (- (/ (* i 200) 10.0) 8.0) (- (/ (* j 200) 10.0) 8.0) 16.0 16.0)))
    (set-source rad-pat)
    (fill-path)
    
    (pattern-add-color-stop-rgba lin-pat 0.00 1 1 1 0)
    (pattern-add-color-stop-rgba lin-pat 0.25 0 1 0 0.5)
    (pattern-add-color-stop-rgba lin-pat 0.50 1 1 1 0)
    (pattern-add-color-stop-rgba lin-pat 0.75 0 0 1 0.5)
    (pattern-add-color-stop-rgba lin-pat 1.00 1 1 1 0)
    
    (rectangle 0.0 0.0 200 200)
    (set-source lin-pat)
    (fill-path)))

(with-png-file ("simple-text.png" :argb32 200 200)
  
  ;; (set-source-rgb r g b) is equivalent to using (set-source-rgba r g b 1.0)
  ;;(set-source-rgb 1 1 1)
  
  ;; clear background to the source 
  ;;(paint)
  (move-to 0 100)
  (set-font-size 50)
  (show-text "foo")
  (destroy *context*))

