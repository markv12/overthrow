ActiveAdmin.register Game do
  permit_params :name, user_ids: []

  index do
    column :id
    column :name
    actions
  end

  form do |f|
    f.inputs "Game Information" do
      f.input :name, :input_html => {:rows => 1, :cols => 10}
      f.input :users,:as => :select, :input_html => {:multiple => true}
    end
    f.actions
  end
end