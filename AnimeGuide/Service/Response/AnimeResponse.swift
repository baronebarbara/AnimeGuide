import Foundation

struct AnimeResponse: Decodable {
    let pagination: Pagination?
    let data: [Anime]
    
    struct Pagination: Decodable {
        let hasNextPage: Bool?
        let currentPage: Int?
    }
    
    struct Anime: Decodable {
        let malId: Int?
        let title: String?
        let score: Double?
        let synopsis: String?
        let images: Images?
        let genres: [Genre]
        let aired: Aired
        
        struct Images: Decodable {
            let jpg: JpgImages?
            
            struct JpgImages: Decodable {
                let imageUrl: String?
                
                enum CodingKeys: String, CodingKey {
                    case imageUrl = "image_url"
                }
            }
        }
        
        struct Genre: Decodable {
            let name: String?
        }
        
        struct Aired: Decodable {
            let from: String?
        }
        
        enum CodingKeys: String, CodingKey {
            case malId = "mal_id"
            case title
            case score
            case synopsis
            case images
            case genres
            case aired
        }
    }
}
