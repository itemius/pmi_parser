class Certificate < ActiveRecord::Base

  validates :last_name, :first_name, :city, :credential, :earned, :status, presence: true

  enum status: [:active, :retired]
end
