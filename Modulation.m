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
s1 = 2 * ( modulated .* c1' )
s2 = 2 * ( modulated .* c2' )
s3 = 2 * ( modulated .* c3' )

# Low Pass Filer
[b,a] = butter(10,fc1/(fs/2))
filtered1 = filter(b,a,s1)

[b,a] = butter(10,fc2/(fs/2))
filtered2 = filter(b,a,s2)

[b,a] = butter(10,fc2/(fs/2)) 
filtered3 = filter(b,a,s3)

# Plot Original and Recieved
subplot(3, 2, 1)
plot( t,m1 )
title('Signal M1 Before Modulation')
subplot(3, 2, 2)
plot( t,filtered1 )
title('Signal M1 After Modulation')
subplot(3, 2, 3)
plot( t,m2 )
title('Signal M2 Before Modulation')
subplot(3, 2, 4)
plot( t,filtered2 )
title('Signal M2 After Modulation')
subplot(3, 2, 5)
plot( t,m3 )
title('Signal M3 Before Modulation')
subplot(3, 2, 6)
plot( t,filtered3 )
title('Signal M3 After Modulation')

# Play to see difference in sound
sound(m1)
sound(filtered1)
sound(m2)
sound(filtered2)
sound(m3)
sound(filtered3)

# 3 )












