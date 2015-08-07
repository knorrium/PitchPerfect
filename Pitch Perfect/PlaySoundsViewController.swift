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
    
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnPlayFast: UIButton!
    @IBOutlet weak var btnSnail: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            var filePathUrl = NSURL.fileURLWithPath(filePath)
            audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
            audioPlayer.enableRate = true
        } else {
            println("the file path is empty")
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stopAudio(sender: UIButton) {
        println("stopAudio")
        audioPlayer.stop()
    }

    
    @IBAction func playFastAudio(sender: UIButton) {
        println("PlayFast")
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        audioPlayer.play()
    }

    
    @IBAction func playSlowAudio(sender: UIButton) {
        println("PlaySlow")
        audioPlayer.stop()
        audioPlayer.rate = 0.1
        audioPlayer.play()
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
