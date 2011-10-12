class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @projects = current_user.projects

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  def show
    @project = current_user.projects.where(:id => params[:id]).first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  def new
    @project = current_user.projects.new(:scenario => params[:scenario])
    @project.datasets.new(:category => "case")
    @project.datasets.new(:category => "control") if %w(case_and_control).include?(params[:scenario])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  def edit
    @project = current_user.projects.where(:id => params[:id]).first
    
    #@project.datasets.new(:category => "case")
    #@project.datasets.new(:category => "control") if %w(case_and_control).include?(params[:scenario])

  end

  def create
    @project = Project.new(params[:project])

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

  def update
    @project = current_user.projects.where(:id => params[:id]).first

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = current_user.projects.where(:id => params[:id]).first
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end

  
  def genes
    @project = current_user.projects.where(:id => params[:id]).first
    
    datasets = @project.datasets
    @case_dataset = datasets.where(:category => "case").first
    @control_dataset = datasets.where(:category => "control").first

    @variants = Variant.where(:dataset_id => datasets) #.page(params[:page])
    @variants = apply_variants_filter(@variants, params)
    
    params[:genes] ||= {}
    params[:genes][:case_genomes] ||= "all"
    params[:genes][:control_genomes] ||= "no"
    
    case_genomes_range = case params[:genes][:case_genomes]
    when "all"
      [@case_dataset.genomes_count]
    when "some"
      (1 .. (@case_dataset.genomes_count - 1)).to_a
    when "no"
      [0]
    else
      [@case_dataset.genomes_count]
    end

    control_genomes_range = case params[:genes][:control_genomes]
    when "all"
      [@control_dataset.genomes_count]
    when "some"
      (1 .. (@control_dataset.genomes_count - 1)).to_a
    when "no"
      [0]
    else
      [0]
    end

    var_by_transcript = @variants.group_by(&:transcript_id)
    @transcripts = var_by_transcript.keys.map {|t| [var_by_transcript[t].first, var_by_transcript[t].select {|x| x.dataset_id == @case_dataset.id}.map(&:genome_id).uniq.size, var_by_transcript[t].select {|x| x.dataset_id == @control_dataset.id}.map(&:genome_id).uniq.size]}.select{|x| case_genomes_range.include?(x[1]) and control_genomes_range.include?(x[2])}.sort_by {|x| [x[1] - x[2], x[1]]}.reverse
    @transcripts_size = @transcripts.size
  end
end
