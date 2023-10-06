function lista3()
  clc;
  A = [-1, 1, -3; 3, -2, 8; 2, -2, 5];
  b = [-4; 14; 7];
  Ab = pivotamentoParcial([A b], size(A));

  Ab = gaussJordan([A b], size(A));

endfunction

function Ab = pivotamentoParcial(Ab, n)
  for i = 1:n-1
    [~,pos] = max(abs(Ab(i:end, i)));
    pos = pos + i - 1;

    if i ~= pos
      aux = Ab(pos,:);
      Ab(pos,:) = Ab(i,:);
      Ab(i,:) = aux;
    endif

  endfor
endfunction

function Ab = gaussJordan(Ab, n)
  Ab
  for i = 1:n
    Ab(i,:) = Ab(i,:) ./ Ab(i,i);
    for j = 1:n
      if i ~= j
        fator = Ab(j,i);
        Ab(j,:) = Ab(j,:) - fator * Ab(i,:);

      endif
    endfor
  endfor
  Ab
endfunction
