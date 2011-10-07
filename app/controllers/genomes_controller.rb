class GenomesController < ApplicationController
  before_filter :authenticate_user!

  def index
    redirect_to genome_path(params[:genome][:id])
  end

  def show
    @genome = Genome.find(params[:id], :include => {:dataset => :project})

    @grouped_genomes = []
    @genome.dataset.project.datasets.each do |dataset|
      genomes = dataset.genomes.map {|g| [g.file_name, g.id]}
      @grouped_genomes.push([dataset.category, genomes])
    end

    @variants = @genome.variants #.page(params[:page])
    @variants = apply_variants_filter(@variants, params)
    
    var_by_transcript = @variants.group_by(&:transcript_id)
    @transcripts = var_by_transcript.keys.map {|t| [var_by_transcript[t].first, var_by_transcript[t].map(&:var_ID).uniq.size]}.sort {|x, y| y[1] <=> x[1]}
  end
end