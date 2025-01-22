//
//  ImmersiveView.swift
//  SpatialMediaTutorial
//
//  Created by Riccardo Carlotto on 20/01/25.
//

import SwiftUI
import RealityKit
import Studio

struct ImmersiveView: View {

    var body: some View {
        RealityView { content in
            if let immersiveContentEntity = try? await Entity(named: "AAA_MainScene", in: studioBundle) {
                content.add(immersiveContentEntity)
            }
        }
    }
}

#Preview(immersionStyle: .full) {
    ImmersiveView()
        .environment(AppModel())
}
