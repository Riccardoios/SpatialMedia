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
            
            let videoEntity = spatialVideoState.videoEntity
            videoEntity.position = [0.5, 1.5, -1.5]
            content.add(videoEntity)
            
            if let spatialPhoto = attachments.entity(for: "SpatialPhoto") {
                spatialPhoto.position = [-0.5, 1.5, -1.5]
                content.add(spatialPhoto)
            }
            
            if let toggleButtonEntity = attachments.entity(for: "ToggleButton") {
                toggleButtonEntity.position = [0, 2, -2]
                content.add(toggleButtonEntity)
            }
                
        } attachments: {
            Attachment(id: "SpatialPhoto") {
                SpatialGalleryView(state: spatialGalleryState)
            }
            
            Attachment(id: "ToggleButton") {
                ToggleImmersiveSpaceButton()
                    .padding()
                    .glassBackgroundEffect()
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
