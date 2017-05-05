class Project
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes.fetch :name
    @id = attributes.fetch :id
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each do |project|
      name = project.fetch "name"
      id = project.fetch("id").to_i
      projects.push(Project.new({:name => name, :id => id}))
    end
    projects
  end

  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(another_project)
    (self.name == another_project.name) & (self.id == another_project.id)
  end


  def self.find(id)
    found_project = nil
    Project.all.each do |project|
      if project.id == id
        found_project = project
      end
    end
    found_project
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{self.id};")
  end

  def update(attributes)
    @name = attributes.fetch :name
    @id = self.id
    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
  end

  def volunteers
    project_volunteers = []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id};")
    volunteers.each do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      project_volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    project_volunteers
  end

  def self.project_search(query)
    found_projects = DB.exec("SELECT * FROM projects WHERE name LIKE '%#{query}%';")
    projects = []
    found_projects.each() do |project|
      name = project.fetch('name')
      id = project.fetch('id').to_i
      projects.push(Project.new({:name => name, :id => id}))
    end
    projects
  end
end
