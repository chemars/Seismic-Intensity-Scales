% Copyright (c) 2019-2025 chemars
% License: MIT License
%
% Calculate the new CWB seismic intensity (take effect on 2020-01-01)
% https://github.com/chemars/Seismic-Intensity-Scales
function II = cwb2020(filename,delimiter,ignore_row,ns_column,ew_column,ud_column,sample_rate)
pkg load signal
data = dlmread(filename,delimiter,ignore_row,0);
ns = data(:,ns_column);
ew = data(:,ew_column);
ud = data(:,ud_column);
fs = sample_rate;
[b,a] = butter(4,10/(fs/2),"low");
ns_f = filter(b,a,ns);
ew_f = filter(b,a,ew);
ud_f = filter(b,a,ud);
tf = sqrt(ns_f.^2 + ew_f.^2 + ud_f.^2);
pga = max(tf);
if (pga < 0.8)
  II = "0";
elseif (pga >= 0.8 && pga < 2.5)
  II = "1";
elseif (pga >= 2.5 && pga < 8.0)
  II = "2";
elseif (pga >= 8.0 && pga < 25.0)
  II = "3";
elseif (pga >= 25.0 && pga < 80.0)
  II = "4";
elseif (pga >= 80.0)
  num = size(ns,1);
  n = [0:(num-1)]';
  t = n / fs;
  ns_v = cumtrapz(t,ns);
  ew_v = cumtrapz(t,ew);
  ud_v = cumtrapz(t,ud);
  [bb,aa] = butter(4,0.075/(fs/2),"high");
  ns_vf = filter(bb,aa,ns_v);
  ew_vf = filter(bb,aa,ew_v);
  ud_vf = filter(bb,aa,ud_v);
  tvf = sqrt(ns_vf.^2 + ew_vf.^2 + ud_vf.^2);
  pgv = max(tvf);
  if (pgv < 15)
    II = "4";
  elseif (pgv >= 15 && pgv < 30)
    II = "5-";
  elseif (pgv >= 30 && pgv < 50)
    II = "5+";
  elseif (pgv >= 50 && pgv < 80)
    II = "6-";
  elseif (pgv >= 80 && pgv < 140)
    II = "6+";
  elseif (pgv >= 140)
    II = "7";
  endif
endif
endfunction