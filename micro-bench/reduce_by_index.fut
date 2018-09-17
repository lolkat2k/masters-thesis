-- ==
-- input @ buckets_16_10m
-- input @ buckets_64_10m
-- input @ buckets_256_10m
-- input @ buckets_1024_10m

let main [m][n] (hist : *[n]i32) (image : [m]i32) : [n]i32 =
  reduce_by_index hist (+) 0 (map (% n) image) image
