import Foundation
import iDenfySDK

func getRustString(result: UnsafePointer<CChar>?) -> String {
    let swift_result = String(cString: result!)
    rust_free_string(UnsafeMutablePointer(mutating: result))
    return swift_result
}

func getSavedKey() -> String {
    let query = [
           kSecAttrService: "sideos-key",
           kSecAttrAccount: "sideos",
           kSecClass: kSecClassGenericPassword,
           kSecReturnData: true
       ] as CFDictionary
  
    var item: AnyObject?
    let status = SecItemCopyMatching(query, &item)
    guard status == errSecSuccess else {
        return ""
    }
    let key = item as! Data
    return String(decoding: key, as: UTF8.self)
}

@_cdecl("getKeys")
public func getKeys(result: UnsafePointer<CChar>?) ->  UnsafeMutablePointer<Int8> {
    let str = getSavedKey()
    let unsafePointer = UnsafeMutablePointer<Int8>(mutating: (str as NSString).utf8String)
    return unsafePointer.unsafelyUnwrapped
}

@_cdecl("saveKeys")
public func saveKeys(keys: UnsafeMutablePointer<Int8>?) {
    let key = String(cString: keys!)
    let addquery = [   kSecClass as String: kSecClassGenericPassword,
                       kSecAttrService as String: "sideos-key",
                       kSecAttrAccount as String: "sideos",
                       kSecValueData: Data(key.utf8)] as CFDictionary
    let status = SecItemAdd(addquery as CFDictionary, nil)
    guard status == errSecSuccess else {
        return
    }
}

struct CodeMsg: Decodable, Encodable {
    var code: Int64
    var message: String
}

struct SideosError: Decodable, Encodable {
    var error: Bool
    var message: Any
    
    enum CodingKeys: String, CodingKey {
        case error, message
     }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let CodeMsg = message as? CodeMsg {
          try container.encode(CodeMsg, forKey: .message)
        }
        if let messageString = message as? String {
          try container.encode(messageString, forKey: .message)
        }
    }
    
    init(from decoder: Decoder) throws {
          let values = try decoder.container(keyedBy: CodingKeys.self)
        
          error = try values.decode(Bool.self, forKey: .error)
            
        
          do {
            let msg = try values.decode(CodeMsg.self, forKey: .message) as CodeMsg
            message = msg.message
            
          } catch {
              do {
                  let pop = try values.decode([String:String].self, forKey: .message) as [String: String]
                  message = pop
              }
              catch {
                  do {
                      let bol = try values.decode(Bool.self, forKey: .message) as Bool
                      message = bol
                  }
                  catch {
                      let msg = try values.decode(String.self, forKey: .message) as String
                      message = msg
                  }
                  
              }
          }
        }
}


public class SideosSdk {
    
    public init() {}
    
    public func getFilePath() -> String {
        let fileURL = try! FileManager.default
           .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
           .appendingPathComponent("ssidb.sqlite")
        return fileURL.absoluteString
    }

    public func startKYC(authToken: String, view:UIViewController) -> String {
        let idenfyUISettingsV2 = IdenfyUIBuilderV2()
                    .build()

        let idenfySettingsV2 = IdenfyBuilderV2()
            .withAuthToken(authToken)
            .withUISettingsV2(idenfyUISettingsV2)
            .build()

        let idenfyController = IdenfyController.shared
        idenfyController.initializeIdenfySDKV2WithManual(idenfySettingsV2: idenfySettingsV2)
        let idenfyVC = idenfyController.instantiateNavigationController()

        view.present(idenfyVC, animated: true, completion: nil)
        return ""
    }
    
    public func getLocalDID() -> String {
        let res = rust_getLocalDid(getFilePath())
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
    public func createLocalDID(version: String) -> String {
        let res = rust_createLocalDid(version, getFilePath())
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
    public func getVerifiableCredentials() -> String {
        let res = rust_getVerifiableCredentials(getFilePath())
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
    public func deleteVerifiableCredential(id: String) -> String {
        let res = rust_deleteVerifiableCredential(id, getFilePath())
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
    public func verifyVC(vc: String, signature: String) -> String {
        let res = rust_verifyVC(vc, signature)
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
    public func parseVC(vc: String) -> String {
        let res = rust_parseVC(vc)
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
    public func signVC(vc: String) -> String {
        let res = rust_signVC(vc, getFilePath())
        let swift_result = getRustString(result: res)
        return swift_result
    }

    public func parseJWT(jwt: String) -> String {
        let res = rust_parseJWT(jwt)
        let swift_result = getRustString(result: res)
        return swift_result
    }
   
    public func saveVerifiableCredential(vc: String, type: String) -> String {
        let res = rust_saveVerifiableCredential(vc, type, getFilePath())
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
    public func signAcceptanceJWT(vc: String, destinationDid: String) -> String {
        let res = rust_signAcceptanceJWT(vc, destinationDid, getFilePath())
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
    public func signSharedJWT(vc: String, destinationDid: String) -> String {
        let res = rust_signSharedJWT(vc, destinationDid, getFilePath())
        let swift_result = getRustString(result: res)
        return swift_result
    }

    public func respondToServer(url: String, payload: String) -> String {
        let res = rust_respondToServer(url, payload)
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
    public func cryptDataExt(key: String, data: String) -> String {
        let res = rust_CryptDataExt(key, data)
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
    public func decryptDataExt(key: String, data: String) -> String {
        let res = rust_DecryptDataExt(key, data)
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
    public func deriveSharedKey(key: String, pkey: String) -> String {
        let res = rust_DeriveSharedKey(key, pkey)
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
    public func createSharedKeyPair() -> String {
        let res = rust_createSharedKeyPair()
        let swift_result = getRustString(result: res)
        return swift_result
    }
    
}

