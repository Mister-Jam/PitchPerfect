//
//  Constants.swift
//  PitchPerfect
//
//  Created by King Bileygr on 5/15/21.
//

import Foundation

struct Alerts {
    static let dismissAlert = "Close"
    static let recordingFailed = "Recording failed"
    static let recordingDisabledTitle = "Recording Disabled"
    static let recordingDisabledMessage = "You've disabled this app from recording your microphone. Check Settings."
    static let recordingFailedTitle = "Recording Failed"
    static let recordingFailedMessage = "Something went wrong with your recording."
    static let audioRecorderError = "Audio Recorder Error"
    static let audioSessionError = "Audio Session Error"
    static let audioRecordingError = "Audio Recording Error"
    static let audioFileError = "Audio File Error"
    static let audioEngineError = "Audio Engine Error"
    static let failedToSave = "Recording was unsuccessful and was not saved"
}

struct Recording {
    static let inProgressText = "Recording in progress"
    static let defaultText = "Tap to Record"
    static let name = "recordedAudio.wav"
}
