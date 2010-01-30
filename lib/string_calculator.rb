class StringCalculator
  class << self
    def calculate input
      sum(extract_numbers(values(input), delimiter_pattern(input)))
    end

    private

    def delimiter_pattern input
      case input
      when %r(\A//((\[.+\])+)$) then multi_delimiter_regexp($1)
      when %r(\A//(.+)$) then $1
      else %r([,\n])
      end
    end

    def values input
      input =~ %r((\A//.+?)$) ? input.sub($1, '') : input
    end

    def extract_numbers input, delimiter
      input.split(delimiter).map(&:to_i)
    end

    def sum numbers
      reject_negatives numbers
      ignore_over_1000(numbers).inject(0, &:+)
    end

    def reject_negatives numbers
      negatives = numbers.select {|n| n < 0}
      raise "Negatives not allowed: #{negatives.join(", ")}" unless negatives.empty?
    end

    def ignore_over_1000 numbers
      numbers.reject {|n| n > 1000}
    end
    
    def extract_delimiters string
      string[1..-2].split "]["
    end

    def multi_delimiter_regexp delimiters
      %r{(#{extract_delimiters(delimiters).map{|str| Regexp.escape(str)}.join("|")})}
    end
  end
end
