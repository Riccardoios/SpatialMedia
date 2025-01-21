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

struct SpacialImageView: View {
    let name: String

    private var url: URL? {
        Bundle.main.url(forResource: name, withExtension: "heic")
    }

    var body: some View {
        RealityView { content in
            do {
                let modelEntity = try await {
                    var shaderGraphMaterial = try await ShaderGraphMaterial(
                        named: "/Root/Material", from: "Scene.usda",
                        in: realityKitContentBundle)
                    let images = try getImages(url: url)
                    let leftImage = try await convertTexture(from: images.left)
                    try shaderGraphMaterial.setParameter(
                        name: "LeftEye", value: .textureResource(leftImage))

                    let rightImage = try await convertTexture(
                        from: images.right)
                    try shaderGraphMaterial.setParameter(
                        name: "RightEye", value: .textureResource(rightImage))

                    let entity = ModelEntity(
                        mesh: .generatePlane(
                            width: Float(leftImage.width) / 5000,
                            height: Float(leftImage.height) / 5000,
                            cornerRadius: 0.01))
                    print(Float(leftImage.width) / 5000, Float(leftImage.height) / 5000)
                    entity.model?.materials = [shaderGraphMaterial]
                    return entity
                }()
                content.add(modelEntity)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    private func getImages(url: URL?) throws -> (left: CGImage, right: CGImage) {
        guard let url,
            let source = CGImageSourceCreateWithURL(url as CFURL, nil)
        else {
            throw ImageError.url
        }
        let rightImage: CGImage? = CGImageSourceCreateImageAtIndex(
            source, 1, nil)
        let leftImage: CGImage? = CGImageSourceCreateImageAtIndex(
            source, 2, nil)
        guard let leftImage = leftImage, let rightImage = rightImage else {
            throw ImageError.invalidData
        }
        return (left: leftImage, right: rightImage)
    }

    private func convertTexture(from image: CGImage) async throws
        -> TextureResource {
        try await TextureResource(
            image: image,
            options: TextureResource.CreateOptions.init(semantic: nil))
    }
}

enum ImageError: Error, LocalizedError {
    case url
    case invalidData
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
