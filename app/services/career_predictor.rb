require 'pycall/import'
include PyCall::Import

class CareerPredictor < ApplicationService
  attr_reader :user
  
  def initialize(user)
    pyimport 'joblib', as: 'joblib'

    @user = user
    @best_model = Rails.application.config.best_model
    @encoders = Rails.application.config.encoders
  end

  def call
    input_encoded = encode_input(InputDataFormatter.call(@user))
    prediction = @best_model.predict(input_encoded)
    decoded_prediction = decode_prediction(prediction)

    decoded_prediction
  end

  private

  def encode_input(input_data)
    pyimport 'pandas', as: 'pd'

    df = pd.DataFrame.new(data: input_data)
    columns = input_data.keys

    columns.each do |col|
      le = @encoders[col]
      df[col] = le.transform(df[col]) if le
    end

    df
  end

  def decode_prediction(prediction)
    target_col = :"Suggested Job Role"
    le = @encoders[target_col]
    decoded = le.inverse_transform(prediction)

    decoded[0]
  end
end