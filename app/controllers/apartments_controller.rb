class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :error_message_not_found
rescue_from ActiveRecord::RecordInvalid, with: :error_message_invalid_info
wrap_parameters format: []

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update(apartment_params)
        render json: apartment
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

private

    def apartment_params
        params.permit(:number)
    end

    def error_message_not_found(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end

    def error_message_invalid_info(invalid)
        render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
