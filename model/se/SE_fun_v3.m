function [S] = SE_fun_v3(M0, T1, T2, kap, TE, TR, a_ex, a_ref, dw, is_mag)    
%   Input:
%       M0      (A/m)       spin density
%       T1      (ms)        spin-lattice relaxation time
%       T2      (ms)        spin-spin relaxation time
%       kap     ()          flip angle scaling factor
%       TE      (ms)        echo time
%       TR      (ms)        repetition time
%       a_ex    (rad)       nominal excitation flip angle (usually pi/2)
%       a_ref   (rad)       nominal refocusing flip angle (usually pi)
%       dw      (kHz)       off-resonance field map
%       is_mag              toggle returning magnitude signal on/off
%   Output:
%       S       (A/m)       spin-echo signal
%
%   Written by: Gopal Nataraj, Copyright 2016
%
%   Changes from v2:
%       added variation in nominal excitation and refocusing flip
%       added an error catch for NaNs where flip angle is zero

% convert nominal flips to true flips
a_ex = kap .* a_ex;
a_ref = kap .* a_ref;

% spin-echo signal, in steady-state 
S = -exp((TE.*(-1.0./2.0))./T2).*cos(TE.*dw.*(1.0./2.0)).*(sin(a_ref).*...
    (M0.*(exp((TE.*(-1.0./2.0))./T1)-1.0)-(M0.*exp((TE.*(-1.0./2.0))./...
    T1).*exp((TE.*(1.0./2.0))./T2).*cos(a_ex).*(exp((TE.*(1.0./2.0))./...
    T1)-exp((TE.*(1.0./2.0)-TR)./T1).*cos(a_ref)-exp((TE.*(1.0./2.0))./...
    T1).*exp((TE.*(1.0./2.0)-TR)./T1)+exp((TE.*(1.0./2.0))./T1).*...
    exp((TE.*(1.0./2.0)-TR)./T1).*cos(a_ref)))./(exp((TE.*(1.0./2.0))./...
    T1).*exp((TE.*(1.0./2.0))./T2)-exp((TE.*(1.0./2.0))./T2).*exp((TE.*...
    (1.0./2.0)-TR)./T1).*cos(a_ex).*cos(a_ref)+exp((TE.*(1.0./2.0))./...
    T1).*exp((TE.*(1.0./2.0)-TR)./T1).*sin(TE.*dw.*(1.0./2.0)).*...
    sin(a_ex).*sin(a_ref)))-(M0.*sin(TE.*dw.*(1.0./2.0)).*cos(a_ref).*...
    sin(a_ex).*(exp((TE.*(1.0./2.0))./T1)-exp((TE.*(1.0./2.0)-TR)./T1).*...
    cos(a_ref)-exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./2.0)-TR)./...
    T1)+exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./2.0)-TR)./T1).*...
    cos(a_ref)))./(exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./2.0))./...
    T2)-exp((TE.*(1.0./2.0))./T2).*exp((TE.*(1.0./2.0)-TR)./T1).*...
    cos(a_ex).*cos(a_ref)+exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./...
    2.0)-TR)./T1).*sin(TE.*dw.*(1.0./2.0)).*sin(a_ex).*sin(a_ref)))+...
    exp((TE.*(-1.0./2.0))./T2).*sin(TE.*dw.*(1.0./2.0)).*(sin(a_ref).*...
    (M0.*(exp((TE.*(-1.0./2.0))./T1)-1.0)-(M0.*exp((TE.*(-1.0./2.0))./...
    T1).*exp((TE.*(1.0./2.0))./T2).*cos(a_ex).*(exp((TE.*(1.0./2.0))./...
    T1)-exp((TE.*(1.0./2.0)-TR)./T1).*cos(a_ref)-exp((TE.*(1.0./2.0))./...
    T1).*exp((TE.*(1.0./2.0)-TR)./T1)+exp((TE.*(1.0./2.0))./T1).*...
    exp((TE.*(1.0./2.0)-TR)./T1).*cos(a_ref)))./(exp((TE.*(1.0./2.0))./...
    T1).*exp((TE.*(1.0./2.0))./T2)-exp((TE.*(1.0./2.0))./T2).*exp((TE.*...
    (1.0./2.0)-TR)./T1).*cos(a_ex).*cos(a_ref)+exp((TE.*(1.0./2.0))./...
    T1).*exp((TE.*(1.0./2.0)-TR)./T1).*sin(TE.*dw.*(1.0./2.0)).*...
    sin(a_ex).*sin(a_ref)))-(M0.*sin(TE.*dw.*(1.0./2.0)).*cos(a_ref).*...
    sin(a_ex).*(exp((TE.*(1.0./2.0))./T1)-exp((TE.*(1.0./2.0)-TR)./T1).*...
    cos(a_ref)-exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./2.0)-TR)./T1)+...
    exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./2.0)-TR)./T1).*...
    cos(a_ref)))./(exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./2.0))./...
    T2)-exp((TE.*(1.0./2.0))./T2).*exp((TE.*(1.0./2.0)-TR)./T1).*...
    cos(a_ex).*cos(a_ref)+exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./...
    2.0)-TR)./T1).*sin(TE.*dw.*(1.0./2.0)).*sin(a_ex).*sin(a_ref))).*...
    1i+(M0.*exp((TE.*(-1.0./2.0))./T2).*cos(TE.*dw.*(1.0./2.0)).^2.*...
    sin(a_ex).*(exp((TE.*(1.0./2.0))./T1)-exp((TE.*(1.0./2.0)-TR)./...
    T1).*cos(a_ref)-exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./2.0)-TR)./...
    T1)+exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./2.0)-TR)./T1).*...
    cos(a_ref)).*1i)./(exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./2.0))./...
    T2)-exp((TE.*(1.0./2.0))./T2).*exp((TE.*(1.0./2.0)-TR)./T1).*...
    cos(a_ex).*cos(a_ref)+exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./...
    2.0)-TR)./T1).*sin(TE.*dw.*(1.0./2.0)).*sin(a_ex).*sin(a_ref))+...
    (M0.*exp((TE.*(-1.0./2.0))./T2).*cos(TE.*dw.*(1.0./2.0)).*sin(TE.*...
    dw.*(1.0./2.0)).*sin(a_ex).*(exp((TE.*(1.0./2.0))./T1)-exp((TE.*...
    (1.0./2.0)-TR)./T1).*cos(a_ref)-exp((TE.*(1.0./2.0))./T1).*exp((TE.*...
    (1.0./2.0)-TR)./T1)+exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./2.0)-...
    TR)./T1).*cos(a_ref)))./(exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./...
    2.0))./T2)-exp((TE.*(1.0./2.0))./T2).*exp((TE.*(1.0./2.0)-TR)./T1).*...
    cos(a_ex).*cos(a_ref)+exp((TE.*(1.0./2.0))./T1).*exp((TE.*(1.0./...
    2.0)-TR)./T1).*sin(TE.*dw.*(1.0./2.0)).*sin(a_ex).*sin(a_ref));

% error catch: set any NaN values to zero
S(isnan(S)) = 0;

% optional: return magnitude signal only
if (is_mag)
    S = abs(S);
end
end