require_relative('../db/sql_runner')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @name = options['name']
    @funds = options['funds']
  end


  def save()
  sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
  values = [@name, @funds]
  customer = SqlRunner.run(sql, values).first
  @id = customer['id'].to_i
end

def films()
  sql = "SELECT films.* FROM films
  INNER JOIN tickets
  ON tickets.films_id = films.id
  WHERE tickets.customer_id = $1"
  values = [@id]
  films = SqlRunner.run(sql, values)
  result = films.map { |film| Film.new(film)}
end

def self.all()
  sql = "SELECT * FROM customers"
  customers = SqlRunner.run(sql)
  result = customers.map { |customer| Customer.new( customer )}
  return result
end

def self.delete_all()
  sql = "DELETE FROM customers"
  values = []
  SqlRunner.run(sql, values)
end

def update()
  sql = "UPDATE customers SET (name, funds) = ($1, $2)
  WHERE id = $3"
  values = [@name, @funds, @id]
  updated_customer = SqlRunner.run(sql, values)
  result = updated_customer.map{|customer| Customer.new( customer )}
end


def delete()
  sql = "DELETE FROM customers WHERE id = $1"
  values = [@id]
  customers = SqlRunner.run(sql, values)
  result = customers.map{|customer| Customer.new(customer)}
end

end
