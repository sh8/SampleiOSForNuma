//
//  ViewController.swift
//  SampleForNuma
//
//  Created by Shun Iwase on 2017/04/29.
//  Copyright © 2017 Shun Iwase. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func uploadImageButton(_ sender: Any) {
        if let image = UIImage(named: "test.png") {
            let imageData = UIImagePNGRepresentation(image)
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(imageData!, withName: "file", fileName: "swift_file.jpeg", mimeType: "image/png")
            }, to:"http://localhost:3000/images") { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        //self.delegate?.showSuccessAlert()
                        print(response.request)  // original URL request
                        print(response.response) // URL response
                        print(response.data)     // server data
                        print(response.result)   // result of response serialization
                        //                        self.showSuccesAlert()
                        //self.removeImage("frame", fileExtension: "txt")
                        if let JSON = response.result.value {
                            print("JSON: \(JSON)")
                        }
                    }
                    
                case .failure(let encodingError):
                    //self.delegate?.showFailAlert()
                    print(encodingError)
                }
                
            }
        }
    }

}

