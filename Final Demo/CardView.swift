//
//  CardView.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-18.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import AVFoundation

class CardView: UIView, AVAudioRecorderDelegate {
    
    @IBOutlet weak var answerSpeakerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionScrollView: UIScrollView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerScrollView: UIScrollView!
    
    @IBOutlet weak var questionSpeakerLabel: UILabel!
    var recordingSession = AVAudioSession.sharedInstance()
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer?
    var recordingURL = ""
    let cardManager = CardManager.sharedInstance
    var cardForSound: CardObject?
    class func initFromNib() -> CardView {
        let nib = UINib(nibName: "CardView", bundle: nil)
        let cardView = nib.instantiate(withOwner: nil, options: nil)[0] as! CardView
        return cardView
    }
    
    @IBAction func playQuestion(_ sender: UIButton) {
        guard let senderSuperview = sender.superview else {
            return
        }
        playTapped(sender.tag, index: senderSuperview.tag)
    }
    
    @IBAction func recordQuestion(_ sender: UIButton) {
        guard let senderSuperview = sender.superview else {
            return
        }
        recordTapped(sender.tag, index: senderSuperview.tag)
    }
    
    @IBAction func playAnswer(_ sender: UIButton) {
        guard let senderSuperview = sender.superview else {
            return
        }
        playTapped(sender.tag, index: senderSuperview.tag)
    }
    
    @IBAction func recordAnswer(_ sender: UIButton) {
        guard let senderSuperview = sender.superview else {
            return
        }
        recordTapped(sender.tag, index: senderSuperview.tag)
    }
    
    
    @IBAction func showAnswer(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            if self.answerLabel.alpha != 1 {
                self.answerSpeakerLabel.alpha = 1
                self.answerLabel.alpha = 1
            }
        })
    }
    
    func startRecording() {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: getFileURL(), settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
        }
        
    }
    
    func getCacheDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    func getFileURL() -> URL {
        let path = getCacheDirectory().appending("recording.caf")
        let filePath = URL(fileURLWithPath: path)
        return filePath
    }
    
    
    func finishRecording(success: Bool, type: Int, index: Int) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if !success {
            return
        }
        if success {
            do {
                let data = try Data.init(contentsOf: getFileURL())
                let cards = cardManager.getCardArray()
                guard let currentCards = cards else {
                    return
                }
                for card in currentCards {
                    if card.index == Int16(index) {
                        cardForSound = card
                    }
                }
                guard let card = cardForSound else {
                    return
                }
                switch type {
                case 0:
                    card.questionAudio = data as NSData?
                    break
                case 1:
                    card.answerAudio = data as NSData?
                    break
                default:
                    break
                }
                DataManager.sharedInstance.saveContext()
            } catch {
                return
            }
        }
    }
    
    func recordTapped(_ type: Int, index: Int) {
        if audioRecorder == nil {
            startRecording()
        }
        else {
            finishRecording(success: true, type: type, index: index)
        }
    }
    
    func playTapped (_ type: Int, index: Int) {
        if let player = audioPlayer {
            if player.isPlaying {
                player.stop()
            }
        }
        do {
            let cards = cardManager.getCardArray()
            guard let currentCards = cards else {
                return
            }
            for card in currentCards {
                if card.index == Int16(index) {
                    cardForSound = card
                }
            }
            guard let card = cardForSound else {
                return
            }

            switch type {
            case 0:
                if card.questionAudio != nil {
                    audioPlayer = try AVAudioPlayer.init(data: card.questionAudio as! Data)
                }
                break
            case 1:
                if card.answerAudio != nil {
                    audioPlayer = try AVAudioPlayer.init(data: card.answerAudio as! Data)
                }
                break
            default:
                break
            }
            audioPlayer?.play()
        } catch {
            return
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false, type: 0, index: 0)
        }
    }
}
