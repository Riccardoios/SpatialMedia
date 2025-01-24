//
//  SpatialMediaTutorialApp.swift
//  SpatialMediaTutorial
//
//  Created by Riccardo Carlotto on 20/01/25.
//

import SwiftUI

enum WindowID: String, CaseIterable, Identifiable {
    case main
    case photo
    case video

    var id: UUID {
        UUID()
    }
    
    var description: String {
        switch self {
        case .main:
            return "Main"
        case .photo:
            return "Photo"
        case .video:
            return "Video"
        }
    }
}

@main
struct SpatialMediaTutorialApp: App {
    @State private var appModel = AppModel()

    var body: some Scene {
        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView(
                spatialVideoState: SpatialVideoState(),
                spatialGalleryState: SpatialGalleryState()
            )
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}
