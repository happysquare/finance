module Finance
	module AssetReturns
		##
		# determine the rate of return of an asset 
		# over a given time period
		# *purchase_price
		# *sale_price
		# *dividend paid for period
		def simple_return(purchase_price, sale_price, dividend = 0)
			if dividend > 0
				capital = (sale_price.to_d - purchase_price.to_d) / purchase_price.to_d
				dividend_yield = dividend.to_d/purchase_price.to_d
				capital + dividend_yield
			else
				(sale_price.to_d / purchase_price.to_d) - 1
			end
		end

		def continuously_compounding_return(purchase_price,sale_price)
			simple = simple_return(purchase_price,sale_price)
			Math.log(simple +  1)
		end

		##
		# determine the values of multiple returns
		# *purchase_price
		# *sale_price
		# *periods - number of returns over given period
		def multiple_returns(purchase_price,sale_price,periods)
			per_period_gain = (sale_price.to_d - purchase_price.to_d ) / periods.to_d
			returns = []
			periods.times do |i|
				returns << simple_return(purchase_price + i * per_period_gain, purchase_price + (i +1) * per_period_gain).to_f
			end	
			returns
		end

		##
		# Multiple continuously compounded returns
		#
		def multiple_continuously_compounded_returns(returns,periods)
			
			returns.each do |ret|

			end
		end
		##
		# Determine return on protfolio
		# assets - array of hashes containing:
		# purchase and sale price of a given asset
		# quantity of givent asset purchased
		# returns a hash in format {:return => "the percentage of return", :value => "the value of the portfolio"}
		def portfolio_return(assets)
			#calculate the initial value of the asset
			portfolio_value_start = (assets.map {|a| a[:purchase_price] * a[:qty]}.reduce(:+)).to_d
			returns = []
			assets.each do |a|
				a[:portfolio_share] =  a[:purchase_price].to_d * a[:qty] / portfolio_value_start
				a_return = simple_return(a[:purchase_price], a[:sale_price]) * a[:portfolio_share]
				returns << a_return
			end
			portfolio_return = returns.reduce(:+)
			value = portfolio_value_start * (1 + portfolio_return)
			{:return => portfolio_return, :value => value}
		end

		#
		# Determine a value adjusted for inflation
		# value
		# cpi - depreciating component
		def adjust_for_inflation(value,cpi)
			value / cpi
		end
		##
		# Annualize a rate of return
		#
		def annualized_rate_of_return(rate)
			(1+rate)**12 - 1
		end

	end
end