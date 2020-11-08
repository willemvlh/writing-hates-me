const SaxonJS = require("saxon-js")
const fs = require("fs")
const path = require("path")
const process = require("process")
const url = require("url")
const os = require("os")

async function writePosts() {
    //make pages dir for output
    let pagesDir = path.join(__dirname, "../pages")
    if (!fs.existsSync(pagesDir)) {
        fs.mkdirSync(pagesDir)
    }

    //pre-compute collection for getting posts
    let postsDir = path.join(__dirname, "../posts")
    let files = fs.readdirSync(postsDir).map(fn => postsDir + "/" + fn)
    let resolved = await Promise.all(files.map(async fn => SaxonJS.getResource({ file: fn, type: "xml" })))

    //write main
    let main = SaxonJS.transform({
        stylesheetLocation: path.join(__dirname, "main.sef"),
        collectionFinder: _ => resolved,
        destination: "serialized",
    })

    fs.writeFileSync(path.join(__dirname, "../pages/index.html"), main.principalResult, { encoding: "utf-8" })

    //write posts
    files.forEach((fn) => {
        SaxonJS.transform({
            stylesheetLocation: path.join(__dirname, "post.sef"),
            sourceLocation: url.pathToFileURL(fn),
            deliverResultDocument: uri => {
                return { destination: "file", save: (a, b, c) => fs.writeFileSync("./pages/" + uri, (b[0].value), { encoding: c }) }
            }
        })
    })
}

writePosts().catch(err => {
    console.error(err)
    process.exit(-1)
})





