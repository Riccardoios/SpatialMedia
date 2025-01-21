//
//  ContentView.swift
//  SpacialMediaTutorial
//
//  Created by Riccardo Carlotto on 20/01/25.
//

import RealityKit
import SwiftUI

struct Media: Identifiable {
    let id = UUID()
    var url: URL?
}

@Observable
class ContentState {
    let allMedia: [Media] = [
        Media(
            url: Bundle.main.url(forResource: "IMG_1439", withExtension: "heic")
        ),
        Media(
            url: Bundle.main.url(forResource: "IMG_0406", withExtension: "heic")
        ),
        Media(
            url: Bundle.main.url(forResource: "IMG_1659", withExtension: "heic")
        )
    ]
    
    
    func readMedia(_ url: URL) -> (left: CGImage, right: CGImage)? {
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            print("Url not valid")
            return nil
        }
        let leftImage: CGImage? = CGImageSourceCreateImageAtIndex(
            source, 1, nil)
        let rightImage: CGImage? = CGImageSourceCreateImageAtIndex(
            source, 2, nil)
        guard let leftImage = leftImage, let rightImage = rightImage else {
            print("image not valid")
            return nil
        }
        return (left: leftImage, right: rightImage)
    }
}

struct ContentView: View {
    @State var state = ContentState()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(state.allMedia) { media in
                    HStack {
                        if let url = media.url,
                           let (left, right) = state.readMedia(url)
                        {
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
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
