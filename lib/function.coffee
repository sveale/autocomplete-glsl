Keyword = require './keyword'

module.exports =
  class Function extends Keyword
    constructor: (@name, @category, @description, @parameters, @returnValue) ->
      super(@name, @category)

    getSignature: ->
      "#{@returnValue} #{@name}(#{@getParameters()})"

    getSnippet: ->
      null

    getParameters: ->
      if @parameters not instanceof Array
        return @parameters.name
      else
        params = ""
        for parameter, index in @parameters
          if index is 0
            params += "#{parameter.name}"
          else if index < @parameters.length
            params += ", #{parameter.name}"
        return params
