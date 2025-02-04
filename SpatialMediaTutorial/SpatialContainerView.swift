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
        PhotoAsset(
            id: UUID(),
            url: Bundle.main.url(
                forResource: "Sample_Photo_1", withExtension: "jpg"),
            photoType: .regular),
        PhotoAsset(
            id: UUID(),
            url: Bundle.main.url(
                forResource: "Sample_Photo_2", withExtension: "jpg"),
            photoType: .regular),
        PhotoAsset(
            id: UUID(),
            url: Bundle.main.url(
                forResource: "Sample_Photo_3", withExtension: "jpg"),
            photoType: .regular),
        PhotoAsset(
            id: UUID(),
            url: Bundle.main.url(
                forResource: "Sample_SpatialPhoto_4", withExtension: "heic"),
            photoType: .spatial),
        PhotoAsset(
            id: UUID(),
            url: Bundle.main.url(
                forResource: "Sample_SpatialPhoto_5", withExtension: "heic"),
            photoType: .spatial),
        PhotoAsset(
            id: UUID(),
            url: Bundle.main.url(
                forResource: "Sample_SpatialPhoto_6", withExtension: "heic"),
            photoType: .spatial),
    ]
}

struct SpatialContainerView: View {
    @State var state: ContentState
    private let width: CGFloat = 1250
    private let height: CGFloat = 700

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(state.photoAssets) { asset in
                    switch asset.photoType {
                    case .regular:
                        if let uiImage = UIImage(
                            contentsOfFile: asset.url!.path)
                        {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 30)
                                )
                                .frame(width: width, height: height)
                        } else {
                            Text("Image not found")
                        }
                    case .spatial:
                        SpatialImageView(asset: asset)
                            .frame(width: width, height: height)
                            .background(Color.black.opacity(0.001))
                    }

                }
            }
        }
        .scrollTargetBehavior(.paging)
        .frame(width: width, height: height)
    }
}

#Preview(windowStyle: .automatic) {
    @Previewable @State var state = ContentState()
    SpatialContainerView(state: state)
        .environment(AppModel())
}
