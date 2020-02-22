//
//  ItunesModel.swift
//  iTunesFavoriteApp
//
//  Created by Juan Pablo on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import Foundation

struct ArtistModel: Decodable {
    let wrapperType: String
    let collectionId: Int
    let trackId: Int
    let artistName: String
    let collectionName: String
    let trackName: String?
    let previewUrl: String?
    let artworkUrl100: String
    
    static func empty() -> ArtistModel {
        return ArtistModel(wrapperType: "", collectionId: 0, trackId: 0, artistName: "", collectionName: "", trackName: "", previewUrl: "", artworkUrl100: "")
    }
}
