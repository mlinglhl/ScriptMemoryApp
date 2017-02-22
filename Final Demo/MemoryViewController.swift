//
//  MemoryViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-18.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {
    var anchorArray = [NSLayoutConstraint]()
    var activeAnchorArray = [[NSLayoutConstraint]]()
    let cardManager = CardManager.sharedInstance
    
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var deckImageView: UIImageView!
    
    var wrongArray = [CardView]()
    var correctArray = [CardView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapDeck(_ sender: UITapGestureRecognizer) {
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
        let tempArray = [
            cardView.widthAnchor.constraint(equalTo: self.deckImageView.widthAnchor, multiplier: 3),
            cardView.heightAnchor.constraint(equalTo: self.deckImageView.heightAnchor, multiplier: 3),
            cardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            cardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100)]
        for constraint in tempArray {
            constraint.isActive = true
        }
        activeAnchorArray.append(tempArray)
        
        UIView.animate(withDuration: 0.2, animations: {
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
            if card.answerLabel.alpha == 1 {
                wrongArray.append(card)
                activeAnchorArray[card.tag][2].constant = -400
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    self.wrongLabel.text = "\(self.wrongArray.count)"
                })
            }
        }
    }
    
    func markRight(_ sender: UISwipeGestureRecognizer) {
        let card = sender.view as! CardView
        if card.answerLabel.alpha == 1 {
            correctArray.append(card)
            activeAnchorArray[card.tag][2].constant = 400
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.correctLabel.text = "\(self.correctArray.count)"
            })
        }
    }
    
    //MARK helper methods
    
    func setUpCardView() -> UIView {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }
    
    func setUpCardBack() -> UIView {
        let cardBack = UIImageView(image: #imageLiteral(resourceName: "BeeRed"))
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
    
}
