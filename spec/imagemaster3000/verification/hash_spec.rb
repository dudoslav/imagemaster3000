require 'spec_helper'

describe Imagemaster3000::Verification::Hash do
  let(:test_obj) { Object.new.extend(described_class) }

  context 'with set hash' do
    before do
      class << test_obj
        def verification
          { hash: { function: Digest.const_get('SHA256'),
                    list: 'ffc8d83038e369f2c27487298732470e6eef4c924f9fe59397f5a5716d339cc3 archlinux-the-best.tar.gz
4b1dc1c1e18f500d1266992b986ce1c83e374412ac2a98af57acaa9798ff3e2d  debian.rar
bbfffaba559709031969b368a891d796596da14c70340c5035ba879a9cbb4a5e  verific.img
7f1502cced50114af3f0c8fe2b999abb67331847183d2a9363bf63273bd97e8f  fedora-mlady.zip
e32aa11f4e5cee02521906c4386290014fff9dd69e1871889ec6125653e92b9a  msdos.7zip
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  unverific.img
ab004837f3eae7ef5420167956f54e24ce1d1381ad4f643a6b24311196dea6ef  ms-windows.tar.zip.rar.jpg.gz.mp3' } }
        end
      end
    end

    context 'with correct sums for verification' do
      before do
        class << test_obj
          def file
            MOCK_DIR + '/verific.img'
          end
        end
      end
      
      it 'wont raise error' do
        expect { test_obj.verify_hash! }.not_to raise_error
      end
    end

    context 'with wrong sums for verification' do
      before do
        class << test_obj
          def file
            MOCK_DIR + '/unverific.img'
          end
        end
      end

      it 'will raise error' do
        expect { test_obj.verify_hash! }.to raise_error(Imagemaster3000::Errors::VerificationError)
      end
    end
  end
end
