//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Felipe Kuhn on 7/27/15.
//  Copyright (c) 2015 Knorrium. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var recordingStatus: UILabel!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialStatus()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initialStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag) {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func pauseRecording(sender: UIButton) {
        pausedStatus()
    }

    @IBAction func startRecording(sender: UIButton) {
        if (recordingStatus.text == "Tap to Record") {
            let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
            
            
            let recordingName = "my_audio.wav"
            
            let pathArray = [dirPath, recordingName]
            let filePath = NSURL.fileURLWithPathComponents(pathArray)
            println(filePath)
            
            var session = AVAudioSession.sharedInstance()
            session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
            
            audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } else {
            audioRecorder.record()
        }
        
        recordStatus()
    }
    
    func pausedStatus() {
        audioRecorder.pause()
        
        btnPause.hidden = true
        btnRecord.hidden = false
        btnStop.hidden = false
        btnRecord.enabled = true

        recordingStatus.text = "Tap to Resume"
    }
    
    func recordStatus() {
        btnPause.hidden = false
        btnRecord.hidden = false
        btnStop.hidden = false
        btnRecord.enabled = false
        
        recordingStatus.text = "Recording"
    }
    
    func initialStatus() {
        btnPause.hidden = true
        btnStop.hidden = true
        btnRecord.enabled = true
        btnRecord.hidden = false
        
        recordingStatus.hidden = false
        recordingStatus.text = "Tap to Record"
    }
    
    func finishedStatus() {
        btnPause.hidden = true
        btnStop.hidden = true
        btnRecord.enabled = true
        btnRecord.hidden = false
        
        recordingStatus.hidden = false
        recordingStatus.text = "Finished recording"
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        finishedStatus()
    }

}

