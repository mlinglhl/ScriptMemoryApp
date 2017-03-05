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
    
    class func initFromNib() -> CardView {
        let nib = UINib(nibName: "CardView", bundle: nil)
        let cardView = nib.instantiate(withOwner: nil, options: nil)[0] as! CardView
        return cardView
    }
    
    @IBAction func playQuestion(_ sender: UIButton) {
        //                let sound = NSDataAsset(name: "SampleClip")
        //                do {
        //                    let player = try AVAudioPlayer(data: sound!.data)
        //                    player.play()
        //                    self.player = player
        //                }
        //                catch {
        //                    return
        //                }
    }
    
    @IBAction func recordQuestion(_ sender: UIButton) {
        do {
            print("Pressed")
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Made it!")
                    } else {
                        print("Failed to record early")
                        return
                    }
                }
            }
        } catch {
            print("Failed to record")
        }
        recordTapped()
    }
    
    @IBAction func playAnswer(_ sender: UIButton) {
    }
    
    @IBAction func recordAnswer(_ sender: UIButton) {
    }
    
    
    @IBAction func showAnswer(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.answerLabel.alpha = 1
            
        })
    }
    
    func startRecording() {
//        let audioFileName = getDocumentsDirectory().appendingPathComponent("recording.m4a")
//        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
//        do {
//            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
//            audioRecorder.delegate = self
//            audioRecorder.record()
//            
//            //toggle record button - started recording here
//        } catch {
//            finishRecording(success: false)
//        }
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
//        let path = getCacheDirectory().stringByAppendingPathComponent
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentsDirectory = paths[0]
//        return documentsDirectory
    }
    
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            // recording stopped and was successful
        } else {
            // recording stopped and never happened
        }
    }
    
    func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        }
        else {
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
}
