//
//  SpatialVideoView.swift
//  SpatialMediaTutorial
//
//  Created by Riccardo Carlotto on 22/01/25.
//

import SwiftUI
import RealityKit
import AVFoundation

class SpatialVideoEntity {
    func makeVideoEntity(player: AVPlayer) -> Entity {
        var videoPlayerComponent = VideoPlayerComponent(avPlayer: player)
        videoPlayerComponent.desiredViewingMode = .stereo
        let entity = Entity()
        entity.components.set(videoPlayerComponent)
        entity.scale *= 0.4
        return entity
    }
}

@MainActor
@Observable
class SpatialVideoState {
    let movieMedia = Media(name: "MOV_2525")
    let spatialVideoEntity = SpatialVideoEntity()
    let player = AVPlayer()
    
    func makeSpatialVideo() -> Entity {
        let url = Bundle.main.url(forResource: movieMedia.name, withExtension: "mov")!
        let asset = AVURLAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        player.replaceCurrentItem(with: playerItem)
        return spatialVideoEntity.makeVideoEntity(player: player)
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
}
