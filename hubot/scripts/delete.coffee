module.exports = (robot) ->
 robot.respond /delete (.*)$/i, (msg) ->
    log = msg.match[1]
    @exec = require('child_process').exec
    command = "ruby -i.bak -ne 'print if not /#{log}/' /opt/hubot/reports/Shift_Report_level1operations.out"

    msg.send "Deleting  #{log}"

    @exec command, (error, stdout, stderr) ->
      
      if error == null then msg.send "Log #{log} has been deleted." else msg.send "Que?... http://www.generadormemes.com/media/created/t9sx4k.jpg"
