require 'cancan/matchers'
require 'spec_helper'

describe 'User' do
  describe 'abilities' do
    subject(:ability) { Ability.new(user) }

    let(:user) { nil }
    let(:blocked) do
      User.new(username: 'blocked user',
               email: 'blocked@user.ts',
               blocked: true)
    end

    context 'when is an admin' do
      let(:user) { User.new(admin: true) }

      it { should be_able_to(:manage, User.new) }
      it { should be_able_to(:manage, blocked) }
    end

    context 'when is simple user' do
      let(:user) { User.new }

      it { should_not be_able_to(:manage, user) }
      it { should be_able_to(:edit, user) }
      it { should_not be_able_to(:show, blocked) }
      it { should_not be_able_to(:show, user) }
    end
  end
end
