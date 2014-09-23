require 'finance'
describe Finance::AssetReturns do
	subject{
		Class.new{
			include Finance::AssetReturns
		}.new

	}
	it "should calculate the simple return on an asset correctly" do
		expect(subject.simple_return(85,90).round(4)).to eq(0.0588)

	end
	it "should calculate multiple returns on an asset correctly" do
		expect(subject.multiple_returns(80,90,2)).to eq([0.0625,0.058823529])
	end
	it "should calculate the value of return on a portfolio" do
		assets = []
		assets << {:purchase_price => 85, :qty => 10, :sale_price => 90}
		assets << {:purchase_price => 30, :qty => 10, :sale_price => 28}
		portfolio_value = subject.portfolio_return(assets)
		expect(portfolio_value[:return].to_f.round(5)).to eq(0.02609)
		expect(portfolio_value[:value].to_f.round(0)).to eq( 1180)
	end
	it "should calculate returns with dividends correctly" do
		buy = 85
		sell = 90
		dividend = 1
		expect(subject.simple_return(85,90,1).round(4)).to eq(0.0706)
	end
	it "should be able to adjust for inflation" do
		cpi_at_time_of_purchase = 1 #what we are using for inflation
		cpi_at_time_of_sale = 	1.01
		expect(subject.adjust_for_inflation(85,1)).to eq(85)
		expect(subject.adjust_for_inflation(90,1.01).round(4)).to eq(89.1089)
	end

	it "should be able to calculate a continuously compounding return" do
		
		expect(subject.continuously_compounding_return(85,90).round(4)).to eq(0.0572)
	end

	it "should be able to calculate the continuously compounding return on a portfolio" do
		asset_1 = {:portfolio_portion => 0.25, :real_rate_of_return => 0.0588}
		asset_1 = {:portfolio_portion => 0.75, :real_rate_of_return => -0.053}
		#gives portfolio return of −0.02302
		#this is the same as working the simple return then finding the log of 1 + simple return
		#Need to consider refactoring for method chaining
	end

	it "should caclulate the continuously compounding return and adjust for inflation" do
		p Math.log(1 - 0.1439) * 12
	end

	context "assignment one", assignment_1: true do
		# Actual Starbucks stock over period December 2004 - 2005
		# December,		2004	$31.18
		# January,		2005	$27.00
		# February,		2005	$25.91
		# March,		2005	$25.83
		# April,		2005	$24.76
		# May,			2005	$27.40
		# June,			2005	$25.83
		# July,			2005	$26.27
		# August,		2005	$24.51
		# September,	2005	$25.05
		# October,		2005	$28.28
		# November,		2005	$30.45
		# December,		2005	$30.51

		it "Using the data in the table, what is the simple monthly return between the end of December 2004 and the end of January 2005" do
			expect(subject.simple_return(31.18,27).round(4)).to eq(-0.1341)
		end
		it "Using the data in the table, what is the continuously compounded monthly return between December 2004 and January 2005?" do
			expect(subject.continuously_compounding_return(31.18,27).round(4)).to eq(-0.1439)
		end
		it "Assuming that the simple monthly return you computed in Question 1 is the same for 12 months, what is the annual return with monthly compounding?" do
			expect(subject.annualized_rate_of_return(-0.1341).round(4)).to eq(-0.8223)
		end
		it "Assuming that the continuously compounded monthly return you computed in Question 3 is the same for 12 months, what is the continuously compounded annual return?" do
			ret = 0
			12.times do 
				ret = ret -0.1439
			end
			expect( ret.round(4)).to eq(-1.7268)
		end	
		it "Using the data in the table, compute the actual simple annual return between December 2004 and December 2005." do
			expect(subject.simple_return(31.18,30.51).round(4)).to eq(-0.0215)
		end
		it "Using the data in the table, compute the actual annual continuously compounded return between December 2004 and December 2005." do
			expect(subject.continuously_compounding_return(31.18,30.51).round(4)).to eq(-0.0217)
		end
	end

end