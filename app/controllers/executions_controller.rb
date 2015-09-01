class ExecutionsController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :set_execution, only: [:show, :edit, :update, :destroy, :abort]

  # GET /executions
  # GET /executions.json
  def index
    @executions = Execution.all
  end

  # GET /executions/1
  # GET /executions/1.json
  def show
  end

  # GET /executions/new
  def new
    @execution = Execution.new
  end

  # GET /executions/1/edit
  def edit
  end

  # POST /executions
  # POST /executions.json
  def create
    @execution = Execution.new(execution_params)

    respond_to do |format|
      if @execution.save
        @execution.queue if params[:execute_now]

        format.html { redirect_to @execution, notice: 'Execution was successfully created.' }
        format.json { render :show, status: :created, location: @execution }
      else
        format.html { render :new }
        format.json { render json: @execution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /executions/1
  # PATCH/PUT /executions/1.json
  def update
    respond_to do |format|
      if @execution.update(execution_params)
        format.html { redirect_to @execution, notice: 'Execution was successfully updated.' }
        format.json { render :show, status: :ok, location: @execution }
      else
        format.html { render :edit }
        format.json { render json: @execution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /executions/1
  # DELETE /executions/1.json
  def destroy
    @execution.destroy
    respond_to do |format|
      format.html { redirect_to executions_url, notice: 'Execution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # DELETE /executions/1/abort
  # DELETE /executions/1/abort.json
  def abort
    @execution.abort
    respond_to do |format|
      format.html { redirect_to @execution, notice: 'Execution was successfully aborted.' }
      format.json { render :show, status: :ok, location: @execution }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_execution
      @execution = Execution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def execution_params
      params.require(:execution).permit(:revision_id, :is_dry_run, :status)
    end
end
