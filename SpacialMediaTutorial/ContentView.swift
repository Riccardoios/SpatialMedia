//
//  ContentView.swift
//  SpacialMediaTutorial
//
//  Created by Riccardo Carlotto on 20/01/25.
//

import SwiftUI
import RealityKit

struct Media: Identifiable {
    let id = UUID()
    var resource: ImageResource
    var url: URL?
}

struct ContentView: View {
    let allMedia: [Media] = [
        Media(resource: ImageResource(name: "IMG_1659", bundle: .main)),
        Media(resource: ImageResource(name: "IMG_1439", bundle: .main), url: URL(string: "/SpacialMediaTutorial/Pics/IMG_1439.heic")!),
        Media(resource: ImageResource(name: "IMG_0406", bundle: .main), url:  Bundle.main.url(forResource: "IMG_1439", withExtension: "heic"))
    ]
    
    var body: some View {
        HStack {
            VStack {
                ForEach(allMedia) { media in
                    Image(media.resource)
                        .resizable()
                        .scaledToFit()
                        .background(Color.red)
                    
                }
            }
            VStack {
                ForEach(allMedia) { media in
                    if let url = media.url,
                       let (left, right) = readMedia(url) {
                        Image(uiImage: UIImage(cgImage: left))
                            .resizable()
                            .scaledToFit()
                            .background(Color.red)
                        Image(uiImage: UIImage(cgImage: right))
                            .resizable()
                            .scaledToFit()
                            .background(Color.red)
                    }
                }
            }
        }
    }
    
    func readMedia(_ url: URL) -> (left: CGImage, right: CGImage)? {
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            print("Url not valid")
            return nil
        }
        let leftImage: CGImage? = CGImageSourceCreateImageAtIndex(source, 0, nil)
        let rightImage: CGImage? = CGImageSourceCreateImageAtIndex(source, 1, nil)
        guard let leftImage = leftImage, let rightImage = rightImage else {
            print("image not valid")
            return nil
        }
        return (left: leftImage, right: rightImage)
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
