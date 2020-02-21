//
//  TrackEntity+CoreDataProperties.swift
//  ItunesPagerApp
//
//  Created by slacker on 1/30/20.
//  Copyright © 2020 Juan Pablo. All rights reserved.
//
//

import Foundation
import CoreData

extension TrackEntity {

    @nonobjc public class func fetchAll() -> NSFetchRequest<TrackEntity> {
        return NSFetchRequest<TrackEntity>(entityName: "TrackEntity")
    }

    @nonobjc public class func fetchTracks(by trackName: String) -> NSFetchRequest<TrackEntity> {
        let request = TrackEntity.fetchAll()
        request.predicate = NSPredicate(format: "(%K CONTAINS[c] %@) OR (%K CONTAINS[c] %@)", #keyPath(TrackEntity.trackName), trackName,  #keyPath(TrackEntity.collectionName), trackName)
        
        return request
    }

    @nonobjc public class func fetchTracks(by collectionId: Int) -> NSFetchRequest<TrackEntity> {
        let request = TrackEntity.fetchAll()
        request.predicate = NSPredicate(
            format: "%K == %@", #keyPath(TrackEntity.collectionId), NSNumber(integerLiteral: collectionId))

        return request
    }

    @NSManaged public var wrapperType: String
    @NSManaged public var collectionId: Int
    @NSManaged public var artistName: String
    @NSManaged public var collectionName: String
    @NSManaged public var trackName: String?
    @NSManaged public var previewUrl: String?
    @NSManaged public var artworkUrl100: String
}
