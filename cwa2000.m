% Copyright (c) 2019-2025 chemars
% License: MIT License
%
% Calculate the CWA seismic intensity (promulgated and revised on 2000-08-01)
% https://github.com/chemars/Seismic-Intensity-Scales
function II = cwa2000(filename,delimiter,ignore_row,ns_column,ew_column,ud_column)
data = dlmread(filename,delimiter,ignore_row,0);
ns = data(:,ns_column);
ew = data(:,ew_column);
ud = data(:,ud_column);
pga_ns = max(abs(ns));
pga_ew = max(abs(ew));
pga_ud = max(abs(ud));
pga = max([pga_ns pga_ew pga_ud]);
if (pga < 0.8)
  II = 0;
elseif (pga >= 0.8 && pga < 2.5)
  II = 1;
elseif (pga >= 2.5 && pga < 8.0)
  II = 2;
elseif (pga >= 8.0 && pga < 25.0)
  II = 3;
elseif (pga >= 25.0 && pga < 80.0)
  II = 4;
elseif (pga >= 80.0 && pga < 250.0)
  II = 5;
elseif (pga >= 250.0 && pga < 400.0)
  II = 6;
elseif (pga >= 400.0)
  II = 7;
endif
endfunction