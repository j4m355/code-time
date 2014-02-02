settings = require(__dirname + '/functions/config')
_ = require('underscore')
request = require('superagent')
com = require('node-comline')

command = _.keys(com())


webserviceUrl = settings.get("task-server-url")

addTask= (taskName)->
    console.log taskName

outputIncorrectUseage= (optionalError)->
    message = "\nIncorrect use \nFor correct use run 'code-time help'. "
    if optionalError
        message = message + optionalError
    console.log message

commandAction= (command)->
    task = command.splice(2, command.length) #removes the first two parts of the command
    task = task.toString().replace(",", " ")
    return task


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
            else
                outputIncorrectUseage()
                
    when "help"
        console.log " "          
        console.log "code-time against tasks:"
        console.log " "
        console.log "code-time <task> <add | remove | list | start | complete> <task-name>"
        console.log " "
        console.log "Example:"
        console.log "code-time task start something-amazing"
        console.log " "
        console.log "code-time help  - this menu"
        console.log " "
        console.log " "

    else
        outputIncorrectUseage()






