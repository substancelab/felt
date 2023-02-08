# frozen_string_literal: true

module InputGroup
  class Game
    include ActiveModel::API

    attr_accessor :released

    def released?
      !!released
    end
  end

  class CheckboxFieldPreview < ViewComponent::Preview
    def default
      model = Game.new
      model.released = true
      form = build_form(model)
      render(Felt::InputGroup::CheckboxField.new(form: form, attribute: :released))
    end

    def with_label
      model = Game.new
      form = build_form(model)
      render(Felt::InputGroup::CheckboxField.new(form: form, attribute: :released, label: "Game released"))
    end

    def with_hint
      model = Game.new
      form = build_form(model)
      render(Felt::InputGroup::CheckboxField.new(form: form, attribute: :released, hint: "Enter the released of the game"))
    end

    def with_help
      model = Game.new
      form = build_form(model)
      render(Felt::InputGroup::CheckboxField.new(form: form, attribute: :released, help: "Games can have different releaseds in different regions."))
    end

    def with_errors
      model = Game.new
      model.errors.add(:released, :invalid)
      form = build_form(model)
      render(Felt::InputGroup::CheckboxField.new(form: form, attribute: :released))
    end

    def with_input_options
      model = Game.new
      form = build_form(model)
      render(Felt::InputGroup::CheckboxField.new(form: form, attribute: :released, input_options: {autofocus: true}))
    end

    def with_specific_values
      model = Game.new
      form = build_form(model)
      render(Felt::InputGroup::CheckboxField.new(form: form, attribute: :released, input_options: {checked_value: "42"}))
    end

    def with_everything
      model = Game.new
      form = build_form(model)
      render(Felt::InputGroup::CheckboxField.new(
        form: form,
        attribute: :released,
        helpful: "Helpful text about checking boxes",
        hint: "Has the game been released for public consumption?",
        input_options: {autofocus: true},
        label: "Really released?"
      ))
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
