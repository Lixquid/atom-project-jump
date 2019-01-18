## Dependencies ################################################################

fs = require "fs"
path = require "path"
{SelectListView} = require "atom-space-pen-views"

## View ########################################################################

module.exports =
	class ProjectRemoveListView extends SelectListView

		## Fields ##

		panel: null
		multi: null

		## SelectListView Methods ##

		initialize: ->
			super

			@panel = atom.workspace.addModalPanel( item: this, visible: false )
			@addClass( "project-jump" )

		getFilterKey: ->
			return "name"

		viewForItem: ( project ) ->
			el = document.createElement( "li" )
			el.textContent = path.parse( project ).base
			return el

		destroy: ->
			@panel.destroy()

		cancelled: ->
			@panel.hide()

		confirmed: ( project ) ->
			@cancel() unless @multi

			@removeProject( project )

			@addProjects() if @multi

		attach: ->
			@storeFocusedElement()
			@addProjects()
			@panel.show()
			@focusFilterEditor()

		## ProjectJump Methods ##

		addProjects: ->
			@setItems( atom.project.getPaths() )

		show: ( options ) ->
			@multi = options.multi
			@attach()

		removeProject: ( dir ) ->
			console.log dir
			atom.project.removePath( dir )
