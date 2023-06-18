//
//  Simple_MetronomeApp.swift
//  Simple Metronome
//
//  Created by Andy Yu on 2023-06-11.
//

import SwiftUI

@main
struct Simple_MetronomeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().frame(minWidth: 300, idealWidth: 330, maxWidth: 380,
                                minHeight: 300, idealHeight: 400, maxHeight: .infinity,
                                alignment: .center)
        }.defaultSize(CGSize(width: 400, height: 400))
            .windowResizability(.contentSize)
    }
}
