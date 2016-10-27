require 'rails_helper'

describe Message do
  describe '#links' do
    context 'when message is nil' do
      it 'returns an empty list' do
        expect(Message.new.links).to be_empty
      end
    end

    context 'when message is blank' do
      it 'returns an empty list' do
        expect(Message.new('').links).to be_empty
      end
    end

    context 'when message does not contain links' do
      it 'returns an empty list' do
        expect(Message.new('this is a valid message with no links in it').links).to be_empty
      end
    end

    context 'when message contains one link' do
      it 'returns a list with one url' do
        message = Message.new('check out this page: http://www.google.com.br')
        expect(message.links).to eq(['http://www.google.com.br'])
      end
    end

    context 'when message contains many links' do
      it 'returns a list of links' do
        message = Message.new('check out http://www.google.com.br and http://www.youse.com.br')
        expect(message.links).to eq(['http://www.google.com.br', 'http://www.youse.com.br'])
      end
    end
  end
end
