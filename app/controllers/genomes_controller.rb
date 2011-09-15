class GenomesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @genome = Genome.find(params[:id], :include => {:dataset => :project})
    if params[:variant].present?
      @transcripts = @genome.variants.select("chromosome, gene_symbol")
      params[:variant].each do |key, value|
        if value.present?
          @transcripts = @transcripts.where(key.to_sym => value)
        end
      end
      @transcripts = @transcripts.group(:chromosome, :gene_symbol, :transcript_ID ).order("count_all desc, chromosome, gene_symbol").count
    end
  end
end