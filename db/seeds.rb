# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(email: 'nuua@nuua.com', password: ENV["NUUA_DB_PASS"], password_confirmation:ENV["NUUA_DB_PASS"] ) if Rails.env.development?AdminUser.create!(email: 'nuua@example.com', password: ENV["NUUA_DB_PASS"], password_confirmation: ENV["NUUA_DB_PASS"]) if Rails.env.development?
