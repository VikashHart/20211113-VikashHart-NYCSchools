import UIKit

protocol BoroCellModeling {
    var image: UIImage { get }
    var boroTitle: String { get }
    var boroCode: EndpointBuilder.Boro { get }
}

class BoroCellViewModel: BoroCellModeling {
    var image: UIImage

    var boroTitle: String

    var boroCode: EndpointBuilder.Boro

    init(boro: BoroData) {
        self.image = boro.boroImage
        self.boroTitle = boro.boroName
        self.boroCode = boro.boroCode
    }
}
