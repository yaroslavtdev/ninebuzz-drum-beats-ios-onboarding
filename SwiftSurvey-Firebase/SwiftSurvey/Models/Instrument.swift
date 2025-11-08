public enum OnboardingInstrument: String, CaseIterable {
    case guitar = "guitar"
    case bassGuitar = "bass_guitar"
    case drums = "drums"
    case pianoKeyboard = "piano_keyboard"
    case ukulele = "ukulele"
    case trumpet = "trumpet"
    case saxophone = "saxophone"
    case trombone = "trombone"
    case violin = "violin"
    case banjo = "banjo"
    case accordion = "accordion"
    case bassoon = "bassoon"
    case brass = "brass"
    case cello = "cello"
    case clarinet = "clarinet"
    case doubleBass = "double_bass"
    case fiddle = "fiddle"
    case flute = "flute"
    case harmonica = "harmonica"
    case horn = "horn"
    case mandolin = "mandolin"
    case organ = "organ"
    case pedalSteelGuitar = "pedal_steel_guitar"
    case percussion = "percussion"
    case tuba = "tuba"
    case vibraphone = "vibraphone"
    case viola = "viola"
    case voiceSinger = "voice_singer"
    case other = "other"

    private var subject: String {
        switch self {
        case .guitar: return "Guitarists"
        case .bassGuitar: return "Bass players"
        case .drums: return "Drummers"
        case .pianoKeyboard: return "Pianists"
        case .ukulele: return "Ukulele players"
        case .trumpet: return "Trumpet players"
        case .saxophone: return "Sax players"
        case .trombone: return "Trombone players"
        case .violin: return "Violinists"
        case .banjo: return "Banjo players"
        case .accordion: return "Accordion players"
        case .bassoon: return "Bassoon players"
        case .brass: return "Brass players"
        case .cello: return "Cellists"
        case .clarinet: return "Clarinet players"
        case .doubleBass: return "Double bass players"
        case .fiddle: return "Fiddle players"
        case .flute: return "Flutists"
        case .harmonica: return "Harmonica players"
        case .horn: return "Horn players"
        case .mandolin: return "Mandolin players"
        case .organ: return "Organists"
        case .pedalSteelGuitar: return "Pedal steel guitar players"
        case .percussion: return "Percussionists"
        case .tuba: return "Tuba players"
        case .vibraphone: return "Vibraphonists"
        case .viola: return "Viola players"
        case .voiceSinger: return "Singers"
        case .other: return "Musicians"
        }
    }

    var headlineInfo: String {
        return subject + " love Drum Beats+!"
    }

    var messageInfo: String {
        switch self {
        case .guitar:
            return "\"I’m a guitar teacher, and I recommend this app as a supplement to your practice. I tell all my students to use it.\""
        case .bassGuitar:
            return "\"This has been part of my bass practicing routine for years. Every warmup. Every time. I highly recommend it.\""
        case .drums:
            return "\"I've been teaching drums for over 40 years and have been playing for over 60 years...This is one of the best drum machine apps out there.\""
        case .pianoKeyboard:
            return "\"I use this app with my piano students. They love feeling like they are playing with a band and it works just like a metronome. My students' rhythm is improving and they are having fun! I use it with kids AND adults.\""
        case .ukulele:
            return "\"I'm a ukulele instructor. Drum Beats+ is an incredibly helpful tool for students to learn & integrate their chord progressions & apply rhythm pockets. Very useful.\""
        case .trumpet:
            return "\"I am a teacher and musician. I use it with my students every day in place of the boring metronome. I have tried many other apps and this one is hands down my favorite!\""
        case .saxophone:
            return "\"My sax teacher uses Drum Beats+ for me for all my exercises!\""
        case .trombone:
            return "\"I use this app when studying a chart in working out rhythms and tricky parts without my horn as well as playing.\""
        case .violin:
            return "\"I use it with my students every day in place of the boring metronome. I have tried many other apps and this one is hands down my favorite!\""
        case .banjo:
            return "\"Truly a just install and use app. I practice banjo, guitar, & mandolin with it. No break the flow programming. Use it almost daily.\""
        case .accordion, .bassoon, .brass, .cello, .clarinet, .doubleBass, .fiddle, .flute, .harmonica, .horn, .mandolin, .pedalSteelGuitar, .percussion, .tuba, .vibraphone, .viola, .voiceSinger, .other:
            return "\"I use it with my students every day in place of the boring metronome. I have tried many other apps and this one is hands down my favorite!\""
        case .organ:
            return "\"I use this app with my piano students. They love feeling like they are playing with a band and it works just like a metronome. My students' rhythm is improving and they are having fun! I use it with kids AND adults.\""
        }
    }

    var messageAuthor: String {
        switch self {
        case .guitar:
            return "Kenneth P."
        case .bassGuitar:
            return "Harlem B."
        case .drums:
            return "Jerry E."
        case .pianoKeyboard, .organ:
            return "Sarah S."
        case .ukulele:
            return "Pete H."
        case .trumpet:
            return "Kenneth P."
        case .saxophone:
            return "Melissa P."
        case .trombone, .violin, .banjo, .accordion, .bassoon, .brass, .cello, .clarinet, .doubleBass, .fiddle, .flute, .harmonica, .horn, .mandolin, .pedalSteelGuitar, .percussion, .tuba, .vibraphone, .viola, .voiceSinger, .other:
            return "Jeff C."
        }
    }

    var imageNameInfo: String {
        switch self {
        case .guitar:
            return "guitar"
        case .bassGuitar:
            return "bass guitar"
        case .drums:
            return "drums"
        case .pianoKeyboard:
            return "piano keyboard"
        case .ukulele:
            return "ukulele"
        case .trumpet:
            return "trumpet"
        case .saxophone:
            return "saxophone"
        case .trombone:
            return "trombone"
        case .violin:
            return "violin"
        case .banjo:
            return "banjo"
        case .accordion:
            return "accordion"
        case .bassoon:
            return "bassoon"
        case .brass:
            return "brass"
        case .cello:
            return "cello"
        case .clarinet:
            return "clarinet"
        case .doubleBass:
            return "double bass"
        case .fiddle:
            return "fiddle"
        case .flute:
            return "flute"
        case .harmonica:
            return "harmonica"
        case .horn:
            return "horn"
        case .mandolin:
            return "mandolin"
        case .organ:
            return "organ"
        case .pedalSteelGuitar:
            return "pedal steel guitar"
        case .percussion:
            return "percussion"
        case .tuba:
            return "tuba"
        case .vibraphone:
            return "vibraphone"
        case .viola:
            return "viola"
        case .voiceSinger:
            return "voice singer"
        case .other:
            return "other"
        }
    }

    var timingImageName: String {
        switch self {
        case .guitar:
            return "guitar timing"
        case .bassGuitar:
            return "bass guitar timing"
        case .drums:
            return "drums timing"
        case .pianoKeyboard:
            return "piano keyboard timing"
        case .ukulele:
            return "ukulele timing"
        case .trumpet:
            return "trumpet timing"
        case .saxophone:
            return "saxophone timing"
        case .trombone:
            return "trombone timing"
        case .violin:
            return "violin timing"
        case .banjo:
            return "banjo timing"
        case .accordion:
            return "accordion timing"
        case .bassoon:
            return "bassoon timing"
        case .brass:
            return "brass timing"
        case .cello:
            return "cello timing"
        case .clarinet:
            return "clarinet timing"
        case .doubleBass:
            return "double bass timing"
        case .fiddle:
            return "fiddle timing"
        case .flute:
            return "flute timing"
        case .harmonica:
            return "harmonica timing"
        case .horn:
            return "horn timing"
        case .mandolin:
            return "mandolin timing"
        case .organ:
            return "organ timing"
        case .pedalSteelGuitar:
            return "pedal steel guitar timing"
        case .percussion:
            return "percussion timing"
        case .tuba:
            return "tuba timing"
        case .vibraphone:
            return "vibraphone timing"
        case .viola:
            return "viola timing"
        case .voiceSinger:
            return "voice singer timing"
        case .other:
            return "other timing"
        }
    }

    var confidenceImageName: String {
        switch self {
        case .guitar:
            return "guitar confidence"
        case .bassGuitar:
            return "bass guitar confidence"
        case .drums:
            return "drums confidence"
        case .pianoKeyboard:
            return "piano keyboard confidence"
        case .ukulele:
            return "ukulele confidence"
        case .trumpet:
            return "trumpet confidence"
        case .saxophone:
            return "saxophone confidence"
        case .trombone:
            return "trombone confidence"
        case .violin:
            return "violin confidence"
        case .banjo:
            return "banjo confidence"
        case .accordion:
            return "accordion confidence"
        case .bassoon:
            return "bassoon confidence"
        case .brass:
            return "brass confidence"
        case .cello:
            return "cello confidence"
        case .clarinet:
            return "clarinet confidence"
        case .doubleBass:
            return "double bass confidence"
        case .fiddle:
            return "fiddle confidence"
        case .flute:
            return "flute confidence"
        case .harmonica:
            return "harmonica confidence"
        case .horn:
            return "horn confidence"
        case .mandolin:
            return "mandolin confidence"
        case .organ:
            return "organ confidence"
        case .pedalSteelGuitar:
            return "pedal steel guitar confidence"
        case .percussion:
            return "percussion confidence"
        case .tuba:
            return "tuba confidence"
        case .vibraphone:
            return "vibraphone confidence"
        case .viola:
            return "viola confidence"
        case .voiceSinger:
            return "voice singer confidence"
        case .other:
            return "other confidence"
        }
    }

    var motivatedImageName: String {
        switch self {
        case .guitar:
            return "guitar motivated"
        case .bassGuitar:
            return "bass guitar motivated"
        case .drums:
            return "drums motivated"
        case .pianoKeyboard:
            return "piano keyboard motivated"
        case .ukulele:
            return "ukulele motivated"
        case .trumpet:
            return "trumpet motivated"
        case .saxophone:
            return "saxophone motivated"
        case .trombone:
            return "trombone motivated"
        case .violin:
            return "violin motivated"
        case .banjo:
            return "banjo motivated"
        case .accordion:
            return "accordion motivated"
        case .bassoon:
            return "bassoon motivated"
        case .brass:
            return "brass motivated"
        case .cello:
            return "cello motivated"
        case .clarinet:
            return "clarinet motivated"
        case .doubleBass:
            return "double bass motivated"
        case .fiddle:
            return "fiddle motivated"
        case .flute:
            return "flute motivated"
        case .harmonica:
            return "harmonica motivated"
        case .horn:
            return "horn motivated"
        case .mandolin:
            return "mandolin motivated"
        case .organ:
            return "organ motivated"
        case .pedalSteelGuitar:
            return "pedal steel guitar motivated"
        case .percussion:
            return "percussion motivated"
        case .tuba:
            return "tuba motivated"
        case .vibraphone:
            return "vibraphone motivated"
        case .viola:
            return "viola motivated"
        case .voiceSinger:
            return "voice singer motivated"
        case .other:
            return "other motivated"
        }
    }

    func getImageName(_ type: SpeedQuestionType, landscape: Bool) -> String {
        switch type {
        case .timing:
            return self.timingImageName + (landscape ? " landscape" : "")
        case .confidence:
            return self.confidenceImageName + (landscape ? " landscape" : "")
        case .motivated:
            return self.motivatedImageName + (landscape ? " landscape" : "")
        }
    }
}
