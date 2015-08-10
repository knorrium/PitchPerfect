//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Felipe Kuhn on 8/6/15.
//  Copyright (c) 2015 Knorrium. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnPlayFast: UIButton!
    @IBOutlet weak var btnSnail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func resetPlayer() {
        audioPlayer.stop()
        audioEngine.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 1.0
        audioEngine.reset()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        resetPlayer()
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithVariableRate(2.0)
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }
    
    @IBAction func playDarthVader(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }

    func playAudioWithVariableRate(rate: Float) {
        resetPlayer()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        resetPlayer()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
}
