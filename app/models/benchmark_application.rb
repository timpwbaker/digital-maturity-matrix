class BenchmarkApplication < ActiveRecord::Base
  belongs_to :user, :foreign_key =>"user_id"

  validates :organisation_name, presence: true
  validates :opt_in, :acceptance => {:accept => true}

  def self.turnover
	    [
	      "under £20,000",
	      "£20,001 - £100,000",
	      "under £100,000 - £500,000",
	      "£500,000 - £1m",
	      "£1m - £5m",
	      "£5m - £20m",
	      "£20m - £100m",
	      "£100m+",
	    ]
  	end
  	def self.employees
	    [
	      "1-5",
	      "6-15",
	      "16-50",
	      "50-100",
	      "100-500",
	      "500-2500",
	      "2500+",
	    ]
  	end
  	def self.digital
	    [
	      "1",
	      "1-3",
	      "3-8",
	      "8-15",
	      "15-30",
	      "30-50",
	      "50+",
	    ]
  	end

  def process_payment
    customer = Stripe::Customer.create card: card_token, email: email
                                       

    Stripe::Charge.create customer: customer.id,
                          amount: 5000,
                          description: "description",
                          currency: 'gbp'

	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to new_charge_path

  end
end
