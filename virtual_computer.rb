class Computer

  @@users = {}

  def initialize(username, password)
    @username = username
    @password = password
    @files = {}
    @@users[username] = password
  end

  def create(filename)
    time = Time.now
    @files[filename] = time
    puts "A new file #{filename} was created at #{time} by #{@username}."
  end

  def delete(filename)
    time = Time.now
    @files.delete(filename)
    puts "File #{filename} was deleted at #{time} by #{@username}."
  end

  def Computer.get_users
    @@users
  end
end

my_computer = Computer.new('Mike', 123456)

my_computer.create("text.txt")
my_computer.create("example.txt")
my_computer.delete("text.txt")

puts "Users: #{Computer.get_users}"
