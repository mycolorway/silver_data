require_relative 'input_type/registry'
require_relative 'input_type/base'

require_relative 'input_type/checkbox_field'
require_relative 'input_type/date_field'
require_relative 'input_type/email_field'
require_relative 'input_type/select_field'
require_relative 'input_type/text_field'
require_relative 'input_type/number_field'
require_relative 'input_type/date_field'
require_relative 'input_type/textarea_field'

module InputType
  @registry = Registry.new

  class << self
    attr_accessor :registry # :nodoc:

    def register(type_name, klass = nil, **options, &block)
      registry.register(type_name, klass, **options, &block)
    end

    def lookup(*args, **kwargs) # :nodoc:
      registry.lookup(*args, **kwargs)
    end
  end

  register(:checkbox_field, CheckboxField)
  register(:date_field, DateField)
  register(:email_field, EmailField)
  register(:select_field, SelectField)
  register(:text_field, TextField)
  register(:number_field, NumberField)
  register(:textarea_field, TextareaField)
end
