//
//  GameScene.swift
//  SpriteKitBootcamp
//
//  Created by Hassan Alkhafaji on 12/18/23.
//

import Foundation
import SpriteKit


class MainScreen: SKScene {
    override func didMove(to view: SKView) {
        createButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            enumerateChildNodes(withName: "//*") { node, stop in
                if node.name == "Start" {
                    if node.contains(touch.location(in: self)) {
                        
                        print("Started")
                    }
                }
            }
        }
    }
    
    
    
    let startButton = SKLabelNode(fontNamed: "Helvetica")
    func createButton() {
        startButton.text = "Start Game"
        startButton.fontSize = 25
        startButton.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        startButton.fontColor = .white
        startButton.name = "Start"
        addChild(startButton)
    }
    
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    var emojiNode: SKLabelNode!
    var emojiNode2: SKLabelNode!
    
    var score = 0
    static var lives = 5
    var isGameStarted = false
    
    let random = Int.random(in: 100..<300)
    let moveRight = SKAction.move(by: CGVector(dx: Int.random(in: 100..<300), dy: 0), duration: 1.5)
    let moveLeft = SKAction.move(by: CGVector(dx: Int.random(in: -300 ... -100), dy: 0), duration: 1.8)
    
    
    
    
    
    struct PhysicsCategory {
        static let Emoji: UInt32 = 1
        static let Platform: UInt32 = 2
        static let Shooter: UInt32 = 3
        static let Bullet: UInt32 = 4
        
    }
    
    let scoreLabel = SKLabelNode(fontNamed: "Helvitica")
    let lifeCount = SKLabelNode(fontNamed: "Helvitica")
    
    override func didMove(to view: SKView) {
        
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 25
        scoreLabel.position = CGPoint(x: UIScreen.main.bounds.maxX - 100, y: UIScreen.main.bounds.maxY - 100)
        scoreLabel.fontColor = .green
        addChild(scoreLabel)
        
        
        
        lifeCount.text = "❤️: \(GameScene.lives)"
        lifeCount.fontSize = 25
        lifeCount.position = CGPoint(x: UIScreen.main.bounds.maxX - 100, y: UIScreen.main.bounds.maxY - 125)
        lifeCount.fontColor = .red
        addChild(lifeCount)
        
        print("game loaded")
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        self.physicsWorld.contactDelegate = self
        
        if isGameStarted == true {
            createPlatform()
            gameStarted()
        }
        
        
    }
    
    
    func createPlatform() {
        let platform = SKSpriteNode()
        platform.size = CGSize(width: 500, height: 50)
        platform.color = .blue
        platform.position = CGPoint(x: 200, y: 25)
        
        //        setting the size of it to the size of platform
        platform.physicsBody = SKPhysicsBody(rectangleOf: platform.size)
        
        platform.physicsBody?.isDynamic = false
        platform.physicsBody?.affectedByGravity = false
        
        platform.physicsBody!.categoryBitMask = PhysicsCategory.Platform
        platform.physicsBody!.contactTestBitMask = PhysicsCategory.Emoji
        
        self.addChild(platform)
        
    }
    
    func gameStarted() {
        
        createShooter()
        let create1 = SKAction.run { [unowned self] in
            createEmoji(move: moveRight)
        }
        
        
        let wait = SKAction.wait(forDuration: 2.5)
        let sequence = SKAction.sequence([create1, wait])
        let repeatForever = SKAction.repeatForever(sequence)
        run(repeatForever)
        
    }
    
    
    func createEmoji(move: SKAction) {
        let emojis = ["👽", "👺", "👻", "👹", "🤖", "🧌"]
        
        let randomIndex = Int.random(in: 0..<emojis.count)
        let randomIndex2 = Int.random(in: 0..<emojis.count)
        let randomHeight = Int.random(in: 500...700)
        let randomHeight2 = Int.random(in: 500...700)
        
        
        
        
        if emojiNode == nil {
            emojiNode = SKLabelNode(fontNamed: "Helvetica")
            emojiNode.text = emojis[randomIndex]
            emojiNode.fontSize = 50
            emojiNode.position = CGPoint(x: 10, y: randomHeight)
            emojiNode.physicsBody = SKPhysicsBody(rectangleOf: emojiNode.frame.size)
            emojiNode.physicsBody?.restitution = 0.5
            emojiNode.name = emojis[randomIndex]
            
            emojiNode.physicsBody!.categoryBitMask = PhysicsCategory.Emoji
            emojiNode.physicsBody!.contactTestBitMask = PhysicsCategory.Platform
            addChild(emojiNode)
        } else {
            emojiNode.removeFromParent()
            emojiNode = SKLabelNode(fontNamed: "Helvetica")
            emojiNode.text = emojis[randomIndex]
            emojiNode.fontSize = 50
            emojiNode.position = CGPoint(x: 10, y: randomHeight)
            emojiNode.physicsBody = SKPhysicsBody(rectangleOf: emojiNode.frame.size)
            emojiNode.physicsBody?.restitution = 0.5
            emojiNode.name = emojis[randomIndex]
            
            emojiNode.physicsBody!.categoryBitMask = PhysicsCategory.Emoji
            emojiNode.physicsBody!.contactTestBitMask = PhysicsCategory.Platform
            addChild(emojiNode)
        }
        
        
        
        
        if emojiNode2 == nil {
            emojiNode2 = SKLabelNode(fontNamed: "Helvetica")
            emojiNode2.text = emojis[randomIndex2]
            emojiNode2.fontSize = 50
            emojiNode2.position = CGPoint(x: 370, y: randomHeight2)
            emojiNode2.physicsBody = SKPhysicsBody(rectangleOf: emojiNode2.frame.size)
            emojiNode2.physicsBody?.restitution = 0.5
            emojiNode2.name = emojis[randomIndex2]
            
            emojiNode2.physicsBody!.categoryBitMask = PhysicsCategory.Emoji
            emojiNode2.physicsBody!.contactTestBitMask = PhysicsCategory.Platform
            addChild(emojiNode2)
        } else {
            emojiNode2.removeFromParent()
            emojiNode2 = SKLabelNode(fontNamed: "Helvetica")
            emojiNode2.text = emojis[randomIndex2]
            emojiNode2.fontSize = 50
            emojiNode2.position = CGPoint(x: 370, y: randomHeight2)
            emojiNode2.physicsBody = SKPhysicsBody(rectangleOf: emojiNode2.frame.size)
            emojiNode2.physicsBody?.restitution = 0.5
            emojiNode2.name = emojis[randomIndex2]
            
            emojiNode2.physicsBody!.categoryBitMask = PhysicsCategory.Emoji
            emojiNode2.physicsBody!.contactTestBitMask = PhysicsCategory.Platform
            addChild(emojiNode2)
        }
        
        
        
        //Animations
        
        let wait = SKAction.wait(forDuration: Double.random(in: 1..<2.5))
        let wait2 = SKAction.wait(forDuration: Double.random(in: 1..<2.5))
        let sequence = SKAction.sequence([moveRight, wait])
        let sequence2 = SKAction.sequence([moveLeft, wait2])
        
        let repeatSequence = SKAction.repeatForever(sequence)
        let repeatSequence2 = SKAction.repeatForever(sequence2)
        emojiNode.run(repeatSequence)
        emojiNode2.run(repeatSequence2)
        func handleTap(at location: CGPoint) {
            print("Tapped")
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collisionObject = contact.bodyA.categoryBitMask == PhysicsCategory.Platform ? contact.bodyB : contact.bodyA
        
        let collisionBullet = contact.bodyA.categoryBitMask == PhysicsCategory.Bullet ? contact.bodyB : contact.bodyA
        
        if collisionBullet.categoryBitMask == PhysicsCategory.Emoji {
            contact.bodyB.node?.removeFromParent()
            contact.bodyA.node?.removeFromParent()
            
            score += 1
            scoreLabel.text = "Score: \(score)"
        }
        
        if collisionObject.categoryBitMask == PhysicsCategory.Emoji {
            contact.bodyB.node?.removeFromParent()
            GameScene.lives -= 1
            lifeCount.text = "❤️: \(GameScene.lives)"
            
            
            
        }
    }
    
    let ship = SKSpriteNode()
    
    func createShooter() {
        ship.size = CGSize(width: 50, height: 50)
        ship.color = .systemTeal
        ship.position = CGPoint(x: UIScreen.main.bounds.width / 2,y:UIScreen.main.bounds.minY + 100)
        
        ship.physicsBody = SKPhysicsBody(rectangleOf: ship.frame.size)
        ship.physicsBody?.isDynamic = false
        ship.physicsBody!.affectedByGravity = false
        ship.physicsBody!.usesPreciseCollisionDetection = true
        
        ship.physicsBody!.categoryBitMask = PhysicsCategory.Shooter
        ship.physicsBody!.contactTestBitMask = PhysicsCategory.Emoji
        
        addChild(ship)
        
        
    }
    
    
    
    func createBullet() {
        let bullet = SKShapeNode(circleOfRadius: 5)
        
        bullet.fillColor = .red
        bullet.strokeColor = bullet.fillColor
        bullet.name = "Bullet"
        bullet.position = CGPoint(x: ship.position.x, y: ship.position.y + 20)
        
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
        bullet.physicsBody?.isDynamic = false
        bullet.physicsBody!.affectedByGravity = false
        bullet.physicsBody!.usesPreciseCollisionDetection = true
        
        
        
        bullet.physicsBody!.categoryBitMask = PhysicsCategory.Bullet
        bullet.physicsBody!.contactTestBitMask = PhysicsCategory.Emoji
        
        addChild(bullet)
        
        //Bullet movement
        let moveup = SKAction.move(by: CGVector(dx: 0, dy: 800), duration: 2)
        let delete = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveup, delete])
        
        bullet.run(sequence)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            createBullet()
            
            
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let newlocation = CGPoint(x: location.x, y: ship.position.y)
            let move = SKAction.move(to: newlocation, duration: 0.1)
            
            ship.run(move)
            
        }
    }
}
