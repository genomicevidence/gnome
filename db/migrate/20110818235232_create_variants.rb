class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.integer :genome_id
      t.string :chromosome, :limit => 5
      t.string :source, :limit => 3
      t.string :varType, :limit => 3
      t.integer :var_begin
      t.integer :var_end
      t.integer :score, :limit => 2
      t.string :var_strand, :limit => 1
      t.string :phase, :limit => 1
      t.integer :var_ID
      t.string :Reference_seq, :limit => 192
      t.string :Variant_seq, :limit => 169
      t.integer :allele, :limit => 1
      t.string :ID_dbSNP132_EUR, :limit => 252
      t.float :AF_dbSNP132_EUR
      t.float :AF_1000G_EUR
      t.float :AF_200E_EUR
      t.string :impact, :limit => 18
      t.integer :variant_seq_index, :limit => 1
      t.string :gene_component, :limit => 11
      t.string :transcript_ID, :limit => 12
      t.string :gene_symbol, :limit => 15
      t.integer :transcript_position, :limit => 3
      t.integer :CDS_position, :limit => 3
      t.integer :protein_position, :limit => 3
      t.string :reference_codon, :limit => 12
      t.string :variant_codon, :limit => 12
      t.string :reference_amino_acid, :limit => 18
      t.string :variant_amino_acid, :limit => 14
      t.float :Average_conservation_score
      t.float :Portion_with_sequence_repeat
      t.string :Sequence_repeat_detail, :limit => 186
      t.float :SIFT_score
      t.string :SIFT_pred, :limit => 11
      t.float :PPH2_score
      t.string :PPH2_pred, :limit => 11
      t.float :Condel_score
      t.string :Condel_pred, :limit => 11
      t.string :SIFT_PPH2_detail, :limit => 50
    end
    add_index :variants, [:genome_id, :impact, :AF_dbSNP132_EUR, :AF_1000G_EUR, :AF_200E_EUR], :name => "index_variants_on_genome_id_and_impact_and_af"
  end
end