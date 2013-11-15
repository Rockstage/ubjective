class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  # add excepts [browse and public show]
  before_filter :find_user
  before_filter :find_project, only: [:edit, :update, :destroy]
  before_filter :ensure_proper_user, except: [:browse, :show]
  # GET /projects
  # GET /projects.json
  def index
    #@projects = Project.all
    @projects = current_user.projects.all(:order => 'updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  def browse
    @projects = Project.public.all(:order => 'updated_at DESC')
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    #@project = Project.new
    @project = current_user.projects.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    #@project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    #@project = Project.new(params[:project])
    @project = current_user.projects.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    #@project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    #@project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
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

  def find_project
    @project = current_user.projects.find(params[:id])
  end







end
