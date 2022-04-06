//
//  GraphSeismometer.swift
//  Seismometer
//
//  Created by chino on 2022/04/04.
//

import SwiftUI

struct GraphSeismometer: View {
    @EnvironmentObject private var detector: MotionDetector
    @State private var data = [Double]()
    let maxData = 1000

    let graphMaxValue = 1.0
    let graphMinValue = -1.0

    var body: some View {
        VStack {
            Spacer()
            LineGraph(data: data, maxData: maxData, minValue: graphMinValue, maxValue: graphMaxValue)
                .clipped()
                .background(Color.accentColor.opacity(0.1))
                .cornerRadius(20)
                .padding()
                .aspectRatio(1, contentMode: .fit)
            
            Spacer()
            
            Text("Set your device on a flat surface to record vibrations using its motion sensors.")
                .padding()
            
            Spacer()
        }
        .onAppear {
            detector.onUpdate = {
                data.append(-detector.zAcceleration)
                if data.count > maxData {
                    data = Array(data.dropFirst())
                }
            }
        }
    }
}

struct GraphSeismometer_Previews: PreviewProvider {
    @StateObject static private var detector = MotionDetector(updateInterval: 0.01).started()

    static var previews: some View {
        GraphSeismometer()
            .environmentObject(detector)
    }
}
