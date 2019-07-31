##function I = cwb2020(filename,delimiter,ignore_row,ns_column,ew_column,ud_column,sample_rate)
clear all; close all; clc;
data = dlmread("fdata.txt");
ns = data(:,3);
ew = data(:,4);
ud = data(:,2);
fs = 200;

pkg load signal
##data = dlmread(filename,delimiter,ignore_row,0);
##ns = data(:,ns_column);
##ew = data(:,ew_column);
##ud = data(:,ud_column);
##fs = sample_rate;
num = size(ns,1);
n = [0:(num-1)]';
t = n / fs;
[b,a] = butter(12,10/(fs/2),"low");
ns = filter(b,a,ns);
ew = filter(b,a,ew);
ud = filter(b,a,ud);
a = sqrt(ns.^2 + ew.^2 + ud.^2);
pga = max(a);
i = 2.00 * log10(pga) + 0.70
if (i >= 4.5)
  ns_v = cumtrapz(t,ns);
  ew_v = cumtrapz(t,ew);
  ud_v = cumtrapz(t,ud);
  v = sqrt(ns_v.^2 + ew_v.^2 + ud_v.^2);
  pgv = max(v);
  i_v = 2.14 * log10(pgv) + 1.89
  ##return;
endif
##I = round(i)
##endfunction