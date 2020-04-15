require_relative "../config/environment.rb"

class Student
attr_accessor :name, :grade
attr_reader :id

  def initialize(id = nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      create table if not exists students (
        id integer primary key,
        name text,
        grade integer
        )
        SQL
    DB[:conn].execute(sql)
  end


end

# Remember, you can access your database connection anywhere in this class
#  with DB[:conn]
