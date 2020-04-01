//
//  UIDevice+Extension.swift
//
//  Created by Oliver Paray on 5/1/18.
//

import AVFoundation
import Foundation
import UIKit

extension UIDevice{
    
    //MARK: - Properties

    public class var frontCamera:AVCaptureDevice?{
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
    }

    public class var rearCamera:AVCaptureDevice?{
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
    }

    public class var microphone:AVCaptureDevice?{
        return AVCaptureDevice.default(.builtInMicrophone, for: AVMediaType.audio, position: .unspecified)
    }

    //MARK: - Initializers

    //MARK: - Class Methods
    

    //MARK: - Public Methods

    //MARK: - Private Methods

}
