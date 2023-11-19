function lista5()
  clc;

  x = [0.1; 0.2; 0.4; 0.6; 0.9; 1.3; 1.5; 1.7; 1.8];
  y = [0.75; 1.25; 1.45; 1.25; 0.85; 0.55; 0.35; 0.28; 0.18];
  ordem = 2;
  xx = 18;

  n = 5;
  l = zeros(n+1,n+1);
  z = 6;
  coef = calcularPolinomio(x,y,ordem);
  pred = funcaoPolinomial(coef,xx);
  pol = polyfit(x,y,ordem);

  plotaGrafico(x, y);
endfunction

function X = calcularPolinomio(x,y,order)
  n = size(x,1);
  if(n<(order+1))
    fprintf("Regressão é impossível.\n\n");
  else
    for(i=1:(order+1))
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
      a(i,(order+2))=soma;
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

function plotaGrafico(x, y)
    figure(1)
    clf
    grid('on');
    hold('on');

    p1 = plot(x, y, 'linewidth', 2, 'og');
    p2 = plot(xr, getRoot(xr), 'linewidth', 2, 'oxr', 'markersize', 15);

    hold('off');

    # Informações do Gráfico

    set(gca, 'fontsize', 15);
    title(sprintf('F(%.6f) = %.6f, Iteracoes: %d', xr, getRoot(xr), i));
    xlabel('x');
    ylabel('F(x)');
    pause(0.10); # Velocidade das iteracoes
end

