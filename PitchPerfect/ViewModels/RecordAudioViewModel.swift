//
//  RecordAudioViewModel.swift
//  PitchPerfect
//
//  Created by King Bileygr on 5/15/21.
//

import UIKit
import AVFoundation

class RecordingAudioViewModel {
    
    var audioRecorder: AVAudioRecorder?
    
    func beginRecording (viewController: UIViewController) {
        
        //MARK: Get Path for file to be stored and Recording Name then make an array of both and create Path URL
        let directoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = Recording.name
        let pathArray = [directoryPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        //MARK: Instantiate New Recording Session and Start Recording
        
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        guard let filePath = filePath else { return }
        try? audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
        audioRecorder?.delegate = viewController as? AVAudioRecorderDelegate
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.prepareToRecord()
        audioRecorder?.record()
        
    }
    
    func endRecording() {
        audioRecorder?.stop()
        let session = AVAudioSession.sharedInstance()
        try? session.setActive(false)
    }
}
