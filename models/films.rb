require_relative('../db/sql_runner')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
  sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
  values = [@title, @price]
  film = SqlRunner.run(sql, values).first
  @id = film['id'].to_i
end

def customers()
  sql = "SELECT customers.* FROM customers
  INNER JOIN tickets
  ON tickets.customer_id = customer.id
  WHERE tickets.films_id = $1"
  values = [@id]
  customers = SqlRunner.run(sql, values)
  result = customers.map{ |customer| Customer.new(customer)}
end

def self.all()
  sql = "SELECT * FROM films"
  films = SqlRunner.run(sql)
  result = films.map{ |film| Film.new( film )}
  return result
end

def self.delete_all()
  sql = "DELETE FROM films"
  values = []
  SqlRunner.run(sql, values)
end

def update()
  sql = "UPDATE films SET (title, price) = ($1, $2)
  WHERE id = $3"
  values = [@title, @price, @id]
  updated_film = SqlRunner.run(sql, values)
  result = updated_film.map{|film| Film.new( film )}
end

def delete()
  sql = "DELETE FROM films WHERE id = $1"
  values = [@id]
  films = SqlRunner.run(sql, values)
  result = films.map{|film| Film.new(film)}
end

end
