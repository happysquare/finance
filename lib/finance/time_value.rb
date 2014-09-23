module Finance
	class TimeValue
		require 'bigdecimal'
		require 'bigdecimal/util'
		##
		# determine the future value of an investment of
		# present_value with given interest rate over time
		# *periods - number of periods (years) that the interest is cumulated
		# *rate - the annual rate of return
		# *present_value - the value at the start of the period
		# *compound_frequency - number of compounds / period(year)
		#
		def future_value(rate,periods,present_value,compound_frequency = 1)
			compound_frequency = resolve_compound_frequency!(compound_frequency)
			if compound_frequency == :continuous
				return continuous_compound_fv(rate,periods,present_value)
			end
			future_value = present_value * (1+rate/compound_frequency)** (periods * compound_frequency)
		end


		##
		# determine the present value required to acheive a
		# future value with given interest rate over time
		# *periods - number of periods (years) that the interest is cumulated
		# *rate - the annual rate of return
		# *future_value - the value at the end of the period
		#
		def present_value(rate,periods,future_value)
			present_value = future_value / (1+rate)**periods
		end
		##
		# determine the rate of return over a period
		# *periods - number of periods (years) that the interest is cumulated
		# *present_value - the value at the start of the period
		# *future_value - the value at the end of the period
		#
		def compound_return(periods,present_value,future_value)
			pv = present_value.to_d
			fv = future_value.to_d
			n = periods.to_d
			rate = ((fv / pv)**(1/n))-1
		end
		alias_method :capital_gain, :compound_return
		
		##
		# determine the investment horizon (length of time) required
		# to create a future value given a present value and interest rate
		# *present_value - the value at the start of the period
		# *future_value - the value at the end of the period
		# *rate - the annual rate of return
		#
		def investment_horizon(rate,present_value,future_value)
			pv = present_value.to_d
			fv = future_value.to_d
			periods = Math.log(fv/pv) / Math.log(1+rate)
		end

		##
		# determine the effective annual rate for a given simple interest rate compounded
		# over a given number of periods
		# *rate simple annual rate
		# *compound_per_period compound / period
		def effective_annual_rate(rate,compound_frequency)
			compound_frequency = resolve_compound_frequency!(compound_frequency)
			if compound_frequency == :continuous
				return continuous_effective_annual_rate(rate)
			end
			m= compound_frequency
			e_rate = (1 + rate/m)**m -1
		end



		private
			def resolve_compound_frequency!(compound_frequency)
				
				if( !compound_frequency.is_a?( Numeric) && compound_frequency.to_s != "continuous" )
					case(compound_frequency.to_s)#allow for strings
						when "quarterly"
							compound_frequency = 4
						when "weekly"
							compound_frequency = 52
						when "monthly"
							compound_frequency = 12
						when "daily"
							compound_frequency = 365
						when "annually" 
							compound_frequency = 1
						else
							raise(ArgumentError,"#{compound_frequency} is not a valid parameter, enter an integer or: :continuous, :daily, :weekly, :monthly, :quarterly")
						end
				end
				compound_frequency
			end
			def continuous_effective_annual_rate(rate)
				Math::E**rate -1
			end
			def continuous_compound_fv(rate,periods,present_value)
				future_value = present_value * Math::E**(rate*periods)
			end
	end
end