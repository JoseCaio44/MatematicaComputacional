clear
clc

% Exemplo de gr�fico com curvas sobrepostas
t = 0:pi/360:10*pi;
y1 = sin(t) + 1/3*sin(3*t) + 1/5*sin(5*t);
y2 = cos(t) + 3*sin(5*t + pi/4);
return
figure(1);
clf;
f1 = plot(t, y1, 'linewidth', 2, 'color', 'b', 'marker', 'none', 'markersize', 10, 'markerfacecolor', [1 1 1]);
hold('on');
f2 = plot(t, y2, 'linewidth', 2, 'color', 'r', 'marker', 'none', 'markersize', 10, 'markerfacecolor', [1 1 1]);
hold('off');
set(gca, 'fontsize', 12);
grid('on');
legend([f1, f2], {'y1(t)', 'y2(t)'}, 'location', 'northwest');
ylabel('Imagem da função');
xlabel('t');
title('Plot de duas funções em função de t');
xlim([t(1) t(end)]);
ylim([-5 5]);
saveas(gcf, 'figura1.png');

% Exemplo de gr�fico com subplot
figure(2);
clf;
subplot(2, 1, 1);
f1 = plot(t, y1, 'linewidth', 2, 'color', 'b', 'marker', 'none', 'markersize', 10, 'markerfacecolor', [1 1 1]);
set(gca, 'fontsize', 12);
grid('on');
ylabel('y1(t)');
xlabel('t');
title('Plot de uma função unidimensional');
xlim([t(1) t(end)]);
ylim([-5 5]);

subplot(2, 1, 2);
f2 = plot(t, y2, 'linewidth', 2, 'color', 'r', 'marker', 'none', 'markersize', 10, 'markerfacecolor', [1 1 1]);
set(gca, 'fontsize', 12);
grid('on');
ylabel('y2(t)');
xlabel('t');
title('Plot de outra função unidimensional');
xlim([t(1) t(end)]);
ylim([-5 5]);
saveas(gcf, 'figura2.png');

%% Exemplo de gr�fico 3D
x = -2*pi:pi/10:2*pi;
y = -2*pi:pi/10:2*pi;

z = zeros(length(x), length(y));
i = 1;
for xx = x
  j = 1;
  for yy = y
    z(i, j) = sin(0.5*xx - 1.5*yy + 0.34*pi) - xx.^2 + 3.*sqrt(yy + 2*pi);
    j = j + 1;
  end
  i = i + 1;
end

x2 = -7.5:1/3:7.5;
y2 = x2;
z2 = sin(4*x2) + 1/3*sin(3*y2) + 1/5*sin(5*x2 + 5*y2) + 10;

figure(3);
clf;
f1 = surf(x, y, z);
shading('faceted');
view([30, 30]);
hold('on');
f2 = plot3(x2, y2, z2, 'linewidth', 2, 'color', 'r', 'marker', 'o', 'markersize', 5, 'markerfacecolor', [1 1 1]);
hold('off');
set(gca, 'fontsize', 12);
grid('on');
legend([f1, f2], {'z1(x, y)', 'z2(x2, y2)'}, 'location', 'northwest');
zlabel('Imagem da fun��o');
ylabel('y');
xlabel('x');
title('Plot de duas funções tridimensionais em função de x e y');
saveas(gcf, 'figura3.png');

%% Exemplo de gr�fico 3D animado
x2 = x(1:30);
y2 = y(1:30);
z2 = diag(z(1:30, 1:30));
figure(4)
clf

for i = 1:30
  f1 = surf(x, y, z);
  shading('faceted');
  view([30 + i, 30 + i]);
  hold('on');
  f2 = plot3(x2(1:i), y2(1:i), z2(1:i), 'linewidth', 2, 'color', 'r');
  f3 = plot3(x2(i), y2(i), z2(i), 'linewidth', 2, 'color', 'r', 'marker', 'o', 'markersize', 10, 'markerfacecolor', [1 1 1]);
  hold('off');
  set(gca, 'fontsize', 12);
  grid('on');
  legend([f1, f3], {'z1(x, y)', 'Solução atual'}, 'location', 'northwest');
  zlabel('Imagem da função');
  ylabel('y');
  xlabel('x');
  title('Plot de duas funções tridimensionais em função de x e y');
  saveas(gcf, sprintf('figura4-%i.png', i));
  % keyboard    % isso � para colocar um breakpoint
  pause(0.1)
end
