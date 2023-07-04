//
//  EncoderInterface.swift
//  PassOniOS
//
//  Created by niv ben-porath on 24/06/2023.
//

import Foundation
import PassEncoder

struct EncoderInterface {
    
    var encoder: PassEncoder?
    
    mutating func createEncoder(with passInfo: PassInfo) -> Data? {
//        guard startEncode(with: passInfo) else {return nil}
        
        if startEncode(with: passInfo) {
            if addImages() {
                return createManifest()
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    private mutating func startEncode(with passInfo: PassInfo) -> Bool {
        let data = PassJson.jsonfile(passInfo: passInfo)
        guard let encoder = PassEncoder(passData: data) else {
            print("no encoder")
            return false
        }
        self.encoder = encoder
        return true
    }
    
    private func addImages() -> Bool {
        guard let iconPath = Bundle.main.url(forResource: "icon", withExtension: "png"),
              let icon2Path = Bundle.main.url(forResource: "icon2", withExtension: "png"),
              let logoPath = Bundle.main.url(forResource: "logo", withExtension: "png"),
              let logo2Path = Bundle.main.url(forResource: "logo2", withExtension: "png")
        else {
            print("no image")
            return false
        }
        
        print("icons")
        
        guard let encoder = self.encoder else {return false}
        
        let a = encoder.addFile(from: iconPath)
        let b = encoder.addFile(from: icon2Path)
        let c = encoder.addFile(from: logoPath)
        let d = encoder.addFile(from: logo2Path)
        
        if a && b && c && d {
            return true
        }
        else {
            return false
        }
    }
    
    private func createManifest() -> Data? {
        guard
            let encoder = self.encoder,
            let passData = encoder.createManifest()
        else {
            print("no encoder or no data")
            return nil
        }
        return passData
    }
    
    func addSignature(with data: Data) -> Bool {
        
        if let encoder = self.encoder, encoder.addFileWithoutHash(named: "signature", from: data) {
            return true
        }
        else {
            return false
        }
    }
    
    func archivedData() throws -> Data {
        do {
            
            let signedData = try self.encoder!.archivedData()
            return signedData
        }
        catch {
            print("no archivedData")
            throw error
        }
    }
    
    func archiveURL() -> URL {
        return self.encoder!.archiveURL()
    }
}
