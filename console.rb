require_relative('models/customers')
require_relative('models/films')
require_relative('models/tickets')

require('pry')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()



film1= Film.new({ 'title' => 'Aquaman', 'price' => 12})
film1.save
film2= Film.new({'title' => 'Glass', 'price' => 10})
film2.save

customer1= Customer.new({'name' => 'Bob', 'funds' => 20})
customer1.save
customer2= Customer.new({'name' => 'Bill', 'funds' => 15})
customer2.save

ticket1= Ticket.new({'films_id' => film1.id, 'customer_id' => customer1.id})
ticket1.save
ticket2= Ticket.new({'films_id' => film2.id, 'customer_id' => customer2.id})
ticket2.save

film1.title = 'Broly'
film1.update()

customer1.name = 'James'
customer1.update()

ticket1.customer_id = customer2.id
ticket1.update()




binding.pry
nil
