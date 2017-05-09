RSpec::Matchers.define :create_record do |klass, attributes|
  supports_block_expectations

  match do |actual|
    if using_form?
      allow(form_klass).to receive(:new).and_call_original
      expect_any_instance_of(form_klass).to receive(:save).and_call_original
    end

    expect {
      actual.call
    }.to change { klass.count }.by(1)

    created_record_id = klass.maximum(klass.primary_key)
    created_record = klass.find(created_record_id)
    expect(created_record).to have_attributes(attributes)

    if using_form?
      expect(form_klass).to have_received(:new).with(kind_of(klass), kind_of(Hash))
    end

    true
  end

  def using_form(form_klass)
    @form_klass = form_klass
    self
  end

  def using_form?
    form_klass.present?
  end

  private

  attr_reader :form_klass, :form
end
