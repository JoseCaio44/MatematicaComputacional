function teste()
  imax = 1000;
  tol = 10e-5;
  xl = 3;
  xu = 4;
  [xr, iter] = biccecao(xl, xu, tol, imax);
  fprintf('O valor encontrado e: %.5f. com %i iteracoes \n', xr, iter);
endfunction

function [xr, iter] = biccecao(xl, xu, tol, imax, ea)
  xold = inf;
  for iter = 1:imax;
    xr = (xl + xu) / 2;
    if (xr != 0)
      ea = abs(xr - xold);
    endif
    teste = funcao(xl) * funcao(xr);
    if (teste < 0)
      xu = xr;
    elseif (teste > 0)
      xl = xr;
    else
      break;
    endif
    if ea < tol
      break;
    endif
    xold = xr;
  endfor
endfunction

function y = funcao(x)
  y = tan(x) * (((35/2) * x^3) - (44 * x^2) + (887 * x) + 229)
endfunction

function grafico(iter,xr)
  figure(1);
  clf;
  plot(1:iter, funcao(xr) , 'linewidth', 2, 'color', 'b');
  set(gca, 'fontsize', 10);
  ylabel('f(x)');
  xlabel('Iteracao');
  grid on;
  hold on;
  xlim([1 iter]);
  ylim([min(xr) - 1, max(xr) + 1]);
  title('Grafico de convergencia de x');

endfunction

function animado(iter,intervaloX,Y,XR)
  for i=1:iter;
    figure(2);
    clf;
    plot(intervaloX, Y, 'linewidth', 2, 'color', 'blue'),
    hold on;
    plot(XR(i),funcao(XR(i)),'o','color','red','markerfacecolor','red','markersize',10);
    hold off;
    set(gca, 'fontsize',16);
    grid on;
    ylabel('f(x)');
    xlabel('x');
    pause(0.5);
  endfor
end
