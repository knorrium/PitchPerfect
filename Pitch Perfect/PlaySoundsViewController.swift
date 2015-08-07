//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Felipe Kuhn on 8/6/15.
//  Copyright (c) 2015 Knorrium. All rights reserved.
//

import UIKit

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var btnSnail: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSlowAudio(sender: UIButton) {
        
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
