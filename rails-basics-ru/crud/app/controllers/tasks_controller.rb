# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:created_at)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'New task has been successfully created'
      redirect_to task_path(@task)
    else
      flash[:failure] = 'Task hasn`t been created'
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task has been successfully updated'
      redirect_to task_path(@task)
    else
      flash[:failure] = 'Task hasn`t been updated'
      render :edit, status: 422
    end
  end

  def destroy
    @task = Task.find(params[:id])

    if @task.destroy
      flash[:success] = 'Task has been successfully deleted'
      redirect_to tasks_path
    else
      flash[:failure] = 'Task hasn`t been deleted'
      redirect_to task_path(@task)
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :status, :creator, :performer, :completed)
  end
end
