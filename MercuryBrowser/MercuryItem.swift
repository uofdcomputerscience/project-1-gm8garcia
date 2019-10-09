//
//  File.swift
//  MercuryBrowser
//
//  Created by Russell Mirabelli on 9/29/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import Foundation

struct MercuryItem: Codable {
    let name: String
    let type: String
    let url: String
    
    var imageURL: URL {
        return URL(string: url)!
    }
}
