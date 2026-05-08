clear all; clc;
pkg load symbolic;

% 1. Entradas via Teclado (com valores padrão)
f_input = input('Digite a função (ou Enter para 3-x^3): ', 's');
if isempty(f_input); f_input = '3 - x^3'; end

a = input('Digite o limite inferior a (ex: 1): ');
b = input('Digite o limite superior b (ex: 2): ');
tol = input('Digite a tolerância (ex: 1e-10, ou Enter para padrão): ');
if isempty(tol); tol = 1e-10; end

% 2. Definição das Funções
syms x;
f_sym = sym(f_input);
d1_sym = diff(f_sym, x);
d2_sym = diff(d1_sym, x);

f_anon = function_handle(f_sym);
d1 = function_handle(d1_sym);
d2 = function_handle(d2_sym);

disp('--- Resolução de Equações: Método de Newton-Raphson ---');

% 3. Validação do Intervalo (TVI) e Chute Inicial (Fourier)
if f_anon(a) * f_anon(b) > 0
    error('O TVI não foi satisfeito: f(a) e f(b) têm o mesmo sinal no intervalo dado.');
end

% Escolha do chute inicial (Fourier): onde f(x)*f''(x) > 0
if f_anon(a) * d2(a) > 0
    x0 = a;
else
    x0 = b;
end
fprintf('Chute inicial escolhido por Fourier: x0 = %.2f\n', x0);

% 4. Tabela Formatada
largura = 85;
div = repmat('-', 1, largura);
fprintf('\n%s\n', div);
fprintf('%5s | %20s | %18s | %18s | %15s\n', 'Iter', 'xi', 'f(xi)', 'xi+1', '|ER|');
fprintf('%s\n', div);

% 5. Loop de Newton
imax = 50;
for i = 1:imax
    try
        fx0 = f_anon(x0);
        dfx0 = d1(x0);

        if abs(dfx0) < 1e-12
            fprintf('Erro: Derivada nula em x = %.4f\n', x0);
            break;
        end

        xi = x0 - fx0 / dfx0;
        ER = abs((xi - x0) / xi);

        fprintf('%5d | %20.15f | %18.2e | %18.15f | %15.2e\n', i, x0, fx0, xi, ER);

        if ER < tol || abs(f_anon(xi)) < 1e-14
            fprintf('%s\n', div);
            fprintf('>> Convergência atingida! Raiz aproximada: %.15f\n', xi);
            break;
        end

        x0 = xi;
    catch ME
        fprintf('\n>> Erro no cálculo: %s\n', ME.message);
        break;
    end

    if i == imax
        fprintf('\n>> Aviso: Limite de iterações atingido.\n');
    end
end
