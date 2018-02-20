2.times do |t|
 Product.create(name: "тестовый товар №#{t}", price: 100, product_category_id: 1)
end  