class Currency < ApplicationRecord

    belongs_to :portfolio
    has_many :orders
end
