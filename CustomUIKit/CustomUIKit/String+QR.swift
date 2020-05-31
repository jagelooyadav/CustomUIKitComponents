//
//  String+QR.swift
//  CustomUIKit
//
//  Created by Ganesh Waje on 31/05/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

extension String {
    
    private func createQR() -> CIImage? {
        let stringData = self.data(using: .utf8)

        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(stringData, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")

        return filter?.outputImage
    }
    
    public func qrCodeImage(qrCodeSize: CGSize = CGSize(width: 200, height: 200)) -> UIImage? {
        guard let ciImage = createQR() else { return nil }
        
        // Size
        let ciImageSize = ciImage.extent.size
        let widthRatio = qrCodeSize.width / ciImageSize.width
        let heightRatio = qrCodeSize.height / ciImageSize.height
                
        return ciImage.nonInterpolatedImage(withScale: Scale(dx: widthRatio, dy: heightRatio))
    }
}

private typealias Scale = (dx: CGFloat, dy: CGFloat)

private extension CIImage {

    func nonInterpolatedImage(withScale scale: Scale = Scale(dx: 1, dy: 1)) -> UIImage? {
        guard let cgImage = CIContext(options: nil).createCGImage(self, from: self.extent) else { return nil }
        let size = CGSize(width: self.extent.size.width * scale.dx, height: self.extent.size.height * scale.dy)
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .none
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(cgImage, in: context.boundingBoxOfClipPath)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
}
