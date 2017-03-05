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
    var audioPlayer: AVAudioPlayer!
    var recordingURL = ""
    
    class func initFromNib() -> CardView {
        let nib = UINib(nibName: "CardView", bundle: nil)
        let cardView = nib.instantiate(withOwner: nil, options: nil)[0] as! CardView
        return cardView
    }
    
    @IBAction func playQuestion(_ sender: UIButton) {
        playTapped()
    }
    
    @IBAction func recordQuestion(_ sender: UIButton) {
        recordTapped()
    }
    
    @IBAction func playAnswer(_ sender: UIButton) {
        playTapped()
    }
    
    @IBAction func recordAnswer(_ sender: UIButton) {
        recordTapped()
    }
    
    
    @IBAction func showAnswer(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.answerLabel.alpha = 1
            
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
    
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            do {
                audioPlayer = try AVAudioPlayer.init(contentsOf: getFileURL())
            } catch {
                return
            }
        } else {
        }
    }
    
    func recordTapped() {
        if audioRecorder == nil {
            startRecording()
            print("RStart")
        }
        else {
            finishRecording(success: true)
            print("RStop")
        }
    }
    
    func playTapped () {
        if audioPlayer != nil {
        audioPlayer.play()
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
