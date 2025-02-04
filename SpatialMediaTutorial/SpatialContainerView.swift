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
    let photoAssets: [PhotoAsset] = [
        PhotoAsset(id: UUID(), url: Bundle.main.url(forResource: "Sample_Photo_1", withExtension: "jpg"), photoType: .regular),
            PhotoAsset(id: UUID(), url: Bundle.main.url(forResource: "Sample_Photo_2", withExtension: "jpg"), photoType: .regular),
            PhotoAsset(id: UUID(), url: Bundle.main.url(forResource: "Sample_Photo_3", withExtension: "jpg"), photoType: .regular),
            PhotoAsset(id: UUID(), url: Bundle.main.url(forResource: "Sample_SpatialPhoto_4", withExtension: "heic"), photoType: .spatial),
            PhotoAsset(id: UUID(), url: Bundle.main.url(forResource: "Sample_SpatialPhoto_5", withExtension: "heic"), photoType: .spatial),
            PhotoAsset(id: UUID(), url: Bundle.main.url(forResource: "Sample_SpatialPhoto_6", withExtension: "heic"), photoType: .spatial)
    ]
}

struct SpatialContainerView: View {
    @State var state: ContentState

    var body: some View {
        TabView {
            ForEach(state.photoAssets) { asset in
                switch asset.photoType {
                case .regular:
                    RealityView { content in
                        
                    } update: { content in
                        let cube = ModelEntity(mesh: .generateBox(size: .init(x: 0.1, y: 0.1, z: 0.1)))
                        content.add(cube)
                    }

                case .spatial:
                    RealityView { content in
                        
                    } update: { content in
                        let sfere = ModelEntity(mesh: .generateSphere(radius: 0.1))
                        content.add(sfere)
                    }
                }
//                SpatialImageView(asset: asset)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .padding()
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
