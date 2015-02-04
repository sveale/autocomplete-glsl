module.exports =
  registration: null
  glslProvider: null

  activate: ->
    GlslProvider = require('./glsl-provider')
    @glslProvider = new GlslProvider()
    @registration = atom.packages.serviceHub.provide('autocomplete.provider', '1.0.0', {provider: @glslProvider})

  deactivate: ->
    @registration?.dispose()
    @registration = null
    @glslProvider?.dispose()
    @glslProvider = null
