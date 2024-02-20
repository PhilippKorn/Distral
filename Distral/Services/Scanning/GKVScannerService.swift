//
//  EKVScannerService.swift
//  Distral
//
//  Created by Philipp Korn on 20.02.24.
//

import Foundation
import UIKit
import Vision

class GKVScannerService {

    // Funktion zur Erkennung von Text in einem Bild
    func recognizeText(in image: UIImage, completion: @escaping (String) -> Void) {
        guard let cgImage = image.cgImage else {
            completion("")
            return
        }

        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                completion("")
                return
            }
            let recognizedText = observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
            
            let pattern = "Persönliche\\s[Kk]e[rn]*[Dd]*nummer\\s([A-Z0-9]{10})"
              if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
                  let nsString = recognizedText as NSString
                  let results = regex.matches(in: recognizedText, options: [], range: NSRange(location: 0, length: nsString.length))
                  if let match = results.first {
                      let matchedString = nsString.substring(with: match.range(at: 1))
                      if self.isValidKennnummer(matchedString) {
                          completion(matchedString)
                      } else {
                          completion("Kennummer nicht Erkannt")
                      }
                      return
                  }
              }
            print("Erkannter Text: \n\(recognizedText)")

            completion(recognizedText)
        }
        
        request.recognitionLevel = .accurate

        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        do {
            try requestHandler.perform([request])
        } catch {
            completion("")
        }
    }
    
    func isValidKennnummer(_ kennnummer: String) -> Bool {
         return kennnummer.count == 10
     }
}
