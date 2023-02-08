class Contact < ApplicationRecord
    # After we create the the model (which was a foreing key of contact) we need to create the associoation from "kind" to "contact"
    # The model kind belongs to contact with a FK
    belongs_to :kind

    def author
        "Tulio Manso"
    end

    def kind_description
        self.kind.description # Here we get the contact element itself, his "kind" and his description, in other words...
        # We can get the description type in the current contact (self), and show it here
    end

    # The "render json" in "contacts_controller" has his own method in rails, so now, we go to replace the original method
    # including some news attributes
    def as_json(option={})
        # The super is used to invoke the original "as_json"
        super(
            root: true,
            methods: [:kind_description, :author] # Here we push the methods from the model to improve our /contacts show
            # include: {kind: {only: :description}} # we canceled it because we created the method kind_description
        )
    end
end
