//
//  ToggleImmersiveSpaceButton.swift
//  SpatialMediaTutorial
//
//  Created by Riccardo Carlotto on 20/01/25.
//

import SwiftUI

struct ToggleImmersiveSpaceButton: View {
    @Environment(AppModel.self) private var appModel

    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace

    private var immersiveSpaceBinding: Binding<Bool> {
        Binding(
            get: { appModel.immersiveSpaceState == .open },
            set: { isOn in
                Task { @MainActor in
                    if isOn {
                        // Open immersive space
                        appModel.immersiveSpaceState = .inTransition
                        switch await openImmersiveSpace(id: appModel.immersiveSpaceID) {
                            case .opened:
                                // Do nothing here; rely on ImmersiveView.onAppear().
                                break
                            case .userCancelled, .error:
                                fallthrough
                            @unknown default:
                                appModel.immersiveSpaceState = .closed
                        }
                    } else {
                        // Close immersive space
                        appModel.immersiveSpaceState = .inTransition
                        await dismissImmersiveSpace()
                        // Do not set .closed here; rely on ImmersiveView.onDisappear().
                    }
                }
            }
        )
    }

    var body: some View {
        Toggle(isOn: immersiveSpaceBinding) {
            Text("Show Immersive Space")
        }
        .frame(width: 300)
        .disabled(appModel.immersiveSpaceState == .inTransition)
        .animation(.none, value: appModel.immersiveSpaceState)
        .fontWeight(.semibold)
    }
}

#Preview {
    ToggleImmersiveSpaceButton()
        .environment(AppModel())
}
