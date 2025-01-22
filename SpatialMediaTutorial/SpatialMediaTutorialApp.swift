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
}

@main
struct SpatialMediaTutorialApp: App {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup(id: WindowID.main.rawValue) {
            MainView()
                .onAppear {
                    Task {
                        await openImmersiveSpace(id: appModel.immersiveSpaceID)
                    }
                }
        }

        WindowGroup(id: WindowID.photo.rawValue) {
            SpatialContainerView()
                .environment(appModel)
        }

        WindowGroup(id: WindowID.video.rawValue) {
            SpatialVideoView(state: SpatialVideoState())
        }

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
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
