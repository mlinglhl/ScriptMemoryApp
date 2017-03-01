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
    var cardFront: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardBack = setUpCardBack()
        cardFront = setUpCardFront()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let cardView = setUpCardView()
        cardView.isUserInteractionEnabled = false
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
        cardFront.layer.cornerRadius = 8
        cardFront.layer.borderColor = UIColor.black.cgColor
        cardFront.layer.borderWidth = 3.0
        cardFront.backgroundColor = UIColor.white
        cardFront.translatesAutoresizingMaskIntoConstraints = false
        
        cardFront.questionLabel.text = cardManager.setCardQuestion()
        cardFront.answerLabel.text = cardManager.setCardAnswer()
        return cardFront
    }

    
    @IBAction func dismissViewController(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
