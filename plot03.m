pkg load control;
pkg load signal;
R = 100;
C = 0.33*10^(-6);
a1 = [1 1/(R*C)];
b1 = [0 1/(R*C)];
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

T_40k = 1/40000;

t_40k = [0:1/40000:0.001];
#bb1_40k = T_40k/(R*C)*exp(-1/(R*C)*t_40k);
x_40k = ones(1,length(t_40k));
x_40k(1) = 0;
#y1_40k = filter(bb1_40k,1,x_40k);
#y1_40k_2 = y1_40k/y1_40k(length(y1_40k));
#figure(3);
#plot(t_40k,y1_40k_2);
#plot(t_40k,y1_40k);
#axis([0 0.0003 -0.1 1.2]);
#grid on;
figure(2);
bb1_40k_2 = bb1_40k/(y1_40k(length(y1_40k)));
y1_40k_3 = filter(bb1_40k_2,1,x_40k);
plot(t_40k,y1_40k_3);
#axis([0 0.0003 -0.1 0.6]);
grid on;

[bbut, abut] = butter(2,[20]*(T_40k*2), 'high');
figure(3);
freqz(bbut, abut);

x_sin_40k = sin(2*pi*2000*t_40k);
ybut_sin_40k = filter(bbut, abut, x_sin_40k);
figure(4);
hold off;
plot(t_40k, ybut_sin_40k, 'r');
#plot(t_40k, yfir1_sin_40k, 'r');
hold on;
grid on;
plot(t_40k, x_sin_40k);

x_stp = ones(1,length(t_40k));
x_stp(1) = 0;
ybut_stp_40k = filter(bbut, abut, x_stp);
figure(5);
hold off;
plot(t_40k, ybut_stp_40k, 'r');
hold on;
grid on;
plot(t_40k, x_stp);

x_1 = 0;
x_2 = 0;
y_1 = 0;
y_2 = 0;
for i=1:(length(x_sin_40k))
  y_myfil_sin(i) = bbut(1)*x_sin_40k(i) + bbut(2)*x_1 + bbut(3)*x_2 - abut(2)*y_1 - abut(3)*y_2;
  x_2 = x_1;
  x_1 = x_sin_40k(i);
  y_2 = y_1;
  y_1 = y_myfil_sin(i);
endfor
figure(10);
hold off;
plot(t_40k, y_myfil_sin, 'r');
hold on;
grid on;
plot(t_40k, x_sin_40k);


x_1 = 0;
x_2 = 0;
y_1 = 0;
y_2 = 0;
for i=1:(length(x_sin_40k))
  y_myfil_stp(i) = bbut(1)*x_stp(i) + bbut(2)*x_1 + bbut(3)*x_2 - abut(2)*y_1 - abut(3)*y_2;
  x_2 = x_1;
  x_1 = x_stp(i);
  y_2 = y_1;
  y_1 = y_myfil_stp(i);
endfor
figure(11);
hold off;
plot(t_40k, y_myfil_stp, 'r');
hold on;
grid on;
plot(t_40k, x_stp);


t_40k_long = [0:1/40000:0.1];
x_sin_40k_test = sin(2*pi*100*t_40k_long);

y2 = zeros(1, length(x_sin_40k_test));
for i=1:(length(x_sin_40k_test))
  for j=1:(length(bb1_40k_2))

    if ((i-j+1) > 0)
      y2(i) += bb1_40k_2(j)*x_sin_40k_test(i-j+1);
    else
      y2(i) += bb1_40k_2(j)*0;
    endif
    
  endfor
endfor
figure(20);
hold off;
plot(t_40k_long, y2, 'r');
hold on;
grid on;
plot(t_40k_long, x_sin_40k_test);

y3 = zeros(1, length(y2));
x_2 = 0;
x_1 = 0;
y_2 = 0;
y_1 = 0;
for i=1:(length(y2))
  y3(i) = bbut(1)*y2(i) + bbut(2)*x_1 + bbut(3)*x_2 - abut(2)*y_1 - abut(3)*y_2;
  x_2 = x_1;
  x_1 = y2(i);
  y_2 = y_1;
  y_1 = y3(i);
endfor
figure(21);
hold off;
plot(t_40k_long, y3, 'r');
hold on;
grid on;
plot(t_40k_long, y2);

