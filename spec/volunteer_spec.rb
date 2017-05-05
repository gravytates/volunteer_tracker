require('spec_helper')

describe(Volunteer) do
  describe '.all' do
    it("is empty at first") do
      expect(Volunteer.all).to(eq([]))
    end
  end

  describe "#save" do
    it("adds a volunteer to the array of saved volunteers") do
      test_volunteer = Volunteer.new({:name => "Fred", :project_id => 1, :id => nil})
      test_volunteer.save
      expect(Volunteer.all).to(eq([test_volunteer]))
    end
  end

  describe "#name" do
    it("lets you read the name out") do
      test_volunteer = Volunteer.new({:name => "Fred", :project_id => 1, :id => nil})
      expect(test_volunteer.name).to(eq("Fred"))
    end
  end

  describe "#project_id" do
    it('lets you read the project ID out') do
      test_volunteer = Volunteer.new({:name => "Fred", :project_id => 1, :id => nil})
      expect(test_volunteer.project_id).to(eq(1))
    end
  end

  describe "#==" do
    it("is the same volunteer if it has the same name") do
      volunteer1 = Volunteer.new({:name => "Fred", :project_id => 1, :id => nil})
      volunteer2 = Volunteer.new({:name => "Fred", :project_id => 1, :id => nil})
      expect(volunteer1).to(eq(volunteer2))
    end
  end

  describe "#delete" do
    it("lets you delete a volunteer from the database") do
      volunteer = Volunteer.new({:name => "Fred", :project_id => 1, :id => nil})
      volunteer.save
      volunteer2 = Volunteer.new({:name => "Joe", :project_id => 1, :id => nil})
      volunteer2.save
      volunteer.delete
      expect(Volunteer.all).to(eq([volunteer2]))
    end
  end
end
