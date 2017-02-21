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

    @IBOutlet weak var deckImageView: UIImageView!
    var cardViewArray = [CardView]()
    var wrongArray = [CardView]()
    var rightArray = [CardView]()
    let cardArray = [SampleCard.init(question: "Annabel: I have come all this way for the money Mr. Witherspoon. All six million dollars of it.", answer: "Harry: But I accepted the terms of my Uncle's will, and I'm here, you see, carrying out his wishes. So you people have lost."),
                     SampleCard.init(question: "Annabel: Not yet we haven't. Not by a longshot. You see, there's a loophole.", answer: "Harry: Loophole? What loophole? Where?"),
                     SampleCard.init(question: "Annabel: Well, when we received our copy of the will and tape, I noticed how detailed it was. All those social activities. All the things he wants to do and buy and wear... specific times you have to be specific places...", answer: "Harry: I'm doing the best I can!"),
                     SampleCard.init(question: "Annabel: Yes, but make just one little slip--arrive somewhere one minute early or one minute late, put a pink flower in his buttonhole instead of red... you mess up one little detail, and accoridng to our lawyers, you'll be in default of the will!", answer: "Harry: What?!"),
                     SampleCard.init(question: "Annabel: One little slip, and I take your Uncle, finish up the rest of his vacation, and that money goes to the dogs! So you might as well give up!", answer: "Harry: Give up? Give up! You're joking!")]
    var cardIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapDeck(_ sender: UITapGestureRecognizer) {
        let cardBack = UIImageView(image: #imageLiteral(resourceName: "BeeRed"))
        cardBack.translatesAutoresizingMaskIntoConstraints = false
        cardBack.contentMode = UIViewContentMode.scaleToFill
        cardBack.clipsToBounds = true
        cardBack.layer.cornerRadius = 8
        let cardFront = UIImageView(image: #imageLiteral(resourceName: "BeeRed"))
        cardFront.isHidden = true
        cardFront.translatesAutoresizingMaskIntoConstraints = false
        cardFront.layer.cornerRadius = 8
        let newCard = CardView.initFromNib()
        newCard.tag = cardViewArray.count
        cardViewArray.append(newCard)
        let leftSGR = UISwipeGestureRecognizer(target: self, action: #selector(markWrong(_:)))
        leftSGR.direction = UISwipeGestureRecognizerDirection.left
        newCard.addGestureRecognizer(leftSGR)
        let rightSGR = UISwipeGestureRecognizer(target: self, action: #selector(markRight(_:)))
        rightSGR.direction = UISwipeGestureRecognizerDirection.right
        newCard.addGestureRecognizer(rightSGR)
        newCard.addSubview(cardFront)
        newCard.addSubview(cardBack)
        view.addSubview(newCard)
        
        cardFront.widthAnchor.constraint(equalTo: newCard.widthAnchor).isActive = true
        cardFront.heightAnchor.constraint(equalTo: newCard.heightAnchor).isActive = true
        cardFront.centerXAnchor.constraint(equalTo: newCard.centerXAnchor).isActive = true
        cardFront.centerYAnchor.constraint(equalTo: newCard.centerYAnchor).isActive = true
        cardBack.widthAnchor.constraint(equalTo: newCard.widthAnchor).isActive = true
        cardBack.heightAnchor.constraint(equalTo: newCard.heightAnchor).isActive = true
        cardBack.centerXAnchor.constraint(equalTo: newCard.centerXAnchor).isActive = true
        cardBack.centerYAnchor.constraint(equalTo: newCard.centerYAnchor).isActive = true
        
        if cardIndex == cardArray.count {
            cardIndex = 0
        }
        
        newCard.questionLabel.text = cardArray[cardIndex].question
        newCard.answerLabel.text = cardArray[cardIndex].answer
        cardIndex += 1
        newCard.frame = self.deckImageView.frame
        newCard.answerLabel.alpha = 0
        newCard.layer.cornerRadius = 8
        newCard.layer.borderColor = UIColor.black.cgColor
        newCard.layer.borderWidth = 3.0
        newCard.backgroundColor = UIColor.white
        newCard.translatesAutoresizingMaskIntoConstraints = false
        anchorArray = [
            newCard.widthAnchor.constraint(equalTo: self.deckImageView.widthAnchor),
            newCard.heightAnchor.constraint(equalTo: self.deckImageView.heightAnchor),
            newCard.centerXAnchor.constraint(equalTo: self.deckImageView.centerXAnchor),
            newCard.centerYAnchor.constraint(equalTo: self.deckImageView.centerYAnchor)]
        for constraint in anchorArray {
            constraint.isActive = true
        }
        self.view.layoutIfNeeded()
        for constraint in anchorArray {
            constraint.isActive = false
        }
        anchorArray.removeAll()
        let tempArray = [
            newCard.widthAnchor.constraint(equalTo: self.deckImageView.widthAnchor, multiplier: 3),
            newCard.heightAnchor.constraint(equalTo: self.deckImageView.heightAnchor, multiplier: 3),
            newCard.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            newCard.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100)]
        for constraint in tempArray {
            constraint.isActive = true
        }
        activeAnchorArray.append(tempArray)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
            newCard.questionScrollView.contentSize = newCard.questionLabel.frame.size
            newCard.answerScrollView.contentSize = newCard.answerLabel.frame.size
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
                UIView.animate(withDuration: 1.0, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func markRight(_ sender: UISwipeGestureRecognizer) {
        let card = sender.view as! CardView
        if card.answerLabel.alpha == 1 {
            rightArray.append(card)
            activeAnchorArray[card.tag][2].constant = 400
            UIView.animate(withDuration: 1.0, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
}
