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
  # GUITARS (30 products)
  { name: 'Fender Stratocaster Electric Guitar', description: 'Classic American-made electric guitar with three single-coil pickups and versatile tone options.', price: 1299.99, category: guitars, stock_quantity: 5, featured: true },
  { name: 'Gibson Les Paul Standard', description: 'Iconic electric guitar with dual humbuckers and mahogany body for rich, warm tones.', price: 2499.99, category: guitars, stock_quantity: 3, featured: true },
  { name: 'Yamaha FG800 Acoustic Guitar', description: 'Affordable solid-top acoustic guitar perfect for beginners and intermediate players.', price: 249.99, category: guitars, stock_quantity: 12 },
  { name: 'Ibanez SR300E Bass Guitar', description: '4-string electric bass with active electronics and lightweight body.', price: 449.99, category: guitars, stock_quantity: 8 },
  { name: 'Taylor 214ce Acoustic-Electric', description: 'Premium acoustic-electric with solid Sitka spruce top and built-in electronics.', price: 999.99, category: guitars, stock_quantity: 4, on_sale: true, sale_price: 899.99 },
  { name: 'PRS SE Custom 24', description: 'Versatile guitar with coil-split humbuckers and beautiful figured maple top.', price: 699.99, category: guitars, stock_quantity: 6 },
  { name: 'Epiphone SG Standard', description: 'Affordable take on the classic SG design with dual humbuckers.', price: 379.99, category: guitars, stock_quantity: 10, on_sale: true, sale_price: 329.99 },
  { name: 'Fender Player Telecaster', description: 'Classic Tele twang with modern updates and comfortable playability.', price: 749.99, category: guitars, stock_quantity: 7 },
  { name: 'Martin D-28 Acoustic', description: 'Legendary dreadnought with rich bass and clear trebles.', price: 3199.99, category: guitars, stock_quantity: 2, featured: true },
  { name: 'Gretsch G5420T Electromatic', description: 'Hollow body electric with classic rockabilly tone.', price: 599.99, category: guitars, stock_quantity: 5 },
  
  { name: 'Squier Affinity Stratocaster', description: 'Budget-friendly Strat for beginners with great playability.', price: 229.99, category: guitars, stock_quantity: 15 },
  { name: 'Schecter Hellraiser C-1', description: 'Metal machine with EMG pickups and sustainer system.', price: 899.99, category: guitars, stock_quantity: 4 },
  { name: 'Jackson Dinky JS32', description: 'Shred-ready guitar with fast neck and hot humbuckers.', price: 349.99, category: guitars, stock_quantity: 8 },
  { name: 'ESP LTD EC-256', description: 'Les Paul-style guitar with great value and tone.', price: 449.99, category: guitars, stock_quantity: 6 },
  { name: 'Music Man StingRay Bass', description: 'Iconic bass with punchy active electronics.', price: 1899.99, category: guitars, stock_quantity: 3 },
  { name: 'Fender Jazz Bass', description: 'Versatile bass guitar with dual single-coil pickups.', price: 849.99, category: guitars, stock_quantity: 5 },
  { name: 'Rickenbacker 4003 Bass', description: 'Legendary bass with distinctive jangly tone.', price: 2299.99, category: guitars, stock_quantity: 2, featured: true },
  { name: 'Warwick Corvette Bass', description: 'German-made bass with active MEC pickups.', price: 1599.99, category: guitars, stock_quantity: 3 },
  { name: 'Ibanez Gio GRG121DX', description: 'Entry-level shred guitar with HSH pickup configuration.', price: 199.99, category: guitars, stock_quantity: 12 },
  { name: 'Yamaha Pacifica 112V', description: 'Versatile beginner guitar with HSS pickups.', price: 299.99, category: guitars, stock_quantity: 10 },
  { name: 'Seagull S6 Original', description: 'Canadian-made acoustic with rich cedar top.', price: 479.99, category: guitars, stock_quantity: 7 },
  { name: 'Ovation Celebrity Elite', description: 'Acoustic-electric with distinctive round back.', price: 599.99, category: guitars, stock_quantity: 5 },
  { name: 'Guild D-240E Acoustic', description: 'Affordable solid-top dreadnought with electronics.', price: 549.99, category: guitars, stock_quantity: 6 },
  { name: 'Takamine GD20-NS', description: 'Great value acoustic with natural finish.', price: 329.99, category: guitars, stock_quantity: 9 },
  { name: 'Breedlove Pursuit Concert', description: 'Comfortable smaller-body acoustic guitar.', price: 399.99, category: guitars, stock_quantity: 7 },
  { name: 'Chapman ML1 Modern', description: 'Modern guitar with versatile pickup switching.', price: 699.99, category: guitars, stock_quantity: 4 },
  { name: 'Sterling by Music Man SUB Series', description: 'Affordable version of Music Man classics.', price: 449.99, category: guitars, stock_quantity: 6 },
  { name: 'Squier Classic Vibe 60s Jazzmaster', description: 'Vintage-style offset with modern playability.', price: 449.99, category: guitars, stock_quantity: 5 },
  { name: 'Danelectro 56 Single Cutaway', description: 'Retro guitar with unique lipstick pickups.', price: 499.99, category: guitars, stock_quantity: 4 },
  { name: 'Hofner Ignition Beatles Bass', description: 'Classic violin bass made famous by Paul McCartney.', price: 499.99, category: guitars, stock_quantity: 3 },

  { name: 'Fender Stratocaster', description: 'Classic American-made electric guitar with three single-coil pickups and versatile tone options.', price: 1299.99, category: guitars, stock_quantity: 5, featured: true },
  { name: 'Gibson Les Paul', description: 'Iconic electric guitar with dual humbuckers and mahogany body for rich, warm tones.', price: 2499.99, category: guitars, stock_quantity: 7, featured: true },
  { name: 'Yamaha Acoustic Guitar', description: 'Affordable solid-top acoustic guitar perfect for beginners and intermediate players.', price: 249.99, category: guitars, stock_quantity: 6 },
  { name: 'Ibanez  Bass Guitar', description: '4-string electric bass with active electronics and lightweight body.', price: 449.99, category: guitars, stock_quantity: 5 },
  { name: 'Taylor 2142ce Acoustic-Electric', description: 'Premium acoustic-electric with solid Sitka spruce top and built-in electronics.', price: 999.99, category: guitars, stock_quantity: 4, on_sale: true, sale_price: 899.99 },
  { name: 'PRS SE Custom 25', description: 'Versatile guitar with coil-split humbuckers and beautiful figured maple top.', price: 799.99, category: guitars, stock_quantity: 4 },
  { name: 'Epiphone SJ Standard', description: 'Affordable take on the classic SG design with dual humbuckers.', price: 3379.99, category: guitars, stock_quantity: 10, on_sale: true, sale_price: 329.99 },
  { name: 'Fender Player Telecaster', description: 'Classic Tele twang with modern updates and comfortable playability.', price: 749.99, category: guitars, stock_quantity: 2 },
  { name: 'Martin D-29 Acoustic', description: 'Legendary dreadnought with rich bass and clear trebles.', price: 199.99, category: guitars, stock_quantity: 6, featured: true },
  { name: 'Gretsch G5422T Electromatic', description: 'Hollow body electric with classic rockabilly tone.', price: 5399.99, category: guitars, stock_quantity: 9 },
  # DRUMS & PERCUSSION (25 products)
  { name: 'Pearl Export 5-Piece Drum Kit', description: 'Complete drum kit with hardware and cymbals, perfect for rock and pop.', price: 899.99, category: drums, stock_quantity: 3, featured: true },
  { name: 'Zildjian A Custom Cymbal Set', description: 'Professional cymbal pack including hi-hats, crash, and ride cymbals.', price: 799.99, category: drums, stock_quantity: 6 },
  { name: 'Roland TD-17KVX Electronic Drums', description: 'Advanced electronic drum kit with mesh heads and superior sound engine.', price: 1699.99, category: drums, stock_quantity: 2 },
  { name: 'LP Aspire Bongo Set', description: 'Hand percussion bongos with natural wood finish.', price: 129.99, category: drums, stock_quantity: 15 },
  { name: 'Tama Imperialstar 5-Piece', description: 'Great starter kit with excellent build quality.', price: 699.99, category: drums, stock_quantity: 4 },
  { name: 'Ludwig Breakbeats by Questlove', description: 'Compact 4-piece kit perfect for small spaces.', price: 449.99, category: drums, stock_quantity: 5, on_sale: true, sale_price: 399.99 },
  { name: 'Mapex Armory Series', description: 'Mid-range kit with birch/maple hybrid shells.', price: 1099.99, category: drums, stock_quantity: 3 },
  { name: 'Gretsch Catalina Club', description: 'Vintage-sized drums with modern tone.', price: 849.99, category: drums, stock_quantity: 4 },
  { name: 'Yamaha Stage Custom Birch', description: 'Professional-level kit at mid-range price.', price: 1299.99, category: drums, stock_quantity: 2, featured: true },
  { name: 'DW Performance Series', description: 'High-end drums with custom shell composition.', price: 2499.99, category: drums, stock_quantity: 1, featured: true },
  { name: 'Sabian AAX Stage Performance Set', description: 'Bright, cutting cymbals for live performance.', price: 699.99, category: drums, stock_quantity: 5 },
  { name: 'Meinl Byzance Traditional Cymbals', description: 'Hand-hammered Turkish cymbals with complex tone.', price: 899.99, category: drums, stock_quantity: 4 },
  { name: 'Paiste PST 7 Cymbal Pack', description: 'Affordable Swiss-made cymbals.', price: 399.99, category: drums, stock_quantity: 7 },
  { name: 'Roland TD-1DMK V-Drums', description: 'Compact electronic kit for home practice.', price: 499.99, category: drums, stock_quantity: 6 },
  { name: 'Alesis Nitro Mesh Kit', description: 'Budget electronic drums with mesh heads.', price: 379.99, category: drums, stock_quantity: 8 },
  { name: 'LP Compact Conga Set', description: 'Space-saving congas with full tone.', price: 299.99, category: drums, stock_quantity: 6 },
  { name: 'Meinl Djembe', description: 'West African hand drum with rope tuning.', price: 179.99, category: drums, stock_quantity: 10 },
  { name: 'LP Cajon', description: 'Peruvian box drum for unplugged performance.', price: 149.99, category: drums, stock_quantity: 12 },
  { name: 'Remo Practice Pad', description: 'Quiet practice pad with realistic feel.', price: 29.99, category: drums, stock_quantity: 25 },
  { name: 'Vic Firth American Classic 5A Sticks', description: 'Most popular drumstick model.', price: 12.99, category: drums, stock_quantity: 50 },
  { name: 'DW 5000 Series Kick Pedal', description: 'Professional single bass drum pedal.', price: 199.99, category: drums, stock_quantity: 8 },
  { name: 'Pearl P-930 Demonator Pedal', description: 'Smooth-action bass drum pedal.', price: 129.99, category: drums, stock_quantity: 10 },
  { name: 'Gibraltar 9706UA-TP Throne', description: 'Comfortable motorcycle-style drum throne.', price: 179.99, category: drums, stock_quantity: 6 },
  { name: 'Remo Emperor Coated Drumhead Pack', description: 'Warm, focused tone for toms.', price: 89.99, category: drums, stock_quantity: 15 },
  { name: 'Evans EMAD Bass Drum Head', description: 'Controlled low-end with punch.', price: 49.99, category: drums, stock_quantity: 12 },

  # KEYBOARDS & PIANOS (20 products)
  { name: 'Yamaha P-45 Digital Piano', description: '88-key weighted digital piano with realistic piano sound.', price: 549.99, category: keyboards, stock_quantity: 7, featured: true },
  { name: 'Korg MicroKorg Synthesizer', description: 'Compact analog modeling synthesizer with vocoder.', price: 449.99, category: keyboards, stock_quantity: 5 },
  { name: 'Roland FP-30X Digital Piano', description: 'Portable 88-key digital piano with Bluetooth connectivity.', price: 799.99, category: keyboards, stock_quantity: 4, on_sale: true, sale_price: 749.99 },
  { name: 'Casio CT-S300 Keyboard', description: 'Portable 61-key keyboard perfect for beginners.', price: 199.99, category: keyboards, stock_quantity: 20 },
  { name: 'Nord Stage 3', description: 'Professional stage piano with organ and synth engines.', price: 4299.99, category: keyboards, stock_quantity: 1, featured: true },
  { name: 'Kawai ES110 Digital Piano', description: 'Portable piano with Responsive Hammer Compact action.', price: 649.99, category: keyboards, stock_quantity: 5 },
  { name: 'Yamaha PSR-E373 Keyboard', description: '61-key portable keyboard with learning features.', price: 249.99, category: keyboards, stock_quantity: 12 },
  { name: 'Roland Juno-DS88', description: '88-key synthesizer workstation.', price: 999.99, category: keyboards, stock_quantity: 3 },
  { name: 'Korg Kronos 2 88', description: 'Flagship workstation with multiple sound engines.', price: 3799.99, category: keyboards, stock_quantity: 1, featured: true },
  { name: 'Arturia MiniLab MkII', description: 'Compact MIDI controller with software bundle.', price: 99.99, category: keyboards, stock_quantity: 15 },
  { name: 'Novation Launchkey 49 MkIII', description: 'MIDI controller with Ableton integration.', price: 219.99, category: keyboards, stock_quantity: 10 },
  { name: 'M-Audio Keystation 88', description: 'Budget 88-key MIDI controller.', price: 299.99, category: keyboards, stock_quantity: 8 },
  { name: 'Korg B2SP Digital Piano', description: 'Home digital piano with stand and pedals.', price: 599.99, category: keyboards, stock_quantity: 6 },
  { name: 'Yamaha MODX8', description: 'Motion control synthesis workstation.', price: 1699.99, category: keyboards, stock_quantity: 2 },
  { name: 'Casio Privia PX-S1100', description: 'Slim portable digital piano.', price: 749.99, category: keyboards, stock_quantity: 5 },
  { name: 'Roland GO:PIANO', description: 'Entry-level 61-key digital piano.', price: 329.99, category: keyboards, stock_quantity: 10 },
  { name: 'Behringer DeepMind 12', description: 'Analog synthesizer with 12 voices.', price: 999.99, category: keyboards, stock_quantity: 3 },
  { name: 'Moog Subsequent 25', description: 'Compact analog synth with legendary Moog sound.', price: 899.99, category: keyboards, stock_quantity: 2 },
  { name: 'Sequential Prophet Rev2', description: 'Modern classic analog synth.', price: 1499.99, category: keyboards, stock_quantity: 2 },
  { name: 'Teenage Engineering OP-1', description: 'Portable synthesizer with built-in sampler.', price: 1299.99, category: keyboards, stock_quantity: 3 },

  # BAND INSTRUMENTS (15 products)
  { name: 'Yamaha YAS-280 Alto Saxophone', description: 'Student alto saxophone with excellent intonation and tone.', price: 1299.99, category: band_instruments, stock_quantity: 4 },
  { name: 'Bach TR300H2 Trumpet', description: 'Student trumpet with durable construction and great sound.', price: 649.99, category: band_instruments, stock_quantity: 6 },
  { name: 'Pearl Quantz PFP-105E Flute', description: 'Silver-plated concert flute for intermediate players.', price: 899.99, category: band_instruments, stock_quantity: 3 },
  { name: 'Buffet E11 Bb Clarinet', description: 'Professional-quality clarinet with grenadilla wood body.', price: 1499.99, category: band_instruments, stock_quantity: 2 },
  { name: 'Selmer AS42 Alto Saxophone', description: 'Professional student model with excellent build quality.', price: 1899.99, category: band_instruments, stock_quantity: 3, featured: true },
  { name: 'Jupiter JTR700 Trumpet', description: 'Intermediate trumpet with rose brass bell.', price: 799.99, category: band_instruments, stock_quantity: 5 },
  { name: 'Yamaha YTR-2330 Trumpet', description: 'Affordable student trumpet.', price: 549.99, category: band_instruments, stock_quantity: 7 },
  { name: 'Blessing BTR-1460 Trombone', description: 'Student tenor trombone with F attachment.', price: 899.99, category: band_instruments, stock_quantity: 4 },
  { name: 'Yamaha YCL-255 Clarinet', description: 'Student clarinet with excellent response.', price: 549.99, category: band_instruments, stock_quantity: 6 },
  { name: 'Jupiter JFL700 Flute', description: 'Quality student flute with offset G.', price: 399.99, category: band_instruments, stock_quantity: 8 },
  { name: 'Jean Paul AS-400 Alto Sax', description: 'Budget alto saxophone for beginners.', price: 499.99, category: band_instruments, stock_quantity: 5 },
  { name: 'Mendini MCT-E Trumpet', description: 'Entry-level trumpet with case.', price: 179.99, category: band_instruments, stock_quantity: 10 },
  { name: 'Glory Professional Flute', description: 'Affordable closed-hole flute.', price: 129.99, category: band_instruments, stock_quantity: 12 },
  { name: 'Eastar EPC-1 Piccolo', description: 'ABS plastic piccolo for students.', price: 89.99, category: band_instruments, stock_quantity: 8 },
  { name: 'Mendini B Flat Clarinet', description: 'Complete beginner clarinet kit.', price: 139.99, category: band_instruments, stock_quantity: 10 },
]

products_data.each do |product_data|
  Product.create!(product_data)
end

puts "Created #{Product.count} products"

puts "Creating admin user..."

puts "Creating admin user..."

# Create admin user with strong password
admin = User.create!(
  email: 'admin@intothemusic.com',
  password: 'Password123!',
  password_confirmation: 'Password123!',
  first_name: 'Admin',
  last_name: 'User',
  admin: true
)

puts "Created admin user: #{admin.email} (Password: Password123!)"

puts "Creating sample customer..."

# Create sample customer with address
mb_province = Province.find_by(abbreviation: 'MB')

customer = User.create!(
  email: 'customer@example.com',
  password: 'Password123!',
  password_confirmation: 'Password123!',
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

A# Create AdminUser for Active Admin login
AdminUser.find_or_create_by!(email: 'admin@intothemusic.com') do |admin_user|
  admin_user.password = 'Password123!'
  admin_user.password_confirmation = 'Password123!'
end

puts "Created AdminUser for Active Admin: admin@intothemusic.com (Password: Password123!)"