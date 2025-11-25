# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data
puts "Clearing existing data..."
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
Category.destroy_all
Address.destroy_all
User.destroy_all
Province.destroy_all
Page.destroy_all

puts "Creating provinces with tax rates..."

# Canadian Provinces with correct tax rates (as of 2024)
provinces_data = [
  { name: 'Alberta', abbreviation: 'AB', gst_rate: 0.05, pst_rate: 0.0, hst_rate: 0.0 },
  { name: 'British Columbia', abbreviation: 'BC', gst_rate: 0.05, pst_rate: 0.07, hst_rate: 0.0 },
  { name: 'Manitoba', abbreviation: 'MB', gst_rate: 0.05, pst_rate: 0.07, hst_rate: 0.0 },
  { name: 'New Brunswick', abbreviation: 'NB', gst_rate: 0.0, pst_rate: 0.0, hst_rate: 0.15 },
  { name: 'Newfoundland and Labrador', abbreviation: 'NL', gst_rate: 0.0, pst_rate: 0.0, hst_rate: 0.15 },
  { name: 'Northwest Territories', abbreviation: 'NT', gst_rate: 0.05, pst_rate: 0.0, hst_rate: 0.0 },
  { name: 'Nova Scotia', abbreviation: 'NS', gst_rate: 0.0, pst_rate: 0.0, hst_rate: 0.15 },
  { name: 'Nunavut', abbreviation: 'NU', gst_rate: 0.05, pst_rate: 0.0, hst_rate: 0.0 },
  { name: 'Ontario', abbreviation: 'ON', gst_rate: 0.0, pst_rate: 0.0, hst_rate: 0.13 },
  { name: 'Prince Edward Island', abbreviation: 'PE', gst_rate: 0.0, pst_rate: 0.0, hst_rate: 0.15 },
  { name: 'Quebec', abbreviation: 'QC', gst_rate: 0.05, pst_rate: 0.09975, hst_rate: 0.0 },
  { name: 'Saskatchewan', abbreviation: 'SK', gst_rate: 0.05, pst_rate: 0.06, hst_rate: 0.0 },
  { name: 'Yukon', abbreviation: 'YT', gst_rate: 0.05, pst_rate: 0.0, hst_rate: 0.0 }
]

provinces_data.each do |province_data|
  Province.create!(province_data)
end

puts "Created #{Province.count} provinces"

puts "Creating categories..."

# Music store categories
categories_data = [
  { name: 'Guitars', description: 'Acoustic, electric, and bass guitars' },
  { name: 'Drums & Percussion', description: 'Drum kits, cymbals, and percussion instruments' },
  { name: 'Keyboards & Pianos', description: 'Digital pianos, synthesizers, and MIDI controllers' },
  { name: 'Band Instruments', description: 'Brass, woodwind, and orchestral instruments' },
  { name: 'Amplifiers', description: 'Guitar amps, bass amps, and PA systems' },
  { name: 'Effects & Pedals', description: 'Guitar pedals and effects processors' },
  { name: 'Accessories', description: 'Strings, picks, stands, cases, and cables' },
  { name: 'Sheet Music & Books', description: 'Sheet music, method books, and instructional materials' }
]

categories_data.each do |category_data|
  Category.create!(category_data)
end

puts "Created #{Category.count} categories"

puts "Creating products..."

# Get category references
guitars = Category.find_by(name: 'Guitars')
drums = Category.find_by(name: 'Drums & Percussion')
keyboards = Category.find_by(name: 'Keyboards & Pianos')
band_instruments = Category.find_by(name: 'Band Instruments')
amplifiers = Category.find_by(name: 'Amplifiers')
effects = Category.find_by(name: 'Effects & Pedals')
accessories = Category.find_by(name: 'Accessories')
sheet_music = Category.find_by(name: 'Sheet Music & Books')

