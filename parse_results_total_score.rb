#!/usr/bin/env ruby

results = File.read(Dir.glob('ruby-benchmark-suite/results/rbs/*.csv').first)
results.lines.each_with_index do |line, index|
	next if index == 0

	unsorted_results = line.split(',').drop(2)
	sorted_results = unsorted_results.sort.reverse
	sorted_results.each_with_index do |a, i|
		unsorted_results[(unsorted_results.index(a))] = i
	end

	puts unsorted_results.join(',')
end
