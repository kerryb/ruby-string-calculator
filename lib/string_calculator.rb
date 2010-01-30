class StringCalculator
  def self.calculate input
    sum(extract_numbers(values(input), delimiter(input)))
  end
end

private

def delimiter input
  input =~ %r(\A//(.)$) ? $1 : %r([,\n])
end

def values input
  input =~ %r((\A//.*?)$) ? input.sub($1, '') : input
end

def extract_numbers input, delimiter
  input.split(delimiter).map(&:to_i)
end

def sum numbers
  reject_negatives numbers
  numbers.inject(0, &:+)
end

def reject_negatives numbers
  negatives = numbers.select {|n| n < 0}
  raise "Negatives not allowed: #{negatives.join(", ")}" unless negatives.empty?
end
