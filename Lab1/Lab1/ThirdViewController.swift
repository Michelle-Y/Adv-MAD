//
//  ThirdViewController.swift
//  Lab1
//
//  Created by mac on 2019/2/4.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit
import AVFoundation

class ThirdViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var recorder:AVAudioRecorder!
    var player:AVAudioPlayer!
    
    @IBAction func record(_ sender: Any) {
        recorder.record()
        print("start recording")
    }
    @IBAction func play(_ sender: Any) {
        do {
            try player = AVAudioPlayer(contentsOf: (recorder?.url)!)
            player!.delegate = self
            player!.enableRate = true
            player!.prepareToPlay()
            print("Playing")
            player!.play()
        } catch let error as NSError {
            print("audioPlayer error: \(error.localizedDescription)")
        }

    }
    @IBAction func stop(_ sender: Any) {
        recorder.stop()
        print("Stop recording")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0]
        let audioFileURL = docDir.appendingPathComponent("recording.m4a")
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            print("Audio session error: \(error.localizedDescription)")
        }
        
        let recordSettings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            recorder = try AVAudioRecorder(url: audioFileURL, settings: recordSettings)
            recorder?.prepareToRecord()
            print("Recorder ready")
        } catch {
            print("Audio recorder error: \(error.localizedDescription)")
        }
        
        recorder.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
