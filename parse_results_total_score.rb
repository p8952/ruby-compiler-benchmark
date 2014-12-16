#!/usr/bin/env ruby

results_file = Dir.glob('ruby-benchmark-suite/results/rbs/*.csv').last
exit if results_file.nil?
raw_results = File.read(results_file)
results = raw_results.lines.each_with_index.map do |line, index|
	next if index == 0

	unsorted_results = line.split(',').drop(2)
	sorted_results = unsorted_results.sort.reverse

	sorted_results.each_with_index do |a, i|
		unsorted_results[(unsorted_results.index(a))] = (sorted_results.length - i)
	end

	unsorted_results
end
results.compact!

results.first.length.times do |i|
	results_total = []
	results.each do |result|
		results_total << result[i]
	end
	puts results_total.map(&:to_i).reduce(:+)
end
