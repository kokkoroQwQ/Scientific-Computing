%% 
% HW1 for Scientific Computation due 10 a.m. on Sep 26
% Please submit the final PDF via the word or pdf file. 

% Giving the data pair (x, y) （100 Points）： 
% x = [0 0.5 1.1 1.7 2.1 2.5 2.9 3.3 3.7 4.2 4.9 5.3 6.0 6.7 7.0];
% y = [1.1 1.6 2.4 3.8 4.3 4.7 4.8 5.5 6.1 6.3 7.1 7.1 8.2 6.9 5.3];
% For data points xp=0:0.1:7, calculate the value of yp 
% using polynomial fit and interpolation.

x = [0 0.5 1.1 1.7 2.1 2.5 2.9 3.3 3.7 4.2 4.9 5.3 6.0 6.7 7.0];
y = [1.1 1.6 2.4 3.8 4.3 4.7 4.8 5.5 6.1 6.3 7.1 7.1 8.2 6.9 5.3];
xp = 0:0.1:7;

%%
% 1. Try the Polynomial fit using the least square with different order 
% of polynomial degrees n; (Matlab function: polyfit). 
% Plot results for n=1, 2, 3, 14 in Figure 1. （20 Points）

figure;
hold on;
plot(x, y, '*');

P = zeros([5, 15]);

i = 1;
N = [1,2,3,4,14];
for n = N
    p = polyfit(x, y, n);
    P(i, 1:n+1) = p;
    yp = polyval(p, xp);
    plot(xp, yp);
    i = i + 1;
end

xlabel('x'), ylabel('y');
legend('original data ', 'n = 1', 'n = 2', 'n = 3', 'n = 4', 'n = 14');
title('the Polynomial fit with different order n');

%%
% 2. Write the polynomial equation with coefficients 
% for different n=1, 2, 3, 14. （20 Points）
% Check if it is right using giving data pair.


%%
% 3. 3.Calculate three errors: 
% maximum error, average error, root-mean square error 
% for polynomial order n=1, 2, 3, 4, 14. 
% Plot three errors for different n in Figure 2（20 Points）

len = length(y);

% store [maximum_error, average_error, rse_error] with different n
errors = zeros([5,3]);
i = 1;
for n = [1,2,3,4,14]
    p = polyfit(x, y, n);
    fx = polyval(p, x);
    abs_error_vec = abs(fx-y);

    maximum_error = max(abs_error_vec);
    average_error = sum(abs_error_vec) / len;
    rse_error = sqrt(sum(abs_error_vec.*abs_error_vec) / len);

    errors(i, 1:3) = [maximum_error, average_error, rse_error];

    i = i + 1;
end

figure;
hold on;
n = [1,2,3,4,14];
for j = [1,2,3]
    plot(n, transpose(errors(1:5, j)));
end
xlabel('x'), ylabel('y');
legend("Maximum Error", "Average Error", "Root-mean square Error");
title("three errors for polynomial order n=1, 2, 3, 4, 14");

%%
% 4. Try different interpolation method using nearest and spline. 
% Analyze which interpolation is the best? （20 Points）

% x = [0 0.5 1.1 1.7 2.1 2.5 2.9 3.3 3.7 4.2 4.9 5.3 6.0 6.7 7.0];
% y = [1.1 1.6 2.4 3.8 4.3 4.7 4.8 5.5 6.1 6.3 7.1 7.1 8.2 6.9 5.3];
% xp = 0:0.1:7;

figure;
hold on;
plot(x, y, '*');
for method = ["nearest", "spline"]
    yp = interp1(x, y, xp, method);
    plot(xp, yp);
end
xlabel('x'), ylabel('y');
legend("original data", "nearest", "spline", "Location","northwest");
title("the curves with different interpolation method");

% Analysis: Spline method is better!
% Spline（三次样条插值）方法明显优于nearest（最近邻插值）方法。
% 查阅网上资料得知，相较于nearest将距离最近的数据点赋值给插值点的方式，
% spline方法在数据点之间通过三阶多项式进行插值，得到的插值曲线更加光滑，
% 可能更逼近真实的数据。所以spline方法更优。

%% 
% 5. Explain the differences between interpolation and fitting? （20 Points）
% 插值法与拟合法的差异在于：插值依据两个相邻已知数据点来计算这两点之间插入点
% 的值，这样得到的插值曲线一定经过所有的已知数据点，容易受到数据噪声的影响；
% 而拟合则是通过找到某个函数，使得所有点上的预测值与真实值的总的误差到达一个
% 可以接受的范围内，这样得到的拟合曲线一般不能都经过每个已知数据点，但可以更
% 好地克服噪声带来的影响。





