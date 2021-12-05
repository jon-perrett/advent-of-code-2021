if __FILE__ == $0
    lines = []
    file = File.foreach("day3_input.txt") { |line|
        if line != nil
            lines.push(line.strip) 
        end
    }
    sums = Array.new(lines[0].length, 0)
    
    lines.map{|line|
        line.split('').each_with_index{|c, idx|
            sums[idx] = sums[idx] + c.to_i()
            }
        }
    majority_threshold = lines.length / 2.to_f

    gamma = sums.map{|c| c > majority_threshold ? "1" : "0"}.join.to_i(2)
    epsilon = sums.map{|c| c > majority_threshold ? "0" : "1"}.join.to_i(2)
    answer = gamma * epsilon
    puts answer
end