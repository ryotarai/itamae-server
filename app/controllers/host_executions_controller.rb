class HostExecutionsController < ApplicationController
  before_action :set_host_execution, only: [:show, :edit, :update, :destroy]

  # GET /host_executions
  # GET /host_executions.json
  def index
    @host_executions = HostExecution.all
  end

  # GET /host_executions/1
  # GET /host_executions/1.json
  def show
  end

  # GET /host_executions/new
  def new
    @host_execution = HostExecution.new
  end

  # GET /host_executions/1/edit
  def edit
  end

  # POST /host_executions
  # POST /host_executions.json
  def create
    @host_execution = HostExecution.new(host_execution_params)

    respond_to do |format|
      if @host_execution.save
        format.html { redirect_to @host_execution, notice: 'Host execution was successfully created.' }
        format.json { render :show, status: :created, location: @host_execution }
      else
        format.html { render :new }
        format.json { render json: @host_execution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /host_executions/1
  # PATCH/PUT /host_executions/1.json
  def update
    respond_to do |format|
      if @host_execution.update(host_execution_params)
        format.html { redirect_to @host_execution, notice: 'Host execution was successfully updated.' }
        format.json { render :show, status: :ok, location: @host_execution }
      else
        format.html { render :edit }
        format.json { render json: @host_execution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /host_executions/1
  # DELETE /host_executions/1.json
  def destroy
    @host_execution.destroy
    respond_to do |format|
      format.html { redirect_to host_executions_url, notice: 'Host execution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_host_execution
      @host_execution = HostExecution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def host_execution_params
      params.require(:host_execution).permit(:host_id, :execution_id)
    end
end
