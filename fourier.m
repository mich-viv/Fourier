close all
clear all
clc

M=100;
N=100;
T=0.05; % passo di campionamento nel dominio del tempo
F=0.05; % passo di campionamento nel dominon della frequenza
t=-M:T:M; % insieme dei possibili tempi
f=-N:F:N; % insieme delle possibili frequenze
% ricavo il segnale di ingresso x(t) moltiplicando x_1 per un gradino u(t)
x_1=cos(2*t).*exp(-0.8*t+1i*2*pi*8*t);
u=heaviside(t);
x=u.*x_1;

% ricavo la trasformata di Fourier del segnale x(t)
X=zeros (1,length(f));
for k=1: length (f)
X(k)=T*x*exp (-1i*2*pi*f(k)*t).';
end
% grafico del modulo della trasformata di Fourier trovata
precedentemente
figure , plot (f,abs (X));
axis([-4,14,-0.2,1.8]) ;
xlabel('f');
ylabel('|X(f)|');
legend('Modulo del segnale X(f)');
title('Grafico Punto 1');
grid on;
% definisco il segnale rumore n(t) con i dati forniti dal testo
f1=2;
A1=0.25;
n=A1*cos(2*pi*f1*t);
% definisco il segnale somma s pari a x+n
s=x+n;
% ricavo la trasformata di Fourier del segnale s(t)
S=zeros(1,length(f));
for k=1: length (f)
S(k)=T*s*exp(-1i*2*pi*f(k)*t).';
end
% risposta in frequenza del filtro trovata in maniera teorica
H=heaviside(f-3)-heaviside(f-13) ;
h=10*sinc(10*t).*exp(1i*2*pi*8*t);
% ricavo nel dominio della frequenza l' uscita del filtro
Y=S.*H;

% antitrasformo Y(f) per ottenere la risposta nel tempo y(t)
y= zeros (1, length (t));
for k=1: length (t)
y(k)=F*Y*exp (1i*2*pi*f*t(k)).';
end

% grafico di |S(f)| e di |H(f)|
figure , plot (f,abs (S));
hold on;
plot(f,abs (H),'r');
axis([-4,14,-0.2,1.8]) ;
hold off ;
xlabel('f');
ylabel('|S(f)|, |H(f)|');
legend('Modulo della trasformata del segnale s(t)', 'Risposta in frequenza H(f) '); 
title('Grafico Punto 2');
grid on;
% ricavo filtro causale hc(t)
t_1=t+8;
hc=h.*heaviside(t_1);
% ricavo la risposta in frequenza del filtro
Hc= zeros (1,length(f));
for k=1: length (f)
Hc(k)=T*hc*exp(-1i*2*pi*f(k)*t_1).';
end
% ricavo l' uscita del filtro con in ingresso il segnale affetto da rumore
Yc=S.*Hc;

% antitrasformo Yc(f) per ottenere la risposta nel tempo yc(t)
yc=zeros(1,length(t));
for k=1: length (t)
yc(k)=F*Yc*exp(1i*2*pi*f*t(k)).';
end


% grafico contenente |S(f)|,|Y(f)|,| Yc(f)|
figure , plot (f,abs(S),'b');
hold on;
plot(f,abs(Y),'r','LineWidth',1.5);
plot(f,abs(Yc),'g');
axis([-4,14,-0.2,1]);
hold off ;
legend('Modulo della trasformata del segnale s(t)', 'Modulo della trasformata del segnale y(t)', 'Modulo della trasformata del segnale yc(t)');
xlabel('f');
ylabel('|S(f)|, |Y(f)|, |Yc(f)|');
title('Grafico Punto 3');
grid on;
% grafico per verificare la ricostruzione del segnale nel caso del filtro
% causale e del filtro non causale
figure , plot (t,real(x),'LineWidth',1.5)
hold on;
plot(t,real(y),'r');
plot(t,real(yc),'g');
axis([-2,12,-7,7]);
hold off ;
legend('x(t)','y(t)','yc(t)');
xlabel('t');
ylabel('x(t), y(t), yc(t)');
title('Grafico Punto 4');
grid on;