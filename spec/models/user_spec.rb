# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when db schema' do
    let(:model) { described_class.column_names }

    %w[first_name last_name email encrypted_password role].each do |column|
      it "have column #{column}" do
        expect(model).to include(column)
      end
    end
  end

  context 'when validate' do
    %i[first_name last_name email].each do |field|
      subject { described_class.new }

      it { is_expected.to validate_presence_of(field) }
    end
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end
