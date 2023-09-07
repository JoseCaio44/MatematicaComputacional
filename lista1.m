function lista1()
  xl = 1;
  xu = 1.5;
  imax = 100;
  tol = 1e-5;
  xold = inf;

  x = 1.0:0.05:2.0;
  y = zeros(size(x));

  bisseccao(xl, xu, imax, tol, xold);
endfunction

function bisseccao(xl, xu, imax, tol, xold)
  x = 1.0:0.05:2.0;
  y = zeros(size(x));
  X = zeros(20,1);
  FX = zeros(20,1);

  cont = 1;
  for value = x;
    y(cont) = funcao(value);
    cont++;
  endfor

  for iter = 1:imax;
    xr = (xl + xu) / 2;

    teste = funcao(xl) * funcao(xr);

    if (teste < 0)
      xu = xr;
    elseif (teste > 0)
      xl = xr;
    else
      break;
    endif

    grafico(x, y, xr, iter)
    X(iter) = xr;
    FX(iter) = funcao(xr);

    if abs(xr - xold) < tol
      break;
    endif
    xold = xr;

  endfor
  graficosConvergencia(X, FX, iter);
endfunction

function y = funcao(x)
 y = (x^3) - (2*(x^2)) + x - 0.275;
endfunction

function grafico(x, y, xr, i)

 figure(1);
 clf;
 grid('on');
 hold('on');

  p1 = plot(x, y, 'linewidth', 2);
  p2 = plot(xr, funcao(xr), 'linewidth', 2, 'or', 'markersize', 15);

  hold('off');

  set(gca, 'fontsize', 15);
  xlabel('x');


  ylabel('F(x)');
  title(sprintf('F(%.6f) = %.6f, foram necessarias %d interacoes \n', xr, funcao(xr), i));
  legend([p1, p2], {'F(x)', 'Raiz Encontrada'}, 'location', 'northeast');
  pause(0.10);

endfunction



function graficosConvergencia(X, FX, iter)
  figure(2);
  clf;

  subplot(2,1,1);
  p3 = plot(1:(iter - 1), X(1:(iter - 1)), 'linewidth', 2, 'g');
  set(gca, 'fontsize', 20);
  grid('on');
  title('Grafico de convergencia XR');
  ylabel('XR');
  xlabel('Iteracao');

  subplot(2,1,2);
  p4 = plot(1:(iter - 1), FX(1:(iter - 1)), 'linewidth', 2, 'g');
  set(gca, 'fontsize', 20);
  grid('on');
  title('Grafico de convergencia XR');
  ylabel('F(xr)');
  xlabel('Iteracao');
end

