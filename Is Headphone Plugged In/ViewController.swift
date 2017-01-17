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
    @IBOutlet weak var headphonePluggedInStateImageView: UIImageView!
    let deviceRequiredImage = UIImage(named: "device_required")
    let headphonePluggedInImage = UIImage(named: "headphone_plugged_in")
    let headphonePulledOutImage = UIImage(named: "headphone_pulled_out")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        
        if currentRoute.outputs.count != 0 {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSessionPortHeadphones {
                    headphonePluggedInStateImageView.image = headphonePluggedInImage
                    print("headphone plugged in")
                } else {
                    headphonePluggedInStateImageView.image = headphonePulledOutImage
                    print("headphone pulled out")
                }
            }
        } else {
            headphonePluggedInStateImageView.image = deviceRequiredImage
            print("requires connection to device")
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.audioRouteChangeListener(_:)),
            name: NSNotification.Name.AVAudioSessionRouteChange,
            object: nil)
    }
    
    dynamic fileprivate func audioRouteChangeListener(_ notification:Notification) {
        let audioRouteChangeReason = notification.userInfo![AVAudioSessionRouteChangeReasonKey] as! UInt

        switch audioRouteChangeReason {
        case AVAudioSessionRouteChangeReason.newDeviceAvailable.rawValue:
            headphonePluggedInStateImageView.image = headphonePluggedInImage
            print("headphone plugged in")
        case AVAudioSessionRouteChangeReason.oldDeviceUnavailable.rawValue:
            headphonePluggedInStateImageView.image = headphonePulledOutImage            
            print("headphone pulled out")
        default:
            break
        }
    }
    

}

