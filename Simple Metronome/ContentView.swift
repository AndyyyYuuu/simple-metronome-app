//
//  ContentView.swift
//  Simple Metronome
//
//  Created by Andy Yu on 2023-06-11.
//

import SwiftUI
import AVFoundation
import AudioToolbox



struct ContentView: View {
    @State var player: AVAudioPlayer?
    @State var tickPlayer: AVAudioPlayer?
    @State private var bpm = 124.0;
    @State private var metronomeState = false;
    @State var ticker = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect();
    @State var isOn = false;
    
    func playTick() {
        player?.prepareToPlay();
        guard let path = Bundle.main.path(forResource: "tick/tick", ofType: "mp3", inDirectory: "tick.dataset") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getBpmColor() -> Color{
        return Color(hue:(1.65-bpm/340).truncatingRemainder(dividingBy: 1), saturation: 1, brightness:1)
    }
    var body: some View {
        ZStack{
            Color(red:0.25, green:0.25, blue:0.25).ignoresSafeArea()
            VStack {
                Image(systemName:"metronome.fill").foregroundColor(getBpmColor()).font(Font.system(size:96)).rotation3DEffect(.degrees(metronomeState ? 180 : 0), axis: (x: 0, y: 1, z: 0)).onReceive(ticker){_ in
                    //tickPlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "tick", withExtension: "mp3") ?? 0 );
                    if (isOn){
                        AudioServicesPlaySystemSound(1104);
                        metronomeState.toggle();
                        ticker.upstream.connect().cancel();
                        ticker = Timer.publish(every: 60/bpm, on: .main, in: .common).autoconnect();
                    }
                }
                HStack{
                    Slider(value: $bpm,
                           in: 32...240)
                    .accentColor(getBpmColor())
                    
                    Circle()
                        .stroke(lineWidth:0)
                        .background(Circle().foregroundColor(getBpmColor()))
                        .frame(width: 50, height: 50)
                        .overlay(Image(systemName:isOn ? "pause.fill":"play.fill").foregroundColor(Color(red:0.25, green:0.25, blue:0.25)))
                            .font(Font.system(size:32))
                        .onTapGesture {
                            isOn.toggle();
                         }
                }
                HStack (alignment: .bottom){
                    Text(String(Int(round(bpm/4)*4))).foregroundColor(getBpmColor()).font(.system(size: 48))
                    Text("bpm").foregroundColor(getBpmColor()).font(.system(size: 24))
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
