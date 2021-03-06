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
			"project-jump:add": => @listView.show( {mode: "add", multi: false} )
			"project-jump:add-multiple": => @listView.show( {mode: "add", multi: true} )
			"project-jump:open": => @listView.show( {mode: "open", multi: false} )
			"project-jump:remove": => @listViewRemove.show( {multi: false} )
			"project-jump:remove-multiple": => @listViewRemove.show( {multi: true} )
			"project-jump:switch": => @listView.show( {mode: "switch", multi: false} )
		) )

	deactivate: ->
		@commands.dispose()
		@listView.destroy()
		@listViewRemove.destroy()
