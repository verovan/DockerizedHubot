#  Edrans reports 
#
# Notes:
#   Actions to be sent on the next report can be found at bot's reports/ directory
#

module.exports = (robot) ->
  fs = require 'fs'
  moment = require 'moment'
  fs.exists './logs/', (exists) ->
    if exists
      startLogging()
    else
      fs.mkdir './logs/', (error) ->
        unless error
          startLogging()
        else
          console.log "Could not create logs directory: #{error}"
  startLogging = ->
    console.log "Started logging"
    robot.hear /.*/, (msg) ->
      fs.appendFile logFileName(msg), formatMessage(msg), (error) ->
        console.log "Could not log message: #{error}" if error
  logFileName = (msg) ->
    safe_room_name = "#{msg.message.room}".replace /[^a-z0-9]/ig, ''
    "./logs/#{moment().format('YYYY-MM-DD')}-#{safe_room_name}.log"
  formatMessage = (msg) ->
    "[#{new Date()}] #{msg.message.user.name}: #{msg.message.text}\n"
