require 'pycall/import'
include PyCall::Import

pyimport 'joblib', as: 'joblib'
Rails.application.config.best_model = joblib.load(Rails.root.join('lib', 'ML', 'best_model.joblib').to_s)
Rails.application.config.encoders = joblib.load(Rails.root.join('lib', 'ML', 'encoders.joblib').to_s)