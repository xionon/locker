10.times do
  Product.create!(name: Faker::Commerce.product_name)
end

2.times do
  Order.create.tap do |order|
    10.times do
      Purchase.create(
        order: order,
        product: Product.all.sample
      )
    end
  end
end
