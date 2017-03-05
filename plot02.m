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

T_40k = 1/40000;


#bfir1 = fir1(48, [0.00004 0.04], 'pass');
#bfir1 = fir1(8, [0.0004], 'high');
bfir1 = fir1(40, [20]*T_40k*2, 'high');
figure(2);
freqz(bfir1, 1, 512);

#20*T_40k_2 = 0.001
#bfir_remez = remez(8, [0 0.001 0.0015 1], [0 0 1 1]);
#freqz(bfir_remez, 1, 512);

#[bbut, abut] = butter(8,[0.00004 0.04],'pass');
#[bbut, abut] = butter(8,[0.04],'pass');
#[bbut, abut] = butter(8,[100]*(T_40k*2), 'high');
[bbut, abut] = butter(4,[20]*(T_40k*2), 'high');
figure(3);
freqz(bbut, abut);

#[bbut, abut] = butter(8,[0.5]);
#bfir1_2 = fir1(40, [0.5]);
#figure(4);
#freqz(bfir1_2, 1, 512);

T_40k = 1/40000;
t_40k = [0:1/40000:0.01];
x_sin_40k = sin(2*pi*1000*t_40k);
ybut_sin_40k = filter(bbut, abut, x_sin_40k);
#yfir1_sin_40k = filter(bfir1, 1, x_sin_40k);
figure(4);
hold off;
plot(t_40k, ybut_sin_40k, 'r');
#plot(t_40k, yfir1_sin_40k, 'r');
hold on;
grid on;
plot(t_40k, x_sin_40k);

x_stp = ones(401);
x_stp(1) = 0;
#yfir1_stp_40k = filter(bfir1, 1, x_stp);
ybut_stp_40k = filter(bbut, abut, x_stp);
figure(5);
hold off;
#plot(t_40k, yfir1_stp_40k, 'r');
plot(t_40k, ybut_stp_40k, 'r');
hold on;
grid on;
plot(t_40k, x_stp);
