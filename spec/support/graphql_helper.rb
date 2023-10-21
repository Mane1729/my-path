module GraphQLHelper
  def graphql_query(query, variables: {})
    post '/graphql', params: { query: query, variables: variables.to_json }
    JSON.parse(response.body)
  end
end
