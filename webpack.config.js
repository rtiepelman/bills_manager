module.exports = {
    entry: "./client.js",
    output: {
        path: __dirname,
        filename: "./web/bundle.js"
    },
    module: {
        loaders: [
            { test: /\.css$/, loader: "style!css" }
        ]
    }
};
