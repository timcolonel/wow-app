require 'rails_helper'
RSpec.describe Api::V1::PackagesController, type: :controller do
  render_views

  describe 'GET #index' do
    before do
      get :index
    end

    it { expect(response).to be_success }
    it { expect(response).to have_http_status(200) }
    it { expect(response).to return_json }

    test_pagination :index, :package
  end

  describe 'GET #show' do
    subject { FactoryGirl.create(:package) }
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
    let(:authors) {
      [{name: 'Author 1', email: Faker::Internet.email}, {name: 'Author 2', email: Faker::Internet.email}]
    }
    let(:params) { {name: Faker::App.name,
                    homepage: Faker::Internet.url,
                    short_description: Faker::Lorem.sentence,
                    description: Faker::Lorem.paragraph,
                    authors: authors}
    }


    context 'when user is not signed in' do
      before do
        post :create, params
      end

      it { expect(response).to have_http_status(403) }
      it { expect(response).to return_json }
    end

    when_user_signed_in do
      it_create_a(Package).with { params }.and_compare_params { params.except(:authors) }

      it 'set authors correctly' do
        post :create, params
        json =json_response
        expect(json[:authors]).to be_an Array
        expect(json[:authors].size).to eq(authors.size)

        authors.each_with_index do |author_hash, i|
          expect(json[:authors][i][:name]).to eq(author_hash[:name])
          expect(json[:authors][i][:email]).to eq(author_hash[:email])
        end
      end
    end
  end
end