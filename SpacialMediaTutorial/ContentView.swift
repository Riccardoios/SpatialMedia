//
//  ContentView.swift
//  SpacialMediaTutorial
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

struct ContentView: View {
    @State var state = ContentState()

    var body: some View {
        HStack {
            ScrollView(.horizontal) {
                HStack(spacing: 300) {
                    Spacer()
                    ForEach(state.allMedia) { media in
                        SpacialImageView(name: media.name)
                            .frame(width: 537.6, height: 403.2)
                    }
                    Spacer()
                }
            }
        }
    }
}



#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
