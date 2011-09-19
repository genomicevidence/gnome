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

    params[:variant] ||= {}
    params[:variant]["gene_model"] ||= "r"
    params[:variant]["ancestry"] ||= "european"
    params[:variant]["allele_frequency"] ||= "n"
    params[:variant]["impact"] ||= "nonsynonymous"

    if params[:variant].present?
      @variants = @genome.variants #.page(params[:page])
      #@variants = @genome.variants.select("var_ID, chromosome, gene_symbol").page(params[:page])

      params[:variant].each do |key, value|
        if value.present?
          if key != 'ancestry' and key != 'allele_frequency' and key != 'impact'
            @variants = @variants.where(key.to_sym => value)
          elsif key == 'allele_frequency'
            col = key + "_" + params[:variant][:ancestry]
            @variants = @variants.where(col.to_sym => value)
          elsif key == 'impact'
            if value == "nonsynonymous"
              @variants = @variants.where("impact != 'synonymous'")
            elsif value == "synonymous"
              @variants = @variants.where(:impact => 'synonymous')
            elsif value == "any"
              @variants = @variants.where("impact != ''", )
            end
          end
        end
      end
      var_by_transcript = @variants.group_by(&:transcript_ID)
      @transcripts = var_by_transcript.keys.map {|t| [var_by_transcript[t].first, var_by_transcript[t].map(&:var_ID).uniq.size]}.sort {|x, y| y[1] <=> x[1]}
      
    end
  end
end