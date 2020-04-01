//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Oliver Paray on 4/1/20.
//  Copyright © 2020 Oliver Paray. All rights reserved.
//

import Library
import Foundation

struct SearchResult {

    let id: Int
    let kind: String
    let name: String
    let artworkUrl: String
    let genre: String
    let linkUrl: String

    init(id: Int, kind: String, name: String, artworkUrl: String, genre: String, linkUrl: String) {
        self.id = id
        self.kind = kind
        self.name = name
        self.artworkUrl = artworkUrl
        self.genre = genre
        self.linkUrl = linkUrl
    }

    init?(data: Data){
        guard let unarchiver = try? NSKeyedUnarchiver(forReadingFrom: data) else { return nil }
        defer {
            unarchiver.finishDecoding()
        }
        let rawId = unarchiver.decodeInt64(forKey: "id")
        guard
            let rawKind = unarchiver.decodeObject(forKey: "kind") as? String,
            let rawName = unarchiver.decodeObject(forKey: "name") as? String,
            let rawArtUrl = unarchiver.decodeObject(forKey: "artworkUrl") as? String,
            let rawGenre = unarchiver.decodeObject(forKey: "genre") as? String,
            let rawLinkUrl = unarchiver.decodeObject(forKey: "linkUrl") as? String
            else { return nil }
        self.id = Int(rawId)
        self.kind = rawKind
        self.name = rawName
        self.artworkUrl = rawArtUrl
        self.genre = rawGenre
        self.linkUrl = rawLinkUrl
    }

    func encode() -> Data {
        let archiver = NSKeyedArchiver(requiringSecureCoding: false)
        archiver.encode(id, forKey: "id")
        archiver.encode(kind, forKey: "kind")
        archiver.encode(name, forKey: "name")
        archiver.encode(artworkUrl, forKey: "artworkUrl")
        archiver.encode(genre, forKey: "genre")
        archiver.encode(linkUrl, forKey: "linkUrl")
        return archiver.encodedData
    }
    
}
