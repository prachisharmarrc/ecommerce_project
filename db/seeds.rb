require "faker"
require "open-uri"

# Clear existing data
CartItem.delete_all
Cart.delete_all
OrderItem.delete_all
Order.delete_all
Product.delete_all
Category.delete_all
User.delete_all
Tax.delete_all
StaticPage.delete_all # Clear existing static pages
Province.delete_all # Clear existing provinces

# Seed provinces
provinces = [
  { name: "Alberta", abbreviation: "AB" },
  { name: "British Columbia", abbreviation: "BC" },
  { name: "Manitoba", abbreviation: "MB" },
  { name: "New Brunswick", abbreviation: "NB" },
  { name: "Newfoundland and Labrador", abbreviation: "NL" },
  { name: "Nova Scotia", abbreviation: "NS" },
  { name: "Ontario", abbreviation: "ON" },
  { name: "Prince Edward Island", abbreviation: "PE" },
  { name: "Quebec", abbreviation: "QC" },
  { name: "Saskatchewan", abbreviation: "SK" },
  { name: "Northwest Territories", abbreviation: "NT" },
  { name: "Nunavut", abbreviation: "NU" },
  { name: "Yukon", abbreviation: "YT" }
]

provinces.each do |province|
  Province.create!(name: province[:name], abbreviation: province[:abbreviation])
end

# Create a user
User.create!(
  email:       "user@example.com",
  password:    "password",
  address:     "123 Main St",
  city:        "Winnipeg",
  province:    Province.find_by(abbreviation: "MB"),
  postal_code: "R3C 0A1"
)

# Create categories
categories = [
  Category.create!(category_name: "Men's T-Shirts"),
  Category.create!(category_name: "Women's T-Shirts"),
  Category.create!(category_name: "Kids' T-Shirts"),
  Category.create!(category_name: "Custom Design T-Shirts")
]

# Create products with static images from Lorem Picsum
100.times do
  product = Product.new(
    product_name:   "#{Faker::Color.color_name.capitalize} #{['T-Shirt', 'Tee', 'Top',
                                                              'Shirt'].sample}",
    description:    Faker::Marketing.buzzwords,
    price:          Faker::Commerce.price(range: 10.0..100.0),
    stock_quantity: Faker::Number.between(from: 1, to: 100)
  )

  # Attach an image to the product
  image_file = URI.open("https://picsum.photos/seed/#{Faker::Alphanumeric.alphanumeric(number: 10)}/200/300")
  product.image.attach(io: image_file, filename: "image.jpg")

  # Save the product
  product.save!

  # Associate each product with one or more categories
  categories.sample(rand(1..4)).each do |category|
    product.categories << category
  end
end

# Seed taxes for provinces
taxes = [
  { region: "AB", tax_type: "GST", tax_rate: 0.05 },
  { region: "BC", tax_type: "GST", tax_rate: 0.05 },
  { region: "BC", tax_type: "PST", tax_rate: 0.07 },
  { region: "MB", tax_type: "GST", tax_rate: 0.05 },
  { region: "MB", tax_type: "PST", tax_rate: 0.07 },
  { region: "NB", tax_type: "HST", tax_rate: 0.15 },
  { region: "NL", tax_type: "HST", tax_rate: 0.15 },
  { region: "NS", tax_type: "HST", tax_rate: 0.15 },
  { region: "ON", tax_type: "HST", tax_rate: 0.13 },
  { region: "PE", tax_type: "HST", tax_rate: 0.15 },
  { region: "QC", tax_type: "GST", tax_rate: 0.05 },
  { region: "QC", tax_type: "PST", tax_rate: 0.09975 },
  { region: "SK", tax_type: "GST", tax_rate: 0.05 },
  { region: "SK", tax_type: "PST", tax_rate: 0.06 },
  { region: "NT", tax_type: "GST", tax_rate: 0.05 },
  { region: "NU", tax_type: "GST", tax_rate: 0.05 },
  { region: "YT", tax_type: "GST", tax_rate: 0.05 }
]

taxes.each do |tax|
  Tax.create!(region: tax[:region], tax_type: tax[:tax_type], tax_rate: tax[:tax_rate])
end

# Create static pages
StaticPage.create!(title: "Contact", content: "Initial contact page content.")
StaticPage.create!(title: "About", content: "Initial about page content.")

# Display the number of products by category
categories.each do |category|
  puts "Category: #{category.category_name} - #{category.products.count} products"
end

Rails.logger.debug "Seeded #{Province.count} provinces, #{Category.count} categories, #{Product.count} products, and #{StaticPage.count} static pages."
