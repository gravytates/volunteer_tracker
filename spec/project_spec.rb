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
end
