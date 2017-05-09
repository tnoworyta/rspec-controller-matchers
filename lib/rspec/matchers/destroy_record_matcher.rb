RSpec::Matchers.define :destroy_record do |record|
  supports_block_expectations

  match do |actual|
    if using_service?
      allow(service_klass).to receive(:call).and_call_original
    end

    actual.call

    expect(record.class.exists?(id: record.id)).to eq false
    if using_service?
      expect(service_klass).to have_received(:call)
    end
  end

  def using_service(klass)
    @service_klass = klass
    self
  end

  private

  attr_reader :service_klass

  def using_service?
    service_klass.present?
  end
end
