f1 = @(x)   1 ./ (1 + x.^2);
f2 = @(x)   sin(x);

a = 0,001;
b = 5;
N = 1000;

x = linspace(a, b, N);

figure(1);
clf;
loglog(x, f1(x));
grid on;
grid minor;
hold on;
loglog(x, f2(x));

f21 = @(x) f2(x) - f1(x);

for i = 1:(N-1)
    try
        xL = fzero(f21, [x(i), x(i+1)]);
        break
    catch
    end
end

for i = N:-1:2
    try
        xR = fzero(f21, [x(i-1), x(i)]);
        break
    catch
    end
end

xLR = linspace(xL, xR, N);
xRL = flip(xLR);

yLR = f2(xLR);
yRL = f1(xRL);

xi = [xLR, xRL];
yi = [yLR, yRL];

fill(xi, yi, 'y');

format long;
quadgk(f21, xL, xR)
