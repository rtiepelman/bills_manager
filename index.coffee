nunjucks = require "nunjucks"
express_nunjucks = require "express-nunjucks"
express = require "express"
pg = require "pg"


# PostgreSQL
config =
        user: "bills_manager"
        database: "bills_manager"
        password: "myD0p3P4SSw0rD!"
        host: "localhost"

# PostgreSQL Pool
pool = new pg.Pool config
pool.on "error", (err) ->
        console.error "PostgreSQL Client Error #{err.message}", err.stack


# Express
app = express()
app.set "views", "#{__dirname}/templates"

# Nunjucks
njk = express_nunjucks app,
        watch: true
        noCache: true


# Request Handlers
app.get "/", (req, res) ->
        pool.connect (err, client, done) ->
                return console.error "Error fetching client from pool #{err}" if err
                client.query "SELECT 'Bills Manager' AS msg", (err, res) ->
                        do done
                        return console.error "Error running query #{err}" if err
                        console.log res.rows[0].msg
        res.render "index.html"


# start the server
server = app.listen 3000, ->
        host = server.address().address
        port = server.address().port
        console.log "Bill Manager listening at http://#{host}:#{port}"
