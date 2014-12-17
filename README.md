Ruby Compiler Benchmark
=======================

Start EC2 Instance:

    export AWS_ACCESS_KEY="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	export AWS_SECRET_KEY="ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
	vagrant up --provider=aws


Start Benchmark Suite:

	vagrant ssh
	screen
	cd /vagrant
	./benchmark.sh


Collect Benchmark Results:

	cd ruby-benchmark-suite
	rake bench:to_csv
	cd ..
	./parse_results_total_score.rb


Running the full benchmark suite for all compiler takes around 12 hours. If you
only want to run it with certain compilers remove the ones you don't want from
the COMPILERS array on line 54 in benchmark.sh If you only want to run part of
the benchmark suite replace:

    rake bench

On line 50 of benchmark.sh with something like:

    rake bench:pattern  PATTERN=benchmarks/micro-benchmarks/bm_app_*.rb
