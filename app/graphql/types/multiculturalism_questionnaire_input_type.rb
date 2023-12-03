module Types
  class MulticulturalismQuestionnaireInputType < Types::BaseInputObject
    argument :sushi, FourOptionAnswerEnum, required: true
    argument :paella, FourOptionAnswerEnum, required: true
    argument :colosseum, FourOptionAnswerEnum, required: true
    argument :sydney_opera_house, FourOptionAnswerEnum, required: true
    argument :kilt, FourOptionAnswerEnum, required: true
    argument :hanbok, FourOptionAnswerEnum, required: true
  end
end

