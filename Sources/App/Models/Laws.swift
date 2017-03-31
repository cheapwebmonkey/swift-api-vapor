//
//  Law.swift
//  Laws
//
//  Created by Margeaux Spring on 3/30/17.
//

import Foundation
import Vapor

struct Law: Model {
    var exists: Bool = false
    var id: Node?
    let legislator: String
    let bill: String
    let vote: String
    
    init(legislator: String, bill: String, vote: String) {
        self.legislator = legislator
        self.bill = bill
        self.vote = vote
    }
    
    // NodeInitializable
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        legislator = try node.extract("legislator")
        bill = try node.extract("bill")
        vote = try node.extract("vote")
    }
    
    // NodeRepresentable
    func makeNode(context: Context) throws -> Node {
        return try Node(node: ["id": id,
                               "legislator": legislator,
                               "bill": bill,
                               "vote": vote])
    }
    
    // Preparation
    static func prepare(_ database: Database) throws {
        try database.create("laws") { laws in
            laws.id()
            laws.string("legislator")
            laws.string("bill")
            laws.string("vote")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("laws")
    }
}
