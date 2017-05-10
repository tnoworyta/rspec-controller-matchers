RSpec::Matchers.define :be_record do |record|
  match do |actual|
    expect(actual).to be_kind_of(record.class)
    expect(actual).to have_attributes(record.class.primary_key => record[record.class.primary_key])
  end
end
