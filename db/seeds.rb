# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!({ email: 'user@test.com', password: '123456' })
user1 = User.create!({ email: 'test@test.com', password: '123456' })
freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
freelancer1 = Freelancer.create!({ email: 'test@test.com', password: '123456' })
freelancer2 = Freelancer.create!({ email: 'test2@test.com', password: '123456' })

job_presential = JobType.create!({ name: 'Presencial' })
job_remote = JobType.create!({ name: 'Remoto' })
job_hybrid = JobType.create!({ name: 'Híbrido' })

project = Project.create!({ title: 'Sistema Web',
                            description: 'Site de Fast Food por encomenda',
                            wanted_skills: 'No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS.',
                            max_hour_rate: 300, deadline: 4.months.from_now,
                            available: true, job_type: job_remote, user: user })

project2 = Project.create!({ title: 'Infraestrutura',
                             description: 'Realizar a migração da aplicação para a nuvem',
                             wanted_skills: 'Sistemas Linux, conhecimento em uma das Clouds atuais como AWS, Terraform, Oracle Cloud ou Azure e também em Docker. Ruby On Rails, NodeJS e conhecimento mínimo em Banco dados também é desejado.',
                             max_hour_rate: 1000, deadline: 1.month.from_now,
                             available: true, job_type: job_hybrid, user: user })

project3 = Project.create!({ title: 'Atualização de Sistema Legado',
                             description: 'Site feito com ASP 3.0, PHP e MySQL precisa ser migrado para tecnologias mais recentes.',
                             wanted_skills: 'No Back: NodeJS, PostgreSQL. No Front: React, Styled-Components, Sass, Bootstrap.',
                             max_hour_rate: 600, deadline: 3.months.from_now,
                             available: true, job_type: job_presential, user: user1 })

dba = OccupationArea.create!({ name: 'Administração de Banco de Dados' })
ads = OccupationArea.create!({ name: 'Analista e Desenvolvedor de Sistemas' })
bi = OccupationArea.create!({ name: 'Business Intelligence' })
cn = OccupationArea.create!({ name: 'Computação em Nuvem' })
ds = OccupationArea.create!({ name: 'Data Science' })
dw = OccupationArea.create!({ name: 'Desenvolvedor Web' })
gpq = OccupationArea.create!({ name: 'Gestão de Processos e Qualidade' })
gti = OccupationArea.create!({ name: 'Gestão de TI' })
gp = OccupationArea.create!({ name: 'Gestão de Projetos' })
hp = OccupationArea.create!({ name: 'Hardware e Periféricos' })
ib = OccupationArea.create!({ name: 'Informática Biomédica' })
jd = OccupationArea.create!({ name: 'Jogos digitais' })
dw = OccupationArea.create!({ name: 'Mídias sociais' })
qa = OccupationArea.create!({ name: 'Quality Assurance' })
pdt = OccupationArea.create!({ name: 'Pesquisador e Desenvolvedor Tecnológico' })
pdw = OccupationArea.create!({ name: 'Segurança de Sistemas' })
stti = OccupationArea.create!({ name: 'Suporte Técnico de TI' })
wb = OccupationArea.create!({ name: 'Web Designer' })

f_profile = Profile.create!({ full_name: 'Giovanni César Lima', social_name: 'Giovanni César',
                              birth_date: 32.years.ago, formation: 'Ciência da Computação',
                              description: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.',
                              photo: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg',
                              occupation_area: qa, freelancer: freelancer })

f_profile2 = Profile.create!({ full_name: 'Analu Silvana Andreia Ferreira', social_name: 'Analu Silvana',
                               birth_date: 29.years.ago, formation: 'Engenharia da Computação',
                               description: 'Sou uma profissional que sabe trabalhar em projetos grandes, com trabalho em equipe e sou autodidata.',
                               photo: 'https://c.tenor.com/OyIYV1OjcjQAAAAM/anime-fiduka.gif',
                               occupation_area: cn, freelancer: freelancer1 })

p_experience = Experience.create!({ title: 'Fast Entregas', started_at: 6.years.ago, ended_at: 5.years.ago,
                                    description: 'Desenvolvedor Full-Stack Junior',
                                    profile: f_profile })

p_experience2 = Experience.create!({ title: 'Disney', started_at: 5.years.ago, ended_at: Time.now.to_date,
                                     description: 'Realizo parte da programação por trás das animações e cenas com muitos efeitos.',
                                     profile: f_profile })

p_experience3 = Experience.create!({ title: 'Valve', started_at: 10.years.ago, ended_at: Time.now.to_date,
                                     description: 'Trabalho com APIs de e-commerces, para consumir dentro da Loja da Steam. Sempre há algum trabalho de re-design, refatoração, e limpeza de código para realizar.',
                                     profile: f_profile2 })

f_proposal = Proposal.create!({ description: 'Sonho com um projeto desses!',
                                hour_rate: 250, weekly_hours: 40, delivery_estimate: 6.months.from_now,
                                project: project, freelancer: freelancer })

f_proposal2 = Proposal.create!({ description: 'Possuo anos de experiência com Infraestrutura e Cloud...',
                                 hour_rate: 700, weekly_hours: 50, delivery_estimate: 4.months.from_now,
                                 project: project2, freelancer: freelancer1 })
