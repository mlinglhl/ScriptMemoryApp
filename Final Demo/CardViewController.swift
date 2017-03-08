//
//  CardViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-28.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    let cardManager = CardManager.sharedInstance
    var cardBack: UIView!
    var cardFront: CardView!
    var cardIndex = 0
    
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardBack = setUpCardBack()
        cardFront = setUpCardFront()
        let sessionIndex = cardManager.session.cardIndex
        cardManager.session.cardIndex = cardIndex
        guard let card = cardManager.getCurrentCard() else {
            return
        }
        correctLabel.text = "Correct: \(card.correct)"
        wrongLabel.text = "Wrong: \(card.wrong)"
        percentageLabel.text = "0%"
        if card.correct + card.wrong > 0 {
            percentageLabel.text = "\(card.correct*100/(card.correct + card.wrong))%"
        }
        cardManager.session.cardIndex = sessionIndex
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let cardView = setUpCardView()
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
        cardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        cardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cardFront.questionScrollView.contentSize = CGSize(width: cardFront.questionLabel.frame.width, height: cardFront.questionSpeakerLabel.frame.height + cardFront.questionLabel.frame.height + 10)
        cardFront.answerScrollView.contentSize = CGSize(width: cardFront.answerLabel.frame.width, height: cardFront.answerSpeakerLabel.frame.height + cardFront.answerLabel.frame.height + 10)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.transition(from: cardBack, to: cardFront, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
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
        let sessionIndex = cardManager.session.cardIndex
        cardManager.session.cardIndex = cardIndex
        guard let card = cardManager.getCurrentCard() else {
            return cardFront
        }
        cardFront.tag = Int(card.index)
        cardManager.setUpCardFrontWithUnmodifiedDeck(cardFront)
        cardManager.session.cardIndex = sessionIndex
        cardFront.layer.cornerRadius = 8
        cardFront.layer.borderColor = UIColor.black.cgColor
        cardFront.layer.borderWidth = 3.0
        cardFront.backgroundColor = UIColor.white
        cardFront.translatesAutoresizingMaskIntoConstraints = false
        return cardFront
    }

    @IBAction func dismissViewController(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
