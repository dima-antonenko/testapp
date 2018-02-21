=begin

2.times do |t|
 Product.create(name: "тестовый товар №#{t}", price: 100, product_category_id: 1)
end 

=end


ProductCategory.create(name: 'Каталог', product_category_id: 0, is_root: true)