module Calculator
  def self.add input
    return 0 if input.empty?
    delimiter = case input
                when %r(\A//(\[.+?\]+)$) then %r(#{$1[1...-1].split('][').join('|')})
                when %r(\A//(.+)$) then $1
                else %r([,\n])
                end
    numbers = input.sub(/\A\/\/.*$/, '').split(delimiter).map(&:to_i).reject {|n| n > 1000}
    negatives = numbers.find_all {|n| n < 0}
    raise "negatives not allowed: #{negatives.join(', ')}" unless negatives.empty?
    numbers.inject {|sum, number| sum + number}
  end
end
