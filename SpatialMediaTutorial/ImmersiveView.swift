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
    @State var isPhotoBig: Bool = false

    var body: some View {
        RealityView { content, attachments in
            if let immersiveContentEntity = try? await Entity(
                named: "AAA_MainScene", in: studioBundle)
            {
                content.add(immersiveContentEntity)
            }

            let videoEntity = spatialVideoState.makeSpatialVideo()
            videoEntity.position = [0.75, 1.5, -1.5]
            content.add(videoEntity)

            if let spatialPhoto = attachments.entity(for: "SpatialPhoto") {
                spatialPhoto.position = [-0.75, 1.5, -1.5]
                content.add(spatialPhoto)
            }
            
            if let photoControls = attachments.entity(for: "PhotoControls") {
                photoControls.position = [-0.5, 0.9, -1.5]
                content.add(photoControls)
            }

            if let videoControls = attachments.entity(for: "Video Controls") {
                videoControls.position = [0.75, 1.3, -1.5]
                content.add(videoControls)
            }

        } update: { content, attachments in
            
            if let spatialPhoto = attachments.entity(for: "SpatialPhoto") {
                spatialPhoto.position = [-0.5, 1.5, -1.5]
                let scaling: Float = isPhotoBig ? 3.0 : 1.0
                spatialPhoto.scale = [scaling, scaling, scaling]
            }
            
        } attachments: {
            Attachment(id: "SpatialPhoto") {
                SpatialGalleryView(state: spatialGalleryState)
            }

            Attachment(id: "PhotoControls") {
                Button("scale photo") {
                    isPhotoBig.toggle()
                }
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
