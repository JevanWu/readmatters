ActiveAdmin.register Order do
  actions :all, :except => [:destroy]

  member_action :pay_order, method: :put do
    return if current_admin_user.present?
    resource.pay if resource.wait_pay?
    redirect_to resource_path, notice: "已标记为支付状态!"
  end

  action_item :mark_paid, only: :show do
    link_to 'Mark paid', pay_order_admin_order_path(order), method: :put, data: { confirm: "确定该订单已支付吗？" }
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  index do
    id_column
    column :identifier
    column :province
    column :receiver_name
    column :created_at
    column :updated_at
    column :total_price
    column :state do |order|
      I18n.t("attributes.orders.state.#{order.state}")
    end
    column :pay_code

    actions
  end

  show do
    attributes_table do
      row :identifier
      row :province
      row :city
      row :street
      row :receiver_name
      row :seller
      row :state do |order|
        I18n.t("attributes.orders.state.#{order.state}")
      end
      row :total_price
      row :pay_code
    end
    active_admin_comments
  end


end
