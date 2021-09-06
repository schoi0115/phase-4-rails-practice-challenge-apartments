class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :error_message_not_found
rescue_from ActiveRecord::RecordInvalid, with: :error_message_invalid_info
wrap_parameters format: []

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update(tenant_params)
        render json: tenant
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    
    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end


private

    def tenant_params
        params.permit(:name, :age)
    end

    def error_message_not_found(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end

    def error_message_invalid_info(invalid)
        render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
