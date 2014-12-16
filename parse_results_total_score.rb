#!/usr/bin/env ruby

results_file = Dir.glob('ruby-benchmark-suite/results/rbs/*.csv').last
exit if results_file.nil?
results = File.read(results_file)
results.lines.each_with_index do |line, index|
	next if index == 0

	unsorted_results = line.split(',').drop(2)
	sorted_results = unsorted_results.sort.reverse

	sorted_results.each_with_index do |a, i|
		unsorted_results[(unsorted_results.index(a))] = (sorted_results.length - i)
	end

	puts unsorted_results.join(',')
end
