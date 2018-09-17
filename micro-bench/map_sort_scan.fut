-- Semantically a histogram.
-- ==
-- input @ buckets_16_10m
-- input @ buckets_64_10m
-- input @ buckets_256_10m
-- input @ buckets_1024_10m

import "lib/github.com/diku-dk/sorts/merge_sort"
import "lib/github.com/diku-dk/segmented/segmented"

let compare ((x_ind, _) : (i32, i32)) ((y_ind, _) : (i32, i32)) : bool =
  x_ind <= y_ind

-- let segments [n] (xs : [n]i32) : [n]bool =
--   map (\(i,v) -> if i == 0 then true
--                  else let xm1 = unsafe xs[i - 1]
--                       in if xm1 < v then true
--                          else false)
--   (zip (iota n) xs)

-- let xm1 = unsafe xs[i-1]
-- in (i == 0) || (xm1 < v)

let segments2 [n] (xs : [n]i32) : [n]i32 =
  map (\(i,v) -> if i == 0 then v
                 else let xm1 = unsafe xs[i - 1]
                      in if v - xm1 < 1 then 0
                         else v)
      (zip (iota n) xs)

let main [m][n] (hist : *[n]i32) (image : [m]i32) : [n]i32 =
  let inds = map (% n) image
  let xs = zip inds image
  let (inds0, vals) = unzip (merge_sort compare xs)
  let inds1 = segments2 inds0
  let flgs = map (0<) inds1
  let sgms = segmented_reduce (+) 0 flgs vals
  let inds2 = filter (0<) inds1
  in scatter hist inds2 sgms
