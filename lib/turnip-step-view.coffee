{View} = require 'atom'

module.exports =
class TurnipStepView extends View
  @content: ->
    @div class: 'turnip-step overlay from-top', =>
      @div "The TurnipStep package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "turnip-step:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "TurnipStepView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
