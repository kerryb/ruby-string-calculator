require 'rubygems'
require 'spec'
$:.unshift(File.expand_path(File.dirname(__FILE__) + '/../lib'))
require 'calculator'

describe Calculator do
  describe "adding" do
    describe "an empty string" do
      it "returns 0" do
        Calculator.add("").should == 0
      end
    end

    describe "a single number" do
      it "returns the number" do
        Calculator.add("2").should == 2
      end
    end

    describe "two comma-separated numbers" do
      it "returns the sum" do
        Calculator.add("2,40").should == 42
      end
    end

    describe "a whole bunch of comma-separated numbers" do
      it "returns the sum" do
        Calculator.add("1,2,3,4,5").should == 15
      end
    end

    describe "newline-separated numbers" do
      it "returns the sum" do
        Calculator.add("1\n2").should == 3
      end
    end

    describe "mixed comma/newline-separated numbers" do
      it "returns the sum" do
        Calculator.add("1\n2,3").should == 6
      end
    end

    describe "with a specified delimiter" do
      describe "with a single character" do
        it "returns the sum" do
          Calculator.add("//;\n1;2;3").should == 6
        end
      end

      describe "with multiple characters" do
        it "returns the sum" do
          Calculator.add("//foo\n1foo2foo3").should == 6
        end
      end
    end

    describe "with multiple specified delimiters" do
      describe "with a single character" do
        it "returns the sum" do
          Calculator.add("//[,][;]\n1;2,3").should == 6
        end
      end

      describe "with multiple characters" do
        it "returns the sum" do
          Calculator.add("//[foo][bar]\n1foo2bar3").should == 6
        end
      end
    end

    describe "with a negative number" do
      it "raises an exception 'negatives not allowed: <n>'" do
        lambda {Calculator.add("-1")}.should raise_error("negatives not allowed: -1")
      end
    end

    describe "with multiple negative numbers" do
      it "raises an exception 'negatives not allowed: <n, n...>'" do
        lambda {Calculator.add("-1,2,-3")}.should raise_error("negatives not allowed: -1, -3")
      end
    end

    it "ignores numbers above 1000" do
      Calculator.add("1,1001,2").should == 3
    end
  end
end
