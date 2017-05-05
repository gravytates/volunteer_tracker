class Volunteer
  attr_reader :name, :hours, :project_id, :id

  def initialize(attributes)
    @name = attributes.fetch :name
# binding.pry
    @hours = attributes.fetch(:hours).to_i
    @project_id = attributes.fetch :project_id
    @id = attributes.fetch :id
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each do |volunteer|
      name = volunteer.fetch "name"
      hours = volunteer.fetch("hours").to_i
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:name => name, :hours => hours, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, hours, project_id) VALUES ('#{@name}', #{hours}, #{project_id}) RETURNING id;")
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

  def update_hours(attributes)
    @hours = attributes.fetch :hours
    @id = self.id
    DB.exec("UPDATE volunteers SET hours = '#{@hours}' WHERE id = #{@id};")
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

  def self.order_hours
    DB.exec("SELECT * FROM volunteers ORDER BY hours").to_a
  end
end
