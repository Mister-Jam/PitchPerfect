//
//  EditRecordingViewController.swift
//  PitchPerfect
//
//  Created by King Bileygr on 5/15/21.
//

import UIKit
import AVFoundation

class EditRecordingViewController: UIViewController {
    var recordedAudioURL: URL!
    let stopButton = PitchPerfectViewController().stopRecordingButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupStackViews()
        verticalStack.frame = CGRect(x: 0 + (view.safeAreaInsets.left + view.safeAreaInsets.right),
                                     y: 0 + (view.safeAreaInsets.top + view.safeAreaInsets.bottom),
                                     width: view.frame.width,
                                     height: view.frame.height - (stopButton.frame.height + 20) - (view.safeAreaInsets.top + view.safeAreaInsets.bottom))
    }
    
    lazy var verticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [horizontalSfack, secondHorizontalSfack, thirdHorizontalSfack])
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var horizontalSfack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [slowButton, fastButton])
        stackView.axis = .horizontal
        stackView.backgroundColor = .white
        return stackView
    }()
    
    lazy var secondHorizontalSfack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [highPitchButton, lowPitchButton])
        stackView.axis = .horizontal
        stackView.backgroundColor = .white
        return stackView
    }()
    
    lazy var thirdHorizontalSfack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [echoButton, reverbButton])
        stackView.axis = .horizontal
        stackView.backgroundColor = .white
        return stackView
    }()
    
    let slowButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Slow"), for: .normal)
        button.tag = 0
        return button
    }()
    
    let fastButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Fast"), for: .normal)
        button.tag = 1
        return button
    }()
    
    let highPitchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "HighPitch"), for: .normal)
        button.tag = 2
        return button
    }()
    
    let lowPitchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "LowPitch"), for: .normal)
        button.tag = 3
        return button
    }()
    
    let echoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Echo"), for: .normal)
        button.tag = 4
        return button
    }()
    
    let reverbButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Reverb"), for: .normal)
        button.tag = 5
        return button
    }()
    
    func setupStackViews() {
        
        [horizontalSfack, verticalStack, secondHorizontalSfack, thirdHorizontalSfack].forEach {
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 0
        }
        view.addSubview(verticalStack)
        setupButtons()
    }
    
    func setupButtons() {
        [slowButton, fastButton, highPitchButton, lowPitchButton, echoButton, reverbButton].forEach {
            $0.contentMode = .center
            $0.clipsToBounds = true
            $0.imageView?.contentMode = .scaleAspectFit
            $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
        view.addSubview(stopButton)
        stopButton.isEnabled = true
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.addTarget(self, action: #selector(didTapStopButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
                                        stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                        stopButton.heightAnchor.constraint(equalToConstant: 70),
                                        stopButton.widthAnchor.constraint(equalToConstant: 70),
                                        stopButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)])
    }
    
    @objc func didTapButton(button: UIButton) {
        
    }
    
    @objc func didTapStopButton() {
        
    }
}
