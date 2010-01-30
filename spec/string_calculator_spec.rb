require "rubygems"
require "spec"
$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
require "string_calculator"

Spec::Matchers.define :evaluate_to do |expected|
  match do |input|
    @result = StringCalculator.calculate(input)
    @result.should == expected
  end

  failure_message_for_should do |input|
    %Q(Expected "#{input}" to evaluate to #{expected}, but got #{@result.nil? ? "nil" : @result}.)
  end
end

describe StringCalculator do
  describe "with comma-separated numbers" do
    it "calculates the sum of an empty string as 0" do
      "".should evaluate_to(0)
    end

    it "calculates the sum of one number as the number" do
      "1".should evaluate_to(1)
    end

    it "calculates the sum of two numbers" do
      "1,2".should evaluate_to(3)
    end

    it "calculates the sum of five numbers" do
      "1,2,3,4,5".should evaluate_to(15)
    end
  end

  it "allows a newline delimiter" do
    "1\n2\n3".should evaluate_to(6)
  end

  it "allows a mixture of comma and newline delimiters" do
    "1,2\n3".should evaluate_to(6)
  end
end
