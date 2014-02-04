####To Install

    npm install j4m355/code-time -g


#####Users
Place credential settings in ``./app/config/settings.json``.

#####Forkers
If forking ``touch`` a ``_settings.json`` file instead of placing credentials in ``settings.json`` to avoid am accidental commit of credentials.

####Useful info presented in a lazymans format:

	helpMenu= ()->
	    console.log " "          
	    console.log "code-time against tasks:"
	    console.log " " 
	    console.log "Initial setup:"
	    console.log " " 
	    console.log "code-time setup <domain | calendarname | user | password>"
	    console.log " "
	    console.log "note: no full stops in domain or username - use spaces eg mydomain com"
	    console.log " "
	    console.log " "
	    console.log "code-time <task> <add | remove | list | start | complete | current> <task-name>"
	    console.log " "
	    console.log "Example:"
	    console.log "code-time task start something-amazing"
	    console.log " "
	    console.log "code-time help  - this menu"
	    console.log " "
	    console.log " "

