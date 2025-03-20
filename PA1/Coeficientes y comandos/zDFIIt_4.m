% Función que filtra la señal x utilizando un 'DFIIt' de cuarto orden. 
% 
% function y = zDFIIt4(x,neg_a,b);
%    x = entrada del filtro
%    neg_a = vector de coeficientes '-a'.
%    b = vector de coeficientes b.

function y = zDFIIt4(x,neg_a,b);

y=[];
sv1=0; sv2=0; sv3=0; sv4=0;
for i = 1:length(x)
  tmp0 = x(i);
  tmp1 = tmp0 * b(1);
  tmp2 = tmp0 * b(2);
  tmp3 = tmp0 * b(3);
  tmp4 = tmp0 * b(4);
  tmp5 = tmp0 * b(5);

  tmp6 = tmp4 + sv4;
  tmp7 = tmp3 + sv3;
  tmp8 = tmp2 + sv2;
  tmp9 = tmp1 + sv1;

  tmp10 = tmp9 * (-1/neg_a(1));
  tmp11 = tmp10 * neg_a(2);
  tmp12 = tmp10 * neg_a(3);
  tmp13 = tmp10 * neg_a(4);
  tmp14 = tmp10 * neg_a(5);

  tmp15 = tmp8 + tmp11;
  tmp16 = tmp7 + tmp12;
  tmp17 = tmp6 + tmp13;
  tmp18 = tmp5 + tmp14;

  y = [y tmp10];

  sv4 = tmp18;
  sv3 = tmp17;
  sv2 = tmp16;
  sv1 = tmp15;
end;

endfunction;