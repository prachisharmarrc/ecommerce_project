require 'faker'

# Clear existing data
CartItem.delete_all
Cart.delete_all
OrderItem.delete_all
Order.delete_all
Product.delete_all
Category.delete_all

# Create categories
categories = [
  Category.create!(category_name: "Men's T-Shirts"),
  Category.create!(category_name: "Women's T-Shirts"),
  Category.create!(category_name: "Kids' T-Shirts"),
  Category.create!(category_name: "Custom Design T-Shirts")
]

# Create products with images from Lorem Picsum
100.times do
  Product.create!(
    product_name: "#{Faker::Color.color_name.capitalize} #{['T-Shirt', 'Tee', 'Top', 'Shirt'].sample}",
    description: Faker::Marketing.buzzwords,
    price: Faker::Commerce.price(range: 10.0..100.0),
    stock_quantity: Faker::Number.between(from: 1, to: 100),
    category: categories.sample,
    image_url: "https://picsum.photos/200/300?random=#{rand(1..1000)}"
  )
end

# Display the number of products by category
categories.each do |category|
  puts "Category: #{category.category_name} - #{category.products.count} products"
end

puts "Seeded #{Category.count} categories and #{Product.count} products."
