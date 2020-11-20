-72 CONSTANT YSTART
72 CONSTANT YEND
-120 CONSTANT XSTART
120 CONSTANT XEND
30 CONSTANT MAXITER

YSTART VARIABLE Y0
XSTART VARIABLE X0

0 VARIABLE X
0 VARIABLE Y
0 VARIABLE ITER
0 VARIABLE XDIFF

: MANDELBROT
  YSTART Y0 !
  BEGIN
    CR
    XSTART X0 !
    BEGIN
      0 X !
      0 Y !
      0 ITER !
      X0 @ 20 - XDIFF !

      BEGIN
        X @ DUP *
        Y @ DUP *
        - 60 /
        XDIFF @ +  ( Add adjusted screen X offset to result, left on stack )

        X @ Y @ *
        2 *
        60 /
        Y0 @ +       ( Add screen Y offset to result )
        Y !          ( Store in Y )

        X !  ( Write XTEMP, on stack, to X )

        1 ITER +! ( Increment ITER and check if at MAXITER )
        ITER @ MAXITER >  ( Push result to stack )
        X @ DUP 60 / *
        Y @ DUP 60 / *
        + 240 >
        OR
      UNTIL

      ITER @ DUP    ( Get the index of the symbol to print )
      20 < IF
        4 /
      ELSE
        DROP 5
      THEN

      DUP 0 = IF ."  " THEN
      DUP 1 = IF ." ." THEN
      DUP 2 = IF ." :" THEN
      DUP 3 = IF ." %" THEN
      DUP 4 = IF ." $" THEN
      5 = IF ." #" THEN

      3 X0 +!
      X0 @ XEND >
    UNTIL
    6 Y0 +!
    Y0 @ YEND >
  UNTIL

  CR
;
