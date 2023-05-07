//
//  ViewController.swift
//  OpenAPI
//
//  Created by 조성민 on 2023/05/07.
//

import UIKit

enum TagType{
    case area_ar
    case area_se
    case latitude
    case lnmadr
    case ctprvnnm
    case ref_date
    case area_nm
    case rdnmadr
    case inst_nm
    case fclty_knd
    case emdnm
    case area_desc
    case id
    case signgunm
    case longitude
    case none
}

struct item {
    var area_ar: String
    var area_se: String
    var latitude: String
    var lnmadr: String
    var ctprvnnm: String
    var ref_date: String
    var area_nm: String
    var rdnmadr: String
    var inst_nm: String
    var fclty_knd: String
    var emdnm: String
    var area_desc: String
    var id: String
    var signgunm: String
    var longitude: String
    
    init(){
      area_ar = ""
      area_se = ""
      latitude = ""
      lnmadr = ""
      ctprvnnm = ""
      ref_date = ""
      area_nm = ""
      rdnmadr = ""
      inst_nm = ""
      fclty_knd = ""
      emdnm = ""
      area_desc = ""
      id = ""
      signgunm = ""
      longitude = ""
    }
}

class ViewController: UIViewController, XMLParserDelegate{
    
    var tagType : TagType = .none
    var tempModel : item?
    var isLock = true
    var items: [item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        var parser : XMLParser
        let yourKey = "hV7Gzh44w1Lnyf3LNODrtKVCc9dPIJM0KjDWQJdy6bhOQ2tGaInJ%2B8%2BIrSfxAGkEtVD%2FLpIefwDsQkZNb1Mv5Q%3D%3D" // 공공 데이터 포털에서 발급받은 개인 키
        //let url = URL(string: "https://apis.data.go.kr/3040000/smokingService/getSmkAreaList?serviceKey=\(yourKey)")
        let url = URL(string: "https://apis.data.go.kr/3040000/smokingService/getSmkAreaList?serviceKey=\(yourKey)&type=xml&numOfRows=10&pageNo=1&id=%EA%B5%B0%EC%9E%90%EB%8F%99-02-01-020")
        
        parser = XMLParser(contentsOf: url!)!
        parser.delegate = self
        parser.parse()
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        if elementName == "item" {
            isLock = true
            tempModel = item.init()
        } else if elementName == "area_ar" {
            tagType = .area_ar
        } else if elementName == "area_se" {
            tagType = .area_se
        } else if elementName == "latitude" {
            tagType = .latitude
        } else if elementName == "lnmadr" {
            tagType = .lnmadr
        } else if elementName == "ctprvnnm" {
            tagType = .ctprvnnm
        } else if elementName == "ref_date" {
            tagType = .ref_date
        } else if elementName == "area_nm" {
            tagType = .area_nm
        } else if elementName == "rdnmadr" {
            tagType = .rdnmadr
        } else if elementName == "inst_nm" {
            tagType = .inst_nm
        } else if elementName == "fclty_knd" {
            tagType = .fclty_knd
        } else if elementName == "emdnm" {
            tagType = .emdnm
        } else if elementName == "area_desc" {
            tagType = .area_desc
        } else if elementName == "id" {
            tagType = .id
        } else if elementName == "signgunm" {
            tagType = .signgunm
        } else if elementName == "longitude" {
            tagType = .longitude
        } else {
            tagType = .none
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            guard let tempModel = tempModel else {
                return
            }
            items.append(tempModel)
            isLock = false
        } else {
            print("----- didEndElement (else)-----")
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
            let parseString = string.trimmingCharacters(in: .whitespacesAndNewlines)
            if isLock {
                switch tagType {
                case .area_ar:
                    tempModel?.area_ar = parseString
                case .area_se:
                    tempModel?.area_se = parseString
                case .latitude:
                    tempModel?.latitude = parseString
                case .lnmadr:
                    tempModel?.lnmadr = parseString
                case .ctprvnnm:
                    tempModel?.ctprvnnm = parseString
                case .ref_date:
                    tempModel?.ref_date = parseString
                case .area_nm:
                    tempModel?.area_nm = parseString
                case .rdnmadr:
                    tempModel?.rdnmadr = parseString
                case .inst_nm:
                    tempModel?.inst_nm = parseString
                case .fclty_knd:
                    tempModel?.fclty_knd = parseString
                case .emdnm:
                    tempModel?.emdnm = parseString
                case .area_desc:
                    tempModel?.area_desc = parseString
                case .id:
                    tempModel?.id = parseString
                case .signgunm:
                    tempModel?.signgunm = parseString
                case .longitude:
                    tempModel?.longitude = parseString
                case .none: break
                }
            }
        if items.count>0{
            print(items)
        }
        }
}

