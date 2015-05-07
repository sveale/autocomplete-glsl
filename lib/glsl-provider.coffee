Q = null
Keyword = null
Function = null
Fuzzaldrin = null
fs = null


module.exports =
  class GlslProvider
    selector: '.glsl, .vs, .fs, .gs, .tc, tcs, .te, .tes, .vert, .frag'
    inclusionPriority: 10
    excludeLowerPriority: false
    categories:
        preprocessor: {name: "preprocessor", color: "#316782"}
        function: {name: "function", color: "#1f6699"}
        type: {name: "type", color: "#61fab5"}
        qualifier: {name: "qualifier", color: "#8e8685"}
        statement: {name: "statement", color: "#1cde3e"}
        variable: {name: "variable", color: "#5f83aa"}
        keyword: {name: "keyword", color: "#73edca"}
        identifier: {name: "identifier", color: "#ea71d4"}

    getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
      @keywords ?= @loadKeywords()
      @keywords.then (resolvedKeywords) =>
        return unless bufferPosition? and prefix?.length
        suggestions = @findSuggestionsForWord(resolvedKeywords, prefix)
        return unless suggestions?.length
        return suggestions


    findSuggestionsForWord: (keywords, prefix) ->
      return [] unless keywords? and prefix?

      Fuzzaldrin ?= require 'fuzzaldrin'

      results = Fuzzaldrin.filter(keywords, prefix, key: 'name')
      suggestions = for result in results
        if result instanceof Function
          suggestion =
            replacementPrefix: prefix
            snippet: result.getSnippet()
            type: "#{result.category}"
            leftLabel: "#{result.returnValue}"
            description: "#{result.description}"
            descriptionMoreURL: "https://www.opengl.org/sdk/docs/man/html/#{result.name}.xhtml"
        else
          suggestion =
            text: result.name
            type: "#{result.category}"
            replacementPrefix: prefix


    loadKeywords: ->
      Q ?= require 'q'
      keywords = Q.defer()
      packagePath = atom.packages.resolvePackagePath('autocomplete-glsl')
      fs ?= require 'fs-plus'
      fs.readFile("#{packagePath}/data/glsl430-mini.json", 'utf8', ((err, data) =>
        throw err if err?
        tmpKeywords = []

        for item in JSON.parse(data)
          console.error item + " has no category!" if not item.category
          console.error item + " has no name!" if not item.name

          Keyword ?= require './keyword'
          Function ?= require './function'

          if item.category is @categories.function.name
            if item.overload not instanceof Array
              tmpKeywords.push(new Function(item.name, item.category, item.overload.description, item.overload.parameters, item.overload.returnValue))
            else
              for instance in item.overload
                tmpKeywords.push(new Function(item.name, item.category, instance.description, instance.parameters, instance.returnValue))
          else
            tmpKeywords.push(new Keyword(item.name, item.category))
        keywords.resolve(tmpKeywords)
        )
      )
      keywords.promise
