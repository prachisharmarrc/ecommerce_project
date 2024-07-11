require 'faker'
require 'open-uri'

# Clear existing data
CartItem.delete_all
Cart.delete_all
OrderItem.delete_all
Order.delete_all
Product.delete_all
Category.delete_all
User.delete_all
Tax.delete_all
StaticPage.delete_all  # Clear existing static pages

# Create a user
user = User.create!(
  email: 'user@example.com',
  password: 'password',
  address: '123 Main St',
  city: 'Winnipeg',
  province: 'MB',
  postal_code: 'R3C 0A1'
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
    product_name: "#{Faker::Color.color_name.capitalize} #{['T-Shirt', 'Tee', 'Top', 'Shirt'].sample}",
    description: Faker::Marketing.buzzwords,
    price: Faker::Commerce.price(range: 10.0..100.0),
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

# Create taxes
Tax.create!(region: 'MB', tax_type: 'GST', tax_rate: 0.05)
Tax.create!(region: 'MB', tax_type: 'PST', tax_rate: 0.07)
Tax.create!(region: 'ON', tax_type: 'HST', tax_rate: 0.13)
Tax.create!(region: 'BC', tax_type: 'GST', tax_rate: 0.05)
Tax.create!(region: 'BC', tax_type: 'PST', tax_rate: 0.07)

# Create static pages
StaticPage.create!(title: 'Contact', content: 'Initial contact page content.')
StaticPage.create!(title: 'About', content: 'Initial about page content.')

# Display the number of products by category
categories.each do |category|
  puts "Category: #{category.category_name} - #{category.products.count} products"
end

puts "Seeded #{Category.count} categories, #{Product.count} products, and #{StaticPage.count} static pages."
