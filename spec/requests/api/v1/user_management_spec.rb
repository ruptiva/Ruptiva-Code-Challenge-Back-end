# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User management', type: :request do
  let(:unauthorized_message) { t('devise.failure.user.unauthenticated') }

  context 'POST /api/v1/sign_in' do
    context 'when user doesnt exists' do
      let(:unauthorized_message) do
        t('activerecord.errors.messages.user.invalid_session')
      end

      before { post user_session_path }
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(j_body['errors']).to eq(unauthorized_message) }
    end

    context 'when user exists' do
      let(:user) { create(:user) }

      context 'when params are wrong' do
        let(:unauthorized_message) do
          t('activerecord.errors.messages.user.invalid_session')
        end
        let(:wrong_params) do
          {
            user: {
              email: user.email
            }
          }
        end

        before do
          post user_session_path, params: wrong_params
        end

        it { expect(response).to have_http_status(:unprocessable_entity) }
        it { expect(j_body['errors']).to eq(unauthorized_message) }
      end

      context 'when params are right' do
        let(:expected_params) do
          {
            user: {
              email: user.email,
              password: user.password
            }
          }
        end

        before do
          post user_session_path, params: expected_params
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(headers['Authorization']).to be_present }
      end
    end
  end

  context 'POST /api/v1/sign_up' do
    context 'when params are wrong' do
      let(:wrong_params) { { user: {} } }

      before { post user_registration_path, params: wrong_params }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it do
        j_body['errors'].each do |error|
          expect(error.last).to eq(
            [t(
              "activerecord.errors.models.user.attributes.#{error.first}.blank"
            )]
          )
        end
      end
    end

    context 'when params are right' do
      let(:expected_params) do
        { user: attributes_for(:user) }
      end

      before { post user_registration_path, params: expected_params }

      it { expect(response).to have_http_status(:created) }

      %w[first_name last_name email role authentication_token].each do |field|
        it "create with right #{field}" do
          expect(j_body[field]).to eq(User.last.send(field))
        end
      end
    end

    context 'when user already exists' do
      let(:user) { create(:user) }
      let(:expected_params) do
        { user: user.attributes }
      end

      before { post user_registration_path, params: expected_params }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it do
        expect(j_body['errors'].first.last).to eq(
          [t('activerecord.errors.models.user.attributes.email.taken')]
        )
      end
    end
  end

  context 'GET /api/v1/users' do
    context 'when user is not logged' do
      before { get api_v1_users_path }
      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(j_body['errors']).to eq(unauthorized_message) }
    end

    context 'when user is logged' do
      let(:user) { create(:user) }
      let(:token) { user.authentication_token }

      context 'when user is not permitted' do
        let(:expected_error) do
          t('activerecord.errors.messages.pundit.unauthorized')
        end

        before { get api_v1_users_path, headers: { Authorization: token } }

        it { expect(response).to have_http_status(:unauthorized) }
        it { expect(j_body['errors']).to eq(expected_error) }
      end
    end

    context 'when user is permitted' do
      let(:user) { create(:user_admin) }
      let(:token) { user.authentication_token }

      before { get api_v1_users_path, headers: { Authorization: token } }

      it { expect(response).to have_http_status(:ok) }
    end
  end

  context 'GET /api/v1/users/:id' do
    context 'when user is not logged' do
      before { get api_v1_user_path(0) }
      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(j_body['errors']).to eq(unauthorized_message) }
    end

    context 'when user is not permitted' do
      let(:expected_error) do
        t('activerecord.errors.messages.pundit.unauthorized')
      end
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }
      let(:token) { user.authentication_token }

      before do
        get api_v1_user_path(another_user), headers: { Authorization: token }
      end

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(j_body['errors']).to eq(expected_error) }
    end

    context 'when user is permitted to access any use' do
      let(:user) { create(:user_admin) }
      let(:another_user) { create(:user) }
      let(:token) { user.authentication_token }

      before do
        get api_v1_user_path(another_user), headers: { Authorization: token }
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(j_body['id'].to_i).to eq(another_user.id) }
    end

    context 'when user is permitted to access him self' do
      let(:user) { create(:user) }
      let(:token) { user.authentication_token }

      before do
        get api_v1_user_path(user), headers: { Authorization: token }
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(j_body['id'].to_i).to eq(user.id) }
    end
  end

  context 'PUT /api/v1/users/:id' do
    context 'when user is not logged' do
      before { put api_v1_user_path(0) }
      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(j_body['errors']).to eq(unauthorized_message) }
    end

    context 'when user is not permitted' do
      let(:expected_error) do
        t('activerecord.errors.messages.pundit.unauthorized')
      end
      let(:expected_params) do
        { user: { first_name: 'teste' } }
      end
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }
      let(:token) { user.authentication_token }

      before do
        put api_v1_user_path(another_user), headers: { Authorization: token },
                                            params: expected_params
      end

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(j_body['errors']).to eq(expected_error) }
    end

    context 'when user is permitted to access any use' do
      let(:expected_params) do
        { user: { first_name: 'teste' } }
      end
      let(:user) { create(:user_admin) }
      let(:another_user) { create(:user) }
      let(:token) { user.authentication_token }

      before do
        put api_v1_user_path(another_user), headers: { Authorization: token },
                                            params: expected_params
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(j_body['id'].to_i).to eq(another_user.id) }
    end

    context 'when user is permitted to access him self' do
      let(:expected_params) do
        { user: { first_name: 'teste' } }
      end
      let(:user) { create(:user) }
      let(:token) { user.authentication_token }

      before do
        put api_v1_user_path(user), headers: { Authorization: token },
                                    params: expected_params
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(j_body['id'].to_i).to eq(user.id) }
    end
  end

  context 'DELETE /api/v1/users/:id' do
    context 'when user is not logged' do
      before { delete api_v1_user_path(0) }
      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(j_body['errors']).to eq(unauthorized_message) }
    end

    context 'when user is not permitted' do
      let(:expected_error) do
        t('activerecord.errors.messages.pundit.unauthorized')
      end
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }
      let(:token) { user.authentication_token }

      before do
        delete api_v1_user_path(another_user), headers: { Authorization: token }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when user is permitted to access any use' do
      let(:user) { create(:user_admin) }
      let(:another_user) { create(:user) }
      let(:token) { user.authentication_token }

      before do
        delete api_v1_user_path(another_user), headers: { Authorization: token }
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'when user is permitted to access him self' do
      let(:user) { create(:user) }
      let(:token) { user.authentication_token }

      before do
        delete api_v1_user_path(user), headers: { Authorization: token }
      end

      it { expect(response).to have_http_status(:no_content) }
    end
  end
end
