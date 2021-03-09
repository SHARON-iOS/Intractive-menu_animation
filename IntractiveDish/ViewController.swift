//
//  ViewController.swift
//  IntractiveDish
//
//  Created by Mac HD  on 06/03/21.
//

import UIKit

class ViewController: UIViewController {

    var index = 0
    var images = [UIImage(named: "pizza_t"), UIImage(named: "pizza"), UIImage(named: "pizza_t"), UIImage(named: "pizza")]
    
    let itemNames = ["Pizza", "lite", "Pizza", "pizza hot"]
    let backgroundView = UIImageView()
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
    let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        backgroundView.center.x = view.center.x
        backgroundView.center.y = view.center.y - 300
        backgroundView.image = images[index]
        backgroundView.alpha = 0.3
        backgroundView.contentMode = .scaleAspectFit
        view.addSubview(backgroundView)
        
        imageView.center.x = view.center.x
        imageView.center.y = view.center.y - 100
        imageView.image = images[index]
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        nameLabel.center.x = view.center.x
        nameLabel.center.y = view.center.y + 300
        nameLabel.text = itemNames[index]
        nameLabel.textAlignment = .center
        view.addSubview(nameLabel)
        
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        
        swipeGestureLeft.direction = .left
        swipeGestureRight.direction = .right
        view.addGestureRecognizer(swipeGestureLeft)
        view.addGestureRecognizer(swipeGestureRight)
    }

    func checkIndex() {
        if index >= images.count {
            index = 0
        } else if index <= -1 {
            index = images.count - 1
        }
        updateUI()
    }
    
    func updateUI() {
        imageView.image = images[index]
        backgroundView.image = images[index]
        nameLabel.text = itemNames[index]
    }
    
    func applyAnimations() {
        UIView.animate(withDuration: 1.0, animations: {
            self.imageView.transform = CGAffineTransform(rotationAngle: .pi * 2.0)
        }) { (_)in
            UIView.animate(withDuration: 0.3) {
                self.backgroundView.alpha = 0.3
                self.nameLabel.alpha = 1
            }
        }
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .left:
                index += 1
                checkIndex()
                imageView.transform = CGAffineTransform(translationX: 300, y: 0)
                imageView.transform = imageView.transform.rotated(by: .pi)
                backgroundView.alpha = 0
                nameLabel.alpha = 0
                applyAnimations()
                
            case .right:
                index -= 1
                checkIndex()
                imageView.transform = CGAffineTransform(translationX: -300, y: 0)
                imageView.transform = imageView.transform.rotated(by: .pi)
                backgroundView.alpha = 0
                nameLabel.alpha = 0
                applyAnimations()
                
            default:
                break
                
            }
        }
    }
}

