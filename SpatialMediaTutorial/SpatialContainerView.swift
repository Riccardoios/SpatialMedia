//
//  SpatialContainerView.swift
//  SpatialMediaTutorial
//
//  Created by Riccardo Carlotto on 20/01/25.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct Media: Identifiable {
    let id = UUID()
    var name: String
}

@Observable
class SpatialGalleryState {
    let allMedia: [Media] = [
        Media(name: "1"),
        Media(name: "2"),
        Media(name: "3"),
        Media(name: "4"),
        Media(name: "5")
    ]
}

struct SpatialGalleryView: View {
    @State var state: SpatialGalleryState

    var body: some View {
        TabView {
            ForEach(state.allMedia) { media in
                SpatialImageView(name: media.name)
                    .frame(depth: 0)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.001)) // this is needed to make it interactive
    }
}

#Preview(windowStyle: .automatic) {
    @Previewable @State var state = SpatialGalleryState()
    SpatialGalleryView(state: state)
        .environment(AppModel())
}
