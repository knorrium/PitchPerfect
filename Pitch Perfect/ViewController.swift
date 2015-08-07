//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Felipe Kuhn on 7/27/15.
//  Copyright (c) 2015 Knorrium. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Show text "recording in progress"
        //TODO: Record the user's voice
        recordingStatus.hidden = false
        btnStop.hidden = false
        println("in recordAudio")
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingStatus.hidden = true
        btnStop.hidden = true
    }
    @IBOutlet weak var recordingStatus: UILabel!
    @IBOutlet weak var btnStop: UIButton!
}

