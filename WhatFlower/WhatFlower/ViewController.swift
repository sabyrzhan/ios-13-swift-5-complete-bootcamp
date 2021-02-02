//
//  ViewController.swift
//  WhatFlower
//
//  Created by Sabyrzhan Tynybayev on 2/2/21.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    let uiPickerContoller = UIImagePickerController()
    let wikiBaseURL = "https://en.wikipedia.org/w/api.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        uiPickerContoller.delegate   = self
        uiPickerContoller.sourceType = .camera
        uiPickerContoller.allowsEditing = false
    }

    @IBAction func photoButtonPressed(_ sender: UIBarButtonItem) {
        present(uiPickerContoller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let ciImage = CIImage(image: pickedImage) else {
                fatalError("Could not create CIImage from picked image")
            }
            
            detect(ciImage: ciImage) {
                self.uiPickerContoller.dismiss(animated: true, completion: nil)
            }
            
        } else {
            uiPickerContoller.dismiss(animated: true, completion: nil)
        }
    }
    
    func detect(ciImage: CIImage, afterDetect: (() -> ())?) {
        guard let model = try? VNCoreMLModel(for: FlowerClassifier.init(configuration: MLModelConfiguration()).model) else {
            fatalError("Error loading FlowerClassifier model")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, model) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Error getting results from request")
            }
            
            guard let firstResult = results.first else {
                fatalError("Error getting first result from results")
            }
            
            let title = firstResult.identifier
            
            self.navigationItem.title = title
            
            Alamofire.request(self.wikiBaseURL, method: .get, parameters: self.buildParams(title: title)).responseJSON { response in
                if response.result.isSuccess {
                    let jsonData = JSON(response.result.value!)
                    print(jsonData)
                    let pageId = jsonData["query"]["pageids"][0].string!
                    let description = jsonData["query"]["pages"][pageId]["extract"]
                    self.label.text = description.string!
                    let flowerImage = jsonData["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
                    self.imageVIew.sd_setImage(with: URL(string: flowerImage), completed: nil)
                    afterDetect?()
                    
                } else {
                    self.label.text = "Response returned error: \(response.result.value ?? "response is nil"))"
                }
            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("\(error)")
        }
    }
    
    func buildParams(title: String) ->  [String: String] {
        let params : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop": "extracts|pageimages",
            "exintro" : "",
            "explaintext": "",
            "titles" : title,
            "indexpageids": "",
            "redirects": "1",
            "pithumbsize": "500"
        ]
        
        return params
    }
}

