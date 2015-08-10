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
        resetPlayer()
        audioPlayer.rate = 2.0
        audioPlayer.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        resetPlayer()
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
    
    @IBAction func playDarthVader(sender: AnyObject) {
        resetPlayer()
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        resetPlayer()
        playAudioWithVariablePitch(1000)
    }

    
    func playAudioWithVariablePitch(pitch: Float){
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
