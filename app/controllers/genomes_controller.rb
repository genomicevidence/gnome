class GenomesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @genome = Genome.find(params[:id], :include => {:dataset => :project})
    params[:variant] ||= {}
    params[:variant]["gene_model"] ||= "r"
    params[:variant]["ancestry"] ||= "european"
    params[:variant]["allele_frequency"] ||= "n"

    if params[:variant].present?
      @transcripts = @genome.variants.select("chromosome, gene_symbol").page(params[:page])

      params[:variant].each do |key, value|
        if value.present?
          if key != 'ancestry' and key != 'allele_frequency'
            @transcripts = @transcripts.where(key.to_sym => value)
          elsif key == 'allele_frequency'
            col = key + "_" + params[:variant][:ancestry]
            @transcripts = @transcripts.where(col.to_sym => value)
          end
        end
      end
      @transcripts = @transcripts.group(:chromosome, :gene_symbol, :transcript_ID ).order("count_var_id desc, chromosome, gene_symbol").count(:var_ID)
    end
  end
end