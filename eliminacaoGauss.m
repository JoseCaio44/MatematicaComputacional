function eliminacaoGauss()
  A = [1, 1, -3; 2, 1, 1; -7, -2, 1];
  b = [-17; 12; -11];
  N = length(b);
  X = zeros(N,1);
  Ab = [A b];

  Gauss = pivotamnetoParcial(A,b,N,X,Ab)
endfunction

function Gauss = pivotamnetoParcial(A,b,N,X,Ab)
  Gauss = 0;
  for iter=1:N-1
    [M,P] = max(abs(Ab(iter:N, iter)));
    fprintf('\n Iteracao: %d\n', iter);
    fprintf('\n Maior elemento : %f \n', M);
    fprintf('\n linha do elemento : %f \n', P);

    if Ab(iter,iter)==0
      for k=iter+1:N
        if Ab(k,iter)~=0
          aux = Ab(iter,:);
          Ab(iter,:) = Ab(k,:);
          fprintf('\nPivotamento parcial: \n');
          Ab(k,:) = aux;
          break
        endif
      endfor
    endif
    Ab
    for i = iter+1:N
      mult = Ab(i,iter)/Ab(iter,iter);
      Ab(i,:) = Ab(i,:) - mult*Ab(iter,:);
    endfor
  endfor
  resultados(A, b, Ab, N, X);
endfunction

function resultados(A, b, Ab, N, X)
  X(N) = Ab(N,N+1)/Ab(N,N);
  for k=N-1:-1:1
    X(k) = (Ab(k,N+1) - Ab(k,k+1:N)*X(k+1:N)) / Ab(k,k);
  end

  fprintf('\n A solucao da matriz: \n');
  A
  fprintf('\n Vetor : \n');
  b
  fprintf(' Valor final : \n');
  fprintf('X = %.6f\nY = %.6f\nZ = %.6f\n ', X(1), X(2), X(3));
endfunction
