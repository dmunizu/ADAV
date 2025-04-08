% Funci�n que filtra la se�al x utilizando un 'DFIIt' de cuarto orden. 
% 
% function y = zDFIIt4(x,neg_a,b);
%    x = entrada del filtro
%    neg_a = vector de coeficientes '-a'.
%    b = vector de coeficientes b.

function y = zDFIIt4(x,neg_a,b);

y=[];
tmp15=0; tmp16=0; tmp17=0; tmp18=0;
for i = 1:length(x)
  tmp1 = tmp0 * b(1);
  tmp2 = tmp0 * b(2); tmp9 = tmp1 + tmp15;
  tmp3 = tmp0 * b(3); tmp8 = tmp2 + tmp16;
  tmp4 = tmp0 * b(4); tmp7 = tmp3 + tmp17;
  tmp5 = tmp0 * b(5); tmp6 = tmp4 + tmp18;
  
  tmp10 = tmp9 * (-1/neg_a(1));
  tmp11 = tmp10 * neg_a(2); y = [y tmp10];
  tmp12 = tmp10 * neg_a(3); tmp15 = tmp8 + tmp11;
  tmp13 = tmp10 * neg_a(4); tmp16 = tmp7 + tmp12;
  tmp14 = tmp10 * neg_a(5); tmp17 = tmp6 + tmp13;
  tmp18 = tmp5 + tmp14;

end;

endfunction;