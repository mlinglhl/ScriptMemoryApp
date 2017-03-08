//
//  FlashCardViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-24.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import AVFoundation

class FlashCardViewController: UIViewController {
    var anchorArray = [NSLayoutConstraint]()
    var activeAnchorArray = [[NSLayoutConstraint]]()
    let cardManager = CardManager.sharedInstance
    
    @IBOutlet weak var deckImageView: UIImageView!
    var deckEmpty = false
    var timer: Timer?
    var timeIndex = 0
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVAudioSession.sharedInstance().requestRecordPermission() { _ in
        }
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "wood"))
        deckImageView.isUserInteractionEnabled = true
        self.deckImageView.image = #imageLiteral(resourceName: "cardBack")
        cardManager.startSession()
    }
    
    @IBAction func drawCard(_ sender: UITapGestureRecognizer) {
        deckImageView.isUserInteractionEnabled = false
        makeCard()
    }
    
    func makeCard() {
        if deckImageView.image == nil {
            self.deckImageView.isUserInteractionEnabled = false
            self.timeIndex = 0
            reshuffleDeck()
            return
        }
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
            cardFront.questionScrollView.contentSize = CGSize(width: cardFront.questionLabel.frame.width, height: cardFront.questionSpeakerLabel.frame.height + cardFront.questionLabel.frame.height + 10)
            cardFront.answerScrollView.contentSize = CGSize(width: cardFront.answerLabel.frame.width, height: cardFront.answerSpeakerLabel.frame.height + cardFront.answerLabel.frame.height + 10)
        }, completion: { _ in
            if self.cardManager.settings.soundCueMode {
                let card = self.cardManager.getCurrentCardFromDeck()
                do {
                    if card.questionAudio != nil {
                        self.audioPlayer = try AVAudioPlayer.init(data: card.questionAudio as! Data)
                        self.audioPlayer!.play()
                    }
                } catch {}
            }
            UIView.transition(from: cardBack, to: cardFront, duration: 0.75, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
        })
        if cardManager.checkLast() {
            self.deckImageView.isUserInteractionEnabled = true
            self.deckImageView.image = nil
            self.deckImageView.layer.borderColor = UIColor.yellow.cgColor
            self.deckImageView.layer.borderWidth = 3
        }
    }
    
    func markWrong(_ sender: UISwipeGestureRecognizer) {
        let card = sender.view as! CardView
        if card.answerLabel.alpha == 1 {
            cardManager.markCard(sender.view!.tag, isCorrect: false)
            let newFrame = CGRect(x: -400, y: card.frame.origin.y, width: card.frame.width, height: card.frame.height)
            UIView.animate(withDuration: 0.2, animations: {
                card.frame = newFrame
            }, completion: { _ in
                card.superview?.removeFromSuperview()
            })
            if !cardManager.checkLast() {
                if deckImageView.image == nil {
                    deckImageView.image = #imageLiteral(resourceName: "cardBack")
                }
                cardManager.session.cardIndex += 1
                makeCard()
            }
        }
    }
    
    func markRight(_ sender: UISwipeGestureRecognizer) {
        let card = sender.view as! CardView
        if card.answerLabel.alpha == 1 {
            cardManager.markCard(sender.view!.tag, isCorrect: true)
            let newFrame = CGRect(x: 400, y: card.frame.origin.y, width: card.frame.width, height: card.frame.height)
            UIView.animate(withDuration: 0.2, animations: {
                card.frame = newFrame
            }, completion: { _ in
                card.superview?.removeFromSuperview()
            })
            if !cardManager.checkLast() {
                cardManager.session.cardIndex += 1
                makeCard()
            }
        }
    }
    
    //MARK helper methods
    
    func reshuffleDeck() {
        deckImageView.isUserInteractionEnabled = false
        let frame = CGRect(x: deckImageView.frame.origin.x + 100, y: deckImageView.frame.origin.y + 500, width: deckImageView.frame.size.width*3, height: deckImageView.frame.size.height*3)
        let card = UIImageView(frame: frame)
        card.image = #imageLiteral(resourceName: "cardBack")
        card.clipsToBounds = true
        card.layer.cornerRadius = 8
        view.addSubview(card)
        cardManager.makeDeck()
        let numberOfCards = cardManager.session.deck.count
        UIView.animate(withDuration: 0.2, animations: {
            card.frame = self.deckImageView.frame
        }, completion: { _ in
            if self.deckImageView.image == nil {
                self.deckImageView.layer.borderWidth = 0
                self.deckImageView.layer.borderColor = UIColor.clear.cgColor
                self.deckImageView.image = #imageLiteral(resourceName: "cardBack")
            }
            card.removeFromSuperview()
        })
        timeIndex += 1
        if timeIndex <= 7 && timeIndex < numberOfCards {
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reshuffleDeck), userInfo: nil, repeats: false)
        }
        if timeIndex > 7 && timeIndex < numberOfCards {
            Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(reshuffleDeck), userInfo: nil, repeats: false)
        }
        if timeIndex == numberOfCards {
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
        cardManager.setUpCardFrontWithModifiedDeck(cardFront)
        cardFront.tag = Int(cardManager.session.deck[cardManager.session.cardIndex].index)
        let leftSGR = UISwipeGestureRecognizer(target: self, action: #selector(markWrong(_:)))
        leftSGR.direction = UISwipeGestureRecognizerDirection.left
        cardFront.addGestureRecognizer(leftSGR)
        let rightSGR = UISwipeGestureRecognizer(target: self, action: #selector(markRight(_:)))
        rightSGR.direction = UISwipeGestureRecognizerDirection.right
        cardFront.addGestureRecognizer(rightSGR)
        cardFront.answerSpeakerLabel.alpha = 0
        cardFront.answerLabel.alpha = 0
        cardFront.layer.cornerRadius = 8
        cardFront.layer.borderColor = UIColor.black.cgColor
        cardFront.layer.borderWidth = 3.0
        cardFront.backgroundColor = UIColor.white
        cardFront.translatesAutoresizingMaskIntoConstraints = false
        
        return cardFront
    }
}
