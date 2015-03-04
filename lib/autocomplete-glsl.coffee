module.exports =
  provider: null
  ready: false

  activate: ->
    @ready = true

  deactivate: ->
    @provider = null

  getProvider: ->
    if not @provider?
      GlslProvider = require './glsl-provider'
      @provider = new GlslProvider()
    return @provider

  provide: ->
    @getProvider()
