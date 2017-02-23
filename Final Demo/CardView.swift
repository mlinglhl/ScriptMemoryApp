//
//  CardView.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-18.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import AVFoundation

class CardView: UIView {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionScrollView: UIScrollView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerScrollView: UIScrollView!
    
    var player: AVAudioPlayer? = nil
    
    class func initFromNib() -> CardView {
        let nib = UINib(nibName: "CardView", bundle: nil)
        let cardView = nib.instantiate(withOwner: nil, options: nil)[0] as! CardView
        return cardView
    }
    
    @IBAction func playSound(_ sender: UIButton) {
        let sound = NSDataAsset(name: "SampleClip")
        do {
            let player = try AVAudioPlayer(data: sound!.data)
            player.play()
            self.player = player
        }
        catch {
            return
        }
    }
    
    @IBAction func showAnswer(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.answerLabel.alpha = 1
        })
    }
}
