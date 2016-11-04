require 'rails_helper'

describe URL do
  describe '#valid?' do
    context 'when url contains terms from black list' do
      it 'returns false' do
        URL::BLACK_LIST.each do |url|
          expect(URL.new("http://#{url}")).not_to be_valid
        end
      end

      it 'returns false' do
        expect(URL.new('http://youse-remembrall.herokuapp.com/')).not_to be_valid
      end
    end

    context 'when url does not contain invalid terms' do
      it 'returns true' do
        expect(URL.new('http://super-valid-url.com.br')).to be_valid
      end
    end
  end
end
