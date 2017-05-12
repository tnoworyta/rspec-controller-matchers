RSpec::Matchers.define :create_record do |klass, attributes|
  supports_block_expectations

  match do |actual|
    @failure_message = nil

    if using_form?
      allow(form_klass).to receive(:new).and_call_original
      expect_any_instance_of(form_klass).to receive(:save).and_call_original
    end

    begin
      expect {
        actual.call
      }.to change { klass.count }.by(1)
    rescue RSpec::Expectations::ExpectationNotMetError
      @failure_message = "Expected a record of #{klass.name} class be created, but was not"
      return false
    end

    begin
      created_record_id = klass.maximum(klass.primary_key)
      created_record = klass.find(created_record_id)
      expect(created_record).to have_attributes(attributes)
    rescue RSpec::Expectations::ExpectationNotMetError => e
      @failure_message = "Record was created but attributes do not match. \n"
      @failure_message << e.message
      return false
    end

    if using_form?
      expect(form_klass).to have_received(:new).with(kind_of(klass), kind_of(Hash))
    end

    true
  end

  chain :using_form do |form_klass|
    @form_klass = form_klass
  end

  failure_message do
    @failure_message
  end

  def using_form?
    form_klass.present?
  end

  private

  attr_reader :form_klass
end
