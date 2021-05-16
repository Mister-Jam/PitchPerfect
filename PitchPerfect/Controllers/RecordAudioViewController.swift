//
//  ViewController.swift
//  PitchPerfect
//
//  Created by King Bileygr on 5/15/21.
//

import UIKit

class RecordAudioViewController: UIViewController {
    
    var viewObjects: PitchPerfectViews
    var viewModel: RecordingAudioViewModel
    
    init(viewObjects: PitchPerfectViews = PitchPerfectViews(), viewModel: RecordingAudioViewModel = RecordingAudioViewModel()) {
        self.viewObjects = viewObjects
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pitch Perfect"
        navigationController?.navigationBar.tintColor = .systemPurple
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple]
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubViews()
    }
    
    func addSubViews() {
        [viewObjects.recordButton, viewObjects.statusLabel, viewObjects.stopRecordingButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        viewObjects.stopRecordingButton.addTarget(self, action: #selector(didTapStopRecording), for: .touchUpInside)
        viewObjects.recordButton.addTarget(self, action: #selector(didTapRecord), for: .touchUpInside)
        constraints()
    }
    
    @objc func didTapRecord() {
        updateUIWith(recordBtn: false, stopRecordingBtn: true, textLabel: Recording.inProgressText)
        viewModel.beginRecording(viewController: self)
    }
    
    @objc func didTapStopRecording() {
        updateUIWith(recordBtn: true, stopRecordingBtn: false, textLabel: Recording.defaultText)
        viewModel.endRecording()
    }
    
    func updateUIWith(recordBtn: Bool, stopRecordingBtn: Bool, textLabel: String) {
        viewObjects.recordButton.isEnabled = recordBtn
        viewObjects.stopRecordingButton.isEnabled = stopRecordingBtn
        viewObjects.statusLabel.text = textLabel
    }

}
