# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

CSV.foreach(Rails.root.join('db/users.csv'), headers: true) do |row|
  User.create({
    username:        row["username"],
    password:        row["password"],
    role:            row["role"],
    address:         row["address"],
  })
end

CSV.foreach(Rails.root.join('db/orders.csv'), headers: true) do |row|
  Order.create({
    user_id:     User.find_by(username: row["username"]).id,
    description: row["description"],
    quantity:    row["quantity"],
    total:       row["total"],
    order_date:  DateTime.parse(row["order_date"])
  })
end


