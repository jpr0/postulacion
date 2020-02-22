//
//  TrackEntity+CoreDataProperties.swift
//  
//
//  Created by Slacker on 22-02-20.
//
//

import Foundation
import CoreData


extension TrackEntity {

    @nonobjc public class func fetchAll() -> NSFetchRequest<TrackEntity> {
        return NSFetchRequest<TrackEntity>(entityName: "TrackEntity")
    }
    
    @nonobjc public class func fetchTrack(by id: Int32) -> NSFetchRequest<TrackEntity> {
        let request = NSFetchRequest<TrackEntity>(entityName: "TrackEntity")
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "%K == %i", #keyPath(TrackEntity.trackId), id)
        
        return request
    }

    @NSManaged public var artistName: String
    @NSManaged public var artworkUrl100: String
    @NSManaged public var collectionId: Int
    @NSManaged public var collectionName: String
    @NSManaged public var previewUrl: String?
    @NSManaged public var trackName: String?
    @NSManaged public var wrapperType: String
    @NSManaged public var trackId: Int32

}
