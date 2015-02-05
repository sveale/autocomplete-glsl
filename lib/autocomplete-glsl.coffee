module.exports =
  provider: null
  ready: false

  activate: ->
    @ready = true

  deactivate: ->
    @provider = null

  getProvider: ->
    return @provider if @provider?
    GlslProvider = require './glsl-provider'
    @provider = new GlslProvider()
    return @provider

  provide: ->
    return {provider: @getProvider()}
