require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'with a read attribute' do
    let(:message) do
      Message.new(body: 'lorem ipsum dolor',
                  user_id: 1,
                  recipient_id: 2)
    end

    it 'bes unread when message created' do
      expect(message).to_not be_read
    end

    it 'bes unread when message created via read? method' do
      expect(message.read?).to be_falsey
    end

    describe '.read' do
      context 'when read' do
        before { message.read! }
        it { expect(message).to be_read }
      end
    end
  end

  context 'with a user attribute' do
    let(:user) do
      User.new(username: 'author_test',
               email: 'lorem@ipsum.ts')
    end

    let(:message) do
      Message.new(body: 'lorem ipsum dolor',
                  user: user,
                  recipient_id: 2)
    end

    context 'message author is the current user' do
      it 'is successful' do
        expect(message.is_user_author?(user)).to be_truthy
      end
    end
  end
end
