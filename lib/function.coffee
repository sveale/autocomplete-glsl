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
      "#{@name}#{@getSnippetParameters()}"

    getSnippetParameters: ->
      if @parameters is undefined
        return "()"
      else if @parameters not instanceof Array
        return "(${1:#{@parameters.name}})"
      else
        toReturn = "("
        counter = 0
        for parameter in @parameters
          toReturn += "${#{++counter}:#{parameter.name}}"
          if counter is @parameters.length
            toReturn += ")"
          else
            toReturn += ", "
        toReturn


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
