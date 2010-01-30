class StringCalculator
  def self.calculate input
    sum(extract_numbers(input))
  end
end

private

def delimiter
  %r([,\n])
end

def extract_numbers input
  input.split(delimiter).map(&:to_i)
end

def sum numbers
  numbers.inject(0, &:+)
end
