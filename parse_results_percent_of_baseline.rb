#!/usr/bin/env ruby

results_file = Dir.glob('ruby-benchmark-suite/results/rbs/*.csv').last
exit if results_file.nil?
results = File.read(results_file)
results = results.lines.each_with_index.map do |line, index|
	next if index == 0

	results = line.split(',').drop(2).map(&:to_f)
	baseline = (results.map(&:to_f).reduce(:+) / results.length)

	results.map! do |result|
		(((result / baseline) * 100) - 100)
	end

	results.join(',')
end
results.compact!

puts results

#12.times do |i|
#	results.each_with_index do |result, index|
#		print  "[#{index + 1}, #{result.split(',')[i]}], "
#	end
#	puts "\n\n"
#end
