// Generated by CoffeeScript 1.12.2
var app, config, express, express_nunjucks, njk, nunjucks, pg, pool, server;

nunjucks = require("nunjucks");

express_nunjucks = require("express-nunjucks");

express = require("express");

pg = require("pg");

config = {
  user: "bills_manager",
  database: "bills_manager",
  password: "myD0p3P4SSw0rD!",
  host: "localhost"
};

pool = new pg.Pool(config);

pool.on("error", function(err) {
  return console.error("PostgreSQL Client Error " + err.message, err.stack);
});

app = express();

app.set("views", __dirname + "/templates");

njk = express_nunjucks(app, {
  watch: true,
  noCache: true
});

app.get("/", function(req, res) {
  pool.connect(function(err, client, done) {
    if (err) {
      return console.error("Error fetching client from pool " + err);
    }
    return client.query("SELECT 'Bills Manager' AS msg", function(err, res) {
      done();
      if (err) {
        return console.error("Error running query " + err);
      }
      return console.log(res.rows[0].msg);
    });
  });
  return res.render("index.html");
});

server = app.listen(3000, function() {
  var host, port;
  host = server.address().address;
  port = server.address().port;
  return console.log("Bill Manager listening at http://" + host + ":" + port);
});
