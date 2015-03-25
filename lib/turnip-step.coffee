StepJumper = require './step-jumper'

module.exports =
  cucumberStepView: null

  activate: (state) ->
    atom.workspaceView.command "turnip-step:jump-to-step", =>
      currentLine = atom.workspace.getActiveEditor().getCursor().getCurrentBufferLine()
      stepJumper = new StepJumper(currentLine)
      return unless stepJumper.firstWord
      options =
        paths: ["spec/steps/**/*.rb"]

      atom.project.scan stepJumper.stepTypeRegex(), options, (match) ->
        if foundMatch = stepJumper.checkMatch(match)
          [file, line] = foundMatch
          console.log("Found match at #{file}:#{line}")
          atom.workspace.open(file).done (editor) -> editor.setCursorBufferPosition([line, 0])


  deactivate: ->
    @turnipStepView.destroy()

  serialize: ->
    turnipStepViewState: @turnipStepView.serialize()
