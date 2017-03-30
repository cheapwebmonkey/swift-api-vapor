import Vapor

let drop = Droplet()

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

//drop.get("laws") { req in
//    return try JSON(node: ["laws": [
//        ["legislator": "Sarah Thomas", "bill": "SB2", "vote": "y"],
//        ["legislator": "Steve Burbank", "bill": "SB2", "vote": "y"],
//        ["legislator": "Drew Hardy", "bill": "SB2", "vote": "n"]
//        ]
//    ])
//}

drop.get("laws") { req in
    let laws = [
        Law(legislator: "Sarah Hanson", bill: "SB2", vote:"y"),
        
        Law(legislator: "Steve Sherman", bill: "SB2", vote:"y"),
        
        Law(legislator: "Drew Hardy", bill: "SB2", vote:"n")
    ]
    let lawsNode = try laws.makeNode()
    let nodeDictionary = ["laws": lawsNode]
    return try JSON(node: nodeDictionary)
}

drop.resource("posts", PostController())

drop.run()
