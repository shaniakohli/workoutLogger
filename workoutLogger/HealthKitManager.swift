//
//  HealthKitManager.swift
//  workoutLogger
//
//  Created by Shania Kohli on 7/28/24.
//

import Foundation
import HealthKit

class HealthKitManager {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()

    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let typesToShare: Set<HKSampleType> = []
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.workoutType(),
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead, completion: completion)
    }
    
    func fetchWorkouts(completion: @escaping ([HKWorkout]?, Error?) -> Void) {
        let workoutType = HKObjectType.workoutType()
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date())
        let query = HKSampleQuery(sampleType: workoutType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let workouts = samples as? [HKWorkout] else {
                completion(nil, error)
                return
            }
            completion(workouts, nil)
        }
        healthStore.execute(query)
    }
    
    func fetchSteps(completion: @escaping ([HKQuantitySample]?, Error?) -> Void) {
        let stepsType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date())
        let query = HKSampleQuery(sampleType: stepsType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let stepSamples = samples as? [HKQuantitySample] else {
                completion(nil, error)
                return
            }
            completion(stepSamples, nil)
        }
        healthStore.execute(query)
    }
    
    func fetchDistances(completion: @escaping ([HKQuantitySample]?, Error?) -> Void) {
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date())
        let query = HKSampleQuery(sampleType: distanceType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let distanceSamples = samples as? [HKQuantitySample] else {
                completion(nil, error)
                return
            }
            completion(distanceSamples, nil)
        }
        healthStore.execute(query)
    }

    func fetchHeartRates(completion: @escaping ([HKQuantitySample]?, Error?) -> Void) {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date())
        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let heartRateSamples = samples as? [HKQuantitySample] else {
                completion(nil, error)
                return
            }
            completion(heartRateSamples, nil)
        }
        healthStore.execute(query)
    }
    
    func fetchAverageHeartRate(startDate: Date, endDate: Date, completion: @escaping (Double?, Error?) -> Void) {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { (query, result, error) in
            if let average = result?.averageQuantity()?.doubleValue(for: HKUnit(from: "count/min")) {
                completion(average, nil)
            } else {
                completion(nil, error)
            }
        }
        healthStore.execute(query)
    }
}
