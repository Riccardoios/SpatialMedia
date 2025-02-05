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
                forResource: "4", withExtension: "heic"),
            photoType: .spatial),
        PhotoAsset(
            id: UUID(),
            url: Bundle.main.url(
                forResource: "5", withExtension: "heic"),
            photoType: .spatial),
        PhotoAsset(
            id: UUID(),
            url: Bundle.main.url(
                forResource: "6", withExtension: "heic"),
            photoType: .spatial),
        PhotoAsset(
            id: UUID(),
            url: Bundle.main.url(
                forResource: "7", withExtension: "heic"),
            photoType: .spatial),
        PhotoAsset(
            id: UUID(),
            url: Bundle.main.url(
                forResource: "8", withExtension: "heic"),
            photoType: .spatial),
        PhotoAsset(
            id: UUID(),
            url: Bundle.main.url(
                forResource: "9", withExtension: "heic"),
            photoType: .regular),
    ]
}

struct SpatialContainerView: View {
    @State var state: ContentState
    @State private var isFullScreen: Bool = false
    private let defaultWidth: CGFloat = 1250
    private let defaultHeight: CGFloat = 700
    private var width: CGFloat {
        isFullScreen ? defaultWidth * 2 : defaultWidth
    }
    private var height: CGFloat {
        isFullScreen ? defaultHeight * 2 : defaultHeight
    }

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
                        SpatialImageView(
                            asset: asset, isFullScreen: isFullScreen
                        )
                        .frame(width: width, height: height)
                        .background(Color.black.opacity(0.001))
                    }
                }
            }
        }
        .scrollTargetBehavior(.paging)
        .frame(width: width, height: height)
        .ornament(attachmentAnchor: .scene(.topTrailing)) {
            Button {
                isFullScreen.toggle()
            } label: {
                Image(
                    systemName: "arrow.down.left.and.arrow.up.right.rectangle")
            }
            .glassBackgroundEffect()
            .padding()

        }
    }
}

#Preview(windowStyle: .automatic) {
    @Previewable @State var state = ContentState()
    SpatialContainerView(state: state)
        .environment(AppModel())
}
