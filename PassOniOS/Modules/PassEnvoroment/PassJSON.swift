//
//  PassJSON.swift
//  PassOniOS
//
//  Created by niv ben-porath on 24/06/2023.
//

import Foundation

struct PassJson {
    static func jsonfile(passInfo: PassInfo) -> Data {
        
        let jsonString = """
{
  "formatVersion" : 1,
  "passTypeIdentifier" : "\(DevInfo.passTypeIdentifier)",
  "serialNumber" : "SN0001",
  "teamIdentifier" : "\(DevInfo.teamIdentifier)",
  "webServiceURL" : "https://example.com/passes/",
  "authenticationToken" : "vxwxd7J8AlNNFPS8k0a0FfUFtq0ewzFdc",
  "barcode" : {
    "message" : "\(passInfo.qrMessage)",
    "format" : "PKBarcodeFormatQR",
    "messageEncoding" : "iso-8859-1"
  },
  "organizationName" : "My org",
  "description" : "\(passInfo.description)",
  "logoText" : "\(passInfo.logoText)",
  "foregroundColor" : "rgb(0, 0, 0)",
  "backgroundColor" : "rgb(255, 255, 255)",
  "generic" : {
      "primaryFields" : [
          {
              "key" : "podcaster",
              "label" : "Recorded by",
              "value" : "\(passInfo.recorderText)"
          }
      ],
      "secondaryFields" : [
          {
              "dateStyle" : "PKDateStyleMedium",
              "isRelative" : false,
              "key" : "recored-date",
              "label" : "Recorded on",
              "timeStyle" : "PKDateStyleNone",
              "value" : "\(passInfo.currentDateString)"
          }
      ]
  }
}

"""
        let data = Data(jsonString.utf8)
        return data
    }
}
