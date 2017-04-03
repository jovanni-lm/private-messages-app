require 'rails_helper'

RSpec.describe MessagesCounter, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: 'messages/new').to route_to('messages#new')
    end

    it 'routes to #create' do
      expect(post: 'messages').to route_to('messages#create')
    end
  end
end
