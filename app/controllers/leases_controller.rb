class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :error_message_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :error_message_invalid_info
    wrap_parameters format: []

    def index
        leases = Lease.all
        render json: leases
    end
    
    def create
        lease = Lease.create!(lease_params)
        render josn: lease, status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end
    
    
    private

    def lease_params
        params.permit(:apartment_id, :tenant_id, :rent)
    end
    
        def error_message_not_found(exception)
            render json: { error: "#{exception.model} not found" }, status: :not_found
        end
    
        def error_message_invalid_info(invalid)
            render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
        end
    

end
