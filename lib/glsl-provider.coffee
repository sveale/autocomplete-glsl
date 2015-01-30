Q = require 'q'
Keyword = require './keyword'
{Range}  = require 'atom'
fuzzaldrin = require 'fuzzaldrin'

# Deferred
fs = null


module.exports =
  class GlslProvider
    id: 'autocomplete-glsl-glslprovider'
    selector: '.glsl,.vs,.fs,.gs,.tc,.te,.vert,.frag'
    blacklist: '.glsl .comment,.vs .comment,.fs .comment,.gs .comment,.tc .comment,.te .comment,.vert .comment,.frag .comment'
    categories: ["preprocessor", "function", "type", "qualifier", "statement", "variable"]

    requestHandler: (options) ->
      @keywords ?= @loadKeywords()
      @keywords.then (resolvedKeywords) =>
        return unless options?.cursor? and options.prefix?.length
        suggestions = @findSuggestionsForWord(resolvedKeywords, options.prefix)
        return unless suggestions?.length
        return suggestions


    findSuggestionsForWord: (keywords, prefix) ->
      return [] unless keywords? and prefix?
      results = fuzzaldrin.filter(keywords, prefix, key: 'name')
      suggestions = for result in results
        suggestion =
          word: result.word
          prefix: prefix
          label: result.category


    loadKeywords: ->
      keywords = Q.defer()
      fs = require 'fs-plus'
      packagePath = atom.packages.resolvePackagePath('autocomplete-glsl')
      fs ?= require 'fs-plus'
      fs.readFile("#{packagePath}/data/glsl430-mini.json", 'utf8', ((err, data) ->
        throw err if err?
        tmpKeywords = []

        for item in JSON.parse(data)
          console.debug "\"#{item.name}\" has no category!" if not item.category
          keyword = new Keyword(item)

          if keyword.category is "function"
            for overload in keyword.overloads
              word = "#{overload.returnValue} #{keyword.name}(#{overload.parameters})"
              exKeyword = new Keyword({word: word, name: keyword.name, category: keyword.category})
              tmpKeywords.push(exKeyword)
          else
            keyword.word = keyword.name
            tmpKeywords.push(keyword)
        keywords.resolve(tmpKeywords)
        )
      )
      keywords.promise