products_data = [
  # Guitars
  { name: 'Fender Stratocaster Electric Guitar', description: 'Classic American-made electric guitar with three single-coil pickups and versatile tone options.', price: 1299.99, category: guitars, stock_quantity: 5, featured: true },
  { name: 'Gibson Les Paul Standard', description: 'Iconic electric guitar with dual humbuckers and mahogany body for rich, warm tones.', price: 2499.99, category: guitars, stock_quantity: 3, featured: true },
  { name: 'Yamaha FG800 Acoustic Guitar', description: 'Affordable solid-top acoustic guitar perfect for beginners and intermediate players.', price: 249.99, category: guitars, stock_quantity: 12 },
  { name: 'Ibanez SR300E Bass Guitar', description: '4-string electric bass with active electronics and lightweight body.', price: 449.99, category: guitars, stock_quantity: 8 },
  { name: 'Taylor 214ce Acoustic-Electric', description: 'Premium acoustic-electric with solid Sitka spruce top and built-in electronics.', price: 999.99, category: guitars, stock_quantity: 4, on_sale: true, sale_price: 899.99 },

  # Drums & Percussion
  { name: 'Pearl Export 5-Piece Drum Kit', description: 'Complete drum kit with hardware and cymbals, perfect for rock and pop.', price: 899.99, category: drums, stock_quantity: 3, featured: true },
  { name: 'Zildjian A Custom Cymbal Set', description: 'Professional cymbal pack including hi-hats, crash, and ride cymbals.', price: 799.99, category: drums, stock_quantity: 6 },
  { name: 'Roland TD-17KVX Electronic Drums', description: 'Advanced electronic drum kit with mesh heads and superior sound engine.', price: 1699.99, category: drums, stock_quantity: 2 },
  { name: 'LP Aspire Bongo Set', description: 'Hand percussion bongos with natural wood finish.', price: 129.99, category: drums, stock_quantity: 15 },

  # Keyboards & Pianos
  { name: 'Yamaha P-45 Digital Piano', description: '88-key weighted digital piano with realistic piano sound.', price: 549.99, category: keyboards, stock_quantity: 7, featured: true },
  { name: 'Korg MicroKorg Synthesizer', description: 'Compact analog modeling synthesizer with vocoder.', price: 449.99, category: keyboards, stock_quantity: 5 },
  { name: 'Roland FP-30X Digital Piano', description: 'Portable 88-key digital piano with Bluetooth connectivity.', price: 799.99, category: keyboards, stock_quantity: 4, on_sale: true, sale_price: 749.99 },
  { name: 'Casio CT-S300 Keyboard', description: 'Portable 61-key keyboard perfect for beginners.', price: 199.99, category: keyboards, stock_quantity: 20 },

  # Band Instruments
  { name: 'Yamaha YAS-280 Alto Saxophone', description: 'Student alto saxophone with excellent intonation and tone.', price: 1299.99, category: band_instruments, stock_quantity: 4 },
  { name: 'Bach TR300H2 Trumpet', description: 'Student trumpet with durable construction and great sound.', price: 649.99, category: band_instruments, stock_quantity: 6 },
  { name: 'Pearl Quantz PFP-105E Flute', description: 'Silver-plated concert flute for intermediate players.', price: 899.99, category: band_instruments, stock_quantity: 3 },
  { name: 'Buffet E11 Bb Clarinet', description: 'Professional-quality clarinet with grenadilla wood body.', price: 1499.99, category: band_instruments, stock_quantity: 2 },

  # Amplifiers
  { name: 'Fender Champion 40 Guitar Amp', description: '40-watt combo amp with multiple built-in effects.', price: 249.99, category: amplifiers, stock_quantity: 10 },
  { name: 'Marshall MG50GFX Half Stack', description: 'Iconic Marshall sound in a 50-watt half stack configuration.', price: 499.99, category: amplifiers, stock_quantity: 5, featured: true },
  { name: 'Ampeg BA-108 Bass Amp', description: 'Compact 20-watt bass combo perfect for practice.', price: 149.99, category: amplifiers, stock_quantity: 12 },
  { name: 'Orange Crush 20RT Guitar Amp', description: '20-watt combo with built-in reverb and tuner.', price: 199.99, category: amplifiers, stock_quantity: 8 },

  # Effects & Pedals
  { name: 'Boss DS-1 Distortion Pedal', description: 'Classic distortion pedal used by countless guitarists.', price: 69.99, category: effects, stock_quantity: 25 },
  { name: 'Electro-Harmonix Big Muff Pi', description: 'Legendary fuzz pedal with sustain and rich harmonics.', price: 89.99, category: effects, stock_quantity: 18 },
  { name: 'TC Electronic Hall of Fame Reverb', description: 'Versatile reverb pedal with TonePrint technology.', price: 149.99, category: effects, stock_quantity: 15 },
  { name: 'MXR Carbon Copy Analog Delay', description: 'Warm analog delay with modulation control.', price: 179.99, category: effects, stock_quantity: 12, on_sale: true, sale_price: 159.99 },
  { name: 'Dunlop Cry Baby Wah Pedal', description: 'The most recognizable wah pedal in rock history.', price: 99.99, category: effects, stock_quantity: 20 },

  # Accessories
  { name: "D'Addario EXL110 Guitar Strings", description: 'Regular light gauge electric guitar strings (10-46).', price: 7.99, category: accessories, stock_quantity: 100 },
  { name: 'Fender Premium Guitar Cable 10ft', description: 'Professional-grade instrument cable with lifetime warranty.', price: 24.99, category: accessories, stock_quantity: 50 },
  { name: 'Hercules GS414B Guitar Stand', description: 'Auto-grip system safely holds electric or acoustic guitars.', price: 39.99, category: accessories, stock_quantity: 30 },
  { name: 'Shure SM57 Microphone', description: 'Industry-standard dynamic microphone for instruments.', price: 119.99, category: accessories, stock_quantity: 15 },
  { name: 'Planet Waves Guitar Strap', description: 'Comfortable padded guitar strap with leather ends.', price: 19.99, category: accessories, stock_quantity: 60 },

  # Sheet Music & Books
  { name: 'Hal Leonard Guitar Method Book 1', description: 'Best-selling guitar instruction book for beginners.', price: 14.99, category: sheet_music, stock_quantity: 40 },
  { name: 'Alfred Basic Piano Library Level 1', description: 'Comprehensive piano method for beginning students.', price: 12.99, category: sheet_music, stock_quantity: 35 },
  { name: 'Real Book Vol 1 (Sixth Edition)', description: 'Jazz standards fake book - the definitive collection.', price: 49.99, category: sheet_music, stock_quantity: 20 },
  { name: 'Essential Elements for Band Book 1', description: 'Comprehensive band method for all instruments.', price: 9.99, category: sheet_music, stock_quantity: 50 }
]

