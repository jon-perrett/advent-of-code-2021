def get_majority_minority (lines)
    sums = Array.new(lines[0].length, 0)
    
    lines.map{|line|
        line.split('').each_with_index{|c, idx|
            sums[idx] = sums[idx] + c.to_i()
            }
        }
    majority_threshold = lines.length / 2.to_f

    majority = sums.map{|c| c >= majority_threshold ? "1" : "0"}.join
    minority = sums.map{|c| c >= majority_threshold ? "0" : "1"}.join
    return majority, minority
    end

if __FILE__ == $0
    lines = []
    file = File.foreach("day3_input.txt") { |line|
        if line != nil
            lines.push(line.strip) 
        end
    }

    majority, minority = get_majority_minority(lines)
    remaining_lines = lines
    current_idx = 0
    loop do
        remaining_lines = remaining_lines.select{|line| line.split('')[current_idx] == majority.split('')[current_idx]}
        if remaining_lines.length <= 1
            break
        end
        current_idx += 1
        majority, minority = get_majority_minority(remaining_lines)
    end
    oxygen = remaining_lines[0].to_i(2)

    majority, minority = get_majority_minority(lines)
    remaining_lines = lines
    current_idx = 0
    loop do
        remaining_lines = remaining_lines.select{|line| line.split('')[current_idx] == minority.split('')[current_idx]}
        if remaining_lines.length <= 1
            break
        end
        current_idx += 1
        majority, minority = get_majority_minority(remaining_lines)
    end
    co2 = remaining_lines[0].to_i(2)
    
    puts oxygen * co2
end