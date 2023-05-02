require 'pycall/import'
include PyCall::Import
require 'pandas'


class CareerPredictor < ApplicationService
  pyimport 'numpy', as: 'np'
  pyimport 'pandas', as: 'pd'
  pyimport 'sklearn.preprocessing', as: 'preprocessing'
  pyimport 'joblib', as: 'joblib'

  attr_reader :input_data
  
  # The input should include some hard coded ['Suggested Job Role']
  def initialize(input_data)
    pyimport 'joblib', as: 'joblib'

    @input_data = input_data
    @best_model = joblib.load(Rails.root.join('lib', 'ML', 'best_model.joblib').to_s)
    @encoders = joblib.load('lib/ML/encoders.joblib')
  end

  def call
    input_encoded = encode_input(@input_data)
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

    df = df[df.columns.difference(['Suggested Job Role'])]
    df
  end

  def decode_prediction(prediction)
    target_col = :"Suggested Job Role"
    le = @encoders[target_col]
    decoded = le.inverse_transform(prediction)

    decoded[0]
  end
end

# the input data keys and encoders keys are different, so I need a mapping