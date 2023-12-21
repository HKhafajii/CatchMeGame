//
//  GameScene.swift
//  SpriteKitBootcamp
//
//  Created by Hassan Alkhafaji on 12/18/23.
//

import Foundation
import SpriteKit





class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let emojis = ["👽", "👺", "👻", "👹", "🤖", "🧌"]
    var score = 0
    var lives = 3
    var emojiNode: SKLabelNode!
    
    let random = Int.random(in: 100..<300)
    let moveRight = SKAction.move(by: CGVector(dx: Int.random(in: 100..<300), dy: 0), duration: 1.5)
    let moveLeft = SKAction.move(by: CGVector(dx: Int.random(in: -300 ... -100), dy: 0), duration: 1.8)
    
    

   
    
    struct PhysicsCategory {
        static let Emoji: UInt32 = 1
        static let Platform: UInt32 = 2
        
    }
    
    let scoreLabel = SKLabelNode(fontNamed: "Helvitica")
    let lifeCount = SKLabelNode(fontNamed: "Helvitica")
    
    override func didMove(to view: SKView) {
        
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 25
        scoreLabel.position = CGPoint(x: UIScreen.main.bounds.maxX - 100, y: UIScreen.main.bounds.maxY - 100)
        scoreLabel.fontColor = .green
        addChild(scoreLabel)
        
        lifeCount.text = "❤️: \(lives)"
        lifeCount.fontSize = 25
        lifeCount.position = CGPoint(x: UIScreen.main.bounds.maxX - 100, y: UIScreen.main.bounds.maxY - 125)
        lifeCount.fontColor = .red
        addChild(lifeCount)
        
        print("game loaded")
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        self.physicsWorld.contactDelegate = self
        
        
        createPlatform()
        gameStarted()
    }
    
    
    func createPlatform() {
        let platform = SKSpriteNode()
        platform.size = CGSize(width: 500, height: 50)
        platform.color = .blue
        platform.position = CGPoint(x: 200, y: 200)
        
        //        setting the size of it to the size of platform
        platform.physicsBody = SKPhysicsBody(rectangleOf: platform.size)
        
        platform.physicsBody?.isDynamic = false
        platform.physicsBody?.affectedByGravity = false
        
        platform.physicsBody!.categoryBitMask = PhysicsCategory.Platform
        platform.physicsBody!.contactTestBitMask = PhysicsCategory.Emoji
        
        self.addChild(platform)
        
    }
    
    func gameStarted() {
        
        let create1 = SKAction.run { [unowned self] in
            self.createEmoji(pos: CGPoint(x: 10, y: 700), move: moveRight)
        }
        let create2 = SKAction.run { [unowned self] in
            self.createEmoji(pos: CGPoint(x: 300, y: 750), move: moveLeft)
        }
        
        let wait = SKAction.wait(forDuration: 1.5)
        let sequence = SKAction.sequence([create1, wait, create2])
        let repeatForever = SKAction.repeatForever(sequence)
        run(repeatForever)
        
    }
    
    
    func createEmoji(pos: CGPoint, move: SKAction) {
        
        let randomIndex = Int.random(in: 0..<emojis.count)
        if emojiNode == nil {
            emojiNode = SKLabelNode(fontNamed: "Helvetica")
        }
        
        emojiNode.text = emojis[randomIndex]
        emojiNode.fontSize = 50
        emojiNode.position = pos
        emojiNode.physicsBody = SKPhysicsBody(rectangleOf: emojiNode.frame.size)
        emojiNode.physicsBody?.restitution = 0.5
        emojiNode.name = emojis[randomIndex]
        
        emojiNode.physicsBody!.categoryBitMask = PhysicsCategory.Emoji
        emojiNode.physicsBody!.contactTestBitMask = PhysicsCategory.Platform
        
        addChild(emojiNode)
        
        //Animations
       
        let wait = SKAction.wait(forDuration: Double.random(in: 1..<2.2))
        let sequence = SKAction.sequence([move, wait])
        
        let repeatSequence = SKAction.repeatForever(sequence)
        emojiNode.run(repeatSequence)
        
        func handleTap(at location: CGPoint) {
            print("Tapped")
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collisionObject = contact.bodyA.categoryBitMask == PhysicsCategory.Platform ? contact.bodyB : contact.bodyA
        
        if collisionObject.categoryBitMask == PhysicsCategory.Emoji {
            contact.bodyB.node?.removeFromParent()
            
        }
    }
    
    
//    what happens when an emoji is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location == emojiNode.position {
                score += 1
                print("Tapped")
            }
            

        }
    }
}
