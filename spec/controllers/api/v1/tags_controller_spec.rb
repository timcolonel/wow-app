require 'rails_helper'

RSpec.describe Api::V1::TagsController, type: :controller do
  render_views

  describe 'GET #index' do
    before do
      get :index
    end

    it { expect(response).to be_success }
    it { expect(response).to have_http_status(200) }
    it { expect(response).to return_json }

    test_pagination :index, :tag
  end

  describe 'GET #show' do
    subject { FactoryGirl.create(:tag) }
    before do
      get :show, id: subject.id
    end

    it { expect(response).to be_success }
    it { expect(response).to have_http_status(200) }
    it { expect(response).to return_json }
    it { expect(json_response[:id]).to eq(subject.id) }
    it { expect(json_response[:name]).to eq(subject.name) }
  end

  describe 'GET #create' do
    let (:name) { Faker::Lorem.word }

    context 'when user is not signed in' do
      before do
        post :create, name: name
      end

      it { expect(response).to have_http_status(403) }
      it { expect(response).to return_json }
    end

    when_user_signed_in do
      before do
        post :create, name: name
      end
      it { expect(response).to be_success }
      it { expect(response).to have_http_status(201) }
      it { expect(response).to return_json }
    end
  end

  describe 'PATCH #update' do
    let (:subject) { FactoryGirl.create(:tag) }
    let (:name) { Faker::Lorem.word }

    context 'when user is not signed in' do
      before do
        patch :update, id: subject.id, name: name
      end

      it { expect(response).to have_http_status(403) }
      it { expect(response).to return_json }
      it { expect(json_response[:name]).not_to eq(name) }
    end

    when_user_signed_in do
      before do
        patch :update, id: subject.id, name: name
      end
      it { expect(response).to be_success }
      it { expect(response).to have_http_status(200) }
      it { expect(response).to return_json }
      it { expect(json_response[:id]).to eq(subject.id) }
      it { expect(json_response[:name]).to eq(name) }
    end
  end

  describe 'DELETE #destroy' do
    let (:subject) { FactoryGirl.create(:tag) }
    let (:name) { Faker::Lorem.word }

    context 'when user is not signed in' do
      before do
        delete :destroy, id: subject.id
      end

      it { expect(response).to have_http_status(403) }
      it { expect(response).to return_json }
    end

    when_user_signed_in do
      before do
        delete :destroy, id: subject.id
      end
      it { expect(response).to be_success }
      it { expect(response).to have_http_status(204) }
      it { expect(Tag.find_by_id(subject.id)).to be nil }
    end
  end
end