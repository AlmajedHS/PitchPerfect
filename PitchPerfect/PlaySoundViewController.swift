//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Hussain Almajed on 11/3/18.
//  Copyright © 2018 UdacityHS. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordAudiUrl: URL!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    @IBAction func playSoundForButton(_ sender: Any) {
        switch (ButtonType(rawValue: (sender as AnyObject).tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true )
        case .reverb:
            playSound(reverb: true)
            
        }
        configureUI(.playing)
    }
    @IBAction func stopButtonPressed(_ sender: Any) {
        
        stopAudio()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        for button:UIButton in [snailButton, rabbitButton, highPitchButton, lowPitchButton, echoButton, reverbButton] {
            button.contentMode = .scaleAspectFit
            button.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
