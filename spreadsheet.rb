require 'bundler'
Bundler.require
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
)

# Define a minimal database schema
ActiveRecord::Schema.define do
    create_table :events, force: true do |t|
        t.string "name"
        t.float "points"
        t.float "buy_in"
        t.integer "entrants"
        t.date "date"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
    end
  
    create_table :players, force: true do |t|
        t.string "name"
        t.integer "points"
        t.float "prize_pool"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
        t.belongs_to :event, index: true
    
    end
  end
  # Define the models
  class Event < ActiveRecord::Base
    has_many :players
  end
  
  class Player < ActiveRecord::Base
    belongs_to :event
  end
  
session = GoogleDrive::Session.from_service_account_key("client-secret.json")

spreadsheet = session.spreadsheet_by_title("Poker tournaments data structure")
worksheet = spreadsheet.worksheets.first;


worksheet.rows.first(worksheet.num_rows).each do |row| 
    
   if row[0].include?('SHRS') 
    @eventName = '#' + row[0].split('#').last

    next
   end
   if row[0].include?('Place') 
    puts @eventName
    @event = Event.create(name: @eventName, points: row[2].to_f, buy_in: row[4].to_f, entrants: row[5].to_i, date: row[6] )
    @event.save!
    
    next
   end
   if (row[0] != '') 
    player = @event.players.create(name: row[1], points: row[2],prize_pool: row[3] )
    player.save!
   
   end
end
puts 'Done'
