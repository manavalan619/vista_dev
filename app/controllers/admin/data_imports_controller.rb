class Admin::DataImportsController < Admin::BaseController
  def index
    @data_imports = DataImport.page(params[:page])
  end

  def new
    @data_import = DataImport.new
  end

  def create
    @data_import = DataImport.new(data_import_params)

    respond_to do |format|
      if @data_import.save
        format.html {
          redirect_to %i[admin data_imports], success: 'Import queued'
        }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def show
    @data_import = DataImport.find params[:id]
  end

  private

  def data_import_params
    params.require(:data_import).permit(permitted_params)
  end

  def permitted_params
    %i[file categories questions locking_conditions visibility_conditions]
  end
end
