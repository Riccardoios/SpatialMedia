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
class ContentState {
    let allMedia: [Media] = [
        Media(name: "IMG_1439"),
        Media(name: "IMG_0406"),
        Media(name: "IMG_1659")
    ]
}

struct SpatialContainerView: View {
    @State var state: ContentState

    var body: some View {
        TabView {
            ForEach(state.allMedia) { media in
                SpatialImageView(name: media.name)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview(windowStyle: .automatic) {
    @Previewable @State var state = ContentState()
    SpatialContainerView(state: state)
        .environment(AppModel())
}
