Keyword = require './keyword'

module.exports =
  class Function extends Keyword
    constructor: (@name, @category, @description, @parameters, @returnValue) ->
      super(@name, @category)


    getSimpleSignature: ->
      "(#{@returnValue}) (#{@getSimpleParameters()})"

    getMediumSignature: ->
      "#{@returnValue} #{@name}(#{@getSimpleParameters()})"

    getFullSignature: ->
      "#{@returnValue} #{@name}(#{@getFullParameters()})"

    getSnippet: ->
      null

    getSimpleParameters: ->
      if @parameters not instanceof Array
        return @parameters.name.split(" ")[0]
      else
        params = ""
        for parameter, index in @parameters
          if index is 0
            params += "#{parameter.name.split(" ")[0]}"
          else if index < @parameters.length
            params += ", #{parameter.name.split(" ")[0]}"
        return params

    getFullParameters: ->
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
