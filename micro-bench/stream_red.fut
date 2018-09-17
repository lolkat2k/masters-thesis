-- Benchmark: Rodinia - kmeans.
-- ==
-- input @ buckets_16_10m

-- Original main declaration
-- let main [m][n] (k : i32, membership : [m]i32) : [n]i32 =
let main [m][n] (_ : *[n]i32) (image : [m]i32) : [n]i32 =
  let points_in_clusters =
    stream_red_per (\(acc : [n]i32) (x : [n]i32) ->
                    map2 (+) acc x)
                   (\(inp : []i32) ->
                    loop acc = (replicate n 0) for c in inp do
                      unsafe let acc[c] = acc[c] + 1 in acc)
                   image
  in points_in_clusters
