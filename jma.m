% Copyright (c) 2019 chemars
% License: MIT License
% The code is modified from https://tinyurl.com/yxhdj5nc
%
% Calculate the JMA instrumental seismic intensity
% https://github.com/chemars/Seismic-Intensity-Scales
function II = jma(filename,delimiter,ignore_row,ns_column,ew_column,ud_column,sample_rate)
data = dlmread(filename,delimiter,ignore_row,0);
ns = data(:,ns_column)';
ew = data(:,ew_column)';
ud = data(:,ud_column)';
fs = sample_rate;
num = size(ns,2);
n = 0:(num-1);
f =  n / (num/fs) + 0.00000001;
spec_ns = fft(ns);
spec_ew = fft(ew);
spec_ud = fft(ud);
winX = sqrt(1./f);
y = f./10;
winY = 1./sqrt(ones(1,num) + 0.694*y.^2 + 0.241*y.^4 + 0.0557*y.^6 + 0.009664*y.^8 + 0.00134*y.^10 + 0.000155*y.^12);
winZ = sqrt(ones(1,num) - exp(-(f./0.5).^3));
win1 = winX.*winY.*winZ;
win2 = fliplr(winX).*fliplr(winY).*fliplr(winZ);
if mod(num,2) == 0
  win = [win1(1:(num/2)),win2((num/2+1):num)];
else
  nn = floor(num/2);
  win = [win1(1:nn),win1(nn+1),win2(nn+2:num)];
endif
spec_ns = win.*spec_ns;
spec_ew = win.*spec_ew;
spec_ud = win.*spec_ud;
res_ns = ifft(spec_ns);
res_ew = ifft(spec_ew);
res_ud = ifft(spec_ud);
a0 = abs(sqrt(res_ns.^2 + res_ew.^2 + res_ud.^2));
a1 = sort(a0,"descend");
a2 = a1(floor(0.3*fs)+1);
ii = 2 * log10(a2) + 0.94;
II = floor(10*(ii+0.005)) / 10;
endfunction