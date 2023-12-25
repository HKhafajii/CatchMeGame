//
//  ContentView.swift
//  SpriteKitBootcamp
//
//  Created by Hassan Alkhafaji on 12/18/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var scene: SKScene {
        let scene = MainScreen()
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.backgroundColor = .gray
        
        return scene
        
    }
    
    var body: some View {
        
        VStack {
            
            SpriteView(scene: scene)
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
            Spacer()
            
        }
        
    }
}

#Preview {
    ContentView()
}
