class RentsController < ApplicationController
  before_action :set_rent, only: [:show, :edit, :update, :destroy]
  before_action :set_vehicle, only: [:new, :create]

  def index
    @rents = current_user.rents
  end

  def show
  end

  def new
    @rent = Rent.new
  end

  def create
    @rent = @vehicle.rents.new(rent_params)
    days = @rent.end_date - @rent.start_date
    @rent.price = days.to_i * @vehicle.price
    @rent.user = current_user

    if @rent.save
      redirect_to rent_path(@rent), notice: 'Renta creada exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @rent = Rent.find(params[:id])
    @rent.destroy
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Vehículo no encontrado.'
  end

  def set_rent
    @rent = Rent.find(params[:id])
  end

  def rent_params
    params.require(:rent).permit(:start_date, :end_date)
  end
end
