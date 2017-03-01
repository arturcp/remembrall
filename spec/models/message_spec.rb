require 'rails_helper'

describe Message do
  describe '#urls' do
    context 'when message is nil' do
      it 'returns an empty list' do
        expect(Message.new.urls).to be_empty
      end
    end

    context 'when message is blank' do
      it 'returns an empty list' do
        expect(Message.new('').urls).to be_empty
      end
    end

    context 'when message does not contain urls' do
      it 'returns an empty list' do
        expect(Message.new('this is a valid message with no urls in it').urls).to be_empty
      end
    end

    context 'when message contains one link' do
      it 'returns a list with one url' do
        message = Message.new('check out this page: <http://www.google.com.br>')
        expect(message.urls).to eq(['http://www.google.com.br'])
      end
    end

    context 'when message contains many urls' do
      it 'returns a list of urls' do
        message = Message.new('check out <http://www.google.com.br> and <http://www.youse.com.br>')
        expect(message.urls).to eq(['http://www.google.com.br', 'http://www.youse.com.br'])
      end
    end
  end

  describe '#hashtags' do
    context 'when there are hashtags' do
      it 'captures all hashtags from the message' do
        message = Message.new('#tag <http://www.google.com.br> #ficaADica')
        expect(message.hashtags).to match_array(['tag', 'ficaADica'])
      end

      it 'ignores hashtags that are part of the url' do
        message = Message.new('#tag <http://www.google.com.br#anchor1> #ficaADica')
        expect(message.hashtags).to match_array(['tag', 'ficaADica'])
      end
    end

    context 'when there are no hashtags' do
      it 'returns an empty array' do
        message = Message.new('<http://www.google.com.br#test>')
        expect(message.hashtags).to be_empty
      end
    end
  end
end
