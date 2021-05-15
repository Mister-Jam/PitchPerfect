//
//  ViewController.swift
//  PitchPerfect
//
//  Created by King Bileygr on 5/15/21.
//

import UIKit
import AVFoundation

class PitchPerfectViewController: UIViewController {
    
    var audioRecorder: AVAudioRecorder?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pitch Perfect"
        view.backgroundColor = .white
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addSubViews()
        view.layoutIfNeeded()
    }
    
    let recordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "Record"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTapRecord), for: .touchUpInside)
        return button
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap to Record"
        return label
    }()
    
    let stopRecordingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "Stop"), for: .normal)
        button.isEnabled = false
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTapStopRecording), for: .touchUpInside)
        return button
    }()
    
    func addSubViews() {
        [recordButton, statusLabel, stopRecordingButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: recordButton.bottomAnchor),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stopRecordingButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            stopRecordingButton.heightAnchor.constraint(equalToConstant: 70),
            stopRecordingButton.widthAnchor.constraint(equalToConstant: 70),
            stopRecordingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func didTapRecord() {
        recordButton.isEnabled = false
        stopRecordingButton.isEnabled = true
        statusLabel.text = "Recording in progress"
        // get the path for the file to be stored and recording name as strings then make an array of both and create the path local url
        let directoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedAudio.wav"
        let pathArray = [directoryPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        //after creating url, we instantiate a new recording session and start recording
        
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        guard let filePath = filePath else { return }
//        guard var audioRecorder = audioRecorder else { return }
        try? audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
        audioRecorder?.delegate = self
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.prepareToRecord()
        audioRecorder?.record()
    }
    
    @objc func didTapStopRecording() {
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        statusLabel.text = "Tap to Record"
        audioRecorder?.stop()
        let session = AVAudioSession.sharedInstance()
        try? session.setActive(false)
    }
}

extension PitchPerfectViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            let controller = EditRecordingViewController()
            controller.recordedAudioURL = audioRecorder?.url
            navigationController?.pushViewController(controller, animated: true)
        } else {
            failureAlert(viewController: self)
        }
    }
    
    func failureAlert(viewController: UIViewController) {

          let controller = UIAlertController(title: "Error", message: "Recording was unsuccessful", preferredStyle: .alert)
          let alert = UIAlertAction(title: "Close", style: .destructive, handler: nil)
          controller.addAction(alert)
          viewController.present(controller, animated: true, completion: nil)

      }
}

