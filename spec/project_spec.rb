require "spec_helper"

describe(Project) do
  describe ".all" do
    it('starts off with no projects') do
      expect(Project.all()).to(eq([]))
    end
  end

  describe "#id" do
    it('sets its ID when you save it') do
      project = Project.new({:name => "Riparian Restoration", :id => nil})
      project.save
      expect(project.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe "#save" do
    it('lets you save projects to the database') do
      project = Project.new({:name => "Riparian Restoration", :id => nil})
      project.save
      expect(Project.all).to(eq([project]))
    end
  end

  describe "#==" do
    it('is the same project if it has the same name') do
      project1 = Project.new({:name => "Riparian Restoration", :id => nil})
      project2 = Project.new({:name => "Riparian Restoration", :id => nil})
      expect(project1).to(eq(project2))
    end
  end

  describe "#delete" do
    it("lets you delete a project from the database") do
      project = Project.new({:name => "Riparian Restoration", :id => nil})
      project.save
      project2 = Project.new({:name => "Graffiti removal", :id => nil})
      project2.save
      project.delete
      expect(Project.all).to(eq([project2]))
    end

    it("deletes a project's volunteers from the database") do
      project = Project.new({:name => "Riparian Restoration", :id => nil})
      project.save
      volunteer = Volunteer.new({:name => "Fred", :hours => 0, :project_id => project.id, :id => nil})
      volunteer.save
      volunteer2 = Volunteer.new({:name => "Sara", :hours => 0, :project_id => project.id, :id => nil})
      volunteer2.save
      project.delete
      expect(Volunteer.all).to(eq([]))
    end
  end

  describe "#update" do
    it("lets you update projects in the database") do
      project = Project.new({:name => "Riparian Restoration", :id => nil})
      project.save
      project.update({:name => "Mudfest"})
      expect(project.name).to(eq("Mudfest"))
    end
  end

  describe("#project") do
    it('returns an array of volunteers for that project') do
      test_project = Project.new({:name => 'Riparian Restoration', :id => nil})
      test_project.save
      test_volunteer = Volunteer.new({:name => 'Fred', :hours => 0, :project_id => test_project.id, :id => nil})
      test_volunteer.save
      test_volunteer2 = Volunteer.new({:name => 'Frederick', :hours => 0, :project_id => test_project.id, :id => nil})
      test_volunteer2.save
      expect(test_project.volunteers).to(eq([test_volunteer, test_volunteer2]))
    end
  end

  describe ".order" do
    it("lets you sort projects alphabetically") do
      project = Project.new({:name => "Riparian Restoration", :id => nil})
      project.save
      project2 = Project.new({:name => "Graffiti removal", :id => nil})
      project2.save
      expect(Project.order).to(be_a(Array))
    end
  end
end
