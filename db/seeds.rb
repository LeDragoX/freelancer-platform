# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!({ email: "test@test.com", password: "123456" })
user2 = User.create!({ email: "user@email.com", password: "123456" })
freelancer = Freelancer.create!({ email: "test@test.com", password: "123456" })
freelancer2 = Freelancer.create!({ email: "freelancer@email.com", password: "123456" })

job_presencial = JobType.create!({ name: "Presencial" })
job_remoto = JobType.create!({ name: "Remoto" })
job_hibrido = JobType.create!({ name: "Híbrido" })

project = Project.create!({ title: "Sistema Web",
                            description: "Site de Fast Food por encomenda",
                            wanted_skills: "No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS",
                            max_hour_rate: 300, deadline: 4.month.from_now,
                            job_type: job_remoto, available: true, status: 1, user: user })

project = Project.create!({ title: "Atualização de Sistema Legado",
                            description: "Site feito com ASP 3.0, PHP e MySQL precisa ser migrado para tecnologias mais recentes",
                            wanted_skills: "No Back: NodeJS, PostgreSQL. No Front: React, Styled-Components, Sass, Bootstrap.",
                            max_hour_rate: 600, deadline: 3.month.from_now,
                            job_type: job_remoto, available: true, status: 1, user: user2 })