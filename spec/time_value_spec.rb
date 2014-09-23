require 'finance'

describe Finance::TimeValue do
	subject { 
		Class.new { 
			include Finance::TimeValue 
		}.new 
	}
	it "should calculate the future value of money correctly" do
		expect(subject.future_value(0.03,1,1000)).to eq(1030)
		expect(subject.future_value(0.03,5,1000).round(2)).to eq(1159.27)
		expect(subject.future_value(0.03,10,1000).round(2)).to eq(1343.92)
	end
	it "should calculate the present value correctly" do
		expect(subject.present_value(0.03,1,1030)).to eq(1000)
		expect(subject.present_value(0.03,5,1159.27).round(0)).to eq(1000)
		expect(subject.present_value(0.03,10,1343.92).round(0)).to eq(1000)
	end
	it "should calculate the compound return correctly" do
		expect(subject.compound_return(1,1000,1030)).to eq(0.03)
		expect(subject.compound_return(5,1000,1159.27).round(2)).to eq(0.03)
		expect(subject.compound_return(10,1000,1343.92).round(2)).to eq(0.03)
	end
	it "should calculate the investment horizon correctly" do
		expect(subject.investment_horizon(0.03,1000,1030)).to eq(1)
		expect(subject.investment_horizon(0.03,1000,1159.27).round(0)).to eq(5)
		expect(subject.investment_horizon(0.03,1000,1343.92).round(0)).to eq(10)
	end
	it "should be able to calculate the future value correctly when compounding occurs more than once / period" do
		expect(subject.future_value(0.1,1,1000,1)).to eq(1100)
		expect(subject.future_value(0.1,1,1000,4).round(2)).to eq(1103.81)
		expect(subject.future_value(0.1,1,1000,52).round(2)).to eq(1105.06)
		expect(subject.future_value(0.1,1,1000,365).round(2)).to eq(1105.16)
		expect(subject.future_value(0.1,1,1000,:continuous).round(2)).to eq(1105.17)
		expect(subject.future_value(0.1,1,1000,:quarterly).round(2)).to eq(1103.81)
		expect(subject.future_value(0.1,1,1000,:weekly).round(2)).to eq(1105.06)
		expect(subject.future_value(0.1,1,1000,:daily).round(2)).to eq(1105.16)
		expect{subject.future_value(0.1,1,1000,:fortnightly)}.to raise_error(ArgumentError)
	end
	it "should calculate the effective annual rate with multiple compounding periods correctly" do
		expect(subject.effective_annual_rate(0.1,2).round(4)).to eq(0.1025)
		expect(subject.effective_annual_rate(0.1,:quarterly).round(4)).to eq(0.1038)
		expect(subject.effective_annual_rate(0.1,:continuous).round(4)).to eq(0.1052)
	end

	it "should calculate the future value correctly when compounding" do
		#expected capital gain = 3.9%
		#present value = 620000
		#periods = 4
		#compound per period = 1
		expect(subject.future_value(0.039,4,620000).round(2)).to eq(722526.67)
	end

	it "should calculate the capital gain" do
		expect(subject.capital_gain(4,620000,722526).round(4)).to eq(0.039)
	end
end