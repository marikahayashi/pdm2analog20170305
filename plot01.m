pkg load control;
pkg load signal;
R = 100;
C1 = 10^(-6);
C2 = 10^(-6);
a1 = [1 (C1+C2)/(R*C1*C2)];
b1 = [0 1/(R*C2)];
H1 = tf(b1, a1);
w = logspace(1, 6, 100);
[mag1, phase1, wout1] = bode(H1, w);
figure(1);
subplot(211);
semilogx(wout1/(2*pi), 20*log10(mag1));
grid on;
subplot(212);
semilogx(wout1/(2*pi), phase1);
grid on;

T = 10^(-6);
t = [0:0.000001:0.001];
aa1 = 1;
bb1 = T/(R*C2)*exp(-1*(C1+C2)/(R*C1*C2)*t);
# aa2 = 1;
# bb2 = 1/(R*C2)*exp(-1/(R*C2)*t);
x = ones(1,1001);
x(1) = 0;
y1 = filter(bb1, aa1, x);
figure(2);
plot(t, y1);
axis([0 0.0003 -0.1 0.6]);
grid on;

# figure(3);
# step(H1);

# T_20k = 1/20000;
# t_20k = [0:1/20000:0.001];
# bb1_20k = T_20k/(R*C2)*exp(-1*(C1+C2)/(R*C1*C2)*t_20k);
# x_20k = ones(1,21);
# x_20k(1) = 0;
# y1_20k = filter(bb1_20k,aa1,x_20k);
# figure(5);
# plot(t_20k,y1_20k);
# axis([0 0.0003 -0.1 0.6]);
# grid on;

# x_zeros = zeros(1,1001);
# x_zeros(1) = 1;
# y1_imp = filter(bb1, aa1, x_zeros);
# figure(5);
# plot(t, y1_imp);
# grid on;


T = 10^(-6);
t_short = [0:0.000001:0.0003];
aa1 = 1;
bb1_short = T/(R*C2)*exp(-1*(C1+C2)/(R*C1*C2)*t_short);
x_short = ones(1,301);
x(1) = 0;
y1_short = filter(bb1, aa1, x_short);
figure(6);
plot(t_short, y1_short);
# axis([0 0.0003 -0.1 0.6]);
grid on;


# T_40k = 1/40000;
# t_40k = [0:1/40000:0.001];
# bb1_40k = T_40k/(R*C2)*exp(-1*(C1+C2)/(R*C1*C2)*t_40k);
# x_40k = ones(1,41);
# x_40k(1) = 0;
# y1_40k = filter(bb1_40k,aa1,x_40k);
# figure(4);
# plot(t_40k,y1_40k);
# axis([0 0.0003 -0.1 0.6]);
# grid on;

# T_100k = 1/100000;
# t_100k = [0:1/100000:0.001];
# bb1_100k = T_100k/(R*C2)*exp(-1*(C1+C2)/(R*C1*C2)*t_100k);
# x_100k = ones(1,length(t_100k));
# x_100k(1) = 0;
# y1_100k = filter(bb1_100k,aa1,x_100k);
# figure(7);
# plot(t_100k,y1_100k);
# axis([0 0.0003 -0.1 0.6]);
# grid on;

x_sin_short = sin(2*pi*10000*t_short);
y_sin_short = filter(bb1_short, aa1, x_sin_short);
figure(7);
hold off;
plot(t_short, y_sin_short);
grid on;
hold on;
set(gca, 'ytick', [-1, -0.2, 0, 0.2, 1]);
plot(t_short, x_sin_short);

# T_20k = 1/20000;
# t_20k = [0:1/20000:0.001];
# bb1_20k = T_20k/(R*C2)*exp(-1*(C1+C2)/(R*C1*C2)*t_20k);
# x_20k = ones(1,length(t_20k));
# x_20k(1) = 0;
# y1_20k = filter(bb1_20k,aa1,x_20k);
# y1_20k_2 = y1_20k/y1_20k(length(y1_20k))
# figure(3);
# plot(t_20k,y1_20k_2);
# axis([0 0.0003 -0.1 0.6]);
# grid on;
# figure(4);
#bb1_20k_2 = bb1_20k/(y1_20k(length(y1_20k))/length(bb1_20k));
# bb1_20k_2 = bb1_20k/(y1_20k(length(y1_20k))/0.5);
# y1_20k_3 = filter(bb1_20k_2,aa1,x_20k);
# plot(t_20k,y1_20k_3);
# axis([0 0.0003 -0.1 0.6]);
# grid on;

# x_sin_20k = sin(2*pi*6000*t_20k);
# y_sin_20k = filter(bb1_20k_2, aa1, x_sin_20k);
# figure(8);
# hold off;
# plot(t_20k, y_sin_20k);
# grid on;
# hold on;
# set(gca, 'ytick', [-1, -0.2, 0, 0.2, 1]);
# plot(t_20k, x_sin_20k);


T_40k = 1/40000;
t_40k = [0:1/40000:0.001];
bb1_40k = T_40k/(R*C2)*exp(-1*(C1+C2)/(R*C1*C2)*t_40k);
x_40k = ones(1,length(t_40k));
x_40k(1) = 0;
y1_40k = filter(bb1_40k,aa1,x_40k);
y1_40k_2 = y1_40k/y1_40k(length(y1_40k));
figure(3);
plot(t_40k,y1_40k_2);
# axis([0 0.0003 -0.1 0.6]);
grid on;
figure(4);
#bb1_20k_2 = bb1_20k/(y1_20k(length(y1_20k))/length(bb1_20k));
bb1_40k_2 = bb1_40k/(y1_40k(length(y1_40k))/0.5);
y1_40k_3 = filter(bb1_40k_2,aa1,x_40k);
plot(t_40k,y1_40k_3);
axis([0 0.0003 -0.1 0.6]);
grid on;

x_sin_40k = sin(2*pi*10000*t_40k);
y_sin_40k = filter(bb1_40k_2, aa1, x_sin_40k);
figure(8);
hold off;
plot(t_40k, y_sin_40k);
grid on;
hold on;
set(gca, 'ytick', [-1, -0.2, 0, 0.2, 1]);
plot(t_40k, x_sin_40k);
axis([0 0.0003 -1 1])