products_data.each do |product_data|
  Product.create!(product_data)
end

puts "Created #{Product.count} products"

puts "Creating admin user..."

# Create admin user
admin = User.create!(
  email: 'admin@intothemusic.com',
  first_name: 'Admin',
  last_name: 'User',
  admin: true
)

puts "Created admin user: #{admin.email}"

puts "Creating sample customer..."

# Create sample customer with address
mb_province = Province.find_by(abbreviation: 'MB')

customer = User.create!(
  email: 'customer@example.com',
  first_name: 'John',
  last_name: 'Doe',
  admin: false
)

Address.create!(
  user: customer,
  street_address: '123 Main Street',
  city: 'Winnipeg',
  province: mb_province,
  postal_code: 'R3C 1A5'
)

puts "Created sample customer: #{customer.email}"

puts "Creating About and Contact pages..."

Page.create!(
  title: 'About Us',
  slug: 'about',
  content: 'Into the Music has been serving Winnipeg musicians for 4 years. We are a small, locally-owned music store specializing in guitars, drums, keyboards, band instruments, amplifiers, and accessories. Our passionate team of 3 (including our owner) is dedicated to helping musicians of all levels find the perfect instrument and gear for their musical journey.'
)

Page.create!(
  title: 'Contact Us',
  slug: 'contact',
  content: 'Visit us at our Winnipeg location or contact us by phone or email. We are open Monday-Saturday 10am-6pm. Phone: (204) 555-MUSIC | Email: info@intothemusic.com'
)

puts "Created #{Page.count} pages"

puts "\n"
puts "=" * 50
puts "SEED DATA COMPLETE!"
puts "=" * 50
puts "Provinces: #{Province.count}"
puts "Categories: #{Category.count}"
puts "Products: #{Product.count}"
puts "Users: #{User.count}"
puts "Pages: #{Page.count}"
puts "\nAdmin login: admin@intothemusic.com"
puts "Customer login: customer@example.com"
puts "=" * 50