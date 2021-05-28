# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Destroying old records'
User.destroy_all
Location.destroy_all
puts 'Seeding started'
puts 'Creating Locations'

bom_data_links = {
  'NSW' => 'ftp://ftp.bom.gov.au/anon/gen/fwo/IDN11020.xml',
  'QLD' => 'ftp://ftp.bom.gov.au/anon/gen/fwo/IDQ10606.xml',
  'SA' => 'ftp://ftp.bom.gov.au/anon/gen/fwo/IDS11055.xml',
  'TAS' => 'ftp://ftp.bom.gov.au/anon/gen/fwo/IDT16000.xml',
  'VIC' => 'ftp://ftp.bom.gov.au/anon/gen/fwo/IDV10750.xml',
  'WA' => 'ftp://ftp.bom.gov.au/anon/gen/fwo/IDW13010.xml'
}

bom_data_links.each do |state, link|
  region_data = Hash.from_xml(Nokogiri::XML(URI.open(link)).to_s)
  regions = region_data['product']['forecast']['area'].map{|h| h['description']}.drop(1)
  regions.each do |region|
    Location.create(state: state, region: state + ' - ' + region)
  end
end

Location.create(state: 'NT', region: 'NT - North')
Location.create(state: 'NT', region: 'NT - Central')
Location.create(state: 'NT', region: 'NT - South')

puts 'Creating admin account'

user = User.create(
  username: 'admin',
  email: 'admin@gmail.com',
  password: 'password123',
  admin: true
)

profile = user.create_profile(
  first_name: 'Admin',
  last_name: 'Tester',
  user_type: 1,
  location: Location.find(93)
)

puts 'Creating fake users, profiles and listings'

20.times {
  user = User.create(
    username: Faker::Internet.username,
    email: Faker::Internet.safe_email,
    password: Faker::Internet.password(min_length: 8)
  )

  puts user.errors.full_messages

  offset = rand(Location.count)
  profile = user.create_profile(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    user_type: rand(1..4),
    location: Location.offset(offset).first
  )
  puts profile.errors.full_messages

  make = Faker::Vehicle.make

  listing = nil

  rand(1..2).times {
    listing = user.listings.create(
      ad_type: rand(1..2),
      status: 1,
      price: rand(10..1000) * 100,
      year: Faker::Vehicle.year,
      make: make,
      model: Faker::Vehicle.model(make_of_model: make),
      odometer: Faker::Vehicle.kilometrage,
      engine: Faker::Vehicle.engine,
      transmission: Faker::Vehicle.transmission,
      trim: 'base model',
      body_style: Faker::Vehicle.car_type,
      registration_number: Faker::Vehicle.license_plate,
      roadworthy: rand(1..3),
      condition: rand(1..4),
      description: Faker::Vehicle.standard_specs[0]
    )
  }
  puts listing.errors.full_messages
}

puts 'Seeding succesfull!'
