## Dependencies ################################################################

fs = require "fs"
path = require "path"
{SelectListView} = require "atom-space-pen-views"

## View ########################################################################

module.exports =
	class ProjectJumpListView extends SelectListView

		## Fields ##

		panel: null
		mode: null

		## SelectListView Methods ##

		initialize: ->
			super

			@panel = atom.workspace.addModalPanel( item: this, visible: false )
			@addClass( "project-jump" )
			@list.addClass( "mark-active" )

		getFilterKey: ->
			return "name"

		viewForItem: ( project ) ->
			el = document.createElement( "li" )
			el.textContent = project.name
			el.dataset.dir = project.dir
			if atom.project.getPaths().indexOf( project.dir ) != -1
				el.classList.add( "active" )
			return el

		destroy: ->
			@panel.destroy()

		cancelled: ->
			@panel.hide()

		confirmed: ( project ) ->
			@cancel()

			@openProject( project.dir )

		attach: ->
			@storeFocusedElement()
			@addProjects()
			@panel.show()
			@focusFilterEditor()

		## ProjectJump Methods ##

		addProjects: ->
			list = []

			try
				projectHome = atom.config.get( "core.projectHome" )
				for project in fs.readdirSync( projectHome )
					list.push(
						name: project
						dir: path.join( projectHome, project )
					)

			@setItems( list )

		show: ( mode ) ->
			@mode = mode
			@attach()

		openProject: ( dir ) ->
			switch @mode
				when "add"
					atom.project.addPath( dir )
				when "open"
					atom.open( pathsToOpen: [ dir ], newWindow: true )
				when "switch"
					atom.project.setPaths( [ dir ] )
