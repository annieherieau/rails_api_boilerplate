# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
Faker::Config.locale='fr'
Faker::UniqueGenerator.clear

# Supprimer toutes les données existantes
def reset_db
  User.destroy_all

  # reset table sequence
  ActiveRecord::Base.connection.tables.each do |t|
    # postgreSql
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
    # SQLite
    # ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = '#{t}'")
  end

  puts('drop and reset all tables')
end

def boolean_ratio(percent = 50)
  ratio = percent.to_f / 100
  Faker::Boolean.boolean(true_ratio: ratio)
end

def super_admin
  User.create!(
    email: ENV['ADMIN_EMAIL'],
    password: ENV['ADMIN_PASSWORD'],
    admin: true
  )
  puts("super Admin créé")
end

def create_users(number)
  number.times do |i|
    User.create!(
      # email: Faker::Internet.unique.email,
      email: "user#{i+1}@az.az",
      password: '123456',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name 
    )
  end
  puts("#{number} Users créés")
end

# PERFORM SEEDING
reset_db
create_users(2)