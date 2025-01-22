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
    @State var state = ContentState()

    var body: some View {
        HStack {
            ScrollView(.horizontal) {
                HStack(spacing: 300) {
                    Spacer()
                    ForEach(state.allMedia) { media in
                        SpatialImageView(name: media.name)
                            .frame(width: 537.6, height: 403.2)
                    }
                    Spacer()
                }
            }
        }
    }
}



#Preview(windowStyle: .automatic) {
    SpatialContainerView()
        .environment(AppModel())
}
