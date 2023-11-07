function lista04()
  clc;
  format long;
  x0 = [3; 0];
  maxIter = 1000;
  otimo = [1; 1];
  tol = 1e-3;
  flag = 1;
  x0 = [3; 0];

  [x0, i] = otimizacao(x0, tol, maxIter, otimo, flag);

  printf("O resultado de F(%.6f, %.6f) = %.6f, e foram necessarias %d iteracoes\n", x0(1), x0(2), funcao(x0), i-1);

endfunction

function [x0, i] = otimizacao(x0, tol, maxIter, otimo, flag)
  if flag == 1
     alpha = 0.1;
   else
     alpha = 0.12;
   endif

   for i = 1:maxIter

    X(1, 1:2) = x0;
    Y(1, 1:1) = funcao(x0);

    if flag == 1
     x1 = x0 - alpha*gradiente(x0);
    else
     x1 = x0 - alpha*(hessian_levy13(x0)\gradiente(x0));
    endif

    X(i+1, 1:2) = x1;
    Y(i+1, 1:1) = funcao(x1);

    if max(abs(x1 - x0)) < tol
      break;
    endif
    x0 = x1;
  endfor

  distancia = euclidiana(x0, otimo);

  plotarGrafico(X,Y,i);
  convergenciaX(i,X);
  convergenciaF(i,Y);
endfunction


function y = funcao(x)
  y = sin(3 * pi * x(1))^2 + (x(1) - 1)^2 * (1 + sin(3 * pi * x(2))^2) + (x(2) - 1)^2 * (1 + sin(2 * pi * x(2))^2);
endfunction

function e = euclidiana(x0, otimo)
  e = sqrt((x0(1) - otimo(1))^2 + (x0(2) - otimo(2))^2);
endfunction

function g = gradiente(x)
   g = zeros(2, 1);
   g(1) = 2*sin(3*pi*x(1))*3*pi*(x(1) - 1) + 2*(x(1) - 1);
   g(2) = 2*sin(3*pi*x(2))*3*pi*(x(1) - 1) + 2*(x(2) - 1)*(1 + sin(2*pi*x(2))^2) + 2*(x(2) - 1);
endfunction

function h = hessiana(x)
   h = zeros(2, 2);
   h(1, 1) = 18*pi^2*sin(3*pi*x(1))^2 + 2*(1 + sin(3*pi*x(2))^2);
   h(1, 2) = 6*pi*sin(3*pi*x(2))*sin(3*pi*x(1));
   h(2, 1) = 6*pi*sin(3*pi*x(2))*sin(3*pi*x(1));
   h(2, 2) = 4*(x(2) - 1)*sin(2*pi*x(2))^2 + 2*(1 + sin(2*pi*x(2))^2);
endfunction

function plotarGrafico(X,Y,iter)
  X = X(1:(iter + 1), :);
  maiorValor = max(max(X));
  menorValor = min(min(X));
  intervalo = (menorValor - 5):0.5:(maiorValor + 5);
  numX = numel(intervalo);
  numY = numel(intervalo);
  Z = zeros(numY, numX, 2);

  for j = 1:numX
    for i = 1:numY
      Z(i, j, :) = funcao([intervalo(i); intervalo(j)]);
    endfor
  endfor

  for k = 1:(iter + 1);
    figure(1);
    clf;
    surf(intervalo, intervalo, Z(:, :, 1));
    hold on;
    plot3(X(1:k, 2), X(1:k, 1), Y(1:k, 1), 'color', 'm',  'linewidth', 2);
    plot3(X(k, 2), X(k, 1), Y(k, 1), 'Marker', 'o', 'MarkerFaceColor', 'm', 'color', 'k', 'linewidth', 2, 'markersize', 10);
    title(sprintf('Grafico da Funcao\nIteraco: %d, x = %1.6f, y = %1.6f, f(x,y) = %1.6f', k,  X(k, 1), X(k,2), Y(k, 1)));
    set(gca, 'fontsize', 15);
    xlabel('y');
    ylabel('x');
    zlabel('f(x,y)');
    pause(0.1);
  end
endfunction

function convergenciaX(iter,X)
  figure(2);
  clf;
  plot(0:iter,X, 'linewidth', 2);
  xlabel('Iteracoes');
  ylabel('(x,y)');
  legend('valor de x','valor de y');
  grid on;
  title(sprintf('Grafico de convergencia de x e y'));
  set(gca, 'fontsize', 20);
endfunction

function convergenciaF(iter,Y)
      figure(3);
      clf;
      plot(0:iter,Y, 'linewidth', 2);
      xlabel('Iteracoes');
      ylabel('f(x,y)');
      legend('f(x,y)');
      grid on;
      title(sprintf('Grafico de convergencia de f(x,y)'));
      set(gca, 'fontsize', 20);
endfunction
