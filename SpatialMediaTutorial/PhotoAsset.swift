//
//  PhotoAsset.swift
//  SpatialMediaTutorial
//
//  Created by Riccardo Carlotto on 03/02/25.
//


import Foundation

public struct PhotoAsset: Identifiable {
    public enum PhotoType {
        case regular
        case spatial
    }

    public let id: UUID
    public let url: URL?
    public let photoType: PhotoType

    public init(id: UUID, url: URL?, photoType: PhotoType) {
        self.id = id
        self.url = url
        self.photoType = photoType
    }
}
