<Cabbage>
form caption("FM Pluck Bass") size(500, 380), guiMode("queue"), pluginId("fmpb")
keyboard bounds(10, 10, 480, 80)

groupbox bounds(10, 100, 230, 120), text("Synth"), plant("synth") {
rslider bounds(10, 30, 60, 60), channel("modIndex"), range(0, 16, 8, 1, 0.1), text("Mod Index"), textColour(200, 200, 200)
rslider bounds(75, 30, 60, 60), channel("modRatio"), range(0.5, 4, 2.01, 1, 0.01), text("Mod Ratio"), textColour(200, 200, 200)
rslider bounds(140, 30, 60, 60), channel("filterMult"), range(1, 12, 6, 1, 0.1), text("Brightness"), textColour(200, 200, 200)
}

groupbox bounds(250, 100, 240, 120), text("Echo"), plant("echo") {
rslider bounds(10, 30, 60, 60), channel("echoSend"), range(0, 1, 0.4, 1, 0.01), text("FX Send"), textColour(200, 200, 200)
rslider bounds(75, 30, 60, 60), channel("delTimeL"), range(50, 800, 280, 1, 1), text("Time L (ms)"), textColour(200, 200, 200)
rslider bounds(140, 30, 60, 60), channel("delTimeR"), range(50, 800, 420, 1, 1), text("Time R (ms)"), textColour(200, 200, 200)
}

groupbox bounds(10, 230, 230, 120), text("Envelope"), plant("env") {
rslider bounds(10, 30, 60, 60), channel("attack"), range(0.0001, 0.01, 0.001, 1, 0.0001), text("Attack"), textColour(200, 200, 200)
rslider bounds(75, 30, 60, 60), channel("decay"), range(0.05, 1, 0.2, 1, 0.01), text("Decay"), textColour(200, 200, 200)
rslider bounds(140, 30, 60, 60), channel("sustain"), range(0, 1, 0, 1, 0.01), text("Sustain"), textColour(200, 200, 200)
}

groupbox bounds(250, 230, 240, 120), text("Feedback"), plant("fb") {
rslider bounds(10, 30, 60, 60), channel("feedbackL"), range(0, 0.8, 0.38, 1, 0.01), text("FB L"), textColour(200, 200, 200)
rslider bounds(75, 30, 60, 60), channel("feedbackR"), range(0, 0.8, 0.4, 1, 0.01), text("FB R"), textColour(200, 200, 200)
rslider bounds(140, 30, 60, 60), channel("dryWet"), range(0, 1, 0.6, 1, 0.01), text("Dry/Wet"), textColour(200, 200, 200)
}

label bounds(10, 355, 480, 20), text("FM Pluck Bass - Use MIDI keyboard or on-screen keys"), fontColour(150, 150, 150)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

massign 0, 1

gaEcho init 0

instr 1
iFreq = p4
iVel = p5

kModIndex chnget "modIndex"
kModIndex port kModIndex, 0.05
kModRatio chnget "modRatio"
kModRatio port kModRatio, 0.05
kFilterMult chnget "filterMult"
kFilterMult port kFilterMult, 0.05
kEchoSend chnget "echoSend"
kEchoSend port kEchoSend, 0.05
iAttack chnget "attack"
iDecay chnget "decay"
iSustain chnget "sustain"

iAmp = 0.6 * iVel

kCarEnv = linsegr(0, iAttack, 1, iDecay, iSustain, 0.1, 0)
kModEnv = expsegr(1, iAttack*0.5, 0.3, iDecay*0.4, 0.01, 0.1, 0.0001)
kModIdx = kModEnv * kModIndex
aFM = foscili(kCarEnv * iAmp, iFreq, 1, kModRatio, kModIdx, 1)
aFat = butterlp(aFM, iFreq*kFilterMult)

gaEcho += aFat * kEchoSend
out aFat, aFat
endin

instr 99
kDelTimeL chnget "delTimeL"
kDelTimeL port kDelTimeL, 0.05
kDelTimeR chnget "delTimeR"
kDelTimeR port kDelTimeR, 0.05
kFeedbackL chnget "feedbackL"
kFeedbackL port kFeedbackL, 0.05
kFeedbackR chnget "feedbackR"
kFeedbackR port kFeedbackR, 0.05
kDryWet chnget "dryWet"
kDryWet port kDryWet, 0.05

aDelL = vdelay3(gaEcho, kDelTimeL, 1000)
aDelR = vdelay3(gaEcho, kDelTimeR, 1000)
aFbL = vdelay3(aDelR*kFeedbackL, kDelTimeL, 1000)
aFbR = vdelay3(aDelL*kFeedbackR, kDelTimeR, 1000)
aEchoL = gaEcho*(1-kDryWet) + (aDelL + aFbL)*kDryWet
aEchoR = gaEcho*(1-kDryWet) + (aDelR + aFbR)*kDryWet
out aEchoL, aEchoR
clear gaEcho
endin

</CsInstruments>
<CsScore>
f 1 0 16384 10 1
i 99 0 3600

e
</CsScore>
</CsoundSynthesizer>
