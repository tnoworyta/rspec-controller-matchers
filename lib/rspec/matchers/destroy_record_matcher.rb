RSpec::Matchers.define :destroy_record do |record|
  supports_block_expectations

  match do |actual|
    @failure_message = nil

    if using_service?
      allow(service_klass).to receive(:call).and_wrap_original do |original_method, *args|
        begin
          expect{ original_method.call(*args) }.to change { record.class.exists?(id: record.id) }.to(false)
        rescue RSpec::Expectations::ExpectationNotMetError
          @failure_message = "Expected a record #{record.inspect} to be destroyed by #{service_klass}, but was not"
          return false
        end
      end
    end

    begin
      actual.call
      expect(record.class.exists?(id: record.id)).to eq false
    rescue RSpec::Expectations::ExpectationNotMetError
      @failure_message = "Expected a record of #{record.class.name} class to be destroyed, but was not"
      return false
    end
    
    if using_service?
      expect(service_klass).to have_received(:call)
    end
    
    true
  end

  chain :using do |service_klass|
    @service_klass = service_klass
  end

  failure_message do
    @failure_message
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
