//
//  FlashCardViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-24.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class FlashCardViewController: UIViewController {
    var anchorArray = [NSLayoutConstraint]()
    var activeAnchorArray = [[NSLayoutConstraint]]()
    let cardManager = CardManager.sharedInstance
    
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var deckImageView: UIImageView!
    
    var timer: Timer?
    var timeIndex = 0
    var correctCount = 0
    var wrongCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deckImageView.isHidden = true
        startUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func drawCard(_ sender: UITapGestureRecognizer) {
        let cardView = setUpCardView()
        let cardBack = setUpCardBack()
        let cardFront = setUpCardFront()
        cardView.addSubview(cardFront)
        cardView.addSubview(cardBack)
        view.addSubview(cardView)
        
        cardFront.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
        cardFront.heightAnchor.constraint(equalTo: cardView.heightAnchor).isActive = true
        cardFront.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        cardFront.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        cardBack.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
        cardBack.heightAnchor.constraint(equalTo: cardView.heightAnchor).isActive = true
        cardBack.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        cardBack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        
        anchorArray = [
            cardView.widthAnchor.constraint(equalTo: self.deckImageView.widthAnchor),
            cardView.heightAnchor.constraint(equalTo: self.deckImageView.heightAnchor),
            cardView.centerXAnchor.constraint(equalTo: self.deckImageView.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: self.deckImageView.centerYAnchor)]
        for constraint in anchorArray {
            constraint.isActive = true
        }
        self.view.layoutIfNeeded()
        for constraint in anchorArray {
            constraint.isActive = false
        }
        anchorArray.removeAll()
        UIView.animate(withDuration: 0.2, animations: {
            let randomX = CGFloat(arc4random_uniform(100))-50
            let randomY = CGFloat(arc4random_uniform(125))-120
            let tempArray = [
                cardView.widthAnchor.constraint(equalTo: self.deckImageView.widthAnchor, multiplier: 2.5),
                cardView.heightAnchor.constraint(equalTo: self.deckImageView.heightAnchor, multiplier: 2.5),
                cardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: randomX),
                cardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: randomY)]
            for constraint in tempArray {
                constraint.isActive = true
            }
            self.activeAnchorArray.append(tempArray)
            self.view.layoutIfNeeded()
            cardFront.questionScrollView.contentSize = cardFront.questionLabel.frame.size
            cardFront.answerScrollView.contentSize = cardFront.answerLabel.frame.size
        }, completion: { _ in
            UIView.transition(from: cardBack, to: cardFront, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
        })
    }
    
    func markWrong(_ sender: UISwipeGestureRecognizer) {
        let card = sender.view as! CardView
        if card.answerLabel.alpha == 1 {
            wrongCount += 1
            self.wrongLabel.text = "\(wrongCount)"
            let newFrame = CGRect(x: -400, y: card.frame.origin.y, width: card.frame.width, height: card.frame.height)
            UIView.animate(withDuration: 0.2, animations: {
                card.frame = newFrame
            }, completion: { _ in
                card.superview?.removeFromSuperview()
            })
        }
    }
    
    func markRight(_ sender: UISwipeGestureRecognizer) {
        let card = sender.view as! CardView
        if card.answerLabel.alpha == 1 {
            correctCount += 1
            self.correctLabel.text = "\(correctCount)"
            let newFrame = CGRect(x: 400, y: card.frame.origin.y, width: card.frame.width, height: card.frame.height)
            UIView.animate(withDuration: 0.2, animations: {
                card.frame = newFrame
            }, completion: { _ in
                card.superview?.removeFromSuperview()
            })
        }
    }
    
    //MARK helper methods
    
    func startUp() {
        let rightFrame = CGRect(x: 400, y: deckImageView.frame.origin.y, width: deckImageView.frame.size.width*3, height: deckImageView.frame.size.height*3)
        let leftFrame = CGRect(x: -400, y: deckImageView.frame.origin.y, width: deckImageView.frame.size.width*3, height: deckImageView.frame.size.height*3)
        let rightCard = UIImageView(frame: rightFrame)
        rightCard.image = #imageLiteral(resourceName: "cardBack")
        rightCard.clipsToBounds = true
        rightCard.layer.cornerRadius = 8
        let leftCard = UIImageView(frame: leftFrame)
        leftCard.image = #imageLiteral(resourceName: "cardBack")
        leftCard.clipsToBounds = true
        leftCard.layer.cornerRadius = 8
        view.addSubview(rightCard)
        view.addSubview(leftCard)
        
        UIView.animate(withDuration: 0.2, animations: {
            rightCard.frame = self.deckImageView.frame
            leftCard.frame = self.deckImageView.frame
        }, completion: { _ in
            rightCard.removeFromSuperview()
            leftCard.removeFromSuperview()
        })
        timeIndex += 1
        if timeIndex <= 5 {
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startUp), userInfo: nil, repeats: false)
        }
        if timeIndex > 5 && timeIndex < 15 {
            Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(startUp), userInfo: nil, repeats: false)
        }
        if timeIndex == 15 {
            deckImageView.isHidden = false
            deckImageView.isUserInteractionEnabled = true
        }
    }
    
    func setUpCardView() -> UIView {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }
    
    func setUpCardBack() -> UIView {
        let cardBack = UIImageView(image: #imageLiteral(resourceName: "cardBack"))
        cardBack.translatesAutoresizingMaskIntoConstraints = false
        cardBack.contentMode = UIViewContentMode.scaleToFill
        cardBack.clipsToBounds = true
        cardBack.layer.cornerRadius = 8
        return cardBack
    }
    
    func setUpCardFront() -> CardView {
        let cardFront = CardView.initFromNib()
        cardFront.tag = cardManager.cardIndex
        let leftSGR = UISwipeGestureRecognizer(target: self, action: #selector(markWrong(_:)))
        leftSGR.direction = UISwipeGestureRecognizerDirection.left
        cardFront.addGestureRecognizer(leftSGR)
        let rightSGR = UISwipeGestureRecognizer(target: self, action: #selector(markRight(_:)))
        rightSGR.direction = UISwipeGestureRecognizerDirection.right
        cardFront.addGestureRecognizer(rightSGR)
        cardFront.answerLabel.alpha = 0
        cardFront.layer.cornerRadius = 8
        cardFront.layer.borderColor = UIColor.black.cgColor
        cardFront.layer.borderWidth = 3.0
        cardFront.backgroundColor = UIColor.white
        cardFront.translatesAutoresizingMaskIntoConstraints = false
        
        cardFront.questionLabel.text = cardManager.setCardQuestion()
        cardFront.answerLabel.text = cardManager.setCardAnswer()
        return cardFront
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
