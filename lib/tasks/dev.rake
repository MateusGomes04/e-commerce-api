namespace :dev do
  desc "TODO"
  task population: :environment do

  if Rails.env.development?

    show_spinner("Droping Database...") {%x(rails db:drop)}
    show_spinner("Creating Database...") {%x(rails db:create)} 
    show_spinner("Migrating Database...") {%x(rails db:migrate)}
    show_spinner("Registering the Default User...") {%x(rails dev:add_default_user)}
    show_spinner("Registering the Address User...") {%x(rails dev:add_address_user)}
    show_spinner("Registering the Brands...") {%x(rails dev:add_brands)}
    show_spinner("Registering the Carts...") {%x(rails dev:add_carts)}
    show_spinner("Registering the Products...") {%x(rails dev:add_products)}
    show_spinner("Registering the CartItems...") {%x(rails dev:add_cart_items)}
   
    
    else
      puts "You are not in the development envrioment to run this!!"
    end
  end

    #  desc "adiciona os usuarios padrao"
    task add_default_user: :environment do
    10.times do |i|
    User.create!(
      email: Faker::Internet.email,
      name: Faker::Name.name,
      phone: Faker::PhoneNumber.cell_phone,
      password: "123456",
      role: 0
    )
    end
  end

    task add_address_user: :environment do
      10.times do |i|
      Address.create!(
        address: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        postal_code: Faker::Address.zip_code,
        user: User.all.sample
      )
      end
    end

    task add_brands: :environment do
      Brand.create!(
        name: "motorola"
      )
      Brand.create!(
        name: "iphone"
      )
      Brand.create!(
        name: "samsung"
      )

    end

    task add_carts: :environment do
      5.times do |i|
       Cart.create!()
      end
    end

    task add_products: :environment do
      20.times do |i|
        Product.create!(
          name: Faker::Device.model_name,
          price_in_cent: rand(10000..90000) / 100,
          description: Faker::Device.platform,
          brand: Brand.all.sample
      )
      end
    end

    task add_cart_items: :environment do
      10.times do |i|
        CartItem.create!(
          quantity: rand(10),
          price_unit: rand(1000..9000),
          cart: Cart.all.sample,
          product: Product.all.sample
      )
      end
    end

    task add_orders: :environment do
      10.times do |i|
        Order.create!(
          value_total: rand(10),
          user: User.all.sample,
          address: Address.all.sample
      )
      end
    end


    task add_order_items: :environment do
      5.times do |i|
        OrderItem.create!(
          order: Order.all.sample,
          cart_items: CartItem.all.sample
        )
      end
    end

  
  private
    def show_spinner(msg_start)
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin
      yield
      spinner.success('(task completed!)')
  
  end
end
