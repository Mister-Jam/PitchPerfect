//
//  RecordAudioVCExtension.swift
//  PitchPerfect
//
//  Created by King Bileygr on 5/15/21.
//

import UIKit
import AVFoundation

extension RecordAudioViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            let controller = PlayRecordingViewController()
            controller.recordedAudioURL = viewModel.audioRecorder?.url
            navigationController?.pushViewController(controller, animated: true)
        } else {
            viewObjects.failureAlert(title: Alerts.recordingFailed, message: Alerts.failedToSave, viewController: self)
        }
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            viewObjects.recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewObjects.recordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            viewObjects.statusLabel.topAnchor.constraint(equalTo: viewObjects.recordButton.bottomAnchor),
            viewObjects.statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            viewObjects.stopRecordingButton.topAnchor.constraint(equalTo: viewObjects.statusLabel.bottomAnchor, constant: 5),
            viewObjects.stopRecordingButton.heightAnchor.constraint(equalToConstant: 70),
            viewObjects.stopRecordingButton.widthAnchor.constraint(equalToConstant: 70),
            viewObjects.stopRecordingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
