//
//  ViewController.swift
//  Is Headphone Plugged In
//
//  Created by Sanjib Ahmad on 4/9/15.
//  Copyright (c) 2015 Object Coder. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        for description in currentRoute.outputs {
            if description.portType == AVAudioSessionPortHeadphones {
                println("headphone plugged in")
            } else {
                println("headphone plugged out")
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "audioRouteChangeListener:",
            name: AVAudioSessionRouteChangeNotification,
            object: nil)
    }
    
    dynamic private func audioRouteChangeListener(notification:NSNotification) {
        let audioRouteChangeReason = notification.userInfo![AVAudioSessionRouteChangeReasonKey] as UInt

        switch audioRouteChangeReason {
        case AVAudioSessionRouteChangeReason.NewDeviceAvailable.rawValue:
            println("headphone plugged in")
        case AVAudioSessionRouteChangeReason.OldDeviceUnavailable.rawValue:
            println("headphone pulled out")
        default:
            break
        }
    }
    

}

