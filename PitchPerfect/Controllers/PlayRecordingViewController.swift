//
//  EditRecordingViewController.swift
//  PitchPerfect
//
//  Created by King Bileygr on 5/15/21.
//

import UIKit

class PlayRecordingViewController: UIViewController {
    
    var recordedAudioURL: URL?
    let playRecordViews: PitchPerfectViews
    let viewModel: PlayRecordingViewModel
    
    enum EditButtons: Int {
        case slow = 0, fast, highPitch, lowPitch, echo, reverb
    }
    
    init(replayViews: PitchPerfectViews = PitchPerfectViews(), viewModel: PlayRecordingViewModel = PlayRecordingViewModel()) {
        self.playRecordViews = replayViews
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        viewModel.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupStackViews()
        guard let recordedAudioURL = recordedAudioURL else { return }
        viewModel.setupAudioPlayBack(with: recordedAudioURL, viewcontroller: self)
        playRecordViews.verticalStack.frame = CGRect(x: 0 + (view.safeAreaInsets.left + view.safeAreaInsets.right),
                                                     y: 0 + (view.safeAreaInsets.top + view.safeAreaInsets.bottom),
                                                     width: view.frame.width,
                                                     height: view.frame.height - (playRecordViews.stopRecordingButton.frame.height + 20) - (view.safeAreaInsets.top + view.safeAreaInsets.bottom))
    }
    
    func setupStackViews() {
        
        [playRecordViews.horizontalSfack, playRecordViews.verticalStack, playRecordViews.secondHorizontalSfack, playRecordViews.thirdHorizontalSfack].forEach {
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 0
        }
        view.addSubview(playRecordViews.verticalStack)
        setupButtons()
    }
    
    func setupButtons() {
        [playRecordViews.slowButton, playRecordViews.fastButton, playRecordViews.highPitchButton, playRecordViews.lowPitchButton, playRecordViews.echoButton, playRecordViews.reverbButton].forEach {
            $0.contentMode = .center
            $0.clipsToBounds = true
            $0.imageView?.contentMode = .scaleAspectFit
            $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
        view.addSubview(playRecordViews.stopRecordingButton)
        playRecordViews.stopRecordingButton.translatesAutoresizingMaskIntoConstraints = false
        playRecordViews.stopRecordingButton.addTarget(self, action: #selector(stopPlayback), for: .touchUpInside)
        constraints()
    
    }
    
    @objc func didTapButton(button: UIButton) {
        switch EditButtons(rawValue: button.tag)! {
        case .slow:
            viewModel.playSound(rate: 0.5, viewcontroller: self)
        case .fast:
            viewModel.playSound(rate: 1.5, viewcontroller: self)
        case .highPitch:
            viewModel.playSound(pitch: 1000, viewcontroller: self)
        case .lowPitch:
            viewModel.playSound(pitch: -1000, viewcontroller: self)
        case .echo:
            viewModel.playSound(echo: true, viewcontroller: self)
        case .reverb:
            viewModel.playSound(reverb: true, viewcontroller: self)
        }
    }
    
    @objc func stopPlayback() {
        
        viewModel.stopPlayBack()
    }
}
