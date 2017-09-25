class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_one :brand, dependent: :destroy
  has_one :submission, dependent: :destroy

  accepts_nested_attributes_for :brand,
    allow_destroy: true

  validates :name,
    :organisation,
    :organisation_turnover,
    :organisation_size,
    :digital_size,
    presence: true

  def self.turnover
    [
      'Extra Small <£10,000',
      'Small £10,001-£100,000',
      'Medium £100,001-£1m',
      'Large £1m-£10m',
      'Extra Large >£10m'
    ]
  end

  def self.employees
    [
      '0',
      '1-5',
      '6-15',
      '16-50',
      '51-100',
      '101-500',
      '501-2500',
      '2500+'
    ]
  end

  def self.digital
    [
      '0',
      '1',
      '2-4',
      '5-7',
      '8-10',
      '11-15',
      '16-20',
      '21-30',
      '31-40',
      '40+'
    ]
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end
end
