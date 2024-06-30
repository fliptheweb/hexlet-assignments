10.times do |index|
  Task.create(
    name: "Task #{index}",
    description: Faker::Lorem.paragraph,
    creator: Faker::Name.unique.name,
    performer: Faker::Name.unique.name,
    status: "new",
  )
end
