//
//  PlayRecordingViewModel.swift
//  PitchPerfect
//
//  Created by King Bileygr on 5/15/21.
//

import UIKit
import AVFoundation

enum PlayState {
    case playing
    case notPlaying
}

protocol ConfigureState: AnyObject {
    func configure(state: PlayState)
}

class PlayRecordingViewModel {
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var timer: Timer!
    let alert = PitchPerfectViews()
    var delegate: ConfigureState?

    //MARK: Setup Stop Button
    @objc func stopPlayBack() {
        if let audioPlayerNode = audioPlayerNode {
              audioPlayerNode.stop()
          }
          if let stopTimer = timer {
              stopTimer.invalidate()
          }
          if let audioEngine = audioEngine {
              audioEngine.stop()
              audioEngine.reset()
          }
        
        delegate?.configure(state: .notPlaying)
      
    }
    
    //MARK: Setup Audio Effects Functions
    
    func setupAudioPlayBack(with url: URL, viewcontroller: UIViewController) {
        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            alert.failureAlert(title: Alerts.audioFileError, message: String(describing: error), viewController: viewcontroller)
        }
        delegate?.configure(state: .notPlaying)
    }
    
    func playSound(rate: Float? = nil, pitch: Float? = nil, echo: Bool = false, reverb: Bool = false, viewcontroller: UIViewController) {
        
        audioEngine = AVAudioEngine()
        
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        
        // node for adjusting rate/pitch
        let changeRatePitchNode = AVAudioUnitTimePitch()
        if let pitch = pitch {
            changeRatePitchNode.pitch = pitch
        }
        if let rate = rate {
            changeRatePitchNode.rate = rate
        }
        audioEngine.attach(changeRatePitchNode)
        
        // node for echo
        let echoNode = AVAudioUnitDistortion()
        echoNode.loadFactoryPreset(.multiEcho1)
        audioEngine.attach(echoNode)
        
        // node for reverb
        let reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset(.cathedral)
        reverbNode.wetDryMix = 50
        audioEngine.attach(reverbNode)
        
        // connect nodes
        if echo == true && reverb == true {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, echoNode, reverbNode, audioEngine.outputNode)
        } else if echo == true {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, echoNode, audioEngine.outputNode)
        } else if reverb == true {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, reverbNode, audioEngine.outputNode)
        } else {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, audioEngine.outputNode)
        }
        
        // schedule to play and start the engine!
        audioPlayerNode.stop()
        audioPlayerNode.scheduleFile(audioFile, at: nil) { [self] in
            renderAndScheduleToPlay(rate: rate)
        }
        startEngine(controller: viewcontroller)
        // play the recording and configure UI
        audioPlayerNode.play()
        delegate?.configure(state: .playing)
    }
    
    func renderAndScheduleToPlay (rate: Float? = nil) {
        var delayInSeconds: Double = 0
        if let lastRenderTime = audioPlayerNode.lastRenderTime, let playerTime = audioPlayerNode.playerTime(forNodeTime: lastRenderTime) {
            if let rate = rate {
                delayInSeconds = Double(audioFile.length - playerTime.sampleTime) / Double(self.audioFile.processingFormat.sampleRate) / Double(rate)
            } else {
                delayInSeconds = Double(audioFile.length - playerTime.sampleTime) / Double(self.audioFile.processingFormat.sampleRate)
            }
        }
        //MARK: Stop timer for when audio finishes playing
        timer = Timer(timeInterval: delayInSeconds, target: self, selector: #selector(self.stopPlayBack), userInfo: nil, repeats: false)
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.default)
    }
    
    func startEngine (controller: UIViewController) {
        do {
            try audioEngine.start()
        } catch {
            alert.failureAlert(title: Alerts.audioEngineError, message: String(describing: error), viewController: controller)
            return
        }
    }
    
    func connectAudioNodes(_ nodes: AVAudioNode...) {
        for x in 0..<nodes.count-1 {
            audioEngine.connect(nodes[x], to: nodes[x+1], format: audioFile?.processingFormat)
        }
    }
}
