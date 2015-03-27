module.exports =
  class StepJumper
    @PLACEHOLDER_REGEXP: /:[\w]+/g

    constructor: (@line) ->
      matchData = @line.match(/^\s*(.+)\s+(.*)/)
      if matchData
        @prepositionOrAdverb = matchData[1]
        @restOfLine = matchData[2]

    stepTypeRegex: ->
      new RegExp "step '.+' do"

    checkMatch: ({filePath, matches}) ->
      for match in matches
        console.log("Searching in #{filePath}")
        if regexMatches = match.matchText.match(/^step\s+'(.*)'/)
          stepExpression = regexMatches[1]
          stepRegExp = @compileRegExp(stepExpression)
          if @restOfLine.match(stepRegExp)
            return [filePath, match.range[0][0]]

    compileRegExp: (expression) ->
      exp = expression.replace(StepJumper.PLACEHOLDER_REGEXP, @resolvePlaceHolder)
      new RegExp(exp)

    resolvePlaceHolder: (placeHolderName) =>
      @defaultPlaceHolder

    defaultPlaceHolder:
      """
      (?:"([^"]*)"|'([^']*)'|([[:alnum:]_-]+))
      """
