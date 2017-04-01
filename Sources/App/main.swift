import Vapor
import VaporPostgreSQL


let drop = Droplet(providers: [VaporPostgreSQL.Provider.self])

drop.preparations.append(Law.self)


let version = try drop.database?.driver.raw("SELECT version()")

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("laws") { req in
    let laws = try Law.all().makeNode()
    let lawsDictionary = ["laws": laws]
    return try JSON(node: lawsDictionary)
}


drop.post("law") { req in
    var law = try Law(node: req.json)
    try law.save()
    return try law.makeJSON()
}


drop.resource("posts", PostController())

drop.run()
