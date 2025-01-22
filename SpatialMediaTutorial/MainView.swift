//
//  MainView.swift
//  SpatialMediaTutorial
//
//  Created by Riccardo Carlotto on 22/01/25.
//

import SwiftUI

struct MainView: View {
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        ForEach(WindowID.allCases) { window in
            Button("Open \(window.rawValue) Window") {
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
