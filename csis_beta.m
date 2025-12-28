% Copyright (c) 2024-2025 chemars
% License: MIT License
%
% Calculate the Chinese seismic intensity scale (GB/T 17742-2020)
% Not accurate
% https://github.com/chemars/Seismic-Intensity-Scales
function II = csis(filename,delimiter,ignore_row,ns_column,ew_column,ud_column,sample_rate)
pkg load signal
data = dlmread(filename,delimiter,ignore_row,0);
ns = 0.01 * data(:,ns_column);
ew = 0.01 * data(:,ew_column);
ud = 0.01 * data(:,ud_column);
fs = sample_rate;
[b,a] = butter(4,[0.1 10]/(fs/2));
ns_f = filter(b,a,ns);
ew_f = filter(b,a,ew);
ud_f = filter(b,a,ud);
tf = sqrt(ns_f.^2 + ew_f.^2 + ud_f.^2);
pga = max(tf);

num = size(ns,1);
n = [0:(num-1)]';
t = n / fs;
ns_v = cumtrapz(t,ns);
ew_v = cumtrapz(t,ew);
ud_v = cumtrapz(t,ud);
ns_vf = filter(b,a,ns_v);
ew_vf = filter(b,a,ew_v);
ud_vf = filter(b,a,ud_v);
tvf = sqrt(ns_vf.^2 + ew_vf.^2 + ud_vf.^2);
pgv = max(tvf);

ia = 3.17 * log10(pga) + 6.59;
iv = 3.00 * log10(pgv) + 9.77;
if (ia >= 6.0 && iv >= 6.0)
  it = iv;
else
  it = (ia + iv) / 2;
endif
if (it < 1.0)
  II = 1.0;
elseif (it > 12.0)
  II = 12.0;
else
II = floor(10 * it) / 10;
endif
endfunction