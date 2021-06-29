# frozen_string_literal: true

class AddPortfolioToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :portfolio, foreign_key: true
  end
end
