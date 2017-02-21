clear all;
clc;
%%  Load data
load u_all;
U=u_all;
%Training set
load u1_base;
R = u1_base;
%Test set
load u1_test;
T = u1_test;
%size of data;
[n,m] = size(R);
%% NMF Algorithm
%Basis number 
basis_num = 100; %you can change this number
%small value
myepts = 1e-20; %for you to avoid NAN
%randdom initial of W and H
W = rand(n,basis_num);
H = rand(basis_num,m);

%NMF updating algorithm including error

%Write downn
error=zeros(1,1000);
d=zeros(n,m);
%use vector 'error' to note the cost for each iteration
for i=1:1000
    r=W*H;%�s��WH�ұo�쪺r
    %�p��C�@�ӹ������x�}�Ȫ��ڴX���o�Z��
    dis=(R-r)*((R-r)');
    error(1,i)=sum(sum(dis));
    %{
    for u=1:n
        for v=1:m
            d(u,v)=R(u,v)-r(u,v);
            error(1,i)=error(1,i)+d(u,v)^2;
        end
    end    
    %}
    %�d�ݬO�_��0�b����G1���n��b��������
   %{
    G1=W*H*(H');
    [p,q]=size(G1);
    for j=1:p
        for k=1:q
            if G1(j,k)==0
                 G1(j,k)=myepts;
            end
        end
    end
    newW=W.*(R*(H'))./(G1);%�sW
    %}
    %�d�ݬO�_��0�b����G2���n��b��������
   %{
    G2=(W')*W*H;
   [p,q]=size(G2);
    for j=1:p
        for k=1:q
            if G2(j,k)==0
                 G2(j,k)=myepts;
            end
        end
    end
    H=H.*((W')*R)./(G2);%�sH
    W=newW;
    %}
    W=W.*(R*(H'))./(W*H*(H')+myepts);
     H=H.*((W')*R)./((W')*W*H+myepts);

    %{
    g1nan=any(any(isnan(G1)));%�d�ݬO�_��NAN
    g2nan=any(any(isnan(G2)));
    wnan=any(any(isnan(W)));
    hnan=any(any(isnan(H)));  
     %}
end
figure(1);
semilogy(error);
%Reconstuction of approximation matrix

%Write down
RE=W*H;

%plot the error
 DIS=(U-RE)*((U-RE)');
 ERROR=sum(sum(DIS));
%% See some feature
%You can use these matrices to see some information from the results

size_n = 10; %can change this number 
RE_rec=RE(1:size_n,1:size_n);
R_all = U(1:size_n,1:size_n);
R_test = T(1:size_n,1:size_n);
R_rec_test = T(1:size_n,1:size_n);
%W_rec = W(1:size_n,:);
%H_rec = H(:,1:size_n);
