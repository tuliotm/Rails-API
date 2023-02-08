class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all

    # render json: @contacts, methods: :author, root: true
    # It could be used this way ".map {|contact| contact.attributes.merge({author: "Tulio Manso"})}", 
    # but its better with method: :method, where you can find this method in the model "contact.rb"

    # In the end, we created a replacement method for "as_json" in the model "contact", because it will serve to all actions
    render json: @contacts
  end

  # GET /contacts/1
  def show
    render json: @contact.attributes.merge({author: "Tulio Manso"})
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:name, :email, :birthdate)
    end
end
