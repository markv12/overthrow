ActiveAdmin.register User do
  permit_params :name, :email, :admin, assessment_ids: []

  index do
    column :name
    column :email
    column :admin
    column :login_count
    column :last_request_at
    actions
  end

  form do |f|
    f.inputs "User Information" do
      f.input :admin
      f.input :name, :input_html => {:rows => 1, :cols => 10}
      f.input :email, :input_html => {:rows => 1, :cols => 10}
      f.input :assessments,:as => :select, :input_html => {:multiple => true}, :collection => Assessment.non_daily_assessments

    end
    f.actions
  end

  action_item :only => :index do
     link_to 'Upload CSV', :action => 'upload_csv'
   end

   collection_action :upload_csv do
     render "admin/upload_csv"
   end

   collection_action :import_csv, :method => :post do
     AdminCsvImport.convert_save("user", params[:dump][:file])
     redirect_to :action => :index
   end
end