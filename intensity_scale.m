function s = intensity_scale(organization,intensity)
II = intensity;
switch organization
  case "jma"
    if (II < 0.5)
      s = "0";
    elseif (II >= 0.5 && II < 1.5)
      s = "1";
    elseif (II >= 1.5 && II < 2.5)
      s = "2";
    elseif (II >= 2.5 && II < 3.5)
      s = "3";
    elseif (II >= 3.5 && II < 4.5)
      s = "4";
    elseif (II >= 4.5 && II < 5.0)
      s = "5 Lower";
    elseif (II >= 5.0 && II < 5.5)
      s = "5 Upper";
    elseif (II >= 5.5 && II < 6.0)
      s = "6 Lower";
    elseif (II >= 6.0 && II < 6.5)
      s = "6 Upper";
    elseif (II >= 6.5)
      s = "7";
    endif
  case "cwb2020"
    s = "coming soon";
  otherwise
    s = "error";
endswitch
endfunction