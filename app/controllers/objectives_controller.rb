class ObjectivesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user
  before_filter :find_task
  before_filter :ensure_proper_user
  # GET /objectives
  # GET /objectives.json
  def index
    #@objectives = Objective.all
    @objectives = @task.objectives.order("position")
    @objective ||= @task.objectives.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @objectives }
    end
  end

  # GET /objectives/1
  # GET /objectives/1.json
  def show
    @objective = Objective.find(params[:id])
    #@objective = @task.objectives.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @objective }
    end
  end

  # GET /objectives/new
  # GET /objectives/new.json
  def new
    @objective = @task.objectives.new
    #@objective = @tasks.objectives.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @objective }
    end
  end

  # GET /objectives/1/edit
  def edit
    @objective = Objective.find(params[:id])
  end

  # POST /objectives
  # POST /objectives.json
  def create
    #@objective = Objective.new(params[:objective])
    @objective = @task.objectives.new(params[:objective])
    @objective.user = current_user

    respond_to do |format|
      if @objective.save
        format.html { redirect_to tasks_path(current_user), notice: 'Objective was successfully created.' }
        format.json { render json: @objective, status: :created, location: @objective }
      else
        format.html { render action: "new" }
        format.json { render json: @objective.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /objectives/1
  # PUT /objectives/1.json
  def update
    @objective = Objective.find(params[:id])

    respond_to do |format|
      if @objective.update_attributes(params[:objective])
        format.html { redirect_to tasks_path(current_user), notice: 'Objective was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @objective.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /objectives/1
  # DELETE /objectives/1.json
  def destroy
    @objective = Objective.find(params[:id])
    @objective.destroy

    respond_to do |format|
      format.html { redirect_to tasks_path(current_user) }
      format.json { head :no_content }
    end
  end

  def sort
    params[:objective].each_with_index do |id, index|
      Objective.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  def complete
    @objective = @task.objectives.find(params[:objective_id])
    @objective.completed = true
    @objective.save
    redirect_to tasks_path(current_user)
  end

  def uncomplete
    @objective = @task.objectives.find(params[:objective_id])
    @objective.completed = false
    @objective.save
    redirect_to tasks_path(current_user)
  end


  def url_options
    { profile_name: params[:profile_name] }.merge(super)
  end



  private



  def ensure_proper_user
    if current_user != @user
      flash[:error] = "You don't have premission to do that."
      redirect_to root_path
    end
  end

  def find_user
    @user = User.find_by_profile_name(params[:profile_name])
  end

  def find_task
    @task = @user.tasks.find(params[:task_id])
    @task.update_attributes!(:updated_at => Time.now)
  end

  def find_objective
    @objective = @task.objectives.find(params[:objective_id])
  end


end












