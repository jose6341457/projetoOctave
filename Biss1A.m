clear all; %limpa os comandos da tela
disp('Resolução Numérica de Equações Algébricas e Transcedentais: Método da Bisseção para raízes reais');
disp('Seja f(x) uma função contínua em I0 = [a,b], com f(a)*f(b)<0');
% Variáveis de entrada
a = input('Entre com o valor de a =');
b = input('Entre com o valor de b =');
f = input('Entre com a função f(x) =', 's');
F = str2func(['@(x)', f]); % Converte f para função anônima
imax = input('CP: Entre com o número máximo de iterações =');
tol = input('CP: Entre com o valor do |ER| desejado =');
% Algoritmo da Bisseção
%xNS = x0 = aproximante da raiz
Fa = F(a); Fb = F(b);
if Fa*Fb > 0 %TVI
  disp('Erro: Não tem raiz no intervalo inicial [a, b]');
else
disp(' i   a  b  xNS  F(a)  F(xNS)  |ER|'); % Cabeçario da Tabela
for i = 1:imax %iterações
  xA = a; %armazena o valor a Anterior
  xNS = (a+b)/2;  % Fórmula do Método da Bisseção
  toli = abs((xNS-xA)/xNS); % Cálculo do |ER| => tolerância do método
  FxNS = F(xNS);
  Fa = F(a);
  fprintf('%3i  %11.6f  %11.6f  %11.6f  %11.6f  %11.6f  %11.6f \n', i, a, b, xNS, Fa, FxNS, toli); %imprime os resultados na tela na Tabela
  %Críterios de Parada
  if FxNS == 0  %CP: Solução exata encontrada
    fprintf('Uma solução exata foi encontrada na iteração i = %3i, com valor de xNS = %11.6f \n', i,
    xNS)
    break
  end
  if toli < tol % CP: |ER|=> erro relativo atingido!
    fprintf('CP: |ER| atingido! O aproximante da raiz foi encontrado na iteração i = %3i, com valor de xNS = %11.6f e  |ER| =%11.6f \n', i, xNS, toli)
    break
  end
 if i == imax % CP: Número Máximo de iterações atingido!
    fprintf('CP: Número máximo i = %i de iterações atingido!', imax)
    break
  end
  % Teste do Próximo Intervalo (TVI)
  if F(a)*F(xNS) < 0
    %Isto é, tem troca de sinal entre f(a) e f(xNS), ou seja a raiz está entre a e xNS
    b = xNS;
  else
    a = xNS;
  end
 end
end

