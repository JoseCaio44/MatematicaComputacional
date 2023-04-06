function ExercicioGaus()

  clc;
  A = [1, 1, -3; 2, 1, 1; -7, -2, 1];
  b = [-17; 12; -11];
  N = length(b);
  X = zeros(N,1);
  Ab = [A b]

  Gauss = eliminacaoGauss(A, b, N, X, Ab);
end

function Gauss = eliminacaoGauss(A,b,N,X,Ab);
  Gauss = 0;
  for j=1:N-1
    [M,P] = max(abs(Ab(j:N, j)));
    fprintf('\nIteracao: %d\n', j);
    fprintf('Maior elemento do pivo ');
    M
    fprintf('Linha do elemento pivo ');
    P
    if Ab(j,j)==0
      for k=j+1:N
        if Ab(k,j)~=0
            aux = Ab(j,:);
            Ab(j,:) = Ab(k,:);
            fprintf('\nPivotamento parcial: \n');
            Ab(k,:) = aux;
            break
        end
      end
    end

    Ab

    for i = j+1:N
        mult = Ab(i,j)/Ab(j,j);
        Ab(i,:) = Ab(i,:) - mult*Ab(j,:);
    end
  end
  resultado(A, b, Ab, N, X);
endfunction

function resultado(A, b, Ab, N, X)
    X(N) = Ab(N,N+1)/Ab(N,N);

    for k=N-1:-1:1
      X(k) = (Ab(k,N+1) - Ab(k,k+1:N)*X(k+1:N)) / Ab(k,k);
    end

    fprintf('\nA solucao da matriz:\n');
    A
    fprintf('Do vetor:\n');
    b
    fprintf(' igual a: \n');

    fprintf('X = %.6f\nY = %.6f\nZ = %.6f\n ', X(1), X(2), X(3));
    fprintf('\n');

endfunction
