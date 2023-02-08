class Contact < ApplicationRecord
    # Associations
    # After we create the the model (which was a foreing key of contact) we need to create the associoation from "kind" to "contact"
    # The model kind belongs to contact with a FK
    belongs_to :kind, optional: true
    # Has_many is used when we can have more than one association for the same table (Contact), and belongs_to is when you only have 1 association
    has_many :phones
    # The contact has only one adress
    has_one :address
    # The accepts nested attributes is used to associate the phones to the contacts whenever we want
    accepts_nested_attributes_for :phones, allow_destroy: true
    accepts_nested_attributes_for :address, update_only: true

    def as_json(options={})
        h = super(options)
        h[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
        h
    end

    # # def birthdate_br
    #     # I18n.l(self.birthdate) unless self.birthdate.blank?
    # # end

    # def author
    #     "Tulio Manso"
    # end

    # def kind_description
    #     self.kind.description # Here we get the contact element itself, his "kind" and his description, in other words...
    #     # We can get the description type in the current contact (self), and show it here
    # end

    # # The "render json" in "contacts_controller" has his own method in rails, so now, we go to replace the original method
    # # including some news attributes
    # def as_json(option={}) #this "option" is what we pass as optional on the method in "name_model_controller.rb"
    #     # The super is used to invoke the original "as_json"
    #     super(
    #         root: true,
    #         methods: [:kind_description, :author, :phones, :address], # Here we push the methods from the model to improve our /contacts show
    #         #include: {kind: {only: :description}} # we canceled it because we created the method kind_description
    #     )
    # end 


end
