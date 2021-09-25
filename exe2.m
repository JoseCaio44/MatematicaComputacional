function ex_estrutura()
  tamanhoX2 = input('Qual o tamanho do vetor?> ');
  x = -2*pi:pi/10:2*pi;
  y = -2*pi:pi/10:2*pi;
  z = zeros(length(x), length(y));
  i = 1;
  for xx = x
    j = 1;
    for yy = y
      z(i, j) = funcao(xx, yy);
      j = j + 1;
    end
    i = i + 1;
  end
  x2 = x(1:tamanhoX2);
  y2 = y(1:tamanhoX2);
  z2 = diag(z(1:tamanhoX2, 1:tamanhoX2));
  plotaGrafico(x, y, z, x2, y2, z2);
  posAleatoria = randi([1 tamanhoX2], 1, 1);
  fprintf('O resultado eh: z(%5.2f, %5.2f) = %5.2f.\n', posAleatoria, posAleatoria, z2(posAleatoria));
end

function z = funcao(x, y)
  z = sin(0.5*x - 1.5*y + 0.34*pi) - x.^2 + 3.*sqrt(y + 2*pi);
end

function plotaGrafico(x, y, z, x2, y2, z2)
  figure(1);
  clf;

  for i = 1:length(x2)
    f1 = surf(x, y, z);
    shading('faceted');
    view([30 + i, 30 + i]);
    hold('on');
    f2 = plot3(x2(1:i), y2(1:i), z2(1:i), 'linewidth', 2, 'color', 'r');
    f3 = plot3(x2(i), y2(i), z2(i), 'linewidth', 2, 'color', 'r', 'marker', 'o', 'markersize', 10, 'markerfacecolor', [1 1 1]);
    hold('off');
    set(gca, 'fontsize', 12);
    grid('on');
    legend([f1, f3], {'z1(x, y)', 'Solu��o atual'}, 'location', 'northwest');
    zlabel('Imagem da fun��o');
    ylabel('y');
    xlabel('x');
    title('Plot de duas fun��es tridimensionais em fun��o de x e y');
    pause(0.1);
  end
end
