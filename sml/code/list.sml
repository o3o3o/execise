(* [];
  [v,v1,v2];
  e1 :: e2 
  v :: [v1,v2,v3] ---> [v,v1,v2,v3]
*)
fun sum_list (xs : int list) =
    if null xs
    then 0
    else hd xs + sum_list(tl xs)
fun countdown (x: int) = (* 7: --> 7,6,5,4,3,2,1*)
    if x = 0
    then []
    else x :: countdown(x-1)

fun append (xs : int list, ys : int list) =
    if null xs
    then ys
    else (hd xs) :: (append ((tl xs), ys))

