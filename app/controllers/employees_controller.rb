class EmployeesController < ApplicationController
  before_action :authenticate_user!

  def index
    @employees = EmployeesService.new.index(params[:page])
  end

  def edit
    @employee = EmployeesService.new.get_employee(params[:id])
  end

  def show
    @employee = EmployeesService.new.get_employee(params[:id])
  end

  def create
    @employee = EmployeesService.new.create(employee_params)
    redirect_to employee_path(@employee.dig("id"))
  end

  def update
    @employee = EmployeesService.new.update(params[:id], employee_params)
    redirect_to employee_path(@employee.dig("id"))
  end

  private

  def employee_params
    params.permit(:name, :position, :date_of_birth, :salary)
  end
end
