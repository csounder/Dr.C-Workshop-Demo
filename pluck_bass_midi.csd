<CsoundSynthesizer>
; Prompt: fat pluck bass with sharp attack and global echo
<CsOptions>
-odac -Ma -d -m0
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

massign 0, 1

gaEcho init 0

instr 1
iFreq = cpsmidinn(notnum())
iVel = veloc:i() / 127
iAmp = 0.6 * iVel

kCarEnv = expsegr:a(1, 0.001, 1, 0.2, 0.0001)
kModEnv = expsegr:a(1, 0.0005, 0.3, 0.08, 0.01, 0.3, 0.0001)
kModIndex = kModEnv * 8
aFM = foscili:a(kCarEnv * iAmp, iFreq, 1, 2.01, kModIndex, 1)
aFat = butterlp(aFM, iFreq*6)

gaEcho += aFat * 0.4
out aFat, aFat
endin

instr 99
aDelL = vdelay3(gaEcho, 280, 1000)
aDelR = vdelay3(gaEcho, 420, 1000)
aFbL = vdelay3(aDelR*0.38, 280, 1000)
aFbR = vdelay3(aDelL*0.4, 420, 1000)
aEchoL = gaEcho*0.6 + (aDelL + aFbL)*0.6
aEchoR = gaEcho*0.6 + (aDelR + aFbR)*0.6
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
