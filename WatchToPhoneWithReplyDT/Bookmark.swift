//
//  Bookmark.swift
//  WatchToPhoneWithReplyDT
//
//  Created by Joynal Abedin on 24/7/23.
//
import Foundation

struct Bookmark: Codable {
    let title: String
    let date: String
    let pageURL: String
    
    func encodeIt() -> Data {
        let data = try! PropertyListEncoder.init().encode(self)
        return data
    }
    
    static func decodeIt(_ data: Data) -> Bookmark {
        let bookmark = try! PropertyListDecoder.init().decode(Bookmark.self, from: data)
        return bookmark
    }
}
