import Foundation

struct Balance: Codable {
    var balanceList : [BalanceItem]?

//    enum CodingKeys: String, CodingKey {
//        case balanceList = "balance_list"
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        balanceList = try values.decodeIfPresent([BalanceItem].self, forKey: .balanceList)
//    }

}

struct BalanceItem: Codable {
    let id: String?
    let title: String?
    let price: String?
    let totalItemPrice: String?
    let totalItemPriceAsDollars: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case price = "price"
        case totalItemPrice = "total_item_price"
        case totalItemPriceAsDollars = "total_item_price_as_dollars"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        totalItemPrice = try values.decodeIfPresent(String.self, forKey: .totalItemPrice)
        totalItemPriceAsDollars = try values.decodeIfPresent(String.self, forKey: .totalItemPriceAsDollars)
    }

    init(id: String, title: String, price: String, totalItemPrice: String, totalItemPriceAsDollars: String) {
        self.id = id
        self.title = title
        self.price = price
        self.totalItemPrice = totalItemPrice
        self.totalItemPriceAsDollars = totalItemPriceAsDollars
    }
}
