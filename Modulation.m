# All 3 Signals Are Sampled at 8000 and have length of 8 secs
[m1,fs] = audioread("echowav/audio1.wav")
[m2,fs] = audioread("echowav/audio2.wav")
[m3,fs] = audioread("echowav/audio3.wav")

#subplot(3, 1, 1)
#plot(m1)
#subplot(3, 1, 2)
#plot(m2)
#subplot(3, 1, 3)
#plot(m3)

t = 0 : 1/fs : fs/1000 - 1/fs
n = length(m1);

fc1 = 1500
fc2 = 2000
c1 = cos( 2*pi*fc1*t ) 
c2 = cos( 2*pi*fc2*t )
c3 = sin( 2*pi*fc2*t )

# Modulation
y1 = m1 .* c1' 
y2 = m2 .* c2'
y3 = m3 .* c3'
modulated = y1 + y2 + y3

# 1 )

y0 = fftshift( fft(modulated) );        
f0 = (-n/2:n/2-1)*(fs/n);

subplot(2, 1, 1)
plot( t , modulated )
title("Modulated Signal in Time Domain")
xlabel("Time")
ylabel("Magnitude")

subplot(2, 1, 2)
plot( f0 , abs(y0)  )
title("Modulated Signal in Frequency Domain")
xlabel("Frequency")
ylabel("Magnitude")

# 2 )

# Synchronous Demodulation
s1 = AMDemodulation( modulated , c1 , fc1 ,fs )
s2 = AMDemodulation( modulated , c2 , fc2 ,fs )
s3 = AMDemodulation( modulated , c3 , fc2 ,fs )

# Plot Original and Recieved
subplot(3, 2, 1)
plot( t,m1 )
title('Signal M1 Before Modulation')
subplot(3, 2, 2)
plot( t,s1 )
title('Signal M1 After Modulation')
subplot(3, 2, 3)
plot( t,m2 )
title('Signal M2 Before Modulation')
subplot(3, 2, 4)
plot( t,s2 )
title('Signal M2 After Modulation')
subplot(3, 2, 5)
plot( t,m3 )
title('Signal M3 Before Modulation')
subplot(3, 2, 6)
plot( t,s3 )
title('Signal M3 After Modulation')

# Play to see difference in sound
sound(m1)
sound(s1)
sound(m2)
sound(s2)
sound(m3)
sound(s3)

# 3 )

c4 = cos( 2*pi*fc1*t + 10*pi/180) 
c5 = cos( 2*pi*fc2*t + 30*pi/180)
c6 = sin( 2*pi*fc2*t + 90*pi/180)

s4 = AMDemodulation( modulated , c4 , fc1 ,fs )
s5 = AMDemodulation( modulated , c5 , fc2 ,fs )
s6 = AMDemodulation( modulated , c6 , fc2 ,fs )

# Plot Original and Recieved
subplot(3, 2, 1)
plot( t,m1 )
title('Signal M1 Before Modulation')
subplot(3, 2, 2)
plot( t,s4 )
title('Signal M1 After Modulation - Phase Shift 10')
subplot(3, 2, 3)
plot( t,m2 )
title('Signal M2 Before Modulation')
subplot(3, 2, 4)
plot( t,s5 )
title('Signal M2 After Modulation - Phase Shift 30')
subplot(3, 2, 5)
plot( t,m3 )
title('Signal M3 Before Modulation')
subplot(3, 2, 6)
plot( t,s6 )
title('Signal M3 After Modulation - Phase Shift 90')

# Play to see difference in sound
sound(m1)
sound(s4)
sound(m2)
sound(s5)
sound(m3)
sound(s6)








