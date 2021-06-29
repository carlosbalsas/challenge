# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(email: 'test@test.com', password: '123456')
user.save!
currencies = Currency.create!([{ name: 'BTC' }, { name: 'EUR' }, { name: 'XLM' }, { name: 'ADA' }])

currencies.each(&:save!)

portfolio = Portfolio.create!(user_id: 1)
portfolio.save!
Portfolio.last.currencies = Currency.all
ada = Portfolio.last.currencies.last
ada.amount = 1000
ada.save
