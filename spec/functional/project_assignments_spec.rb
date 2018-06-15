require 'spec_helper'

describe 'harvest project assignments' do
  let(:harvest) { Harvest.client(access_token: 'mytoken', account_id: '123') }

  describe 'projects assignments' do
    let(:user) { create(:user) }
    let(:client) { create(:client) }
    let(:project) { create(:project, client: client) }
    let(:project_assignment) do
      create(:project_assignment, project: project, client: client)
    end
    let(:project_assignment_attributes) do
      FactoryBot.attributes_for(:project_assignment)
    end
    let(:project_assignments) { [project_assignment] }

    describe 'read' do
      context 'allows finding projects assignment with parameters' do
         before do
          allow(harvest.project_assignments).to receive(:all)
            .and_return(project_assignments)
          project_assignments = harvest.project_assignments.all(user)
        end

        it 'returns invoices' do
          expect(project_assignments.count).to eql(1)
        end
      end
    end
  end
end
