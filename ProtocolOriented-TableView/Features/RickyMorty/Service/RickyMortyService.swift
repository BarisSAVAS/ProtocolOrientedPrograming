//
//  RickyMortyService.swift
//  ProtocolOriented-TableView
//
//  Created by Barış Savaş on 11.05.2023.
//

import Foundation
import Alamofire

enum RickyMortyEndPoint: String {
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}
protocol IRickyMorty {
    func fetcAllDatas(response: @escaping ([Result]?) -> Void )
}
struct RickyMortyService: IRickyMorty {
    func fetcAllDatas(response: @escaping ([Result]?) -> Void) {
        AF.request(RickyMortyEndPoint.characterPath()).responseDecodable(of: PostModel.self) { (model) in
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.results)
        }
    }
}
