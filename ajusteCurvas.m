function ajusteCurvas()
  clc;

  x = [1; 2; 3; 5; 7; 8];
  y = [3; 6; 19; 99; 291; 444];

  n = 5;
  l = zeros(n+1,n+1);
  z = 6;

##  ordem = input("Digite a ordem: ");
  regresPolino(x,y,n,l,z);
endfunction

function regresPolino(x,y,n,L,xx)

  for i = 1:n + 1;
    for j = 1:i;
      k = i + j - 2;
      soma = 0;

      for l = 1:n
        soma = soma + x.^k;
      endfor

    endfor
    soma = 0;
    F = 0;
    for l = 1:n
      soma = soma .+ y .* x.^(i - 1);
    endfor
    F = soma;

  endfor

  coef = polyfit(x,y,5)

  plotarGrafico(x,y,coef,xx,n,coef);

endfunction

function plotarGrafico(X,Y,P,xx,n,soma)
  clf;
  figure(1)
  xInt = X(1):0.1:X(end);
  y = polyval(P,xInt);
  plot(xInt,y,'--', 'Color', [0 0 0])

  hold on
  plot(X,Y,'bo', 'Color', [0 0 0]);

  fprintf('\nPonto estimado = %.6f\n', soma);

  plot(xx,soma, 'Marker', 'o', 'MarkerFaceColor', [1 0 0])
  grid on;

  legend('interpolador','conjuntos dos dados','ponto estimado');

  title(sprintf('Interpolador com polinomio de grau = %d\n', n));
  xlabel('x');
  ylabel('f(x)');
  set(gca, 'fontsize', 12);

endfunction
