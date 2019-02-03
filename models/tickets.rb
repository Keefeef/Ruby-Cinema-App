require_relative('../db/sql_runner')

class Ticket

  attr_accessor :customer_id, :films_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @customer_id = options['customer_id'].to_i
    @films_id = options['films_id'].to_i
  end

  def save()
  sql = "INSERT INTO tickets (customer_id, films_id) VALUES ($1, $2) RETURNING id"
  values = [@customer_id, @films_id]
  ticket = SqlRunner.run(sql, values).first
  @id = ticket['id'].to_i
end

def self.all()
  sql = "SELECT * FROM tickets"
  tickets = SqlRunner.run(sql)
  result = tickets.map { |ticket| Ticket.new(ticket)}
  return result
end

def self.delete_all()
  sql = "DELETE FROM tickets"
  SqlRunner.run(sql)
end

def update()
  sql = "UPDATE tickets SET (customer_id, films_id) = ($1, $2)
  WHERE id = $3"
  values = [@customer_id, @films_id, @id]
  updated_ticket = SqlRunner.run(sql, values)
  result = updated_ticket.map{|ticket| Ticket.new(ticket)}
end

def delete()
  sql = "DELETE FROM tickets WHERE id = $1"
  values = [@id]
  tickets = SqlRunner.run(sql, values)
  result = tickets.map{|ticket| Ticket.new(ticket)}
end


end
