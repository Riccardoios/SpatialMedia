//
//  SpatialImageView.swift
//  SpatialMediaTutorial
//
//  Created by Riccardo Carlotto on 22/01/25.
//
import SwiftUI
import RealityKit
import RealityKitContent

struct SpatialImageView: View {
    let asset: PhotoAsset

    var body: some View {
        RealityView { content in
            do {
                let modelEntity = try await {
                    var shaderGraphMaterial = try await ShaderGraphMaterial(
                        named: "/Root/Material", from: "Scene.usda",
                        in: realityKitContentBundle)
                    let images = try getImages(url: asset.url)
                    let leftImage = try await convertTexture(from: images.left)
                    try shaderGraphMaterial.setParameter(
                        name: "LeftEye", value: .textureResource(leftImage))

                    let rightImage = try await convertTexture(from: images.right)
                    try shaderGraphMaterial.setParameter(
                        name: "RightEye", value: .textureResource(rightImage))

                    let entity = ModelEntity(
                        mesh: .generatePlane(
                            width: Float(leftImage.width) / 4000,
                            height: Float(leftImage.height) / 4000,
                            cornerRadius: 0.03))
                    entity.model?.materials = [shaderGraphMaterial]
                    return entity
                }()
                modelEntity.position.z = 0.01
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
            options: TextureResource.CreateOptions.init(semantic: .color))
    }
}

enum ImageError: Error, LocalizedError {
    case url
    case invalidData
}
