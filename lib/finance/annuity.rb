module Finance
  ##
  # http://www.investopedia.com/articles/03/101503.asp
  #
  module Annuity
    ##
    # Determine the future value of an asset with 
    # reguar payments
    # rate - interest rate per period
    # nper - number of periods or duration
    # pmt - per period contribution
    # pv present value
    # type - 
    #     0:  end of period payments (ordinary annuity)
    #     1:  beginning of period payments (annuity due)
    #
    def future_value(rate,nper,pmt,pv = 0,type = 0)
      #calculate the fv of the payments
      fv = pmt * fv_compounding(rate,nper)
      #calculate the fv of the initial investment
      fvii = pv * (1+rate)**nper
      fv + fvii
    end
    ##
    # Determine the present value of an asset with 
    # reguar payments
    # rate - interest rate / period
    # nper - number of periods or duration
    # pmt - per period contribution
    # fv - future value
    # type - 
    #     0:  end of period payments (ordinary annuity)
    #     1:  beginning of period payments (annuity due)
    #
    def present_value(rate,nper,pmt,fv=0,type = 0)
      #present value of the payments
      pv = pmt * pv_compounding(rate,nper)
      
    end

    def cash_flow(rate,nper,pv = 0,fv=0,type =0)
      if(pv > 0)
        pmt = pv / pv_compounding(rate,nper)
      elsif(fv > 0)
        pmt = fv / fv_compounding(rate,nper)
      else
        0
      end
    end

    private 
      def pv_compounding(rate,nper)
        (1-((1+rate)**-nper)) /
        rate
      end
      def fv_compounding(rate,nper)
        ((1+rate)**nper -1) / 
        rate
      end
  end
end
