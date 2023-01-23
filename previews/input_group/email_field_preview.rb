# frozen_string_literal: true

module InputGroup
  class Subscriber
    include ActiveModel::API

    attr_accessor :email
  end

  class EmailFieldPreview < ViewComponent::Preview
    def default
      model = Subscriber.new
      model.email = "mario@nintendo.com"
      form = build_form(model)
      render(Felt::InputGroup::EmailField.new(form: form, attribute: :email))
    end

    def with_label
      model = Subscriber.new
      form = build_form(model)
      render(Felt::InputGroup::EmailField.new(form: form, attribute: :email, label: "Subscriber Email"))
    end

    def with_hint
      model = Subscriber.new
      form = build_form(model)
      render(Felt::InputGroup::EmailField.new(form: form, attribute: :email, hint: "Enter the email of the subscriber"))
    end

    def with_help
      model = Subscriber.new
      form = build_form(model)
      render(Felt::InputGroup::EmailField.new(form: form, attribute: :email, help: "Subscribers can have different emails in different regions."))
    end

    def with_errors
      model = Subscriber.new
      model.errors.add(:email, :invalid)
      form = build_form(model)
      render(Felt::InputGroup::EmailField.new(form: form, attribute: :email))
    end

    def with_input_options
      model = Subscriber.new
      form = build_form(model)
      render(Felt::InputGroup::EmailField.new(form: form, attribute: :email, input_options: {autofocus: true}))
    end

    private

    def build_form(model)
      ActionView::Helpers::FormBuilder.new(
        model.class.to_s.underscore,
        model,
        build_template,
        {}
      )
    end

    def build_template
      ActionView::Base.new(
        :this,
        {}, # assigns?
        :there
      )
    end
  end
end
