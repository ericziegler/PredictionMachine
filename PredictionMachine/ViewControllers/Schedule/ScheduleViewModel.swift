//
//  ScheduleViewModel.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/9/22.
//

import Foundation

class ScheduleViewModel {
 
    // MARK: - Properties
    
    private let service = ScheduleService()
    private var schedule: Schedule?
    
    // MARK: - Loading
    
    func loadSchedule() throws {
        self.schedule = try service.loadSchedule()
    }
    
    // MARK: - Accessors
    
    var weekCount: Int {
        return schedule?.weeks.count ?? 0
    }
    
    func week(at index: Int) -> Week? {
        guard let schedule = self.schedule, index < schedule.weeks.count else {
            return nil
        }
        
        return schedule.weeks[index]
    }
    
}
