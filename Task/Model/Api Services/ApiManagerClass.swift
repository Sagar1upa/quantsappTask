//
//  ApiManagerClass.swift
//  Task
//
//  Created by Sagar Upadhyay on 19/07/21.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
public func requestGETURL(_ strURL: String,VC:UIViewController ,params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
    if Connectivity.isConnectedToInternet {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setForegroundColor(.black)
        SVProgressHUD.setBackgroundColor(.clear)
        AF.request(strURL, method: .get, parameters: params, encoding: URLEncoding.default,headers: nil).responseJSON { response in
            switch response.result{
            case .success(let res):
                if let code = response.response?.statusCode{
                    if code == 200{
                        SVProgressHUD.dismiss()
                        let response = JSON(res)
                        success(response)
                    }else{
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            VC.presentShow(withTitle: "", message: "error message")
                        }
                    }
                }
            case .failure(let error):
                failure(error)
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    VC.presentShow(withTitle: "", message: "Some error occured")
                }
            }
        }
    }else{
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            VC.presentShow(withTitle: "", message: "Please check your internet connection")
        }
    }
}
