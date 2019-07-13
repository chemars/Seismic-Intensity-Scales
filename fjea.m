% Modified from https://tinyurl.com/yxhdj5nc
function I = fjea(filename,delimiter,ignore_row,ns_column,ew_column,ud_column,sample_rate)
data = dlmread(filename,delimiter,ignore_row,0);
ns = data(:,ns_column)';
ew = data(:,ew_column)';
ud = data(:,ud_column)';
fs = sample_rate;
num = size(ns,2);
n = 0:(num-1);
f =  n / (num/fs);
spec_ns = fft(ns);
spec_ew = fft(ew);
spec_ud = fft(ud);
f1 = (12.87 * f.^6 + 16.65 * f.^4);
f2 = (0.13 * ones(1,num) + f.^8 + 9.18 * f.^6 + 20.77 * f.^4 - 1.34 * f.^2);
ff = f1./f2 ;
win1 = ff;
win2 = fliplr(ff);
win = [win1(1:(num/2)),win2((num/2+1):num)];
spec_ns = win.*spec_ns;
spec_ew = win.*spec_ew;
spec_ud = win.*spec_ud;
res_ns=ifft(spec_ns);
res_ew=ifft(spec_ew);
res_ud=ifft(spec_ud);
a = abs(sqrt(res_ns.^2 + res_ew.^2 + res_ud.^2));
a2 = sort(a,"descend");
i = 2.71 * log10( a2(floor(0.5*fs)+1) / 100 ) + 7.81;
I = floor(i+0.5);
if (I >= 13)
  I = 12;
elseif (I <= 0)
  I = 1;
endif
endfunction