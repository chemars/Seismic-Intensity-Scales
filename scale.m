function s = scale(organization,intensity)
I = intensity;
switch organization
  case "jma"
    if (I < 0.5)
      s = "0";
    elseif (I >= 0.5 && I < 1.5)
      s = "1";
    elseif (I >= 1.5 && I < 2.5)
      s = "2";
    elseif (I >= 2.5 && I < 3.5)
      s = "3";
    elseif (I >= 3.5 && I < 4.5)
      s = "4";
    elseif (I >= 4.5 && I < 5.0)
      s = "5 Lower";
    elseif (I >= 5.0 && I < 5.5)
      s = "5 Upper";
    elseif (I >= 5.5 && I < 6.0)
      s = "6 Lower";
    elseif (I >= 6.0 && I < 6.5)
      s = "6 Upper";
    elseif (I >= 6.5)
      s = "7";
    endif
  case "cwb2020"
    s = "coming soon";
  otherwise
    s = "error";
endswitch
endfunction