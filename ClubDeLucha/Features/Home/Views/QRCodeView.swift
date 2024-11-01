//
//  QRCodeView.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct QRCodeView: View {
    let url: String
    
    var body: some View {
        if let qrCode = generateQRCode(from: url) {
            Image(uiImage: qrCode)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
        } else {
            Image(systemName: "xmark.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
        }
    }
    
    private func generateQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.setValue("H", forKey: "inputCorrectionLevel")
        
        guard let qrImage = qrFilter.outputImage else { return nil }
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        
        guard let cgImage = CIContext().createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
    }
}

#Preview {
    QRCodeView(url: "https://example.com")
        .frame(width: 200, height: 200)
}
