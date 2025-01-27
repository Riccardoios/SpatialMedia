//
//  ImmersiveView.swift
//  SpatialMediaTutorial
//
//  Created by Riccardo Carlotto on 20/01/25.
//

import RealityKit
import Studio
import SwiftUI

struct ImmersiveView: View {
    @State var spatialVideoState: SpatialVideoState
    @State var spatialGalleryState: SpatialGalleryState

    var body: some View {
        RealityView { content, attachments in
            if let immersiveContentEntity = try? await Entity(
                named: "AAA_MainScene", in: studioBundle) {
                content.add(immersiveContentEntity)
            }
            
            let videoEntity = spatialVideoState.makeSpatialVideo()
            videoEntity.position = [0.5, 1.5, -1.5]
            content.add(videoEntity)
            
            if let spatialPhoto = attachments.entity(for: "SpatialPhoto") {
                spatialPhoto.position = [-0.5, 1.5, -1.5]
                content.add(spatialPhoto)
            }
            
            if let videoControls = attachments.entity(for: "Video Controls") {
                videoControls.position = [0.5, 1.3, -1.5]
                content.add(videoControls)
            }
        } attachments: {
            Attachment(id: "SpatialPhoto") {
                SpatialGalleryView(state: spatialGalleryState)
            }
            
            Attachment(id: "Video Controls") {
                HStack {
                    Button("Play") {
                        spatialVideoState.play()
                    }
                    
                    Button("Pause") {
                        spatialVideoState.pause()
                    }
                }
            }
        }
    }
}

#Preview(immersionStyle: .full) {
    ImmersiveView(
        spatialVideoState: SpatialVideoState(),
        spatialGalleryState: SpatialGalleryState()
    )
    .environment(AppModel())
}
