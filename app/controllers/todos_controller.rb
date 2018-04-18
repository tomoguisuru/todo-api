class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @todos = Todo.all
    json_response(@todos)
  end

  # POST /todos
  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      json_response(@todo, :created)
    else
      respond_with_errors(@todo)
    end
  end

  # GET /todos/:id
  def show
    json_response(@todo)
  end

  # PUT /todos/:id
  def update
    if @todo.update(todo_params)
      head :no_content
    else
      respond_with_errors(@todo)
    end
  end

  # DELETE /todos/:id
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    # whitelist params
    # params.permit(:title, :created_by)
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:title, :created_by] )
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end