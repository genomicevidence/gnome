class ApplicationController < ActionController::Base
  protect_from_forgery

  def apply_variants_filter(variants, params)
    params[:variant] ||= {}
    params[:variant]["gene_model"] ||= "r"
    params[:variant]["ancestry"] ||= "european"
    params[:variant]["allele_frequency"] ||= "n"
    params[:variant]["impact"] ||= "nonsynonymous"

    params[:variant].each do |key, value|
      if value.present?
        if ["gene_model", "gene_component", "PPH2_prediction", "SIFT_prediction", "Condel_prediction", "zygosity"].include?(key)
          variants = variants.where(key.to_sym => value)
        elsif key == 'allele_frequency'
          col = key + "_" + params[:variant][:ancestry]
          variants = variants.where(col.to_sym => value)
        elsif key == 'impact'
          if value == "nonsynonymous"
            variants = variants.where("impact > 1")
          elsif value == "any"
            variants = variants.where("impact > 0")
          else
            variants = variants.where(:impact => value)
          end
        elsif ["variant_call_score", "average_conservation_score", "portion_with_sequence_repeat"].include?(key)
          variants = variants.where("#{key} > ?", value)
        end
      end
    end
    return variants
  end
end
