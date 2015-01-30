module.exports =
  class Overload
    constructor: ({parameters, @returnValue, @description}) ->
      if parameters?
        @parameters = ""
        if parameters not instanceof Array
          @parameters = parameters.name
        count = 0
        for object in parameters
          if count++ == 0
            @parameters += "#{object.name}"
          else
            @parameters += ", #{object.name}"
