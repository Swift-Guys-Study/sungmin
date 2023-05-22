//
//  ViewController.swift
//  alamofire_test
//
//  Created by 조성민 on 2023/05/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
        
        var url = "https://openapi.naver.com/v1/papago/n2mt"
        var params : Parameters = [
            "source":"ko",
            "target":"en",
            "text":"만나서 반갑습니다."
        ]
        var header : HTTPHeaders = [
            "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
            "X-Naver-Client-Id":"uGbVnywQ7M1_CpXy9rhb",
            "X-Naver-Client-Secret":"pzV5VtxS1U"
        ]
        
        AF.request(url,method: .post,parameters:params, encoding:URLEncoding.default,headers:header).responseJSON{ response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String:Any],
                   let papagoDTO = json["message"] as? [String:Any],
                   let result = papagoDTO["result"] as? [String:Any],
                    let translatedText = result["translatedText"] as? String{
                    print(translatedText)
                }
            case .failure(let error):
                print(error)
            }
        }
    }


}

