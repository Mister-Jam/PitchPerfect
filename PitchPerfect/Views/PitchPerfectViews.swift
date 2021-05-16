//
//  EditRecordingViews.swift
//  PitchPerfect
//
//  Created by King Bileygr on 5/15/21.
//

import UIKit

class PitchPerfectViews: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = Recording.defaultText
        return label
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
    
    let recordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "Record"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let stopRecordingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "Stop"), for: .normal)
        button.isEnabled = false
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    func failureAlert(title: String, message: String, viewController: UIViewController) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alert = UIAlertAction(title: Alerts.dismissAlert, style: .destructive, handler: nil)
          controller.addAction(alert)
          viewController.present(controller, animated: true, completion: nil)
      }
}
