syms iRd iRq vACd vACq
syms iPVd iPVq
syms vTLLd vTLLq dvTLLddt dvTLLqdt
syms LTL CPV Vref Pref
x= [iRd iRq vACd vACq vTLLd vTLLq];
u = [iPVd iPVq];

dx(1) = (vTLLd - vACd)/LTL + iRq;
dx(2) = (vTLLq - vACq)/LTL - iRd;
dx(3) = (iPVd - iRd)/CPV + vACq;
dx(4) = (iPVq - iRq)/CPV - vACd;
dx(5) = dvTLLddt;
dx(6) = dvTLLqdt;

s1 = vACd^2 + vACq^2 - Vref^2;
s2 = (vACd*iRd + vACq*iRq) - Pref;

dsdt = jacobian([s1;s2],x)* transpose(dx);
%%
syms k1 k2 c1 c2

dsdt = dsdt+ [c1 c2]*[s1;s2];
Fin = solve(dsdt,[iPVd;iPVq]);

iPVd_eq = Fin.iPVd;%(LTL*iRd^2*vACq - LTL*iRq*iRd*vACd + CPV*vACd^2*vACq - CPV*vTLLd*vACd*vACq + CPV*vACq^3 - CPV*vTLLq*vACq^2)/(LTL*(iRd*vACq - iRq*vACd));
            iPVq_eq = Fin.iPVq;%-(LTL*iRq^2*vACd - LTL*iRd*iRq*vACq + CPV*vACd^3 - CPV*vTLLd*vACd^2 + CPV*vACd*vACq^2 - CPV*vTLLq*vACd*vACq)/(LTL*(iRd*vACq - iRq*vACd));
iPVdFin = iPVd_eq + k1;
iPVqFin = iPVq_eq + k2;

dsFinaldt = subs(dsdt,[iPVd;iPVq],[iPVdFin;iPVqFin]);