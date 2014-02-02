settings = require(__dirname + '/functions/config')
_ = require('underscore')
request = require('superagent')
#exec = require('child_process').exec
com = require('node-comline')

command = _.keys(com())

#zeroBasedCommandLength = command.length -1

#console.log zeroBasedCommandLength

#console.log command

webserviceUrl = settings.get("task-server-url")

addTask= (taskName)->
    console.log taskName

if command.length <= 2
    console.log "Incorrect use - call 'code-time help all' for useage"
    process.exit(0)

switch command[0]
    when "task" 
        switch command[1]
            when "add"                
                task = command.splice(2, command.length) #removes the first two parts of the command
                task = task.toString().replace(",", " ")
                request
                    .post(webserviceUrl)
                    .send({name : task})
                    .end((res)->
                        if res.status is 200
                            console.log "Task successfully added"
                        else
                            console.log "Something went wrong. HTTP status: " + res.status)
            when "remove"
                addTask("egg")
                console.log "remove " + command[2]
            when "list"
                console.log "get all"
                
    when "help"
        switch command[1]
            when "all"
                console.log "###################"
                console.log "application usage: "
                console.log "task usage: "
    else
        console.log "Incorrect use - call code-time help all"






