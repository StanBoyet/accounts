class RecordsController < ApplicationController

	def index
    @records = Record.all
		@users = User.all
  end

	def create
	  @record = Record.new(record_params)
	  if record.save
	    render json: record
	  else
	    render json: record.errors, status: :unprocessable_entity
	  end
	end

	def destroy
		record.destroy
		head :no_content
	end

	def update
    if record.update(record_params)
      render json: record
    else
      render json: record.errors, status: :unprocessable_entity
    end
  end

	private

  def record_params
    params.require(:record).slice(:title, :amount, :date, :spender_id, :recipient_ids).permit!
  end

  def record
    @record ||= Record.find(params[:id])
  end

end
