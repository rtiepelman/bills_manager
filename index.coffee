nunjucks = require "nunjucks"
express_nunjucks = require "express-nunjucks"
express = require "express"

app = express()
app.set "views", "#{__dirname}/templates"

njk = express_nunjucks app,
        watch: true
        noCache: true

app.get "/", (req, res) ->
        res.render "index.html"

server = app.listen 3000, ->
        host = server.address().address
        port = server.address().port
        console.log "Bill Manager listening at http://#{host}:#{port}"
