Overload = require './overload'

module.exports =
  class Keyword
    constructor: ({@word, @name, @category, overload}) ->
      if overload?
        @overloads = []
        if overload not instanceof Array
          @overloads.push(new Overload overload)
        for object in overload
          @overloads.push(new Overload(object))
