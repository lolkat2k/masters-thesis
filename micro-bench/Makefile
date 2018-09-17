FUT_CL = /home/fjc657/futhark/.stack-work/install/x86_64-linux/lts-12.7/8.4.3/bin/futhark-opencl
FUT_C  = /home/fjc657/futhark/.stack-work/install/x86_64-linux/lts-12.7/8.4.3/bin/futhark-c

IMAGE_SIZE = 1000000
BUCKETS = 16 64 256 1024

.PHONY: benchmark

benchmark: 	reduce_by_index.json reduce_by_index_seq.json \
		map_sort_scan.json scatter.json # stream_red.json

buckets_%_10m:
	futhark-dataset --i32-bounds=0:0 -g [$*]i32 \
			--i32-bounds=0:$(IMAGE_SIZE) -g [$(IMAGE_SIZE)]i32 > $@

reduce_by_index.json: reduce_by_index.fut $(BUCKETS:%=buckets_%_10m)
	@futhark-bench --compiler=$(FUT_CL) \
		       --runs=5 \
		       --json $@ $<

reduce_by_index_seq.json: reduce_by_index_seq.fut $(BUCKETS:%=buckets_%_10m)
	@futhark-bench --compiler=$(FUT_C) \
		       --runs=5 \
		       --json $@ $<

stream_red.json: stream_red.fut $(BUCKETS:%=buckets_%_10m)
	@futhark-bench --compiler=$(FUT_CL) \
		       --runs=5 \
		       --json $@ $<

map_sort_scan.json: map_sort_scan.fut $(BUCKETS:%=buckets_%_10m)
	@futhark-bench --compiler=$(FUT_CL) \
		       --runs=5 \
		       --json $@ $<

scatter.json: scatter.fut $(BUCKETS:%=buckets_%_10m)
	@futhark-bench --compiler=$(FUT_CL) \
		       --runs=5 \
		       --json $@ $<

clean:
	rm -f reduce_by_index.c reduce_by_index_seq.c \
	      stream_red.c map_sort_scan.c scatter.c
	rm -f reduce_by_index reduce_by_index_seq \
	      stream_red map_sort_scan scatter
	rm -f buckets_*_10m
	rm -f *.json
