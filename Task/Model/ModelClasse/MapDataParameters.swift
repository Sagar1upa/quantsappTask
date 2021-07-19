//
//  MapDataParameters.swift
//  Task
//
//  Created by Sagar Upadhyay on 19/07/21.
//
import SwiftyJSON
import Foundation
class MapDataParameters: NSObject {
    
    var Long = [DataStruct]()
    var short = [DataStruct]()
    var LongU  = [DataStruct]()
    var ShortC = [DataStruct]()
    
    func doInit(_ data:JSON){
        let L = data["l"].string ?? ""
        let lObject = L.components(separatedBy: ";")
        if lObject.count != 0{
            for iteam in lObject {
                let iList = iteam.components(separatedBy: ",")
                if iList.count == 5{
                    let priceChange = (Float(iList[3]) ?? 0.0) * 100
                    Long.append(DataStruct(category: "l", symbol: iList[0], priceChange: priceChange))
                }
            }
        }
        
        let lu = data["lu"].string ?? ""
        let luObject = lu.components(separatedBy: ";")
        if luObject.count != 0{
            for iteam in luObject {
                let iList = iteam.components(separatedBy: ",")
                if iList.count == 5{
                    let priceChange = (Float(iList[3]) ?? 0.0) * 100
                    LongU.append(DataStruct(category: "lu", symbol: iList[0], priceChange: priceChange))
                }
            }
        }
        
        let S = data["s"].string ?? ""
        let sObject = S.components(separatedBy: ";")
        if sObject.count != 0{
            for iteam in sObject {
                let iList = iteam.components(separatedBy: ",")
                if iList.count == 5{
                    let priceChange = (Float(iList[3]) ?? 0.0) * 100
                    short.append(DataStruct(category: "s", symbol: iList[0], priceChange: priceChange))
                }
            }
        }
        
        let sc = data["sc"].string ?? ""
        let scObject = sc.components(separatedBy: ";")
        if scObject.count != 0{
            for iteam in lObject {
                let iList = iteam.components(separatedBy: ",")
                if iList.count == 5{
                    let priceChange = (Float(iList[3]) ?? 0.0) * 100
                    ShortC.append(DataStruct(category: "sc", symbol: iList[0], priceChange: priceChange))
                }
            }
        }
    }
    
}

struct DataStruct {
    let category:String
    let symbol:String
    let priceChange:Float
}
