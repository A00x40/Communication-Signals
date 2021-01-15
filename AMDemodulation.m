function Filtered = AMDemodulation(y , c , fc , f)
  # Demodulation
  s = 2 * ( y .* c' )
  # Low Pass Filer
  [b,a] = butter(10,fc/(f/2))
  Filtered = filter(b,a,s)
 endfunction 