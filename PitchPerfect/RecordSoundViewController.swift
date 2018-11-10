//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Hussain Almajed on 11/3/18.
//  Copyright © 2018 UdacityHS. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

   
    
    @IBOutlet weak var recordingStateLabel: UILabel!
    @IBOutlet weak var startRecordingLabel: UIButton!
    @IBOutlet weak var stopRecordingLabel: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingLabel.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI(isRecording: false)
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startRecording(_ sender: Any) {
       updateUI(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        updateUI(isRecording: false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
        performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
        }else{
            print("error : \(flag)")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecordingSegue"{
            let playSoundVC = segue.destination as! PlaySoundViewController
            let recordAudiUrl = sender as! URL
            playSoundVC.recordAudiUrl = recordAudiUrl
            
        }
    }
    func updateUI(isRecording: Bool) {
        stopRecordingLabel.isEnabled = isRecording
        startRecordingLabel.isEnabled = !isRecording
        recordingStateLabel.text = isRecording ? "Recording in Progress" : "Tap to Record"
    }
}

