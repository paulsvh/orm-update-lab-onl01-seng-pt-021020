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

  def self.drop_table
    sql = "drop table students"
    DB[:conn].execute(sql)
  end

  def save
    if self.id
      self.update
    else
      sql = <<-SQL
        insert into students (name, grade)
        values (?, ?)
        SQL
      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("select last_insert_rowid() from songs")[0][0]
    end
  end

  def self.create(:name, :grade)
    student = student.new(name, grade)
    student.save
    student
  end


end

# Remember, you can access your database connection anywhere in this class
#  with DB[:conn]
