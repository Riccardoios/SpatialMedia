//
//  SpatialVideoView.swift
//  SpacialMediaTutorial
//
//  Created by Riccardo Carlotto on 22/01/25.
//

import SwiftUI
import RealityKit
import AVFoundation

class SpatialVideoEntity {
    func makeVideoEntity(url: URL) -> Entity {
        let asset = AVURLAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer()
        player.replaceCurrentItem(with: playerItem)
        player.play()
        
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
    let movieMedia = Media(name: "MOV_1619")
    
    private var url: URL? {
        Bundle.main.url(forResource: movieMedia.name, withExtension: "mov")
    }
    
    var videoEntity: Entity {
        let spatialVideoEntity = SpatialVideoEntity()
        return spatialVideoEntity.makeVideoEntity(url: url!)
    }
}

struct SpatialVideoView: View {
    @State var state = SpatialVideoState()
    
    var body: some View {
        RealityView { content, attachments in
            content.add(state.videoEntity)
        } attachments: {
            
        }
    }
}

#Preview {
    SpatialVideoView()
}
