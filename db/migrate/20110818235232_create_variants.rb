class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.integer :dataset_id
      t.integer :genome_id
      t.string :gene_model, :limit => 1
      t.string :allele_frequency_european, :limit => 1
      t.string :allele_frequency_asian, :limit => 1
      t.string :allele_frequency_african, :limit => 1
      t.string :impact, :limit => 1
      t.string :gene_component, :limit => 1
      t.string :chromosome, :limit => 5
      t.integer :var_begin
      t.integer :var_end
      t.string :var_strand, :limit => 1
      t.string :variation_type, :limit => 3
      t.integer :variation_call_score, :limit => 2
      t.integer :var_ID
      t.string :reference_seq, :limit => 192
      t.string :variant_seq, :limit => 169
      t.integer :zygosity, :limit => 1
      t.string :transcript_id, :limit => 12
      t.string :gene_symbol, :limit => 15
      t.float :average_conservation_score
      t.float :portion_with_sequence_repeat
      t.string :SIFT_prediction, :limit => 11
      t.string :PPH2_prediction, :limit => 11
      t.string :Condel_prediction, :limit => 11
    end
    add_index :variants, [:dataset_id, :gene_model, :allele_frequency_european, :impact, :gene_component], :name => "index_variants_on_dataset_id_gene_model_af_eur"
    add_index :variants, [:dataset_id, :gene_model, :allele_frequency_asian, :impact, :gene_component], :name => "index_variants_on_dataset_id_gene_model_af_asn"
    add_index :variants, [:dataset_id, :gene_model, :allele_frequency_african, :impact, :gene_component], :name => "index_variants_on_dataset_id_gene_model_af_afr"
    add_index :variants, [:genome_id, :gene_model, :allele_frequency_european, :impact, :gene_component], :name => "index_variants_on_genome_id_gene_model_af_eur"
    add_index :variants, [:genome_id, :gene_model, :allele_frequency_asian, :impact, :gene_component], :name => "index_variants_on_genome_id_gene_model_af_asn"
    add_index :variants, [:genome_id, :gene_model, :allele_frequency_african, :impact, :gene_component], :name => "index_variants_on_genome_id_gene_model_af_afr"
  end
end