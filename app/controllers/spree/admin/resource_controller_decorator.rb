module Spree::Admin::ResourceControllerDecorator

    def self.prepended(base)
      base.rescue_from CanCan::AccessDenied do |exception|
        respond_to do |format|
          format.json { head :forbidden, content_type: 'text/html' }
          format.html { redirect_to '/vendor', notice: "Action: #{exception.action} Subject: #{exception.subject}"}
          format.js   { head :forbidden, content_type: 'text/html' }
        end
      end
    end

   def create
    invoke_callbacks(:create, :before)
    image = permitted_resource_params[:image]
    @object.attributes = permitted_resource_params.except(:image)
    if @object.save
      invoke_callbacks(:create, :after)
      flash[:success] = flash_message_for(@object, :successfully_created)
      respond_with(@object) do |format|
        current_spree_user.has_spree_role?(:vendor) ? location_after_save = '/vendor' : location_after_save = spree.edit_admin_product_url(@object)
        format.html { redirect_to location_after_save }
        format.js   { render layout: false }
      end
    else
      invoke_callbacks(:create, :fails)
      respond_with(@object) do |format|
        format.html do
          flash.now[:error] = @object.errors.full_messages.join(", ")
          render_after_create_error
        end
        format.js { render layout: false }
      end
    end
  end

  Spree::Admin::ResourceController.prepend self
end
