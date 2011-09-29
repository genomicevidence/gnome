# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110929015711) do

  create_table "collections", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.string  "url"
    t.integer "gene_sets_count", :default => 0
  end

  create_table "datasets", :force => true do |t|
    t.integer  "project_id"
    t.string   "category"
    t.string   "file"
    t.integer  "genomes_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "datasets", ["project_id"], :name => "index_datasets_on_project_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "gene_sets", :force => true do |t|
    t.integer "collection_id"
    t.string  "name"
    t.integer "genes_count",   :default => 0
    t.string  "url"
    t.text    "gene_ids"
  end

  add_index "gene_sets", ["collection_id"], :name => "index_gene_sets_on_collection_id"

  create_table "genomes", :force => true do |t|
    t.integer  "dataset_id"
    t.string   "file_name"
    t.string   "genome_build"
    t.string   "ancestry"
    t.integer  "variants_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "genomes", ["dataset_id"], :name => "index_genomes_on_dataset_id"

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "scenario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "summaries", :force => true do |t|
    t.integer "genome_id"
    t.string  "category"
    t.string  "subcategory"
    t.string  "item"
    t.integer "variants_count"
  end

  add_index "summaries", ["genome_id"], :name => "index_summaries_on_genome_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "projects_count",                        :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "variants", :force => true do |t|
    t.integer "dataset_id"
    t.integer "genome_id"
    t.string  "gene_model",                   :limit => 1
    t.string  "allele_frequency_european",    :limit => 1
    t.string  "allele_frequency_asian",       :limit => 1
    t.string  "allele_frequency_african",     :limit => 1
    t.string  "impact",                       :limit => 1
    t.string  "gene_component",               :limit => 1
    t.string  "chromosome",                   :limit => 5
    t.integer "var_begin"
    t.integer "var_end"
    t.string  "var_strand",                   :limit => 1
    t.string  "variant_type",                 :limit => 3
    t.integer "variant_call_score",           :limit => 2
    t.integer "var_ID"
    t.string  "reference_seq",                :limit => 192
    t.string  "variant_seq",                  :limit => 169
    t.integer "zygosity",                     :limit => 1
    t.string  "transcript_id",                :limit => 12
    t.string  "gene_symbol",                  :limit => 15
    t.float   "average_conservation_score"
    t.float   "portion_with_sequence_repeat"
    t.string  "SIFT_prediction",              :limit => 11
    t.string  "PPH2_prediction",              :limit => 11
    t.string  "Condel_prediction",            :limit => 11
  end

  add_index "variants", ["dataset_id", "gene_model", "allele_frequency_african", "impact", "gene_component"], :name => "index_variants_on_dataset_id_gene_model_af_afr"
  add_index "variants", ["dataset_id", "gene_model", "allele_frequency_asian", "impact", "gene_component"], :name => "index_variants_on_dataset_id_gene_model_af_asn"
  add_index "variants", ["dataset_id", "gene_model", "allele_frequency_european", "impact", "gene_component"], :name => "index_variants_on_dataset_id_gene_model_af_eur"
  add_index "variants", ["genome_id", "gene_model", "allele_frequency_african", "impact", "gene_component"], :name => "index_variants_on_genome_id_gene_model_af_afr"
  add_index "variants", ["genome_id", "gene_model", "allele_frequency_asian", "impact", "gene_component"], :name => "index_variants_on_genome_id_gene_model_af_asn"
  add_index "variants", ["genome_id", "gene_model", "allele_frequency_european", "impact", "gene_component"], :name => "index_variants_on_genome_id_gene_model_af_eur"

end
