function lista5()
  clc;

  x = [0.1; 0.2; 0.4; 0.6; 0.9; 1.3; 1.5; 1.7; 1.8];
  y = [0.75; 1.25; 1.45; 1.25; 0.85; 0.55; 0.35; 0.28; 0.18];
  ordem = 6;
  xx = 1.4;

  a = calcularPolinomio(x,y,ordem)
  imprimepolinomio(a);
  grafico(x, y, xx, a, ordem);
  [r2,r] = coeficienteDeterminacao(x,y,a)
  fprintf("O coeficiente de determinação (r2) é: %f\nO coeficiente de correlação (r) é: %f\n", r2, r);

endfunction

function X = calcularPolinomio(x,y,ordem)

  n = size(x,1);

  if(n<(ordem+1))
    fprintf("É impossível realizar a Regressão.\n\n");
  else

    for(i=1:(ordem+1))
      for(j=1:i)
        k=i+j-2;
        soma=0;

        for(l=1:n)
          soma = soma + x(l)^k;
        endfor

        a(i,j) = soma;
        a(j,i) = soma;
      endfor

      soma = 0;

      for(l=1:n)
        soma = soma + y(l)*x(l)^(i-1);
      endfor

      a(i,(ordem+2))=soma;

    endfor

    aA = a(:,1:size(a,2)-1);
    aB = a(:,size(a,2):size(a,2));
    X=aA\aB;

  endif
endfunction

function X = funcaoPolinomial(a,xx)

  som = 0;

  for(i=1:size(a,1))
    som=som + a(i)*xx^(i-1);
  endfor

  X = som;

endfunction

function imprimepolinomio(a)

  pol = "";
  i = numel(a);

  while(i > 1)
    pol = [pol, num2str(a(i)), " * x^", num2str(i-1), " + "];
    i--;
  endwhile

  pol = [pol, num2str(a(i)), " * x"];
  fprintf("O polinômio encontrado é: %s \n", pol);

endfunction

function [r2,r] = coeficienteDeterminacao(x,y,a)
  sr=0;
  st=0;
  for(i=1:size(x,1))
    sr=sr+(y(i)-funcaoPolinomial(a,x(i)))^2;
    st=st+(y(i)-mean(y))^2;
  endfor
  r2=(st-sr)/st;
  r=sqrt(r2);
endfunction


function grafico(X, Y, XX, a, n)
  ponto = [XX, funcaoPolinomial(a, XX)];
  i = 1;

  for j = min(X):0.1:max(X)
    todosX(i) = j;
    todosFX(i) = funcaoPolinomial(a, j);
    i = i + 1;
  endfor

  clf;
  figure(1);
  hold on;
  plot(X, Y, 'o', 'markersize', 10, 'color', 'b')
  plot(todosX, todosFX, 'linewidth', 2, 'color', 'black')
  plot(ponto(1), ponto(2), '.', 'color', 'red', 'markersize', 30)
  hold off;
  set(gca,'fontsize', 16);
  grid on;
  xlabel('X');
  ylabel('F(x)');
  title(sprintf('Interpolador com polinomio de grau = %d\n', n));
  legend('conjuntos dos dados','interpolador','ponto estimado');
endfunction

