-- Benchmark: Rodinia - kmeans.
-- ==
-- input @ buckets_16_10m
-- input @ buckets_64_10m
-- input @ buckets_256_10m
-- input @ buckets_1024_10m

let main [m][n] (_ : *[n]i32) (image : [m]i32) : [n]i32 =
  let inds = map (% n) image
  let points_in_clusters =
    stream_red_per (\(acc : [n]i32) (x : [n]i32) ->
                    map2 (+) acc x)
                   (\(inp : []i32) ->
                    loop acc = (replicate n 0) for c in inp do
                      unsafe let acc[c] = acc[c] + 1 in acc)
                   inds
  in points_in_clusters
