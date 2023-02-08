namespace :dev do
  desc "Configs the development environment"
  task setup: :environment do
    puts "Reseting the databse..."
    %x(rails db:drop db:create db:migrate)

    puts "Registering the types of contacts..."

    kinds = %w(Friend Comercial Known) # %w it is a shortcut so we dont need to put quotes

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end

    puts "Type of contacts successfully registered"

    puts "Registering the types of contacts..."
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )
    end

    puts "Contacts successfully registered!"

    puts "Registering the telephones of the contacts..."
    
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = Phone.create!(number:Faker::PhoneNumber.cell_phone)
        contact.phones << phone
        contact.save!
      end
    end

    puts "Telephones successfully registered!"

    puts "Registering the address of the contacts..."
    
    Contact.all.each do |contact|
      Address.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end

    puts "Address successfully registered!"

  end

end
