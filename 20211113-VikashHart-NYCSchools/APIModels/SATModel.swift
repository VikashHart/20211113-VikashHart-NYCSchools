import Foundation

struct SATModel: Codable {
    let results: [SATData]
}

struct SATData: Codable {
    let schoolID: String
    let schoolName: String
    let numberOfTestTakers: String
    let readingAvgScore: String
    let mathAvgScore: String
    let writingAvgScore: String

    //Using coding keys to shorten & simplify keynames & to avoid snakecase
    enum CodingKeys: String, CodingKey {
        case schoolID = "dbn"
        case schoolName = "school_name"
        case numberOfTestTakers = "num_of_sat_test_takers"
        case readingAvgScore = "sat_critical_reading_avg_score"
        case mathAvgScore = "sat_math_avg_score"
        case writingAvgScore = "sat_writing_avg_score"
    }
}
