import UIKit

protocol BoroRetrievable {
    func getBoros() -> [BoroData]
}

struct BoroData {
    let boroName: String
    let boroImage: UIImage
    let boroCode: EndpointBuilder.Boro
}

class BoroModel: BoroRetrievable {
    let boros = [BoroData(boroName: "Brooklyn", boroImage: UIImage(named: "brooklyn")!, boroCode: .brooklyn),
                 BoroData(boroName: "Bronx", boroImage: UIImage(named: "bronx")!, boroCode: .bronx),
                 BoroData(boroName: "Manhattan", boroImage: UIImage(named: "manhattan")!, boroCode: .manhattan),
                 BoroData(boroName: "Queens", boroImage: UIImage(named: "queens")!, boroCode: .queens),
                 BoroData(boroName: "Staten Island", boroImage: UIImage(named: "statenIsland")!, boroCode: .statenIsland)]

    func getBoros() -> [BoroData] {
        return boros
    }
}
