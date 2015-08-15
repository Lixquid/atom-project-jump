## Dependencies ################################################################

{CompositeDisposable} = require 'atom'
ProjectListView = require "./project-jump-project-view"

## Package #####################################################################

module.exports = ProjectJump =

	commands: null
	listView: null

	activate: ->

		@listView = new ProjectListView

		@commands = new CompositeDisposable
		@commands.add( atom.commands.add( "atom-workspace",
			"project-jump:add": => @listView.show( "add" )
			"project-jump:open": => @listView.show( "open" )
			"project-jump:switch": => @listView.show( "switch" )
		) )

	deactivate: ->
		@commands.dispose()
		@listView.destroy()
