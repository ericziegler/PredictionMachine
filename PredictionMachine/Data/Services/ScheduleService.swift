//
//  ScheduleService.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/9/22.
//

import Foundation

final class ScheduleService {
 
    func loadSchedule() throws -> Schedule {
        guard let jsonData = try readLocalJSONFile(forName: "schedule") else {
            throw AppError.scheduleLoad
        }
        
        guard let schedule = try parse(jsonData: jsonData) else {
            throw AppError.scheduleLoad
        }
        
        return schedule
    }
    
    private func readLocalJSONFile(forName name: String) throws -> Data? {
        guard let filePath = Bundle.main.path(forResource: name, ofType: "json") else {
            return nil
        }
        	
        let fileUrl = URL(fileURLWithPath: filePath)
        let data = try Data(contentsOf: fileUrl)
        return data
    }
    
    private func parse(jsonData: Data) throws -> Schedule? {
        do {
            let decodedSchedule = try JSONDecoder().decode(Schedule.self, from: jsonData)
            return decodedSchedule
        } catch {
            print(error)
            throw error
        }
    }
    
}
