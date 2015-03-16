require 'finance'

describe Finance::Annuity do
  subject {
    Class.new {
      include Finance::Annuity
    }.new
  }
  it "should calulate the future value of an investment with regular payments" do
    expect(subject.future_value(0.03/12,20,1000).round(2)).to eq(20482.20)
  end
  it "should calulate the future value of an investment with regular payments" do
    expect(subject.future_value(0.03/12,20,1000,10000).round(2)).to eq(30994.26)
  end
  
  # it "should calculate the present value of an existing investment with regular payments" do
  #   expect(subject.present_value(0.03/12,20,1000,20482.2).round(2)).to eq(0)
  # end

  # it "should calculate the present value of an existing investment with regular payments" do
  #   expect(subject.present_value(0.03/12,20,1000,100000).round(2)).to eq(114613.37)
  # end
  context "cash flow of an annuity" do
    it "should calculate the loan repayments required to pay back 100k over 5 years at 10%" do
      expect(subject.cash_flow(0.1,5,100000).round(2)).to eq(26379.75)
    end
    it "should calculate the payments required to rach a desired future value" do
      expect(subject.cash_flow(0.1,5,0,100000).round(2)).to eq(16379.75)
    end
  end

  context "present value of an annuity" do
    it "should calculate the following example from http://www.investopedia.com/articles/03/101503.asp correctly" do
      expect(subject.present_value(0.05,5,1000).round(2)).to eq(4329.48)
    end
    it "should calculate how much you need to have in the bank to spend 10k a year for 10 years with 5% interest" do
      expect(subject.present_value(0.05,25,10000).round(2)).to eq(140939.45)
    end


  end
  ##present value of an annuity
end
