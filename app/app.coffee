settings = require(__dirname + '/functions/config')
_ = require('underscore')
request = require('superagent')
com = require('node-comline')
complete = require('complete')
googleapis = require('googleapis')

fs = require('fs')


command = _.keys(com())


webserviceUrl = settings.get("task-server-url")

addTask= (taskName)->
    console.log taskName

outputIncorrectUseage= (optionalError)->
    message = "\nIncorrect use. \n\nFor correct use run 'code-time help'\n\n"
    if optionalError
        message = message + optionalError + "\n\n"
    console.log message

commandAction= (command)->
    task = command.splice(2, command.length) #removes the first two parts of the command
    task = task.toString().replace(",", " ")
    return task

returnCompleteList= ()->
    request
        .get(webserviceUrl)
        .send({name : task})
        .end((res)->
            if res.status is 200
                return res.body)

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



complete.list = returnCompleteList()

    

###complete.callback = (lastSelection, userInput, reducedList)->
    if lastSelection == 'task'###

testStartDate = new Date()
testEndDate = new Date(testStartDate)
testEndDate.setMinutes ( testStartDate.getMinutes() + 30)


###googleapis.discover("calendar", "v3").execute (err, client) ->
    return
    task = {
        end : testEndDate,
        start : testStartDate
    }
    req1 = client.events.insert(task)
    req1.execute (err, response) ->
        console.log "Long url is", response.longUrl
        return###



switch command[0]
    when "task" 
        switch command[1]
            when "add"
                task = commandAction(command)
                request
                    .post(webserviceUrl)
                    .send({name : task})
                    .end((res)->
                        if res.status is 200
                            console.log "Task successfully added"
                        else
                            console.log "Something went wrong. HTTP status: " + res.status)
            when "remove"                
                task = commandAction(command)
                request
                    .del(webserviceUrl)
                    .send({name : task})
                    .end((res)->
                        if res.status is 200
                            console.log "Task successfully removed"
                        else
                            console.log "Something went wrong. HTTP status: " + res.status)
            when "list"
                request
                    .get(webserviceUrl)
                    .send({name : task})
                    .end((res)->
                        if res.status is 200
                            _.each(res.body,(task)->
                                console.log task)
                        else
                            console.log "Something went wrong. HTTP status: " + res.status)
            when "start"
                console.log "starting " + command[2]
            when "complete"
                console.log "completed " + command[2]
            when "current"
                console.log "logs tasks which have been started but not completed"
            else
                outputIncorrectUseage("Perhaps you want: add | remove | list | start | complete | current")                
    when "setup"
        switch command[1]
            when "calendarname"
                calendar = commandAction(command)
                calendar = calendar.toString().replace(",", ".")
                calendar = calendar.toString().replace(" ", ".")
                debugger
                settings.set('googleSettings:calendarname', calendar)
                settings.save()                
                console.log "setting calendar name: " + calendar
            when "user"
                username = commandAction(command)
                username = username.toString().replace(",", ".")
                username = username.toString().replace(" ", ".")
                settings.set('googleSettings:user', username)  
                settings.save() 
                console.log "user name: " + username
            when "password"
                password = commandAction(command)
                settings.set('googleSettings:password', password) 
                settings.save()  
                console.log "username name: " + password
            when "domain"
                domain = commandAction(command)
                domain = domain.toString().replace(",", ".")
                domain = domain.toString().replace(" ", ".")
                settings.set('googleSettings:domain', domain)
                settings.save() 
                console.log "domain: " + domain
            else
                outputIncorrectUseage()
    when "help"
        helpMenu()

    else
        outputIncorrectUseage()






