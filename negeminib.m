clear all; clc;
pkg load symbolic;

% 1. Definição Robusta da Função
% Usamos o ponto (.* , .^ , ./) para que a função aceite vetores (essencial para o gráfico)
f_anon = @(x) sin(x) - log(x);

disp('--- Resolução de Equações: Método de Newton-Raphson ---');

% 2. Cálculo das Derivadas
syms x;
f_sym = sin(x) - log(x);
d1_sym = diff(f_sym, x);
d2_sym = diff(d1_sym, x);

% Conversão para funções numéricas
d1 = function_handle(d1_sym);
d2 = function_handle(d2_sym);

% 3. Parâmetros e Validação
a = 2; b = 3;
tol = 1e-10;
imax = 50;

if f_anon(a) * f_anon(b) > 0
    error('O TVI não foi satisfeito: f(a) e f(b) têm o mesmo sinal.');
end

% Escolha do chute inicial (Fourier)
x0 = (f_anon(a) * d2(a) > 0) * a + (f_anon(a) * d2(a) <= 0) * b;

% 4. Tabela Formatada (Alinhada à direita)
largura = 85;
div = repmat('-', 1, largura);
fprintf('\n%s\n', div);
fprintf('%5s | %20s | %18s | %18s | %15s\n', 'Iter', 'xi', 'f(xi)', 'xi+1', '|ER|');
fprintf('%s\n', div);

% 5. Loop de Newton
for i = 1:imax
    fx0 = f_anon(x0);
    dfx0 = d1(x0);

    if abs(dfx0) < 1e-12
        fprintf('Erro: Derivada muito próxima de zero em x = %.4f\n', x0);
        break;
    end

    xi = x0 - fx0 / dfx0;
    ER = abs((xi - x0) / xi);

    % Impressão alinhada
    fprintf('%5d | %20.15f | %18.2e | %18.15f | %15.2e\n', i, x0, fx0, xi, ER);

    if ER < tol || abs(f_anon(xi)) < 1e-14
        fprintf('%s\n', div);
        fprintf('>> Convergência atingida! Raiz aproximada: %.15f\n', xi);
        break;
    end

    x0 = xi;

    if i == imax
        fprintf('\n>> Aviso: Limite de iterações atingido.\n');
    end
end
