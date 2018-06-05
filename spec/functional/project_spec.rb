require 'spec_helper'

describe 'harvest projects' do
  let(:harvest) { Harvest.client(access_token: 'mytoken', account_id: '123') }

  describe 'projects' do
    let(:client) { create(:client) }
    let(:project) { create(:project, client: client) }
    let(:project_attributes) { FactoryBot.attributes_for(:project) }

    context 'allows to add projects' do
      before do
        allow(harvest.projects).to receive(:create).and_return(project)
        project = harvest.projects.create(project_attributes)
      end

      it 'should return true' do
        expect(project.name).to eql('Project Test')
      end
    end

    context 'allows to update projects' do
      before do
        allow(harvest.projects).to receive(:update).and_return(project)
        project.name = 'Updated Project'
        project = harvest.projects.update(project)
      end

      it 'should return true' do
        expect(project.name).to eql('Updated Project')
      end
    end

    context 'allows to remove projects' do
      before do
        allow(harvest.projects).to receive(:delete).and_return([])
        allow(harvest.projects).to receive(:all).and_return([])
        harvest.projects.delete(project)
      end

      it 'returns true' do
        expect(harvest.projects.all.select do |p|
          p.name == 'Updated Project'
        end).to eql([])
      end
    end
  end

  describe 'clients' do
    context 'allows activating and deactivating clients' do
      let(:active_project) { create(:project, :active) }
      let(:deactive_project) { create(:project, :deactive) }

      before do
        allow(harvest.projects).to receive(:deactivate)
          .and_return(deactive_project)
        allow(harvest.projects).to receive(:activate)
          .and_return(active_project)
      end

      it 'should be active' do
        expect(active_project).to be_active
      end

      it 'should be deactive' do
        project = harvest.projects.deactivate(project)
        expect(deactive_project).not_to be_active
      end

      it 'should reactive a project' do
        project = harvest.projects.activate(project)
        expect(active_project).to be_active
      end
    end
  end
end
