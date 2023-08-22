function teste()
  clc;

  xl = 0;
  xu = 1;

  tolerance = 1e-5;
  maxIterations = 1000;
  xrOld = inf;

  x = -0:0.05:1;
  y = zeros(size(x));

  % funcao para calcular nosso gráfico
  cont = 1;
  for value = x;
    y(cont) = getRoot(value);
    cont++;
  endfor

  % cálculo da raiz
  for i = 1:maxIterations
    xr = (xl + xu) / 2;

    if getRoot(xl) * getRoot(xr) < 0
      xu = xr;
    else getRoot(xl) * getRoot(xr) < 0
      xl = xr;
    endif

    plotGraph(x, y, xr, i)

if abs(xrOld - xr) <= tolerance
      break;
    endif

    xrOld = xr;

  endfor

  printf('F(%.6f) = %.6f, foram necessarias %d interacoes \n', xr, getRoot(xr), i);

endfunction

function y = getRoot(x)
  y = (x^3) + (2*x^2) - 2;
endfunction

function plotGraph(x, y, xr, i)
 figure(1);
 clf;
 grid('on');
 hold('on');

 p1 = plot(x, y, 'linewidth', 2);
 p2 = plot(xr, getRoot(xr), 'linewidth', 2, 'or', 'markersize', 15);

 hold('off');

 set(gca, 'fontsize', 15);
 xlabel('x');


 ylabel('F(x)');
 title(sprintf('F(%.6f) = %.6f, foram necessarias %d interacoes \n', xr, getRoot(xr), i));
 legend([p1, p2], {'F(x)', 'Raiz Encontrada'}, 'location', 'northeast');
 pause(0.10);
endfunction
