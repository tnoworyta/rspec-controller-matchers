RSpec::Matchers.define :render_local do |*args|
  match do |actual|
    allow(controller).to receive(:render).and_call_original

    set_expected_key_and_value(*args)

    if @intermediate_klass
      allow(@intermediate_klass).to receive(:call) { @value }
    end

    actual.call

    verify_local!
  end

  def using(klass)
    @intermediate_klass = klass
    self
  end

  supports_block_expectations

  def set_expected_key_and_value(*args)
    locals_hash = args.extract_options!

    @key = nil
    @value = nil

    if locals_hash.present?
      @key = locals_hash.keys.first.to_sym
      @value = locals_hash.values.first
    elsif args.size == 2
      @key = args.first.to_sym
      subject = args.pop
      if subject.is_a?(Class)
        @value = kind_of(subject)
      else
        @value = subject
      end
    elsif args.size == 1
      subject = args.pop
      if subject.is_a?(Class)
        @key = subject.name.underscore.to_sym
        @value = kind_of(subject)
      end
    end
  end

  def verify_local!
    if @intermediate_klass
      expect(@intermediate_klass).to have_received(:call)
    end
    expect(controller).to have_received(:render).
      at_least(:once).
      with(anything, hash_including(locals: hash_including(@key => @value)))
  end
end


