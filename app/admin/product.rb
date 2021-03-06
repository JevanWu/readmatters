ActiveAdmin.register Product do
  actions :all, :except => [:destroy]


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
    selectable_column
    id_column
    column :name
    column :tags
    column :summary
    column :user do |product|
      link_to "#{product.user.name} (#{product.user.email})", admin_user_path(product.user)
    end
    column :created_at
    actions
  end


end
