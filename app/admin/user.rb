ActiveAdmin.register User do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  filter :channels
  filter :email
  filter :message_zone
  filter :connected
  filter :latitude
  filter :longitude
  filter :pseudo
  filter :last_name
  filter :first_name
  filter :gender
  filter :birth_date
  filter :provider
  
  index do 
    selectable_column
    column :id
    column :message_zone
    column :connected
    column :latitude
    column :longitude
    column :pseudo
    column :last_name
    column :first_name
    column :gender
    column :birth_date
    column :provider
    column :uid
    column :authentication_token
    default_actions
  end

  form do |f|
    f.inputs "Credentials" do 
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.inputs "Details" do 
      f.input :first_name
      f.input :last_name
      f.input :pseudo
      f.input :gender
      f.input :birth_date
    end
  end

end
