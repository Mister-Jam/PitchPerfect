//
//  EditRecordingVCExtension.swift
//  PitchPerfect
//
//  Created by King Bileygr on 5/15/21.
//

import UIKit

extension PlayRecordingViewController {
    
    func setPlayButtonsEnabled(_ enabled: Bool) {
        [playRecordViews.slowButton, playRecordViews.fastButton, playRecordViews.highPitchButton,
         playRecordViews.lowPitchButton, playRecordViews.echoButton, playRecordViews.reverbButton].forEach {
            $0.isEnabled = enabled
         }
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
                                        playRecordViews.stopRecordingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                        playRecordViews.stopRecordingButton.heightAnchor.constraint(equalToConstant: 70),
                                        playRecordViews.stopRecordingButton.widthAnchor.constraint(equalToConstant: 70),
                                        playRecordViews.stopRecordingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
        ])
    }
}

extension PlayRecordingViewController: ConfigureState {
    
    func configure(state: PlayState) {
        switch state {

        case .playing:
            setPlayButtonsEnabled(false)
            playRecordViews.stopRecordingButton.isEnabled = true
        case .notPlaying:
            setPlayButtonsEnabled(true)
            playRecordViews.stopRecordingButton.isEnabled = false
        }
        
    }
    
}
