//
//  CardView.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-18.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class CardView: UIView, AVAudioRecorderDelegate, SFSpeechRecognizerDelegate {
    @IBOutlet weak var microphoneButton: UIButton!
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    @IBOutlet weak var speechToTextLabel: UILabel!
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
        cardView.speechRecognizer.delegate = cardView
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
            }
        }
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
        enableSpeechToText()
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
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        }
        audioRecorder.stop()
        audioRecorder = nil
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        }
        
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
    
    func enableSpeechToText() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.speechToTextLabel.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        speechToTextLabel.text = "Say something, I'm listening!"
        
    }
    
//    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
//        if available {
//            microphoneButton.isEnabled = true
//        } else {
//            microphoneButton.isEnabled = false
//        }
//    }
}
