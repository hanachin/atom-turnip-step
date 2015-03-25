module.exports =
  class StepJumper

    constructor: (@line) ->
      matchData = @line.match(/^\s*(.+)\s+(.*)/)
      if matchData
        @firstWord = matchData[1]
        @restOfLine = matchData[2]

    stepTypeRegex: ->
      new RegExp "step '.+' do"

    checkMatch: ({filePath, matches}) ->
      for match in matches
        console.log("Searching in #{filePath}")
        if regexMatches = match.matchText.match(/^step\s+'(.*)'/)
          if @restOfLine.match(new RegExp(regexMatches[1]))
            return [filePath, match.range[0][0]]
