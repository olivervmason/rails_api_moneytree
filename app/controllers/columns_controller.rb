class ColumnsController < ApplicationController
  before_action :authenticate_user
  before_action :set_user_id_param, only: [:create, :update]
  before_action :set_column, only: [:show, :update, :destroy]

  # GET /columns
  def index
    @columns = current_user.columns          # Changed from default Column.all
    puts current_user.id                     # Get user id in terminal upon receiving GET request

    final = @columns.map { | column | {column: column, tiles: column.tiles} }
    render json: final
  end

  # GET /columns/1
  def show
    result = {column: @column, tiles: @column.tiles}
    render json: result
  end

  # POST /columns
  def create
    @column = Column.new(column_params)

    if @column.save
      render json: @column, status: :created, location: @column
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /columns/1
  def update
    if current_user.id == @column.user_id
      if @column.update(column_params)
        render json: @column
      else
        render json: @column.errors, status: :unprocessable_entity
      end
    else
      puts "User not authenticated to update column"
    end
  end

  # DELETE /columns/1
  def destroy
    if current_user.id == @column.user_id
      @column.destroy
    else
      puts "User not authenticated to delete column"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = Column.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def column_params
      params.require(:column).permit(:title, :user_id)
    end

    # Set user_id to that of user making request
    def set_user_id_param
      params[:column][:user_id] = current_user.id 
    end
end
