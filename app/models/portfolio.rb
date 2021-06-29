class Portfolio < ApplicationRecord
    
    has_many :currencies, dependent: :destroy
    belongs_to  :user
end
