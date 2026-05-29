# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Idempotent seed data so the acceptance runner has something to exercise.
alice = User.find_or_create_by!(api_token: "tok-alice") { |u| u.name = "Alice" }
bob   = User.find_or_create_by!(api_token: "tok-bob")   { |u| u.name = "Bob" }

[["INV-1001", "2026-01-05", "120.00", "paid"],
 ["INV-1002", "2026-02-05", "120.00", "paid"]].each do |invoice_id, date, amount, status|
  alice.invoices.find_or_create_by!(invoice_id:) { |i| i.date = date; i.amount = amount; i.status = status }
end

bob.invoices.find_or_create_by!(invoice_id: "INV-2001") { |i| i.date = "2026-01-09"; i.amount = "90.00"; i.status = "open" }
