require 'benchmark'

# Benchmark.bm 7 do |x|
Benchmark.bmbm do |x|
  x.report 'upto' do
    1.upto(100000).each do |i|
      puts i if i == 100000
    end
  end

  x.report '(1..100000)' do
		(1..100000).each do |i|
			puts i if i == 100000
		end
	end

  x.report '(100000.times)' do
		100000.times do |i|
			puts i if i == 100000
		end
	end
end
