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

  it "allows the delimiter to be specified" do
    "//;\n1;2".should evaluate_to(3)
  end

  it "allows multiple delimiters to be specified" do
    "//[x][y]\n1x2y3".should evaluate_to(6)
  end

  it "allows regexp special chars in delimiters" do
    "//[*][(]\n1*2(3".should evaluate_to(6)
  end

  it "allows a multiple-character delimiter" do
    "//***\n1***2***3".should evaluate_to(6)
  end

  it "allows multiple multiple-character delimiters" do
    "//[abc][***]\n1abc2***3".should evaluate_to(6)
  end

  describe "with negative numbers" do
    it "raises an exception" do
      lambda{StringCalculator.calculate("1,-1")}.should raise_error("Negatives not allowed: -1")
    end

    it "includes all negative numbers in the message" do
      lambda{StringCalculator.calculate("1,-1,-2,-3")}.should raise_error("Negatives not allowed: -1, -2, -3")
    end
  end

  it "accepts numbers up to 1000" do
    "999,1000".should evaluate_to(1999)
  end

  it "ignores numbers over 1000" do
    "2,1001".should evaluate_to(2)
  end
end
