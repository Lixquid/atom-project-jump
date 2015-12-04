## Dependencies ################################################################

{CompositeDisposable} = require 'atom'
ProjectListView = require "./project-jump-project-view"
ProjectRemoveListView = require "./project-jump-project-remove"

## Package #####################################################################

module.exports = ProjectJump =

	commands: null
	listView: null
	listViewRemove: null

	activate: ->

		@listView = new ProjectListView
		@listViewRemove = new ProjectRemoveListView

		@commands = new CompositeDisposable
		@commands.add( atom.commands.add( "atom-workspace",
			"project-jump:add": => @listView.show( "add" )
			"project-jump:open": => @listView.show( "open" )
			"project-jump:switch": => @listView.show( "switch" )
			"project-jump:remove": => @listViewRemove.show()
		) )

	deactivate: ->
		@commands.dispose()
		@listView.destroy()
		@listViewRemove.destroy()
