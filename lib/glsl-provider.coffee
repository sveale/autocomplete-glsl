module.exports =
  class GlslProvider
    id: 'autocomplete-glsl-glslprovider'
    selector: '.glsl,.vs,.fs,.gs,.tc,.te,.vert,.frag'
    blacklist: '.glsl .comment,.vs .comment,.fs .comment,.gs .comment,.tc .comment,.te .comment,.vert .comment,.frag .comment'

    requestHandler: (options) ->
      [{
      word: 'hello',
      prefix: 'h',
      label: '<span style="color: red">world</span>',
      renderLabelAsHtml: true,
      className: 'globe',
      onWillConfirm: -> # Do something here before the word has replaced the prefix (if you need, you usually don't need to),
      onDidConfirm: -> # Do something here after the word has replaced the prefix (if you need, you usually don't need to)
      }]

    dispose: ->
      # nothing to do
