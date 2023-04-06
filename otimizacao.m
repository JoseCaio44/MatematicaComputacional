function otimizacao()
  clc;
  tol = 10e-5;
  x0 = [2;-3];
  X = zeros(101, 2);
  Y = zeros(101, 1);
  X(1, 1:2) = x0;
  Y(1, 1:1) = funcao(x0);
  alpha = input("Introduza o valor do alpha: ");
  imax = 100;
  decs = input("1 - newtom\n2 - gradiente\n3 - BFGS\n");
  if (decs == 1)
    newtom(imax, x0, tol, alpha);
  elseif (decs == 2)
    metodoGradiente(imax,x0, tol, alpha);
  else
    bfgs(imax,x0, tol, alpha);
  endif
endfunction

function metodoGradiente(imax,x0, tol, alpha)
  for iter = 1:imax
    X(1, 1:2) = x0;
    Y(1, 1:1) = funcao(x0);

    G = gradiente(x0);
    H = hessiana(x0);
    x1 = x0  - (alpha * G);
    X(iter+1, 1:2) = x1;
    Y(iter+1, 1:1) = funcao(x1);

    if max(abs(x1-x0)) <= tol
      fprintf("\nSolucao otima\nx = %1.6f\ny = %1.6f\n", x1(1), x1(2));
      x0 = x1;
      break;
    end
    x0 = x1;
  end
  fprintf("\n\nIteracoes %i\n", iter);
  fprintf("x           y\n");
  fprintf("%1.6f    ", x1);
  fprintf("\n\nf(x,y) = ");
  fprintf("%1.6f    ", funcao(x1));

  plotarGrafico(X,Y,iter);
  convergenciaX(iter,X);
  convergenciaF(iter,Y);
endfunction

function newtom(imax, x0, tol, alpha)

  for iter = 1:imax
    G = gradiente(x0);
    H = hessiana(x0);
    x1 = x0  - (alpha * (inv(H) * G));

    X(iter+1, 1:2) = x1;
    Y(iter+1, 1:1) = funcao(x1);

    if max(abs(x1-x0)) <= tol
      fprintf("\n Solucao otima\nX = %1.6f\nY = %1.6f\n", x1(1), x1(2));
      x0 = x1;
      break;
    end
    x0 = x1;
  end

  fprintf("\nIteracoes %i\n", iter);
  fprintf("%1.6f    ", x1);
  fprintf("\n f(x,y) = ");
  fprintf("%1.6f    ", funcao(x1));

  plotarGrafico(X,Y,iter);
  convergenciaX(iter,X);
  convergenciaF(iter,Y);
endfunction

function bfgs(imax,x0, tol, alpha)
  b = eye(2);
  for iter = 1:imax
    X(1, 1:2) = x0;
    Y(1, 1:1) = funcao(x0);

    g = gradiente(x0);
    s = -alpha * (inv(b) * g);
    x1 = x0 + s;

    X(iter+1, 1:2) = x1;
    Y(iter+1, 1:1) = funcao(x1);

    g1 = gradiente(x1);
    y = g1 - g;
    b = b + ((y*y')/(y'*s)) - ((b*s*s'*b') / (s'*b*s));

    if max(abs(x1-x0)) <= tol
      fprintf("\nSolucao otima\nx = %1.6f\ny = %1.6f\n", x1(1), x1(2));
      x0 = x1;
      break;
    end
    x0 = x1;
  end

  fprintf("\nIteracoes %i \n", iter);
  fprintf("x           y \n");
  fprintf("%1.6f    \n", x1);
  fprintf("f(x,y) = \n");
  fprintf("%1.6f    ", funcao(x1));

  plotarGrafico(X,Y,iter);
  convergenciaX(iter,X);
  convergenciaF(iter,Y);
endfunction

function y = funcao(x)
  y = 0.26 * (x(1).^2 + x(2).^2) - 0.48*x(1)*x(2);
endfunction

function h = hessiana(x)
 h = [0.52,0;0,0.52];
endfunction

function g = gradiente(x)
  g = [0.52*x(1)-0.48; 0.52*x(2)-0.48];
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
