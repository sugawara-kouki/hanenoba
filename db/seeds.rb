# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end
puts "Admin user created: admin@example.com / password"

# イベント種別
badminton = EventType.find_or_create_by!(name: "バドミントン")
drinking = EventType.find_or_create_by!(name: "飲み会")
camp = EventType.find_or_create_by!(name: "合宿")
puts "Event types created: バドミントン, 飲み会, 合宿"

# 一般ユーザー（すべて承認待ち）
5.times do |i|
  index = i + 1
  User.find_or_create_by!(email: "dummy#{index}@example.com") do |user|
    user.name = "dummy_user#{index}"
    user.password = "password"
    user.password_confirmation = "password"
    user.approved = false
  end
end
puts "5 dummy users created (all pending approval)"

# イベント予定（5件、定員バラバラ）
events_data = [
  { title: "週末バドミントン練習会", event_type: badminton, capacity: 12, held_at: 2.days.from_now.change(hour: 10) },
  { title: "平日夜のバドミントン", event_type: badminton, capacity: 8, held_at: 4.days.from_now.change(hour: 19) },
  { title: "定期バドミントン", event_type: badminton, capacity: 16, held_at: 7.days.from_now.change(hour: 13) },
  { title: "親睦会（飲み会）", event_type: drinking, capacity: 20, held_at: 3.days.from_now.change(hour: 18) },
  { title: "春のバドミントン合宿", event_type: camp, capacity: 30, held_at: 14.days.from_now.change(hour: 9) }
]

events_data.each do |data|
  Event.find_or_create_by!(title: data[:title], held_at: data[:held_at]) do |event|
    event.event_type = data[:event_type]
    event.capacity = data[:capacity]
    event.location = "代々木体育館" if data[:event_type] == badminton
    event.location = "渋谷の居酒屋" if data[:event_type] == drinking
    event.location = "軽井沢" if data[:event_type] == camp
    event.status = :published
  end
end
puts "5 events created with varied capacities"
