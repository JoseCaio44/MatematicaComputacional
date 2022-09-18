function newtom()
  imax = 1000;
  tol = 10e-5;
  xx = [1;1];
  [iter, x0, X, x1] = rapson(xx, tol, imax)
  fprintf('O valor encontrado e: %.6f e de %.6f com %i iteracoes \n', x0(1), x0(2), iter);
  graficosConvergencia(iter, X)
endfunction

function y = funcao(x)
  y = [x(1) + x(2) - sqrt(x(2)) - 0.25; 8 * (x(1)^2) + 16 * x(2) - (8 * x(1) * x(2)) - 10];
endfunction

function dx = jacobiano(x)
  dx = [ 1, 1 - (1 / (2 * sqrt(x(2)))) ; 16 * x(1) - 8, 8];
endfunction

function [iter, x0, X, x1] = rapson(x, tol, imax)
  x0 = [1;1];
  X = zeros(imax, 2);
  X(1,1:2) = x0;
  for iter = 1:imax;
    x1 = x0 - inv(jacobiano(x0)) * funcao(x0);
    X(iter + 1, 1:2) = x1;
    if(abs(x0 - x1) <= tol)
      max(abs(x1 - x0))
      x0 = x1;
      break;
    endif
    x0 = x1;
  endfor
  X = X(1:(iter+1), : );
endfunction

function geraGraficoFuncao(limInfInt, limSupInt, todosX, todosY, iter)
  x = limInfInt:0.1:limSupInt;
  y = x;
  F = zeros(length(x), length(y), 2);
  for xx = 1:numel(x)
    for yy = 1:numel(y)
      F(xx, yy, 1:2) = funcao([x(xx); y(yy)]);
    end
  end
  for cont = 1:iter
    figure(1);
    subplot(211)
    surf(x, y, F(:, :, 1));
    hold on
    plot3(todosX(1:cont, 2), todosX(1:cont, 1), todosY(1:cont, 1), 'color', 'r', 'linewidth', 2)
    plot3(todosX(cont, 2), todosX(cont, 1), todosY(cont, 1), 'o', 'markersize', 20, 'color', 'r', 'markerfacecolor', [1 1 1], 'linewidth', 2)
    hold off
    set(gca, 'fontsize', 30);
    grid on;
    title(sprintf('Iter %i', cont));
    subplot(212)
    surf(x, y, F(:, :, 2));
    hold on;
    plot3(todosX(1:cont, 2), todosX(1:cont, 1), todosY(1:cont, 2), 'color', 'r', 'linewidth', 2)
    plot3(todosX(cont, 2), todosX(cont, 1), todosY(cont, 2), 'o', 'markersize', 20, 'color', 'r', 'markerfacecolor', [1 1 1], 'linewidth', 2)
    hold off;
    set(gca, 'fontsize', 30);
    grid on;
##    keyboard
  endfor
    figure(2);
    subplot(211)
    plot(1:iter, todosX, 'linewidth', 2)
    set(gca, 'fontsize', 30);
    grid on;

    subplot(212)
    plot(1:iter, todosY, 'linewidth', 2)
    set(gca, 'fontsize', 30);
    grid on;

endfunction

function graficosConvergencia(iter, X)
  figure(3);
  title('Grafico de convergencia');
  plot(X, 'linewidth', 2);
  set(gca, 'fontsize', 20);
  ylabel('F de (X)');
  xlabel('Iteracao');
  grid on;

end
