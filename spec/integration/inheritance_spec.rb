require 'spec_helper'

describe 'inheritance' do
  describe_example 'properties/inheritance' do
    context 'parent class properties' do
      subject { @parent.resource }

      it 'does not add properties to the parent' do
        expect(subject.length).to eq 2
        expect(subject).not_to have_key(:root_access)
      end

      it 'does not override parent properties' do
        expect(subject[:document]).to eq('1234')
      end
    end

    context 'child class properties' do
      subject { @root.resource }

      it 'overrides property configuration' do
        expect(subject[:document]).not_to eq '1234'
        expect(subject[:document]).to eq 1234
      end

      it 'includes the class properties' do
        expect(subject.length).to eq 3
        expect(subject.keys).to include(:root_access)
      end

      it 'includes parent class properties' do
        expect(subject.keys).to include(:login)
        expect(subject.keys).to include(:document)
      end
    end
  end
end
