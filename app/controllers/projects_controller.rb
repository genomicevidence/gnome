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
    
    params[:variant] ||= {}
    params[:variant]["gene_model"] ||= "r"
    params[:variant]["ancestry"] ||= "european"
    params[:variant]["allele_frequency"] ||= "n"
    params[:variant]["impact"] ||= "nonsynonymous"
    
    @datasets = @project.datasets
    case_dataset_id = @project.datasets.where(:category => "case").first.id
    control_dataset_id = @project.datasets.where(:category => "control").first.id
    @variants = Variant.where(:dataset_id => @datasets) #.page(params[:page])
    #@variants = @genome.variants.select("var_ID, chromosome, gene_symbol").page(params[:page])

    params[:variant].each do |key, value|
      if value.present?
        if ["gene_model", "gene_component", "PPH2_prediction", "SIFT_prediction", "Condel_prediction", "zygosity"].include?(key)
          @variants = @variants.where(key.to_sym => value)
        elsif key == 'allele_frequency'
          col = key + "_" + params[:variant][:ancestry]
          @variants = @variants.where(col.to_sym => value)
        elsif key == 'impact'
          if value == "nonsynonymous"
            @variants = @variants.where("impact > 1")
          elsif value == "any"
            @variants = @variants.where("impact > 0")
          else
            @variants = @variants.where(:impact => value)
          end
        elsif ["variant_call_score", "average_conservation_score", "portion_with_sequence_repeat"].include?(key)
          @variants = @variants.where("#{key} > ?", value)
        end
      end
    end
    var_by_transcript = @variants.group_by(&:transcript_id)
    @transcripts = var_by_transcript.keys.map {|t| [var_by_transcript[t].first, var_by_transcript[t].select {|x| x.dataset_id == case_dataset_id}.map(&:genome_id).uniq.size, var_by_transcript[t].select {|x| x.dataset_id == control_dataset_id}.map(&:genome_id).uniq.size]}.sort_by {|x| [x[1] - x[2], x[1]]}.reverse
    #@transcripts = var_by_transcript.keys.map {|t| [var_by_transcript[t].first, var_by_transcript[t].select {|t| t.dataset_id == case_dataset_id}.map(&:genome_id).uniq.size, var_by_transcript[t].select {|t| t.dataset_id == control_dataset_id}.map(&:genome_id).uniq.size]}.sort {|x, y| (y[1] - y[2]) <=> (x[1] - x[2]) || y[1] <=> x[1]}
  end
end
