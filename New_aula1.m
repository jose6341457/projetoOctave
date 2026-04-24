%--------------------------------
% Comentário
% Programa Método de Newton: Exemplo 01
% Algoritmo elaborado por Profa Silvana L P Iahnke
% Objetivo: Encontrar as raízes do exemplo 01 a)f(x) = x^3 - 5x + 1 pelo
## Método de Newton
% Pelo TVI e gráfico identificou-se que f(x) tem raízes nos intervalos:
% I0 = [-3, -2]; I1 = [0, 1] ; I2 = [2, 3]
%--------------------------------
clear all; %Limpa os comandos da Tela
%Entrada dos DADOS
F = @(x) x^3-5*x+1 ; %Define a função anônima F
d1 = @(x) 3*x^2-5; % Define a função anônima da primeira derivada de F(x)
d2=@(x) 6*x; % Define a função anônima da segunda derivada de F(x)
a = -3; b = -2; % Intervalo inicial I0
imax = 10; % Número máximo de iterações
tol =  0.0005; % Tolerância (|ER| < tol)
%(número de algarismos significativos)
%--------------------------------
%PROGRAMA de Newton
disp(''); % pula linha
Fa = F(a);
Fb = F(b);
d2a = d2(a);
d2b = d2(b);
if Fa*Fb > 0
   disp('');
   disp('Erro: A função tem o mesmo sinal nos pontos a e b');
else
   if Fa*d2a > 0 %Teste da convergência
      disp('No ponto x0 = a, há convergência do método de Newton!')
      for k = 1:imax
          x0 = a;
          xi = x0 - F(x0)/d1(x0);
          fi = F(xi);
          d1i = d1(xi);
          d2i = d2(xi);
          e1 = abs((xi-x0)/xi);
          if e1 < tol
             xap = xi;
             fprintf('A solução foi obtida na iteração %i, com xk = %5.5f, com f(xk) = %5.5f e um |ER| = %5.5f \n', k, xi, fi, e1);
          break
          end
          a = xi;
      end
      if k == imax
         fprintf('A solução não foi obtida em %i iterações \n', imax);
      end
   end
end
