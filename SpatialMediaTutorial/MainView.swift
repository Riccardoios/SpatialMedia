//
//  MainView.swift
//  SpatialMediaTutorial
//
//  Created by Riccardo Carlotto on 22/01/25.
//

import SwiftUI

struct MainView: View {
    @Environment(\.openWindow) private var openWindow
    let windowIDs: [WindowID] = [WindowID.photo, WindowID.video]

    var body: some View {
        ForEach(windowIDs) { window in
            Button("Open Spatial \(window.description) Window") {
                openWindow(id: window.rawValue)
            }
        }
        ToggleImmersiveSpaceButton()
    }
}

#Preview {
    MainView()
        .environment(AppModel())
}
