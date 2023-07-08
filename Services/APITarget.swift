import Moya
import Foundation

enum APITarget {
    case getCharacters
}

extension APITarget: TargetType {

    var baseURL: URL {
        guard let url = URL(string: "https://rickandmortyapi.com/api") else {
            fatalError("Cannot access URL")
        }
        return url
    }

    var path: String {
        switch self {
        case .getCharacters:
            return "character"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Moya.Task {
        .requestParameters(parameters: [
            "name": "morty",
            "genger": "female",
        ], encoding: URLEncoding.default)
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
