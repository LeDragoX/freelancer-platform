# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!({ email: "test@test.com", password: "123456" })
freelancer = Freelancer.create!({ email: "test@test.com", password: "123456" })

# enum status: { presential: 1, remote: 2, hybrid: 3 }

project = Project.create!({ title: "Sistema Web", description: "Site para cadastro de Comidas da pizzaria Zé Delivery",
                            wanted_skills: "No Back: NodeJS; PostgresSQL. No Front: VueJS",
                            max_hour_rate: 600, deadline: 6.month.from_now,
                            job_type: 1, available: true, status: 1, user: user })