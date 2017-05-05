class Volunteer
  attr_reader :name, :project_id, :id

  def initialize(attributes)
    @name = attributes.fetch :name
    @project_id = attributes.fetch :project_id
    @id = attributes.fetch :id
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each do |volunteer|
      name = volunteer.fetch "name"
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{project_id}) RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(another_volunteer)
    (self.name == another_volunteer.name) & (self.project_id == another_volunteer.project_id)
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id};")
  end

  def update(attributes)
    @name = attributes.fetch :name
    @id = self.id
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

  def self.find(id)
    found_volunteer = nil
    Volunteer.all.each do |volunteer|
      if volunteer.id == id
        found_volunteer = volunteer
      end
    end
    found_volunteer
  end

  def self.volunteer_search(query)
    found_volunteers = DB.exec("SELECT * FROM volunteers WHERE name LIKE '%#{query}%';")
    volunteers = []
    found_volunteers.each() do |volunteer|
      name = volunteer.fetch('name')
      project_id = volunteer.fetch('project_id').to_i
      id = volunteer.fetch('id').to_i
      volunteers.push(Project.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def self.order
    DB.exec("SELECT * FROM volunteers ORDER BY name").to_a
  end
end
